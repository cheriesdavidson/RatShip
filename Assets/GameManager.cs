using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.SceneManagement;
using UnityEngine.UI;

public class GameManager : MonoBehaviour {

    public const float DEFAULT_TEXT_SPEED = 1.0f;
    public float PlayerTextSpeed = DEFAULT_TEXT_SPEED;
    public GameObject MainMenu;
    public GameObject SettingsMenu;
    public Slider TextSpeedSlider;

    // Use this for initialization
    void Start()
    {
        PlayerTextSpeed = PlayerPrefs.GetFloat("PlayerTextSpeed", DEFAULT_TEXT_SPEED);
        TextSpeedSlider.value = PlayerTextSpeed;
        ShowMainMenu();
    }

    void Awake()
    {

    }

	public void LoadGame(string sceneName)
    {
        //maybe queue this somewhere?
        SceneManager.LoadSceneAsync(sceneName);
    }

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
