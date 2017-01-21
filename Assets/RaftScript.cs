using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class RaftScript : MonoBehaviour {

    public GameObject PaddlePrompt;
    public GameObject PaddleSuccess;
    public GameObject PaddleFail;
    public WavesScript waveScript;
    public int SuccessCount = 0;
    public int FailCount = 0;

    float GetTimeTilWavePeak()
    {
        float time_for_peak_to_pass = 1.15f * waveScript.WAVE_VELOCITY;
        float time_since_peak = Time.time % time_for_peak_to_pass;
        return time_for_peak_to_pass- time_since_peak;
    }

	// Use this for initialization
	void Start () {
        SuccessCount = 0;
        FailCount = 0;
    }

    float LastPaddleTime = -1.0f;
    float LastPaddleSuccess = -1.0f;
    float LastPaddleFail = -1.0f;

	// Update is called once per frame
	void Update () {
        // do we need to display paddle success/failure?
        if (Time.time - LastPaddleSuccess < 0.5f) {
            PaddleSuccess.SetActive(true);
            PaddleFail.SetActive(false);
            PaddlePrompt.SetActive(false);
            return;
        } else if (Time.time - LastPaddleFail < 0.5f) {
            PaddleSuccess.SetActive(false);
            PaddleFail.SetActive(true);
            PaddlePrompt.SetActive(false);
            return;
        }

        PaddleSuccess.SetActive(false);
        PaddleFail.SetActive(false);

        float time_til_wave_peak = GetTimeTilWavePeak();

		// display paddle button prompt
        if (GetTimeTilWavePeak() < 0.5f) {
            PaddlePrompt.SetActive(true);
        } else {
            PaddlePrompt.SetActive(false);
        }

        // did we paddle?
        if(Input.anyKeyDown) {
            LastPaddleTime = Time.time;

            // successfully?
            if(time_til_wave_peak < 0.5f) {
                LastPaddleSuccess = Time.time;
                SuccessCount++;
            } else {
                LastPaddleFail = Time.time;
                FailCount++;
            }
        }

    }
}
