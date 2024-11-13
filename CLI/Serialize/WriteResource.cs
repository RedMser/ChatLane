using System.Text;

public class WriteResource : IDisposable
{
    public List<Block> Blocks = [];

    BinaryWriter Writer;

    public void Dispose()
    {
        Writer.Dispose();
    }

    public void Write(Stream output)
    {
        var pos_blockoffsets = new Queue<long>();

        Writer = new BinaryWriter(output);

        // Write file size later
        Writer.Write(0xFFFFFFFFu);

        // Header version and resource version
        Writer.Write((ushort)0x0C);
        Writer.Write((ushort)0);

        // TODO: proper block offset writing, if we need more blocks
        Writer.Write((uint)8);
        Writer.Write(Blocks.Count);

        foreach (var block in Blocks)
        {
            Writer.Write(Encoding.UTF8.GetBytes(block.Type.ToString()));

            // Write block offset and size later
            pos_blockoffsets.Enqueue(output.Position);
            Writer.Write(0xFFFFFFFFu);
            Writer.Write(0xFFFFFFFFu);
        }

        // TODO: zero padding width (it works like this, not sure what alignment we need here though)
        PadZeroes(12);

        // Write block contents
        foreach (var block in Blocks)
        {
            var startOfBlock = output.Position;
            block.Write(Writer);
            var blockSize = output.Position - startOfBlock;

            // Start of block is here
            var blockOffsetOrigin = pos_blockoffsets.Dequeue();
            var blockOffset = startOfBlock - blockOffsetOrigin;
            Writer.Seek((int)blockOffsetOrigin, SeekOrigin.Begin);
            Writer.Write((uint)blockOffset);
            Writer.Write((uint)blockSize);
            Writer.Seek(0, SeekOrigin.End);
        }

        // Write file size now that we know it
        var fileSize = output.Position;
        Writer.Seek(0, SeekOrigin.Begin);
        Writer.Write((uint)fileSize);
    }

    protected void PadZeroes(int amount)
    {
        var bytes = new byte[amount];
        Writer.Write(bytes);
    }
}