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

}

public class DialogueController : MonoBehaviour {

    [SerializeField]
    private TextAsset inkJSONAsset;
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
    private Story story;
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

        //KICK OFF STORY!
        StartStory();
    }

    void StartStory()
    {
        story = new Story(inkJSONAsset.text);
    }

    void Update()
    {
        //check if we're writting stuff
        //{writing functions}
        //return;
        //eliasPlayer.QueueEvent(setLevel.CreateSetLevelEvent(eliasPlayer.Elias));

        //DEAL WITH STORY VARIABLES
        //ELIAS
        if (story.variablesState["audiolevel"] != null)
        {
            EliasController.inst.SetLevel((int)story.variablesState["audiolevel"]);
        }

        if (story.variablesState["audiotheme"] != null)
        {
            EliasController.inst.SetLevel((int)story.variablesState["audiotheme"]);
        }

        //TEXT SPEED
        if (story.variablesState["textspeed"] != null)
            currentTextSpeed = defaultTextSpeed * (int)story.variablesState["textspeed"];


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

        if (story.canContinue && !printing && playerReadyToContinue)
        {
            ProcessStoryLine();
            return;
        }

        //if there's a choice
        if (story.currentChoices.Count > 0 && playerReadyToContinue)
        {
            //hide the player ready thing
            playerTapButton.SetActive(false);
            waitingForChoice = true;
            ShowChoiceDialogue();
            playerReadyToContinue = true;
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
        string text = story.Continue().Trim();
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

        object imageSlot = story.variablesState["leftslot"];
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
        imageSlot = story.variablesState["rightslot"];
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

        }
        else
        {
            //narrative - all appears at once
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
        for (int i = 0; i < story.currentChoices.Count; i++)
        {
            Choice choice = story.currentChoices[i];
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
        story.ChooseChoiceIndex(choice.index);

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
