using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class VoiceManager : MonoBehaviour {

    AudioSource audioSource;

    void Awake()
    {
        audioSource = GetComponent<AudioSource>();
    }

	// Use this for initialization
	public void Stop()
    {
        audioSource.Stop();
    }

    public  void Play(AudioClip[] voices)
    {
        audioSource.clip= voices[Random.Range(0, voices.Length)];
        audioSource.Play();
    }
}
