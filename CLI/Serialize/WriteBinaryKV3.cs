using System.Collections;
using System.Text;
using KVType = ValveKeyValue.KVValueType;
using ValveResourceFormat.Serialization.KeyValues;

// This would not have been possible without the reverse engineering efforts from
// https://github.com/REDxEYE/SourceIO/blob/master/library/source2/data_types/keyvalues3/binary_keyvalues.py
// and
// https://github.com/ValveResourceFormat/ValveResourceFormat/blob/master/ValveResourceFormat/Resource/ResourceTypes/BinaryKV3.cs
// so thanks a lot for helping out here!

public class WriteBinaryKV3 : IDisposable
{
    public Guid Format = Guid.Parse("7412167c-06e9-4698-aff2-e63eb59037e7"); // generic format
    public KVObject KeyValuesRoot;

    internal bool Loaded = false;
    internal int NumObjects = 0;
    internal int NumArrays = 0;
    internal OrderedHashSet<string> StringValues = [];

    internal MemoryStream TypeBuffer = new();
    internal BinaryWriter TypeWriter;
    internal MemoryStream IntBuffer = new();
    internal BinaryWriter IntWriter;
    internal MemoryStream DoubleBuffer = new();
    internal BinaryWriter DoubleWriter;

    public WriteBinaryKV3()
    {
        TypeWriter = new(TypeBuffer);
        IntWriter = new(IntBuffer);
        DoubleWriter = new(DoubleBuffer);
    }

    public void LoadRoot()
    {
        if (Loaded) throw new Exception("cant load twice!");
        NumObjects++;
        LoadObject(KeyValuesRoot, false);
        Loaded = true;
    }

    protected void LoadObject(KVObject obj, bool includeKey = true)
    {
        if (includeKey)
        {
            StringValues.Add(obj.Key);
        }
        foreach (var prop in obj.Properties)
        {
            LoadString(prop.Key);
            LoadValue(prop.Value);
        }
    }

    protected void LoadValue(KVValue value)
    {
        switch (value.Type)
        {
            case KVType.Array:
                NumArrays++;
                LoadObject((KVObject)value.Value);
                break;
            case KVType.Collection:
                NumObjects++;
                LoadObject((KVObject)value.Value);
                break;
            case KVType.String:
                LoadString((string)value.Value);
                break;
        }
    }

    protected void LoadString(string str)
    {
        if (str != "")
        {
            StringValues.Add(str);
        }
    }

    protected void Align(BinaryWriter writer, int bytes)
    {
        var offset = (int)writer.BaseStream.Position % bytes;
        var padding = new byte[bytes - offset];
        if (padding.Length > 0 && padding.Length < bytes)
        {
            writer.Write(padding);
        }
    }

    public void Write(BinaryWriter writer)
    {
        if (!Loaded) throw new Exception("must load before writing!");

        // Magic
        writer.Write(0x4B563303); // KV3\x03

        // Format
        var formatBytes = new byte[16];
        Format.TryWriteBytes(formatBytes);
        writer.Write(formatBytes);

        // Compression info
        writer.Write(0u); // no compression
        writer.Write((ushort)0);
        writer.Write((ushort)0);

        IntWriter.Write(StringValues.Count);
        WriteValue(new KVValue(KVType.Collection, KeyValuesRoot));

        // Counts
        writer.Write(0u); // TODO byteBuffer?
        writer.Write((uint)IntBuffer.Length / 4);
        writer.Write((uint)DoubleBuffer.Length / 8);

        using MemoryStream tempBuffer = new();
        BinaryWriter tempWriter = new(tempBuffer);

        // TODO byteBuffer?
        // Align(tempWriter, 4);
        IntBuffer.Seek(0, SeekOrigin.Begin);
        IntBuffer.CopyTo(tempBuffer);
        Align(tempWriter, 8);
        DoubleBuffer.Seek(0, SeekOrigin.Begin);
        DoubleBuffer.CopyTo(tempBuffer);

        // Strings
        foreach (string str in StringValues)
        {
            tempWriter.Write(Encoding.UTF8.GetBytes(str));
            tempWriter.Write((byte)0);
        }

        TypeBuffer.Seek(0, SeekOrigin.Begin);
        TypeBuffer.CopyTo(tempBuffer);

        // End of block list
        tempWriter.Write(0xFFEEDD00u);

        var stringsAndTypeSize = StringValues.Sum(str => str.Length+1) + TypeBuffer.Length;
        writer.Write((uint)stringsAndTypeSize);
        writer.Write((ushort)NumObjects);
        writer.Write((ushort)NumArrays);

        // Sizes
        writer.Write((uint)tempBuffer.Length); // uncompressed size
        writer.Write((uint)tempBuffer.Length); // compressed size (same as uncompressed in our case)
        writer.Write(0u); // blockCount (in our case always zero)
        writer.Write(0u); // blockTotalSize (in our case always zero)

        tempBuffer.Seek(0, SeekOrigin.Begin);
        tempBuffer.CopyTo(writer.BaseStream);
    }

    public void WriteType(BinaryWriter writer, KVType type, KVFlag flag = KVFlag.None)
    {
        var typeOut = type switch
        {
            KVType.Null => (byte)1, // NULL
            KVType.Boolean => (byte)2, // BOOLEAN
            KVType.Int64 => (byte)3, // INT64
            KVType.UInt64 => (byte)4, // UINT64
            KVType.FloatingPoint64 => (byte)5, // DOUBLE
            KVType.String => (byte)6, // STRING
            KVType.BinaryBlob => (byte)7, // BINARY_BLOB
            KVType.Array => (byte)8, // ARRAY
            KVType.Collection => (byte)9, // OBJECT
            KVType.Int32 => (byte)11, // INT32
            KVType.UInt32 => (byte)12, // UINT32
            KVType.FloatingPoint => (byte)19, // FLOAT
            KVType.Int16 => (byte)20, // INT16
            KVType.UInt16 => (byte)21, // UINT16
            // KVType.Pointer => (byte)23, // INT32_AS_BYTE
            _ => throw new ArgumentOutOfRangeException(nameof(type), $"Unsupported KVType: {type}"),
        };

        if (flag == KVFlag.None)
        {
            writer.Write(typeOut);
        }
        else
        {
            writer.Write((byte)(typeOut | 0x80));
            writer.Write((byte)flag);
        }
    }

    public void WriteString(BinaryWriter writer, string str)
    {
        if (str == "")
        {
            writer.Write(-1);
        }
        else
        {
            writer.Write(StringValues.IndexOf(str));
        }
    }

    public static KVValue MakeValue(object value)
    {
        switch (value.GetType().Name)
        {
            case "List`1": {
                var list = (List<object>)value;
                var kv = new KVObject("", true, list.Count);
                foreach (var item in list)
                {
                    kv.AddProperty(null, MakeValue(item));
                }
                return new KVValue(KVType.Array, kv);
            }
            case "Dictionary`2": {
                var dict = (Dictionary<object, object>)value;
                var kv = new KVObject("", dict.Count);
                foreach (var prop in dict)
                {
                    kv.AddProperty(prop.Key.ToString(), MakeValue(prop.Value));
                }
                return new KVValue(KVType.Collection, kv);
            }
            case "KVValue": return (KVValue)value;
            case "KVObject": {
                var obj = (KVObject)value;
                return new KVValue(obj.IsArray ? KVType.Array : KVType.Collection, obj);
            }
            default: return new KVValue(value);
        }
    }

    public void WriteValue(KVValue value, bool writeType = true)
    {
        if (writeType)
        {
            // TODO: could re-add the 0.0 and 1.0 double optimizations here
            switch (value.Type)
            {
                case KVType.Boolean: {
                    if ((bool)value.Value)
                    {
                        TypeWriter.Write((byte)13); // BOOLEAN_TRUE
                    }
                    else
                    {
                        TypeWriter.Write((byte)14); // BOOLEAN_FALSE
                    }
                    break;
                }
                default: {
                    WriteType(TypeWriter, value.Type);
                    break;
                }
            }
        }

        switch (value.Type)
        {
            case KVType.Null:
            case KVType.Boolean:
                // EZ
                break;
            case KVType.String:
                WriteString(IntWriter, (string)value.Value);
                break;
            case KVType.Collection:
                var obj = (KVObject)value.Value;
                IntWriter.Write(obj.Count);
                foreach (var prop in obj.Properties)
                {
                    WriteString(IntWriter, prop.Key);
                    WriteValue(prop.Value);
                }
                break;
            case KVType.Int32:
                IntWriter.Write((int)value.Value);
                break;
            case KVType.UInt32:
                IntWriter.Write((uint)value.Value);
                break;
            case KVType.Int64:
                DoubleWriter.Write((long)value.Value);
                break;
            case KVType.FloatingPoint64:
                DoubleWriter.Write((double)value.Value);
                break;
            case KVType.Array: {
                var arr = (KVObject)value.Value;
                IntWriter.Write(arr.Count);
                foreach (var prop in arr)
                {
                    WriteValue(MakeValue(prop.Value));
                }
            } break;
            default:
                throw new NotImplementedException($"WriteValue type {value.Type}");
        }
    }

    public void Dispose()
    {
        TypeBuffer.Dispose();
        IntBuffer.Dispose();
        DoubleBuffer.Dispose();
    }
}

internal class OrderedHashSet<T> : IEnumerable<T>
{
    private readonly List<T> _list;

    public OrderedHashSet()
    {
        _list = new List<T>();
    }

    public bool Add(T item)
    {
        if (!_list.Contains(item))  // Ensure uniqueness with O(n) Contains check
        {
            _list.Add(item);        // Add to the List to maintain insertion order
            return true;
        }
        return false;               // Item was already present
    }

    public bool Remove(T item)
    {
        return _list.Remove(item);  // Remove directly from the list
    }

    public int Count => _list.Count;

    public T this[int index] => _list[index];

    public int IndexOf(T item) => _list.IndexOf(item);

    public bool Contains(T item) => _list.Contains(item);

    public void Clear()
    {
        _list.Clear();
    }

    public IEnumerator<T> GetEnumerator() => _list.GetEnumerator();

    IEnumerator<T> IEnumerable<T>.GetEnumerator() => _list.GetEnumerator();

    IEnumerator IEnumerable.GetEnumerator() => _list.GetEnumerator();
}
