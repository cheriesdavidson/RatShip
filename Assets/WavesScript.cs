using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class WavesScript : MonoBehaviour {
    public GameObject ParentFinishPoint;
    public GameObject ChosenFinishPoint;
    public GameObject Raft;

    float MinFinishPositionX = 37.14f;
    float MaxFinishPositionX = 83.38f;
    public float WAVE_VELOCITY = 2.0f;

    float StartDistanceToTarget = 0.0f;

    void SetRescueTargetVisible(string target)
    {
        bool found = false;
        int children = ParentFinishPoint.transform.childCount;
        print("children:" + children);
        for (int i = 0; i < children; ++i) {
            GameObject child = ParentFinishPoint.transform.GetChild(i).gameObject;

            if (child.name == target) {
                print("activating:" + child.name);
                ChosenFinishPoint = child;
                found = true;
                child.SetActive(true);
            }
            else {
                print("deactivating:" + child.name);
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
        Vector2 dist = ChosenFinishPoint.transform.position - Raft.transform.position;
         return dist.SqrMagnitude();
    }

    // Use this for initialization
    void Start () {
        // scale waves based on difficulty 



        // draw who we are rescuing
        string target = "mordecai"; //GameManager.inst.rescuetarget
        SetRescueTargetVisible(target);

        // move treasure based on distance
        float posx = MinFinishPositionX + (MaxFinishPositionX - MinFinishPositionX) * (GameManager.inst == null ? 0.0f : GameManager.inst.distance);
        ChosenFinishPoint.transform.position = new Vector3(posx, ChosenFinishPoint.transform.position.y, ChosenFinishPoint.transform.position.z);

        StartDistanceToTarget = GetDistanceRaftToFinalSq();
    }

    // Update is called once per frame
    void Update () {

        // move waves leftwards
        transform.position = new Vector3(transform.position.x - Time.deltaTime * WAVE_VELOCITY, transform.position.y, transform.position.z);

        // how far to raft?  tension music
        float dist = GetDistanceRaftToFinalSq() / StartDistanceToTarget;
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
