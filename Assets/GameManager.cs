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

    public void LoadWaveSection(float d = 0)
    {
        waveSectionComplete = false;
        difficulty = d;
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
