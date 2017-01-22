using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class WavesScript : MonoBehaviour {
    public GameObject FinishPoint;
    public GameObject Raft;

    float MinFinishPositionX = 37.14f;
    float MaxFinishPositionX = 83.38f;
    public float WAVE_VELOCITY = 2.0f;

    float StartDistanceToTarget = 0.0f;

    void SetRescueTargetVisible(string target)
    {
        bool found = false;
        int children = FinishPoint.transform.childCount;
        for (int i = 0; i < children; ++i) {
            GameObject child = FinishPoint.transform.GetChild(i).gameObject;

            if (child.name == target) {
                found = true;
                child.SetActive(true);
            }
            else {
                child.SetActive(false);
            }      
        }

        if(!found) {
            GameObject treasure = GameObject.Find("TreasureObject");
            treasure.SetActive(true);
        }
    }

    float GetDistanceRaftToFinalSq()
    {
        Vector2 dist = FinishPoint.transform.position - Raft.transform.position;
         return dist.SqrMagnitude();
    }

    // Use this for initialization
    void Start () {
        // scale waves based on difficulty 


        // move treasure based on distance
        float posx = MinFinishPositionX + (MaxFinishPositionX - MinFinishPositionX) * (GameManager.inst==null ? 0.0f : GameManager.inst.distance);
        FinishPoint.transform.position = new Vector3(posx, FinishPoint.transform.position.y, FinishPoint.transform.position.z);

        // draw who we are rescuing
        string target = "mordecai"; //GameManager.inst.rescuetarget
        SetRescueTargetVisible(target);

        StartDistanceToTarget = GetDistanceRaftToFinalSq();
    }

    // Update is called once per frame
    void Update () {

        // move waves leftwards
        transform.position = new Vector3(transform.position.x - Time.deltaTime * WAVE_VELOCITY, transform.position.y, transform.position.z);

        // how far to raft?  tension music
        float dist = GetDistanceRaftToFinalSq() / StartDistanceToTarget;
        //print(dist);
        if (AudioController.inst) {
            if (dist < .25f) {
                AudioController.inst.SetLevel(3);
            } else if (dist < .5f) {
                AudioController.inst.SetLevel(2);
            } else if(dist < .75f) {
                AudioController.inst.SetLevel(1);
            } else {
                AudioController.inst.SetLevel(0);
            }
        }  
    }
}
