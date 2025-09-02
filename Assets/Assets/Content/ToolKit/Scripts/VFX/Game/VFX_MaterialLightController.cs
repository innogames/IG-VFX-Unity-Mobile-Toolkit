using System;
using UnityEngine;

namespace InnoGames.VFX.Game
{
	/// <summary>
	/// This Unity script controls and updates material properties for visual effects based on a source object's position.
	/// It allows customization of global properties like color, strength, and brightness and applies these settings to
	/// multiple target objects with optional per-object adjustments.
	/// </summary>
	[ExecuteAlways]
	public class VFX_MaterialLightController : MonoBehaviour
	{
		[Header("Source")]
		[Space(10)]
		private GameObject source;

		[Header("Global Properties")]
		[Space(10)]
		[SerializeField]
		private Color gradientColor;
		[SerializeField]
		private float gradientStrength;
		[SerializeField]
		private float gradientBrightness;
		[SerializeField]
		private Vector3 lightPosition;
		[SerializeField]
		private float lightRange;
		[SerializeField]
		private float lightFallOff;
		[SerializeField]
		private float lightHardness;

		[Serializable]
		public class TargetComponent
		{
			[Header("Target")]
			[Space(10)]
			public string name;
			public GameObject Target;
			public bool UseGlobalSettings;
			public Vector4 SetPosition;

			[Header("Target Components")]
			[Space(10)]
			public ParticleSystemRenderer TargetParticleSystemRenderer;
		}

		[SerializeField]
		private TargetComponent[] targetComponents = Array.Empty<TargetComponent>();
		private MaterialPropertyBlock propertyBlock;
		private Transform sourceTransform;
		private Vector4 wpPosition;

		[NonSerialized]
		private bool isInitialized;

		private void GetSourceData()
		{
			source = gameObject;
			sourceTransform = source.GetComponent<Transform>();
		}

		private void GetSourceDataOnUpdate()
		{
			wpPosition = new Vector4(sourceTransform.position.x, sourceTransform.position.y, sourceTransform.position.z,
				0.0f);
		}

		private void SetMaterialData(bool UseInUpdate)
		{
			foreach (var targetComponent in targetComponents)
			{
				propertyBlock = new MaterialPropertyBlock();
				targetComponent.TargetParticleSystemRenderer =
					targetComponent.Target.GetComponent<ParticleSystemRenderer>();
				targetComponent.name = targetComponent.TargetParticleSystemRenderer.name;

				if (UseInUpdate)
				{
					targetComponent.TargetParticleSystemRenderer.GetPropertyBlock(propertyBlock);
					targetComponent.SetPosition = wpPosition;
					propertyBlock.SetVector("_SetPos", wpPosition);
				}
				else
				{
					if (targetComponent.UseGlobalSettings)
					{
						propertyBlock.SetColor("_GradientColor", gradientColor);
						propertyBlock.SetFloat("_GradientStrength", gradientStrength);
						propertyBlock.SetFloat("_GradientBrightness", gradientBrightness);
						propertyBlock.SetVector("_LightPos", lightPosition);
						propertyBlock.SetFloat("_LightRange", lightRange);
						propertyBlock.SetFloat("_LightFallOff", lightFallOff);
						propertyBlock.SetFloat("_LightHardness", lightHardness);
					}
				}

				targetComponent.TargetParticleSystemRenderer.SetPropertyBlock(propertyBlock);
			}
		}

#if UNITY_EDITOR
		private void OnValidate()
		{
			if (!isInitialized)
			{
				return;
			}

			SetMaterialData(false);
		}
#endif

		private void OnEnable()
		{
			GetSourceData();
			SetMaterialData(false);

			isInitialized = true;
		}

		private void Update()
		{
			GetSourceDataOnUpdate();
			SetMaterialData(true);
		}
	}
}
