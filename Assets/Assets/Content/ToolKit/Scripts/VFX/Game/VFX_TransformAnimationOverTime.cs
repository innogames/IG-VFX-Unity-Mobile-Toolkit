using UnityEngine;

namespace InnoGames.Game.VFX
{
	/// <summary>
	/// This script is created to animated transform properties by curve over time.
	/// <summary>
	[ExecuteAlways]
	public class VFX_TransformAnimationOverTime : MonoBehaviour
	{
		[Header("Target")]
		[SerializeField]
		private Transform targetTransform;

		[Space(20)]
		[Header("Animation")]
		[SerializeField]
		private bool looping;
		[SerializeField]
		private float timeSpeed;

		[Space(20)]
		[Header("Position")]
		[Space(5)]
		[SerializeField]
		private bool AnimatedPosition;
		[SerializeField]
		private Vector3 position;
		[SerializeField]
		private Vector3 positionMin;
		[SerializeField]
		private Vector3 positionMax;
		[SerializeField]
		private AnimationCurve positionCurveX;
		[SerializeField]
		private AnimationCurve positionCurveY;
		[SerializeField]
		private AnimationCurve positionCurveZ;

		[Space(20)]
		[Header("Rotation")]
		[SerializeField]
		private bool AnimatedRotation;
		[SerializeField]
		private Vector3 rotation;
		[SerializeField]
		private Vector3 rotationMin;
		[SerializeField]
		private Vector3 rotationMax;
		[SerializeField]
		private AnimationCurve rotationCurveX;
		[SerializeField]
		private AnimationCurve rotationCurveY;
		[SerializeField]
		private AnimationCurve rotationCurveZ;

		[Space(20)]
		[Header("Scale")]
		[SerializeField]
		private bool AnimatedScale;
		[SerializeField]
		private Vector3 scale = new Vector3(1.0f, 1.0f, 1.0f);
		[SerializeField]
		private Vector3 scaleMin = new Vector3(1.0f, 1.0f, 1.0f);
		[SerializeField]
		private Vector3 scaleMax = new Vector3(1.0f, 1.0f, 1.0f);
		[SerializeField]
		private AnimationCurve scaleCurveX, scaleCurveY, scaleCurveZ;
		private Vector4 time;
		private float floatProperty;
		private int count;
		private float currentTime;

		private float Fractional(float value) => value - Mathf.Floor(value);

		private Vector3 AddByRange(Vector3 value, Vector3 min, Vector3 max, Vector3 interpolate)
		{
			Vector3 setValue = new Vector3(0.0f, 0.0f, 0.0f);

			setValue.x = Mathf.Lerp(value.x - min.x, value.x + max.x, interpolate.x);
			setValue.y = Mathf.Lerp(value.y - min.y, value.y + max.y, interpolate.y);
			setValue.z = Mathf.Lerp(value.z - min.z, value.z + max.z, interpolate.z);

			return setValue;
		}

		private Vector3 MultiplyByRange(Vector3 value, Vector3 min, Vector3 max, Vector3 interpolate)
		{
			Vector3 setValue = new Vector3(0.0f, 0.0f, 0.0f);

			setValue.x = Mathf.Lerp(value.x * min.x, value.x * max.x, interpolate.x);
			setValue.y = Mathf.Lerp(value.y * min.y, value.y * max.y, interpolate.y);
			setValue.z = Mathf.Lerp(value.z * min.z, value.z * max.z, interpolate.z);

			return setValue;
		}

		private void PositionAnimation(float time, Vector3 position, Vector3 min, Vector3 max)
		{
			Vector3 positionCurve = new Vector3(positionCurveX.Evaluate(time), positionCurveY.Evaluate(time), positionCurveZ.Evaluate(time));
			targetTransform.localPosition = AddByRange(position, min, max, positionCurve);
		}

		private void RotationAnimation(float time, Vector3 rotation, Vector3 min, Vector3 max)
		{
			Vector3 rotationCurve = new Vector3(rotationCurveX.Evaluate(time), rotationCurveY.Evaluate(time), rotationCurveZ.Evaluate(time));
			targetTransform.localEulerAngles = AddByRange(rotation, min, max, rotationCurve);
		}

		private void ScaleAnimation(float time, Vector3 scale, Vector3 min, Vector3 max)
		{
			Vector3 scaleCurve = new Vector3(scaleCurveX.Evaluate(time), scaleCurveY.Evaluate(time), scaleCurveZ.Evaluate(time));
			targetTransform.localScale = MultiplyByRange(scale, min, max, scaleCurve);
		}

		private void OnValidate()
		{
			targetTransform = GetComponent<Transform>();
		}

		private void OnEnable()
		{
			currentTime = 0.0f;
		}

		private void Update()
		{
			currentTime += Time.deltaTime;
			var timeScale = currentTime * timeSpeed;

			if (looping)
			{
				timeScale = Fractional(timeScale);
			}

			if (AnimatedPosition)
			{
				PositionAnimation(timeScale, position, positionMin, positionMax);
			}

			if (AnimatedRotation)
			{
				RotationAnimation(timeScale, rotation, rotationMin, rotationMax);
			}

			if (AnimatedScale)
			{
				ScaleAnimation(timeScale, scale, scaleMin, scaleMax);
			}
		}
	}
}
