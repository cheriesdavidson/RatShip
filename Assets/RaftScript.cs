using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class RaftScript : MonoBehaviour {

    public GameObject PaddlePrompt;
    public WavesScript wavescript;

    float GetTimeTilWavePeak()
    {
        float time_for_peak_to_pass = 1.15f * wavescript.WAVE_VELOCITY;
        float time_since_peak = Time.time % time_for_peak_to_pass;
        return time_for_peak_to_pass- time_since_peak;
    }


	// Use this for initialization
	void Start () {
		
	}
	
	// Update is called once per frame
	void Update () {
		// display padd button prompt
        if(GetTimeTilWavePeak() < 0.5f) {
            PaddlePrompt.SetActive(true);
        } else {
            PaddlePrompt.SetActive(false);
        }

	}
}
