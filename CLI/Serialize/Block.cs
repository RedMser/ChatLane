using System.IO.Hashing;
using ValveResourceFormat.Serialization.KeyValues;
using BlockType = ValveResourceFormat.BlockType;

public abstract class Block
{
    /// <summary>
    /// Gets the block type.
    /// </summary>
    public abstract BlockType Type { get; }

    /// <summary>
    /// Gets or sets the data size.
    /// </summary>
    public uint Size { get; set; }

    public abstract void Write(BinaryWriter writer);
}

public class DATABlock : Block
{
    public KVObject KeyValuesRoot;

    public override BlockType Type => BlockType.DATA;

    public override void Write(BinaryWriter writer)
    {
        var kv3 = new WriteBinaryKV3
        {
            KeyValuesRoot = KeyValuesRoot
        };
        kv3.LoadRoot();
        kv3.Write(writer);
    }
}

public class RED2Block : Block
{
    public byte[] DataToHash;

    public override BlockType Type => BlockType.RED2;

    public override void Write(BinaryWriter writer)
    {
        // I took a CSDK-generated vdata_c and yanked its RED2 segment.
        // LZ4 decompressed the body and tweaked the header.
        // Did not test if the CRC32 is even checked for in-game, but doesn't harm to update it I guess...
        byte[] red2Data = {
            0x04, 0x33, 0x56, 0x4B, 0x7C, 0x16, 0x12, 0x74, 0xE9, 0x06, 0x98, 0x46,
            0xAF, 0xF2, 0xE6, 0x3E, 0xB5, 0x90, 0x37, 0xE7, 0x00, 0x00, 0x00, 0x00,
            0x00, 0x00, 0x00, 0x00, 0x03, 0x00, 0x00, 0x00, 0x34, 0x00, 0x00, 0x00,
            0x00, 0x00, 0x00, 0x00, 0x82, 0x02, 0x00, 0x00, 0x06, 0x00, 0x07, 0x00,
            0x5E, 0x03, 0x00, 0x00, 0x5E, 0x03, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
            0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
            0x01, 0x01, 0x02, 0x00, 0x21, 0x00, 0x00, 0x00, 0x0A, 0x00, 0x00, 0x00,
            0x00, 0x00, 0x00, 0x00, 0x06, 0x00, 0x00, 0x00, 0x01, 0x00, 0x00, 0x00,
            0x02, 0x00, 0x00, 0x00, 0x03, 0x00, 0x00, 0x00, 0x04, 0x00, 0x00, 0x00,
            0x05, 0x00, 0x00, 0x00, 0xFF, 0xFF, 0xFF, 0xFF, 0x06, 0x00, 0x00, 0x00,
            0x07, 0x00, 0x00, 0x00, 0x08, 0x00, 0x00, 0x00, 0x09, 0x00, 0x00, 0x00,
            0x00, 0x00, 0x00, 0x00, 0x0A, 0x00, 0x00, 0x00, 0x04, 0x00, 0x00, 0x00,
            0x0B, 0x00, 0x00, 0x00, 0x0C, 0x00, 0x00, 0x00, 0x0D, 0x00, 0x00, 0x00,
            0x0E, 0x00, 0x00, 0x00, 0x0F, 0x00, 0x00, 0x00, 0x10, 0x00, 0x00, 0x00,
            0x11, 0x00, 0x00, 0x00, 0x04, 0x00, 0x00, 0x00, 0x12, 0x00, 0x00, 0x00,
            0x13, 0x00, 0x00, 0x00, 0x14, 0x00, 0x00, 0x00, 0x15, 0x00, 0x00, 0x00,
            0x0F, 0x00, 0x00, 0x00, 0x02, 0x00, 0x00, 0x00, 0x16, 0x00, 0x00, 0x00,
            0x04, 0x00, 0x00, 0x00, 0x12, 0x00, 0x00, 0x00, 0x17, 0x00, 0x00, 0x00,
            0x14, 0x00, 0x00, 0x00, 0x15, 0x00, 0x00, 0x00, 0x0F, 0x00, 0x00, 0x00,
            0x16, 0x00, 0x00, 0x00, 0x18, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
            0x19, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x1A, 0x00, 0x00, 0x00,
            0x00, 0x00, 0x00, 0x00, 0x1B, 0x00, 0x00, 0x00, 0x02, 0x00, 0x00, 0x00,
            0x1C, 0x00, 0x00, 0x00, 0x1D, 0x00, 0x00, 0x00, 0x1E, 0x00, 0x00, 0x00,
            0x1F, 0x00, 0x00, 0x00, 0x20, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
            0x6D, 0x5F, 0x49, 0x6E, 0x70, 0x75, 0x74, 0x44, 0x65, 0x70, 0x65, 0x6E,
            0x64, 0x65, 0x6E, 0x63, 0x69, 0x65, 0x73, 0x00, 0x6D, 0x5F, 0x52, 0x65,
            0x6C, 0x61, 0x74, 0x69, 0x76, 0x65, 0x46, 0x69, 0x6C, 0x65, 0x6E, 0x61,
            0x6D, 0x65, 0x00, 0x73, 0x63, 0x72, 0x69, 0x70, 0x74, 0x73, 0x2F, 0x70,
            0x69, 0x6E, 0x67, 0x5F, 0x77, 0x68, 0x65, 0x65, 0x6C, 0x5F, 0x6D, 0x65,
            0x73, 0x73, 0x61, 0x67, 0x65, 0x73, 0x2E, 0x76, 0x64, 0x61, 0x74, 0x61,
            0x00, 0x6D, 0x5F, 0x53, 0x65, 0x61, 0x72, 0x63, 0x68, 0x50, 0x61, 0x74,
            0x68, 0x00, 0x63, 0x69, 0x74, 0x61, 0x64, 0x65, 0x6C, 0x00, 0x6D, 0x5F,
            0x6E, 0x46, 0x69, 0x6C, 0x65, 0x43, 0x52, 0x43, 0x00, 0x6D, 0x5F, 0x62,
            0x4F, 0x70, 0x74, 0x69, 0x6F, 0x6E, 0x61, 0x6C, 0x00, 0x6D, 0x5F, 0x62,
            0x46, 0x69, 0x6C, 0x65, 0x45, 0x78, 0x69, 0x73, 0x74, 0x73, 0x00, 0x6D,
            0x5F, 0x62, 0x49, 0x73, 0x47, 0x61, 0x6D, 0x65, 0x46, 0x69, 0x6C, 0x65,
            0x00, 0x6D, 0x5F, 0x41, 0x64, 0x64, 0x69, 0x74, 0x69, 0x6F, 0x6E, 0x61,
            0x6C, 0x49, 0x6E, 0x70, 0x75, 0x74, 0x44, 0x65, 0x70, 0x65, 0x6E, 0x64,
            0x65, 0x6E, 0x63, 0x69, 0x65, 0x73, 0x00, 0x6D, 0x5F, 0x41, 0x72, 0x67,
            0x75, 0x6D, 0x65, 0x6E, 0x74, 0x44, 0x65, 0x70, 0x65, 0x6E, 0x64, 0x65,
            0x6E, 0x63, 0x69, 0x65, 0x73, 0x00, 0x6D, 0x5F, 0x50, 0x61, 0x72, 0x61,
            0x6D, 0x65, 0x74, 0x65, 0x72, 0x4E, 0x61, 0x6D, 0x65, 0x00, 0x5F, 0x5F,
            0x5F, 0x4F, 0x76, 0x65, 0x72, 0x72, 0x69, 0x64, 0x65, 0x49, 0x6E, 0x70,
            0x75, 0x74, 0x44, 0x61, 0x74, 0x61, 0x5F, 0x5F, 0x5F, 0x00, 0x6D, 0x5F,
            0x50, 0x61, 0x72, 0x61, 0x6D, 0x65, 0x74, 0x65, 0x72, 0x54, 0x79, 0x70,
            0x65, 0x00, 0x42, 0x69, 0x6E, 0x61, 0x72, 0x79, 0x42, 0x6C, 0x6F, 0x62,
            0x41, 0x72, 0x67, 0x00, 0x6D, 0x5F, 0x6E, 0x46, 0x69, 0x6E, 0x67, 0x65,
            0x72, 0x70, 0x72, 0x69, 0x6E, 0x74, 0x00, 0x6D, 0x5F, 0x6E, 0x46, 0x69,
            0x6E, 0x67, 0x65, 0x72, 0x70, 0x72, 0x69, 0x6E, 0x74, 0x44, 0x65, 0x66,
            0x61, 0x75, 0x6C, 0x74, 0x00, 0x6D, 0x5F, 0x53, 0x70, 0x65, 0x63, 0x69,
            0x61, 0x6C, 0x44, 0x65, 0x70, 0x65, 0x6E, 0x64, 0x65, 0x6E, 0x63, 0x69,
            0x65, 0x73, 0x00, 0x6D, 0x5F, 0x53, 0x74, 0x72, 0x69, 0x6E, 0x67, 0x00,
            0x4B, 0x56, 0x33, 0x20, 0x43, 0x6F, 0x6D, 0x70, 0x69, 0x6C, 0x65, 0x72,
            0x20, 0x56, 0x65, 0x72, 0x73, 0x69, 0x6F, 0x6E, 0x00, 0x6D, 0x5F, 0x43,
            0x6F, 0x6D, 0x70, 0x69, 0x6C, 0x65, 0x72, 0x49, 0x64, 0x65, 0x6E, 0x74,
            0x69, 0x66, 0x69, 0x65, 0x72, 0x00, 0x43, 0x6F, 0x6D, 0x70, 0x69, 0x6C,
            0x65, 0x56, 0x44, 0x61, 0x74, 0x61, 0x00, 0x6D, 0x5F, 0x6E, 0x55, 0x73,
            0x65, 0x72, 0x44, 0x61, 0x74, 0x61, 0x00, 0x56, 0x44, 0x61, 0x74, 0x61,
            0x20, 0x43, 0x6F, 0x6D, 0x70, 0x69, 0x6C, 0x65, 0x72, 0x20, 0x56, 0x65,
            0x72, 0x73, 0x69, 0x6F, 0x6E, 0x00, 0x6D, 0x5F, 0x41, 0x64, 0x64, 0x69,
            0x74, 0x69, 0x6F, 0x6E, 0x61, 0x6C, 0x52, 0x65, 0x6C, 0x61, 0x74, 0x65,
            0x64, 0x46, 0x69, 0x6C, 0x65, 0x73, 0x00, 0x6D, 0x5F, 0x43, 0x68, 0x69,
            0x6C, 0x64, 0x52, 0x65, 0x73, 0x6F, 0x75, 0x72, 0x63, 0x65, 0x4C, 0x69,
            0x73, 0x74, 0x00, 0x6D, 0x5F, 0x57, 0x65, 0x61, 0x6B, 0x52, 0x65, 0x66,
            0x65, 0x72, 0x65, 0x6E, 0x63, 0x65, 0x4C, 0x69, 0x73, 0x74, 0x00, 0x6D,
            0x5F, 0x53, 0x65, 0x61, 0x72, 0x63, 0x68, 0x61, 0x62, 0x6C, 0x65, 0x55,
            0x73, 0x65, 0x72, 0x44, 0x61, 0x74, 0x61, 0x00, 0x67, 0x65, 0x6E, 0x65,
            0x72, 0x69, 0x63, 0x5F, 0x64, 0x61, 0x74, 0x61, 0x5F, 0x74, 0x79, 0x70,
            0x65, 0x00, 0x50, 0x69, 0x6E, 0x67, 0x57, 0x68, 0x65, 0x65, 0x6C, 0x4D,
            0x65, 0x73, 0x73, 0x61, 0x67, 0x65, 0x5F, 0x74, 0x00, 0x49, 0x73, 0x43,
            0x68, 0x69, 0x6C, 0x64, 0x52, 0x65, 0x73, 0x6F, 0x75, 0x72, 0x63, 0x65,
            0x00, 0x6D, 0x5F, 0x53, 0x75, 0x62, 0x61, 0x73, 0x73, 0x65, 0x74, 0x52,
            0x65, 0x66, 0x65, 0x72, 0x65, 0x6E, 0x63, 0x65, 0x73, 0x00, 0x6D, 0x5F,
            0x53, 0x75, 0x62, 0x61, 0x73, 0x73, 0x65, 0x74, 0x44, 0x65, 0x66, 0x69,
            0x6E, 0x69, 0x74, 0x69, 0x6F, 0x6E, 0x73, 0x00, 0x09, 0x18, 0x09, 0x06,
            0x06, 0x0C, 0x0E, 0x0D, 0x0E, 0x08, 0x18, 0x09, 0x06, 0x06, 0x0F, 0x0F,
            0x18, 0x09, 0x06, 0x06, 0x0C, 0x0F, 0x06, 0x06, 0x10, 0x0F, 0x08, 0x08,
            0x08, 0x09, 0x06, 0x0F, 0x01, 0x01, 0x00, 0xDD, 0xEE, 0xFF
        };

        var crc = Crc32.Hash(DataToHash);

        for (var i = 0; i < 4; i++)
        {
            var dest = i + 72 + 0x28; // 72 header bytes, and 28 bytes into the actual data

            red2Data[dest] = crc[i];
        }

        writer.Write(red2Data);
    }
}