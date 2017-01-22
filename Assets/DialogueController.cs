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
    public AudioClip[] voice;
    [SerializeField]
    public bool onShip;

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
    Text titleCardText;
    [SerializeField]
    Animator titleCardAnimator;
    [SerializeField]
    VoiceManager voiceManager;
    [SerializeField]
    UpdateBoard boat;
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
    private bool isTitleCardActive = false;

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

        //AudioController.inst.SetLevel(0);

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
                    if (isTitleCardActive)
                        titleCardText.text += currentDialogue[currentLetter];
                    else
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
            //ELIAS
            if (GameManager.inst.story.variablesState["audiolevel"] != null)
            {
                AudioController.inst.SetLevel((int)GameManager.inst.story.variablesState["audiolevel"]);
                Debug.Log("Changing audio to " + (int)GameManager.inst.story.variablesState["audiolevel"] + " level");
            }

            //if not printing and titlecard is active, we get rid of the title card
            if (isTitleCardActive)
            {
                titleCardAnimator.gameObject.SetActive(false);
                titleCardText.text = "";
                isTitleCardActive = false;
            }

            ProcessStoryLine();
            return;
        }

        //if there's a choice
        if (GameManager.inst.story.currentChoices.Count > 0 && playerReadyToContinue)
        {

            boat.UpdateSprites();

            if (GameManager.inst.story.variablesState["paddlingsection"] != null)
            {

                if ((string)GameManager.inst.story.variablesState["paddlingsection"] == "true") {

                    if (!GameManager.inst.waveSectionComplete)
                    {
                        GameManager.inst.LoadWaveSection();
                    }
                    else
                    {
                        characterLeft.gameObject.SetActive(false);
                        characterRight.gameObject.SetActive(false);
                        speakerLabel.transform.parent.gameObject.SetActive(false);

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
            if (isTitleCardActive)
                titleCardText.text = currentDialogue;
            else
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

        //stop audio!
        voiceManager.Stop();

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
                sprite = GetCharacter(imageSlot.ToString()).sprite;
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
                sprite = GetCharacter(imageSlot.ToString()).sprite;
                if (name != null)
                    characterRight.sprite = sprite;
            }
        }

        //then we want to check for character!
        string[] splits = text.Split(':');


        if (splits.Length > 1) //assume this is a character thing
        {
            //if title screen
            if (splits[0].ToLower() == "title")
            {
                //run the title card
                titleCardAnimator.gameObject.SetActive(true);
                isTitleCardActive = true;

            }
            else { //assume it's a char

                //do speaker card stuff:
                char[] speakerName = splits[0].ToString().ToLower().ToCharArray();
                speakerName[0] = speakerName[0].ToString().ToUpper()[0];
                speakerLabel.text = new string(speakerName);
                textBox.fontStyle = FontStyle.Normal;

                //make the speaker label active
                speakerLabel.transform.parent.gameObject.SetActive(true);

                //play voice!
                voiceManager.Play(GetCharacter(speakerLabel.text).voice);
            }
            currentDialogue = splits[1].Trim();
        }
        else
        {
            //narrative - all appears at once
            speakerLabel.transform.parent.gameObject.SetActive(false);
            currentDialogue = splits[0].Trim();
            textBox.fontStyle = FontStyle.Italic;
        }

        textBox.text = "";
        titleCardText.text = "";
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

    Character GetCharacter(string name)
    {
        name = name.ToLower();
        for (int i = 0; i < characters.Length; i++)
        {
            if (characters[i].name == name)
                return characters[i];
        }
        Debug.LogError("Cannot find sprite for character " + name);
        return new Character();
    }


}
