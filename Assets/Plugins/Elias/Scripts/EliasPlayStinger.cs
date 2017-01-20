using System;

[Serializable]
public class EliasPlayStinger
{
	public elias_event_flags flags;
	public uint preWaitTimeMs;
	public string transitionPresetName;
	public string name;
	public int level;

	public elias_event_play_stinger CreatePlayerStingerEvent(EliasHelper elias)
	{
		return new elias_event_play_stinger((uint)flags, preWaitTimeMs, elias.GetTransitionPresetIndex(transitionPresetName), name, level);
	}
}