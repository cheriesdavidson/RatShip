using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.SceneManagement;


public class GameManager : MonoBehaviour {

    void Awake()
    {

    }

	public void LoadGame(string sceneName)
    {
        //maybe queue this somewhere?
        SceneManager.LoadSceneAsync(sceneName);
    }
}
