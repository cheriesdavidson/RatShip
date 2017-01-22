using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.UI;
using Ink.Runtime;

[System.Serializable]
struct Character
{
    [SerializeField]
    public string name;
    [SerializeField]
    public Sprite sprite;
    [SerializeField]
    public AudioClip voice;

}

public class DialogueController : MonoBehaviour {

    [SerializeField]
    Text textBox;
    [SerializeField]
    GameObject choiceContainer;
    [SerializeField]
    GameObject choiceButtonPrefab;
    [SerializeField]
    Text speakerLabel;
    [SerializeField]
    Image characterRight;
    [SerializeField]
    Image characterLeft;
    [SerializeField]
    GameObject playerTapButton;
    [SerializeField]
    Character[] characters;


    //private
    private float defaultTextSpeed = 0.03f;
    private float currentTextSpeed;
    private float nextLetterTime = 0;
    private int currentLetter = 0;
    private string currentDialogue;
    private bool waitingForChoice = false;
    private bool printing = false;
    private bool playerReadyToContinue = true;

    void Start()
    {
        //INIT
        //make character names lower so we don't need to do that later
        name = name.ToLower();
        for (int i = 0; i < characters.Length; i++)
        {
            characters[i].name = characters[i].name.ToLower();
        }

        currentDialogue = "";
        currentLetter = 0;
        currentTextSpeed = defaultTextSpeed;
        textBox.text = "";

    }

    void Update()
    {
        //check if we're writting stuff
        //{writing functions}
        //return;
        //eliasPlayer.QueueEvent(setLevel.CreateSetLevelEvent(eliasPlayer.Elias));

        //TEXT SPEED
        if (GameManager.inst.story.variablesState["textspeed"] != null)
            currentTextSpeed = defaultTextSpeed * (int)GameManager.inst.story.variablesState["textspeed"];


        //DEAL WITH ACTUAL GAME RENDERING
        if (printing)
        {
            if (Time.time > nextLetterTime)
            {
                //print the next letter
                if (currentLetter < currentDialogue.Length)
                {
                    //if we still have things to print...
                    //update lates

                    nextLetterTime = Time.time + currentTextSpeed;
                    textBox.text += currentDialogue[currentLetter];
                    currentLetter++;

                }
                else
                {
                    //we're out of bounds and done
                    printing = false;
                }
            }
            return;
        }

        //if there's more story do something stuff...
        if (waitingForChoice)
        {
            return;
        }

        if (GameManager.inst.story.canContinue && !printing && playerReadyToContinue)
        {
            ProcessStoryLine();
            return;
        }

        //if there's a choice
        if (GameManager.inst.story.currentChoices.Count > 0 && playerReadyToContinue)
        {

            if (GameManager.inst.story.variablesState["paddlingsection"] != null)
            {
                Debug.Log((string)GameManager.inst.story.variablesState["paddlingsection"]);

                if ((string)GameManager.inst.story.variablesState["paddlingsection"] == "true") {

                    if (!GameManager.inst.waveSectionComplete)
                    {
                        GameManager.inst.LoadWaveSection();
                    }
                    else
                    {
                        characterLeft.gameObject.SetActive(false);
                        characterRight.gameObject.SetActive(false);
                        speakerLabel.gameObject.SetActive(false);

                        if (GameManager.inst.paddlingSuccess)
                            GameManager.inst.story.ChooseChoiceIndex(0);
                        else
                            GameManager.inst.story.ChooseChoiceIndex(1);

                    }

                }
                else
                {
                    //hide the player ready thing
                    playerTapButton.SetActive(false);
                    waitingForChoice = true;
                    ShowChoiceDialogue();
                    playerReadyToContinue = true;
                }
            }
            
            else
                Debug.LogError("Padding section variable not set!");


            return;
        }
        //something something figure out if player is in game over state?
    }
    public void PlayerTap()
    {
        if (printing)
        {
            //display all text!
            textBox.text = currentDialogue;
            printing = false;

        }
        else if (!playerReadyToContinue){
            playerReadyToContinue = true;
        }

    }

    void ProcessStoryLine()
    {
        //gets the next set of text?
        string text = GameManager.inst.story.Continue().Trim();
        if (text.Length == 0)
        {
            return;
        }

        playerReadyToContinue = false;
        playerTapButton.SetActive(true);

        //make this print out slowly
        //any slot updates

        //TODO: Check this line actually works and update the string that greg is using!
        Sprite sprite;

        object imageSlot = GameManager.inst.story.variablesState["leftslot"];
        if (imageSlot != null)
        {
            if (imageSlot.ToString().ToLower() == "empty")
            {
                characterLeft.gameObject.SetActive(false);
            }
            else {
                characterLeft.gameObject.SetActive(true);
                sprite = GetCharacterSprite(imageSlot.ToString());
                if (sprite != null)
                    characterLeft.sprite = sprite;
            }
        }
        imageSlot = GameManager.inst.story.variablesState["rightslot"];
        if (imageSlot != null)
        {
            if (imageSlot.ToString().ToLower() == "empty")
            {
                characterRight.gameObject.SetActive(true);
            }
            else {
                sprite = GetCharacterSprite(imageSlot.ToString());
                if (name != null)
                    characterRight.sprite = sprite;
            }
        }

        //then we want to check for character!
        string[] splits = text.Split(':');
        if (splits.Length > 1) //assume this is a character thing
        {
            //manually make caps nice
            char[] speakerName = splits[0].ToString().ToLower().ToCharArray();
            speakerName[0] = speakerName[0].ToString().ToUpper()[0];
            speakerLabel.text = new string(speakerName);
            currentDialogue = splits[1].Trim();
            textBox.fontStyle = FontStyle.Normal;
            speakerLabel.gameObject.SetActive(true);
        }
        else
        {
            //narrative - all appears at once
            speakerLabel.gameObject.SetActive(false);
            currentDialogue = splits[0].Trim();
            textBox.fontStyle = FontStyle.Italic;
        }

        textBox.text = "";
        currentLetter = 0;
        nextLetterTime = Time.time + currentTextSpeed;
        printing = true;

    }

    void ShowChoiceDialogue()
    {
        //active the choices screen!
        choiceContainer.SetActive(true);
        for (int i = 0; i < GameManager.inst.story.currentChoices.Count; i++)
        {
            Choice choice = GameManager.inst.story.currentChoices[i];
            Transform choiceGo = Instantiate(choiceButtonPrefab).GetComponent<Transform>();
            choiceGo.SetParent(choiceContainer.transform);
            Button choiceButton = choiceGo.GetComponent<Button>();
            choiceGo.GetComponentInChildren<Text>().text = choice.text;
            choiceButton.onClick.AddListener(delegate {
                OnClickChoiceButton(choice);
            });
        }
        waitingForChoice = true;

        return;
    }


    void OnClickChoiceButton(Choice choice)
    {
        GameManager.inst.story.ChooseChoiceIndex(choice.index);

        //hide button container & delete buttons
        choiceContainer.SetActive(false);
        RemoveChildren(choiceContainer);
        textBox.text = "";
        waitingForChoice = false;
    }

    void RemoveChildren(GameObject parentGo)
    {
        Transform parent = parentGo.transform;
        int childCount = parent.childCount;
        for (int i = childCount - 1; i >= 0; --i)
        {
            GameObject.Destroy(parent.GetChild(i).gameObject);
        }
    }

    Sprite GetCharacterSprite(string name)
    {
        name = name.ToLower();
        for (int i = 0; i < characters.Length; i++)
        {
            if (characters[i].name == name)
                return characters[i].sprite;
        }
        Debug.LogError("Cannot find sprite for character " + name);
        return null;
    }


}
