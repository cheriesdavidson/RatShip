using System;
using System.Runtime.InteropServices;
using UnityEngine;
using AOT;

/// <summary>
/// Reads ELIAS' output and plays it via an AudioSource.
/// </summary>
public class EliasAudioReader
{
	private EliasHelper elias;
	private AudioSource audioSource;
	private float[] currentData;
	private float[] dataBuffer;
	private int currentDataIndex;
	private int bufferedLength;

	public EliasAudioReader(EliasHelper eliasHelper, AudioSource audioSourceTarget, bool useProceduralClip)
	{
		elias = eliasHelper;
		audioSource = audioSourceTarget;
		dataBuffer = new float[elias.FramesPerBuffer * elias.ChannelCount];
		if (useProceduralClip)
        {
            AudioClip clip = AudioClip.Create("elias clip", elias.FramesPerBuffer * elias.ChannelCount, elias.ChannelCount, elias.SampleRate, true, PCMReadCallback);
            audioSource.clip = clip;
        }
        // By not having any audio clip, and making sure ELIAS is the first effect on the Audio Source, ELIAS is treated as the "source".
		audioSource.loop = true;
	}

	/// <summary>
	/// Stops the AudioSource and disposes references. DOES NOT stop ELIAS!
	/// </summary>
	public void Dispose()
	{
		audioSource.Stop();
		audioSource = null;
		elias = null;
    }
    private void PCMReadCallback(float[] data)
    {
        ReadCallback(data);
    }


    public bool ReadCallback(float[] data)
	{
		currentDataIndex = 0;
		currentData = data;
		while (currentDataIndex < data.Length)
		{
			if (bufferedLength > 0)
			{
				int length = Math.Min(currentData.Length - currentDataIndex, bufferedLength);
				Array.Copy(dataBuffer, 0, currentData, currentDataIndex, length);
				currentDataIndex += length;
				bufferedLength -= length;
				if (bufferedLength > 0)
				{
					Array.Copy(dataBuffer, length, dataBuffer, 0, bufferedLength);
				}
			}
			else
			{
				EliasWrapper.elias_audio_buffer_callback callback = RenderBufferCallback; // We have to hold a local reference, otherwise it will be garbage collected.
				EliasWrapper.elias_result_codes r = EliasWrapper.elias_render_buffer_wrapped(elias.Handle, callback, IntPtr.Zero, 0);
				EliasHelper.LogResult(r, "Failed to render");
                if (r != EliasWrapper.elias_result_codes.elias_result_success)
                {
                    return false;
                }
			}
		}
        return true;
	}

	private void RenderBufferCallback(IntPtr handle, IntPtr buffer, string busName, IntPtr user)
	{
		if (busName.Equals("main"))
		{
			float[] tmp = new float[elias.FramesPerBuffer * elias.ChannelCount];
			EliasAudioBuffer audioBuffer = EliasAudioBuffer.ReadFromPointer(buffer);
			Marshal.Copy(audioBuffer.data, tmp, 0, tmp.Length);
			int length = Math.Min(currentData.Length - currentDataIndex, tmp.Length);
			Array.Copy(tmp, 0, currentData, currentDataIndex, length);
			currentDataIndex += length;
			if (length < tmp.Length)
			{
				bufferedLength = tmp.Length - length;
				Array.Copy(tmp, length, dataBuffer, 0, bufferedLength);
			}
		}
	}
}