using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class WavesScript : MonoBehaviour {
    public GameObject ParentFinishPoint;
    public GameObject ChosenFinishPoint;
    public GameObject Raft;
    private Camera MainCamera;

    float MinFinishPositionX = 37.14f;
    float MaxFinishPositionX = 83.38f;
    public float WAVE_VELOCITY = 2.0f;

    float StartDistanceToTarget = 0.0f;

    float OriginalChosenTargetY = 0.0f; // used for bobbing


    void SetRescueTargetVisible(string target)
    {
        bool found = false;
        GameObject treasure = GameObject.Find("TreasureObject");

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
            treasure.SetActive(true);
            ChosenFinishPoint = treasure;
        }

        OriginalChosenTargetY = ChosenFinishPoint.transform.position.y;
    }

    float GetDistanceRaftToFinalSq()
    {
        Vector2 dist = ChosenFinishPoint.transform.position - Raft.transform.position;
         return dist.SqrMagnitude();
    }

    private Vector3 InitialRaftScreenPos = new Vector3(-1,-1,-1);
    private Vector3 FinalRaftScreenPos = new Vector3(-1, -1, -1);
    // try to line things up so that when we reach the target our boat is on the RHS of the screen
    private void UpdateCameraSpeed()
    {
        if (InitialRaftScreenPos == new Vector3(-1, -1, -1))
        {
            MainCamera = Camera.main;
            InitialRaftScreenPos = MainCamera.WorldToScreenPoint(Raft.transform.position);
            FinalRaftScreenPos = new Vector3(MainCamera.pixelWidth - InitialRaftScreenPos.x, InitialRaftScreenPos.y, InitialRaftScreenPos.z);
            //print("InitialRaftScreenPos " + InitialRaftScreenPos);
            //print("FinalRaftScreenPos " + FinalRaftScreenPos);
        }

        Vector3 raft_to_finish = ChosenFinishPoint.transform.position - Raft.transform.position;
        float time_left = raft_to_finish.x / WAVE_VELOCITY;
        //print("time_left " + time_left);

        Vector3 current_raft_screen_pos = MainCamera.WorldToScreenPoint(Raft.transform.position);
        float desired_camera_speed = (FinalRaftScreenPos.x - current_raft_screen_pos.x) / time_left;
        //print("desired_camera_speed " + desired_camera_speed);

        Vector3 desired_camera_pos = new Vector3(MainCamera.transform.position.x - desired_camera_speed, MainCamera.transform.position.y, MainCamera.transform.position.z);
        MainCamera.transform.position = Vector3.MoveTowards(MainCamera.transform.position, desired_camera_pos, Time.deltaTime);
    }

    private float bobStrength = 0.05f;
    private float bobFrequency = 7.0f;

    private void BobChosenTarget()
    {
        Vector3 floatY = ChosenFinishPoint.transform.position;
        floatY.y = OriginalChosenTargetY + (Mathf.Sin(bobFrequency*Time.time) * bobStrength);
        ChosenFinishPoint.transform.position = floatY;
    }

    // Use this for initialization
    void Start () {
        // scale waves based on difficulty 

        // draw who we are rescuing
        string target = GameManager.inst == null ? "mordecai" : GameManager.inst.rescuetarget;
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

        UpdateCameraSpeed();
        BobChosenTarget();

        // how far to raft?  tension music
        float dist = GetDistanceRaftToFinalSq() / StartDistanceToTarget;
        if (AudioController.inst) {
            if (dist < .25f) {
                AudioController.inst.SetLevel(16);
            } else if (dist < .5f) {
                AudioController.inst.SetLevel(15);
            } else if(dist < .75f) {
                AudioController.inst.SetLevel(14);
            } else {
                AudioController.inst.SetLevel(13);
            }
        }  
    }
}
