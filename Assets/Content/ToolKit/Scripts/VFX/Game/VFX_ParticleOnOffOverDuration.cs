using UnityEngine;

namespace InnoGames.Game.Vfx
{
	/// <summary>
	///     Disables one Game Object and Enables a other one, base on particle system emitter duration.
	/// </summary>
	public class VFX_ParticleOnOffOverDuration : MonoBehaviour
	{
		public ParticleSystem Ps;
		public GameObject OffObject;
		public GameObject OnObject;
		private float psDuration;

		private void OnEnable()
		{
			ParticleSystem.MainModule psMain = Ps.main;
			psDuration = psMain.duration;
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
