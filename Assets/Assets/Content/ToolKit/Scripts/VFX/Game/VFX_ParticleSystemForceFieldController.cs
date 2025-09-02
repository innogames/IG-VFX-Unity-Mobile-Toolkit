using System.Collections;
using System.Collections.Generic;
using UnityEngine;

namespace InnoGames.Game.VFX
{
	///<summary>
	///In summary, this script gradually changes the gravity property of a Particle System Force Field over time using an AnimationCurve.
	/// The intensity of the force field is controlled by the curve, providing a dynamic and animated effect to the associated Particle System.
	///<summary>
	[ExecuteAlways]
	public class VFX_ParticleSystemForceFieldController : MonoBehaviour
	{
		[SerializeField]
		private ParticleSystemForceField targetForceField;
		public AnimationCurve timeCurve;
		private float psDurationTime;
		private float currentTime;

		private void OnEnable()
		{
			currentTime = 0.0f;

			var sourceParticleSystem = gameObject.GetComponent<ParticleSystem>();
			sourceParticleSystem.Play();
			psDurationTime = sourceParticleSystem.main.duration;
		}

		private void Update()
		{
			currentTime += Time.deltaTime;
			float timeScale = currentTime / psDurationTime;

			targetForceField.gravity = timeCurve.Evaluate(timeScale);
		}
	}
}
