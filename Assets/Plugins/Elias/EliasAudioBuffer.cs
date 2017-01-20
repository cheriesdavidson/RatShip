using System;
using System.Runtime.InteropServices;

/// <summary>
/// Struct returned by elias_render_buffer's callback.
/// </summary>
[StructLayout(LayoutKind.Sequential)]
public struct EliasAudioBuffer
{
	public IntPtr data;
	public UInt16 frames;
	public byte channels;

	public static EliasAudioBuffer ReadFromPointer(IntPtr pointer)
	{
		return (EliasAudioBuffer)Marshal.PtrToStructure(pointer, typeof(EliasAudioBuffer));
	}
}