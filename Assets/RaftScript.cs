using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.SceneManagement;
using UnityEngine.UI;

public class RaftScript : MonoBehaviour {

    public GameObject PaddlePrompt;
    public GameObject PaddleSuccess;
    public GameObject PaddleFail;
    public WavesScript waveScript;
    public AudioClip[] OarSounds;

    static float MaxSlowdown = 1.47f;
    static float MinSlowdown = 0.0f;
    float SlowdownPerSecond = 0.0f;

    Vector2 GetWaveNormal()
    {
        // find the wave under the raft
        RaycastHit2D ray = Physics2D.Raycast(transform.position, new Vector2(0, -1),100,1<<4);
        return ray.normal;
    }

    bool IsDescendingWavePeak()
    {
        return GetWaveNormal().x > 0.0f;
    }

    void PlayOarSound()
    {
        AudioSource audio = GetComponent<AudioSource>();

        if (audio.isPlaying) return;
        audio.clip = OarSounds[Random.Range(0, OarSounds.Length)];
        audio.Play();
 
    }

	// Use this for initialization
	void Start () {
        // more difficult, more slowdown
        SlowdownPerSecond = MinSlowdown + (MaxSlowdown - MinSlowdown) * (GameManager.inst == null ? 0.5f : GameManager.inst.difficulty);
    }

    void OnCollisionEnter2D(Collision2D col)
    {
        if (col.gameObject.name == "TreasureObject" || col.gameObject.name == "mordecai" || col.gameObject.name == "arat") {
            print("success");
            waveScript.StopPaddling(true);
        }
    }

    float LastPaddleSuccess = -1.0f;
    float LastPaddleFail = -1.0f;

	// Update is called once per frame
	void Update () {

        // don't update when doing countdown
        if (waveScript.Stage != WavesScript.WaveState.Paddling)
        {
            PaddleSuccess.SetActive(false);
            PaddleFail.SetActive(false);
            PaddlePrompt.SetActive(false);
            return;
        }         

        // slowdown each frame (except the first few frames)
        if(Time.timeSinceLevelLoad > 6.0f)
            waveScript.WAVE_VELOCITY -= SlowdownPerSecond * Time.deltaTime;

        // line ourselves up with wave normal
        Vector2 wave_normal = GetWaveNormal();
        Quaternion desired =  Quaternion.FromToRotation(Vector3.up, wave_normal);
        float damping = 0.8f;
        transform.rotation = Quaternion.Slerp(transform.rotation, desired, damping * Time.deltaTime);

        // do we need to display paddle success/failure?
        if (Time.time - LastPaddleSuccess < 0.5f) {
            PaddleSuccess.SetActive(true);
            PaddleFail.SetActive(false);
            PaddlePrompt.SetActive(false);
        } else if (Time.time - LastPaddleFail < 0.5f) {
            PaddleSuccess.SetActive(false);
            PaddleFail.SetActive(true);
            PaddlePrompt.SetActive(false);
        } else {
            PaddleSuccess.SetActive(false);
            PaddleFail.SetActive(false);
        }

        bool descending = IsDescendingWavePeak();
		// display paddle button prompt
        if (descending) {
            PaddlePrompt.SetActive(true);
        } else {
            PaddlePrompt.SetActive(false);
        }

        // did we paddle?
        if(Input.anyKeyDown) {
            // successfully?
            if(descending) {
                PlayOarSound();
                LastPaddleSuccess = Time.time;
                waveScript.WAVE_VELOCITY += 0.5f;
            } else {
                LastPaddleFail = Time.time;
                waveScript.WAVE_VELOCITY -= 0.5f;  
            }
        }

        if (waveScript.WAVE_VELOCITY <= 0.0f) {
            print("failure");
            waveScript.StopPaddling(false);
        }
    }
}
