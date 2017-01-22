using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.SceneManagement;
using UnityEngine.UI;
using Ink.Runtime;

public class GameManager : MonoBehaviour {

    public static GameManager inst;

    [SerializeField]
    private TextAsset storyJSON;

    public const float DEFAULT_TEXT_SPEED = 1.0f;
    public float PlayerTextSpeed = DEFAULT_TEXT_SPEED;
    public GameObject MainMenu;
    public GameObject SettingsMenu;
    public Slider TextSpeedSlider;

    public bool waveSectionComplete = false;

    public float difficulty;
    public float distance;
    public string rescuetarget;
    public bool paddlingSuccess;
    public Story story;


    void Awake()
    {
        if (inst != null)
        {
            Destroy(this);
        }

        inst = this;
        DontDestroyOnLoad(gameObject);
        gameObject.SetActive(true);
    }

    // Use this for initialization
    void Start()
    {
        PlayerTextSpeed = PlayerPrefs.GetFloat("PlayerTextSpeed", DEFAULT_TEXT_SPEED);
        TextSpeedSlider.value = PlayerTextSpeed;
        ShowMainMenu();
    }

    //GAME MANAGEMENT

    public void StartGame()
    {
        story = new Story(storyJSON.text);
        waveSectionComplete = false;
        paddlingSuccess = false;
        SceneManager.LoadScene("Dialogue");

    }

    void Update (){
        if (Input.GetKeyDown(KeyCode.Escape)){
            Application.Quit();
        }
    }

    public void LoadWaveSection()
    {
        waveSectionComplete = false;

        difficulty = (story.variablesState["difficulty"]!=null) ? (float)story.variablesState["difficulty"] : 0.0f ;
        distance = 0.0f;// (story.variablesState["distance"]!=null) ? (float)story.variablesState["distance"] : 0.0f ;
        rescuetarget = (story.variablesState["rescuetarget"] != null) ? (string)story.variablesState["rescuetarget"] : "";
        SceneManager.LoadScene("Waves");   
    }

    public void CompleteWaveSection(bool success)
    {
        waveSectionComplete = true;
        paddlingSuccess = success;
        SceneManager.LoadScene("Dialogue"); 
    }


    //SETTINGS INFO

    public void ShowMainMenu()
    {
        MainMenu.SetActive(true);
        SettingsMenu.SetActive(false);
    }

    public void ShowSettings()
    {
        TextSpeedSlider.value = PlayerTextSpeed;
        MainMenu.SetActive(false);
        SettingsMenu.SetActive(true);
    }

    public void SaveSettings()
    {
        PlayerTextSpeed = TextSpeedSlider.value;
        PlayerPrefs.SetFloat("PlayerTextSpeed", PlayerTextSpeed);
        ShowMainMenu();
    }

    
}
