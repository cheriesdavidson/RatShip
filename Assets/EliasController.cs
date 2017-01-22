using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class EliasController : MonoBehaviour {

    public static EliasController inst;
    private EliasPlayer eliasPlayer;
    [SerializeField]
    public EliasSetLevel setLevel;

    void Awake()
    {
        inst = this;
        eliasPlayer = GetComponent<EliasPlayer>();
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

}
