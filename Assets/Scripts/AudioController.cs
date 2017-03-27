using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class AudioController : MonoBehaviour {

    public static AudioController inst;
    private EliasPlayer eliasPlayer;
    [SerializeField]
    public EliasSetLevel setLevel;
    private EliasHelper eh;

    void Awake()
    {   
        if (inst != null)
        {
            inst.eliasPlayer.Stop(); // you'd think that destroying it would stop it, but nope, gotta call stop to actually stop the music first!
            Destroy(inst);
        }
            
        inst = this;
        DontDestroyOnLoad(gameObject);
        eliasPlayer = GetComponent<EliasPlayer>();
    }

    void Start()
    {
        SetLevel(20);
    }

    void Update()
    {

        if (GameManager.inst.story != null)
        {

            /*
            if (GameManager.inst.story.variablesState["audiotheme"] != null)
            {
                AudioController.inst.SetTheme((string)GameManager.inst.story.variablesState["audiotheme"]);
            }*/
        }
    }

    public void JumpToBar(int level)
    {
        setLevel.level = level;
        eliasPlayer.QueueEvent(setLevel.CreateSetLevelEvent(eliasPlayer.Elias));
    }

    public void SetLevel(int level)
    {
        setLevel.level = level;
        eliasPlayer.QueueEvent(setLevel.CreateSetLevelEvent(eliasPlayer.Elias));
    }

    public void SetTheme(string theme)
    {
        //setLevel.themeName = theme;
        //eliasPlayer.QueueEvent(setLevel.CreateSetLevelEvent(eliasPlayer.Elias));
    }

    //Somethign something random voice
    public void PlayVoice()
    {

    }

}
