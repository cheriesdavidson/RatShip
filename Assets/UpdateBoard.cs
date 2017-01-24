﻿using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.Serialization;

[System.Serializable]
public struct CharacterSprite
{
    public string name;
    public GameObject spriteOnBoat;
}

public class UpdateBoard : MonoBehaviour {

    [SerializeField]
    CharacterSprite[] characterSprites;
    

	// Use this for initialization
	void Start () {
        UpdateSprites();
    }
	
	// Update is called once per frame
	public void UpdateSprites () {
        //Debug.Log("Updating boat sprites");

        foreach (CharacterSprite c in characterSprites)
        {
            //Debug.Log("Attempting to change " + c.name.ToLower() + "_onboat to "+ GameManager.inst.story.variablesState[c.name.ToLower() + "_onboat"].ToString());
            if (GameManager.inst.story.variablesState[c.name.ToLower() + "_onboat"]==null || GameManager.inst.story.variablesState[c.name.ToLower() + "_onboat"].ToString() != "yes")
                c.spriteOnBoat.SetActive(false);
            else
                c.spriteOnBoat.SetActive(true);
        }
    }
}
