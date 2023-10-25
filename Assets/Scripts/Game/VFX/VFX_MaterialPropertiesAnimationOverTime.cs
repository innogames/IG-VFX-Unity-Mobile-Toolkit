using System;
using UnityEditor;
using UnityEngine;
using UnityEngine.UI;

namespace InnoGames.Game.VFX
{
	///<summary>
	///This script is created to animated material properties by curve over time.
	///<summary>
	[ExecuteAlways]
	public class VFX_MaterialPropertiesAnimationOverTime : MonoBehaviour
	{
		[Header("Source")]
		[SerializeField]
		private bool getMaterialFromImage;
		[Space(20)]

		[Header("Animation")]
		[SerializeField]
		private bool activateAnimation;
		[SerializeField]
		private bool looping;
		[SerializeField]
		private float timeSpeed;
		[System.Serializable]
		public class AnimationGroup
		{

			public string materialPropertyName;

			public bool setAFloatValue;

			public AnimationCurve timeCurveX, timeCurveY, timeCurveZ, timeCurveW;
		}
		public AnimationGroup[] AnimateProperties;
		private Image targetImage;
		private MeshRenderer targetMeshRenderer;
		private Material targetMaterial;
		private Vector4 time;
		private float floatProperty;
		private int count;
		private float currentTime;


		private void Start()
		{
			GameObject root = gameObject;

			if (getMaterialFromImage)
			{
				targetImage = root.GetComponent<Image>();
			}
			else
			{
				targetMeshRenderer = root.GetComponent<MeshRenderer>();
				targetMaterial = targetMeshRenderer.material;
			}
		}

		private void OnEnable()
		{
			currentTime = 0.0f;
		}

		private void Update()
		{
			if (activateAnimation)
			{
				//MaterialForRendering is the material that will be sent to the CanvasRenderer. This is necessary otherwise the material features will not work with mask operation.
				if (getMaterialFromImage)
				{
					targetMaterial = targetImage.materialForRendering;
				}

				currentTime += Time.deltaTime;
				float timeScale = currentTime * timeSpeed;

				if (looping)
				{
					timeScale = Fractional(timeScale);
				}

				foreach (AnimationGroup animateProperty in AnimateProperties)
				{
					time.x = animateProperty.timeCurveX.Evaluate(timeScale);
					time.y = animateProperty.timeCurveY.Evaluate(timeScale);
					time.z = animateProperty.timeCurveZ.Evaluate(timeScale);
					time.w = animateProperty.timeCurveW.Evaluate(timeScale);

					if (animateProperty.setAFloatValue)
					{
						floatProperty = time.x;
						targetMaterial.SetFloat(animateProperty.materialPropertyName, floatProperty);
					}
					else
					{
						targetMaterial.SetVector(animateProperty.materialPropertyName, time);
					}
				}
			}
		}

		private float Fractional(float value)
		{
			return value - Mathf.Floor(value);
		}
	}
}
