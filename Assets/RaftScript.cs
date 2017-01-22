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
    public Text Speed;

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

    void UpdateVelocityText()
    {
        Speed.text = "Speed: " + waveScript.WAVE_VELOCITY;
    }

	// Use this for initialization
	void Start () {
        // more difficult, less time
        SlowdownPerSecond = MinSlowdown + (MaxSlowdown - MinSlowdown) * GameManager.difficulty;
        UpdateVelocityText();
    }

    void OnCollisionEnter2D(Collision2D col)
    {
        if (col.gameObject.name == "TreasureObject") {
            print("success");
            //GameManager.CompleteWaves(true);
        }
    }

    float LastPaddleSuccess = -1.0f;
    float LastPaddleFail = -1.0f;

	// Update is called once per frame
	void Update () {

        // slowdown each frame (except the first few frames)
        if(Time.timeSinceLevelLoad > 0.5f)
            waveScript.WAVE_VELOCITY -= SlowdownPerSecond * Time.deltaTime;

        UpdateVelocityText();

        // line ourselves up with wave normal
        Vector2 wave_normal = GetWaveNormal();
        Quaternion desired =  Quaternion.FromToRotation(Vector3.up, wave_normal);
        float damping = 0.5f;
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
                LastPaddleSuccess = Time.time;
                waveScript.WAVE_VELOCITY += 0.5f;
            } else {
                LastPaddleFail = Time.time;
                waveScript.WAVE_VELOCITY -= 0.5f;
                if(waveScript.WAVE_VELOCITY<=0.0f) { 
                    print("failure");
                    //GameManager.CompleteWaves(false);
                }
            }
        }
    }
}
