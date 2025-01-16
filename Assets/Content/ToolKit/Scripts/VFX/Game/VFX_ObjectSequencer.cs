using UnityEngine;

namespace InnoGames.Game.Vfx
{
	/// <summary>
	/// VFX_ObjectSequencer, enables and disables specified GameObjects based on time, using serialized parameters and timing conditions.
	/// </summary>
	public class VFX_ObjectSequencer : MonoBehaviour
	{
		[SerializeField]
		private float delayStartSequence;
		[Space(25)]
		[SerializeField]
		private GameObject objectToDisable;
		[SerializeField]
		private float delayToDisable;
		[Space(25)]
		[SerializeField]
		private GameObject objectToEnable;
		[SerializeField]
		private float durationUntilEnable;
		[SerializeField]
		private float delayToEnable;
		private float totalDuration;
		private float disableDuration;
		private float enableDuration;
		private float currentTime;

		private void OnEnable()
		{
			currentTime = 0.0f;
			totalDuration = durationUntilEnable + delayStartSequence;
			disableDuration = totalDuration + delayToDisable;
			enableDuration = totalDuration + delayToEnable;
			objectToDisable.SetActive(false);
		}

		private void OnDisable()
		{
			objectToDisable.SetActive(true);
			objectToEnable.SetActive(false);
		}

		private void Update()
		{
			currentTime += Time.deltaTime;

			if (currentTime >= delayStartSequence)
			{
				objectToDisable.SetActive(true);

				if (currentTime > disableDuration)
				{
					objectToDisable.SetActive(false);
				}

				if (currentTime > enableDuration)
				{
					objectToEnable.SetActive(true);
				}
			}
		}
	}
}
