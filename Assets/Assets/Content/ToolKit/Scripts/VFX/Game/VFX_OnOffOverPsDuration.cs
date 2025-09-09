using UnityEngine;

namespace InnoGames.Game.Vfx
{
	/// <summary>
	/// Disables one Game Object and Enables a other one, base on particle system emitter duration.
	/// </summary>
	public class VFX_OnOffOverPsDuration : MonoBehaviour
	{
		public ParticleSystem Ps;
		public GameObject OffObject;
		public GameObject OnObject;
		private float psDuration;

		private void OnEnable()
		{
			var psMain = Ps.main;
			psDuration = psMain.duration;
		}

		private void OnDisable()
		{
			OffObject.SetActive(true);
			OnObject.SetActive(false);
		}

		private void Update()
		{
			var psTime = Ps.time;
			var finished = Mathf.Approximately(psTime, psDuration);

			OffObject.SetActive(!finished);
			OnObject.SetActive(finished);
		}
	}
}
