using System;
using UnityEngine;
using UnityEngine.UI;

namespace InnoGames.Game.VFX
{
	/// <summary>
	/// This script is created to animated material properties by curve over time.
	/// <summary>
	[ExecuteAlways]
	public class VFX_MaterialPropertiesAnimationOverTime : MonoBehaviour
	{
		[Header("Source")]
		[SerializeField]
		private bool getMaterialFromImage;
		[SerializeField]
		private bool getMaterialFromSkinnedMesh;
		[SerializeField]
		private bool getMaterialFromTrailRender;
		[SerializeField]
		private bool getMaterialFromLineRender;
		[SerializeField]
		private bool getMaterialFromParticleSystem;
		[SerializeField]
		private bool getMaterialFromParticleSystemTrail;
		[Space(20)]
		[Header("Animation")]
		[SerializeField]
		private bool activateAnimation;
		[SerializeField]
		private bool looping;
		[SerializeField]
		private float timeSpeed;

		[Serializable]
		public class AnimationGroup
		{
			public string materialPropertyName;

			public bool setAFloatValue;

			public AnimationCurve timeCurveX, timeCurveY, timeCurveZ, timeCurveW;
		}

		public AnimationGroup[] AnimateProperties;
		private Image targetImage;
		private MeshRenderer targetMeshRenderer;
		private SkinnedMeshRenderer targetSkinnedMeshRenderer;
		private TrailRenderer targetTrailRenderer;
		private LineRenderer targetLineRenderer;
		private ParticleSystemRenderer targetParticleSystemRenderer;
		private Material targetMaterial;
		private Vector4 time;
		private float floatProperty;
		private int count;
		private float currentTime;

		private void Start()
		{
			var root = gameObject;

			if (getMaterialFromImage)
			{
				targetImage = root.GetComponent<Image>();
				if (targetImage == null)
				{
					Debug.Log("Image is not assigned to the GameObject. Please assign an Image to the GameObject.");
				}
			}
			else if (getMaterialFromSkinnedMesh)
			{
				targetSkinnedMeshRenderer = root.GetComponent<SkinnedMeshRenderer>();
				if (targetSkinnedMeshRenderer == null)
				{
					Debug.Log("SkinnedMeshRenderer is not assigned to the GameObject. Please assign a SkinnedMeshRenderer to the GameObject.");
					return;
				}
				targetMaterial = targetSkinnedMeshRenderer.sharedMaterial;
			}
			else if (getMaterialFromTrailRender)
			{
				targetTrailRenderer = root.GetComponent<TrailRenderer>();
				if (targetTrailRenderer == null)
				{
					Debug.Log("TrailRenderer is not assigned to the GameObject. Please assign a TrailRenderer to the GameObject.");
					return;
				}
				targetMaterial = targetTrailRenderer.sharedMaterial;
			}
			else if (getMaterialFromLineRender)
			{
				targetLineRenderer = root.GetComponent<LineRenderer>();
				if (targetLineRenderer == null)
				{
					Debug.Log("LineRenderer is not assigned to the GameObject. Please assign a LineRenderer to the GameObject.");
					return;
				}
				targetMaterial = targetLineRenderer.sharedMaterial;
			}
			else if (getMaterialFromParticleSystem)
			{
				targetParticleSystemRenderer = root.GetComponent<ParticleSystemRenderer>();
				if (targetParticleSystemRenderer == null)
				{
					Debug.Log("ParticleSystemRenderer is not assigned to the GameObject. Please assign a ParticleSystemRenderer to the GameObject.");
					return;
				}
				targetMaterial = targetParticleSystemRenderer.sharedMaterial;
			}
			else if (getMaterialFromParticleSystemTrail)
			{
				targetParticleSystemRenderer = root.GetComponent<ParticleSystemRenderer>();
				if (targetParticleSystemRenderer == null)
				{
					Debug.Log("ParticleSystemRenderer is not assigned to the GameObject. Please assign a ParticleSystemRenderer to the GameObject.");
					return;
				}
				targetMaterial = targetParticleSystemRenderer.trailMaterial;
			}
			else
			{
				targetMeshRenderer = root.GetComponent<MeshRenderer>();
				if (targetMeshRenderer == null)
				{
					Debug.Log("MeshRenderer is not assigned to the GameObject. Please assign a MeshRenderer to the GameObject.");
					return;
				}
				targetMaterial = targetMeshRenderer.sharedMaterial;
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
				var timeScale = currentTime * timeSpeed;

				if (looping)
				{
					timeScale = Fractional(timeScale);
				}

				if (targetMaterial)
				{
					foreach (var animateProperty in AnimateProperties)
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
		}

		private float Fractional(float value) => value - Mathf.Floor(value);
	}
}
