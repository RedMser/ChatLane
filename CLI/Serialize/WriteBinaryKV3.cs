using System.Collections;
using System.Text;
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
            case KVType.ARRAY:
            case KVType.ARRAY_TYPED:
            case KVType.ARRAY_TYPE_BYTE_LENGTH:
                NumArrays++;
                LoadObject((KVObject)value.Value);
                break;
            case KVType.OBJECT:
                NumObjects++;
                LoadObject((KVObject)value.Value);
                break;
            case KVType.STRING:
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
        WriteValue(new KVValue(KVType.OBJECT, KeyValuesRoot));

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
        if (flag == KVFlag.None)
        {
            writer.Write((byte)type);
        }
        else
        {
            writer.Write((byte)type | 0x80);
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

    protected static KVValue SimplifyValue(KVValue value)
    {
        switch (value.Type)
        {
            case KVType.BOOLEAN:
                var boolean = (bool)value.Value;
                if (boolean)
                {
                    return new KVValue(KVType.BOOLEAN_TRUE, true);
                }
                else
                {
                    return new KVValue(KVType.BOOLEAN_FALSE, false);
                }
            case KVType.INT64:
                var i64 = (long)value.Value;
                if (i64 == 0)
                {
                    return new KVValue(KVType.INT64_ZERO, 0);
                }
                else if (i64 == 1)
                {
                    return new KVValue(KVType.INT64_ONE, 1);
                }
                break;
            case KVType.DOUBLE:
                var d = (double)value.Value;
                var epsilon = 0.0001;
                if (Math.Abs(d) < epsilon)
                {
                    return new KVValue(KVType.DOUBLE_ZERO, 0.0);
                }
                else if (Math.Abs(d) > (1.0 - epsilon) && Math.Abs(d) < (1.0 + epsilon))
                {
                    return new KVValue(KVType.DOUBLE_ONE, 1.0);
                }
                break;
        }
        return value;
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
                return new KVValue(KVType.ARRAY, kv);
            }
            case "Dictionary`2": {
                var dict = (Dictionary<object, object>)value;
                var kv = new KVObject("", dict.Count);
                foreach (var prop in dict)
                {
                    kv.AddProperty(prop.Key.ToString(), MakeValue(prop.Value));
                }
                return new KVValue(KVType.OBJECT, kv);
            }
            case "String": return new KVValue(KVType.STRING, (string)value);
            case "Boolean": return new KVValue(KVType.BOOLEAN, (bool)value);
            case "Int32": return new KVValue(KVType.INT32, (int)value);
            case "KVValue": return (KVValue)value;
        }
        throw new NotImplementedException($"MakeValue for type {value.GetType().Name}");
    }

    public void WriteValue(KVValue value, bool writeType = true)
    {
        if (writeType)
        {
            value = SimplifyValue(value);
            WriteType(TypeWriter, value.Type);
        }

        switch (value.Type)
        {
            case KVType.NULL:
            case KVType.INT64_ZERO:
            case KVType.INT64_ONE:
            case KVType.DOUBLE_ZERO:
            case KVType.DOUBLE_ONE:
            case KVType.BOOLEAN_FALSE:
            case KVType.BOOLEAN_TRUE:
                // EZ
                break;
            case KVType.STRING:
                WriteString(IntWriter, (string)value.Value);
                break;
            case KVType.OBJECT:
                var obj = (KVObject)value.Value;
                IntWriter.Write(obj.Count);
                foreach (var prop in obj.Properties)
                {
                    WriteString(IntWriter, prop.Key);
                    WriteValue(prop.Value);
                }
                break;
            case KVType.INT32:
                IntWriter.Write((int)value.Value);
                break;
            case KVType.UINT32:
                IntWriter.Write((uint)value.Value);
                break;
            case KVType.INT64:
                DoubleWriter.Write((long)value.Value);
                break;
            case KVType.DOUBLE:
                DoubleWriter.Write((double)value.Value);
                break;
            case KVType.ARRAY: {
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
