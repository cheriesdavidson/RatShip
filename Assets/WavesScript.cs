using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class WavesScript : MonoBehaviour {

 
    public float WAVE_VELOCITY = 2.0f;
    
    // Use this for initialization
    void Start () {
		
	}
	
	// Update is called once per frame
	void Update () {
      
        // move waves leftwards
        transform.position = new Vector3(transform.position.x - Time.deltaTime * WAVE_VELOCITY, transform.position.y, transform.position.z);
    }
}
