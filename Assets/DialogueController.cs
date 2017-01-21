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
    public Image sprite;

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
    Image speakerLeft;
    [SerializeField]
    Image speakerRight;
    [SerializeField]
    Image characterRight;
    [SerializeField]
    Image characterLeft;
    [SerializeField]
    Character[] characters;

    //private
    private Story story;
    private float textSpeed = 1.0f;
    private float nextLetterTime = 0;
    private bool isPrinting = false;

    void Start()
    {
        //INIT
        //make character names lower so we don't need to do that later
        name = name.ToLower();
        for (int i = 0; i < characters.Length; i++)
        {
            characters[i].name = characters[i].name.ToLower();
        }
        

            //KICK OFF STORY!
            //TODO: This should probably driven by 
        StartStory();
    }

    void StartStory()
    {
        story = new Story(inkJSONAsset.text);
        RefreshView();
    }

    void Update()
    {
        //check if we're writting stuff
        //{writing function}

        //
    }


    void RefreshView()
    {
        //Cleanup
        RemoveChildren(choiceContainer);
        textBox.text = "";

        while (story.canContinue)
        {
            string text = story.Continue().Trim();
            //make this print out slowly

            //any slot updates

            //TODO: Check this line actually works and update the string that greg is using!
            Image image;

            object speaker = story.variablesState["slotLeft"];
            if (speaker != null) {
                image = GetCharacterImage(speaker.ToString());
                if (image != null)
                    characterLeft = image;
            }
            speaker = story.variablesState["slotRight"];
            if (speaker != null)
            {
                image = GetCharacterImage(speaker.ToString());
                if (name !=null )
                    characterLeft = image;
            }

            //then we want to check for character!
            string[] splits = text.Split(':');
            

            //who is talking - update their
            //what slot are they in?

            //do something to wait
            textBox.text = text;
        }

        if (story.currentChoices.Count > 0)
        {
            //active the choices screen!
            choiceContainer.SetActive(true);
            for (int i = 0; i < story.currentChoices.Count; i++)
            {
                Choice choice = story.currentChoices[i];
                Transform choiceGo = Instantiate(choiceButtonPrefab).GetComponent<Transform>();
                choiceGo.SetParent(choiceContainer.transform);
                Button choiceButton = choiceGo.GetComponent<Button>();
                choiceButton.onClick.AddListener(delegate {
                    OnClickChoiceButton(choice);
                });
            }
        }
        else {
            //Story is over?
            //Button choice = CreateChoiceView("End of story.\nRestart?");
            /*choice.onClick.AddListener(delegate {
                StartStory();
            });*/
        }
    }

    void OnClickChoiceButton(Choice choice)
    {
        story.ChooseChoiceIndex(choice.index);

        //hide button container & delete buttons
        choiceContainer.SetActive(false);
        RemoveChildren(choiceContainer);
        RefreshView();
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

    Image GetCharacterImage(string name)
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
