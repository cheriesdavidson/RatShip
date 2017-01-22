using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class WavesScript : MonoBehaviour {
    public GameObject FinishPoint;

    float MinFinishPositionX = 37.14f;
    float MaxFinishPositionX = 83.38f;
    public float WAVE_VELOCITY = 2.0f;
    
    // Use this for initialization
    void Start () {
        // scale waves based on difficulty / distance

        // move treasure based on distance
        float posx = MinFinishPositionX + (MaxFinishPositionX - MinFinishPositionX) * GameManager.inst.distance;
        FinishPoint.transform.position = new Vector3(posx, FinishPoint.transform.position.y, FinishPoint.transform.position.z);

    }

    // Update is called once per frame
    void Update () {

        // move waves leftwards
        transform.position = new Vector3(transform.position.x - Time.deltaTime * WAVE_VELOCITY, transform.position.y, transform.position.z);
    }
}
