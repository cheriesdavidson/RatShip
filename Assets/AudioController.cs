using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class AudioController : MonoBehaviour {

    public static AudioController inst;
    private EliasPlayer eliasPlayer;
    [SerializeField]
    public EliasSetLevel setLevel;

    void Awake()
    {   
        if (inst != null)
            Destroy(this);

        DontDestroyOnLoad(gameObject);
        eliasPlayer = GetComponent<EliasPlayer>();
        //SetLevel(0);
    }

    void Update()
    {

        //ELIAS
        if (GameManager.inst.story.variablesState["audiolevel"] != null)
        {
            AudioController.inst.SetLevel((int)GameManager.inst.story.variablesState["audiolevel"]);
        }

        if (GameManager.inst.story.variablesState["audiotheme"] != null)
        {
            AudioController.inst.SetLevel((sting)GameManager.inst.story.variablesState["audiotheme"]);
        }
    }

    public void SetLevel(int level)
    {
        setLevel.level = level;
        eliasPlayer.QueueEvent(setLevel.CreateSetLevelEvent(eliasPlayer.Elias));
    }

    public void SetTheme(string theme)
    {
        setLevel.themeName = theme;
        eliasPlayer.QueueEvent(setLevel.CreateSetLevelEvent(eliasPlayer.Elias));
    }

    //Somethign something random voice
    public void PlayVoice()
    {

    }

}
