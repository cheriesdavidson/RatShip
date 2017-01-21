using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.SceneManagement;

public class RaftScript : MonoBehaviour {

    public GameObject PaddlePrompt;
    public GameObject PaddleSuccess;
    public GameObject PaddleFail;
    public WavesScript waveScript;
    public int SuccessCount = 0;
    public int FailCount = 0;
    public bool GotTreasure = false;

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

	// Use this for initialization
	void Start () {
        SuccessCount = 0;
        FailCount = 0;
        GotTreasure = false;
    }


    void OnCollisionEnter2D(Collision2D col)
    {
        print(col.gameObject.name);
        if (col.gameObject.name == "TreasureObject") {
            print("success");
            GotTreasure = true;
            SceneManager.LoadScene("blank");
        }
    }

    float LastPaddleSuccess = -1.0f;
    float LastPaddleFail = -1.0f;

	// Update is called once per frame
	void Update () {
    
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
                LastPaddleSuccess = Time.time;
                SuccessCount++;
                waveScript.WAVE_VELOCITY += 0.5f;
            } else {
                LastPaddleFail = Time.time;
                FailCount++;
                waveScript.WAVE_VELOCITY -= 0.5f;
                if(waveScript.WAVE_VELOCITY<=0.0f) { 
                    print("failure");
                    SceneManager.LoadScene("blank");
                }
            }
        }
    }
}
