using System.Collections;
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
        foreach (CharacterSprite c in characterSprites)
        {
            Debug.Log("Attempting to change " + c.name.ToLower() + "_onboat");
            if (GameManager.inst.story.variablesState[c.name.ToLower() + "_onboat"].ToString() == "yes")
                c.spriteOnBoat.SetActive(true);
            else
                c.spriteOnBoat.SetActive(false);
        }
    }
}
