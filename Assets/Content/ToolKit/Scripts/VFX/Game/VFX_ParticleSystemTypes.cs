#if UNITY_EDITOR
using System.Collections.Generic;
using System.IO;
//using Coffee.UIExtensions;
using UnityEditor;
using UnityEngine;

namespace InnoGames.VFX.Game
{
	/// <summary>
	/// This script is used with VFX_Master class.
	/// This class is just used in the editor. For usability and workflow reasons this it is written as a MonoBehaviour.
	/// This is code is creating a particle system component.
	/// The method AddVFXParticles() sets various properties of the ParticleSystem, including its shape, render mode, and
	/// material.
	/// </summary>
	public class VFX_ParticleSystemTypes : MonoBehaviour
	{
		[Header("VFX Particle System")]
		[Space(25)]
		public bool UseForUi;
		[Space(25)]
		[SerializeField]
		private bool Stretched_Billboard;
		[SerializeField]
		private bool MeshParticles;
		[SerializeField]
		private bool assignMaterial;
		[SerializeField]
		private string addName;
		[Tooltip("Just change if you need other template assets")]
		[Space(25)]
		[Header("Global Properties")]
		public string MaterialDefault;
		public string TrailMaterialDefault;
		public string UiMaterialDefault;
		public string LutDefault;

		public string PrefabFolder
		{
			get
			{
				var assetPath = PrefabUtility.GetPrefabAssetPathOfNearestInstanceRoot(gameObject);
				var result = Path.GetDirectoryName(assetPath) + "/";
				return result;
			}
		}

		private new ParticleSystem particleSystem;
		private ParticleSystemRenderer particleSystemRender;
		private TrailRenderer trailRenderer;
		private LineRenderer lineRenderer;

		private string ParentName()
		{
			var parentName = gameObject.transform.parent.gameObject.name;
			return parentName;
		}

		private void ParticleSystemSetup()
		{
			//Setup Main
			var main = particleSystem.main;
			main.duration = 1.0f;
			main.startLifetime = 1.0f;
			main.startSpeed = 0.0f;
			main.scalingMode = ParticleSystemScalingMode.Hierarchy;
			var emission = particleSystem.emission;
			emission.enabled = true;
			emission.SetBursts(new ParticleSystem.Burst[] {new(0.0f, 1)});
			emission.rateOverTime = 0.0f;
			var shape = particleSystem.shape;
			shape.enabled = false;

			if (Stretched_Billboard)
			{
				main.startSpeed = 1.0f;
				main.scalingMode = ParticleSystemScalingMode.Hierarchy;
			}

			//Setup Renderer
			particleSystemRender.alignment = ParticleSystemRenderSpace.Local;
			particleSystemRender.renderMode = ParticleSystemRenderMode.Billboard;

			if (MeshParticles)
			{
				var defaultMeshPath =
					AssetDatabase.LoadAssetAtPath<Mesh>("Assets/Content/ArtAssets/VFX/HeroCity/VFX_Template_Mesh.fbx");
				particleSystemRender.renderMode = ParticleSystemRenderMode.Mesh;
				particleSystemRender.mesh = defaultMeshPath;
			}

			if (Stretched_Billboard)
			{
				particleSystemRender.renderMode = ParticleSystemRenderMode.Stretch;
			}
		}

		private void CustomDataSetup()
		{
			// Shouldn't be called for UI asset
			Debug.Assert(!UseForUi);

			var customData = particleSystem.customData;

			customData.enabled = true;
			customData.SetMode(ParticleSystemCustomData.Custom1, ParticleSystemCustomDataMode.Vector);
			customData.SetVectorComponentCount(ParticleSystemCustomData.Custom1, 4);
			customData.SetMode(ParticleSystemCustomData.Custom2, ParticleSystemCustomDataMode.Vector);
			customData.SetVectorComponentCount(ParticleSystemCustomData.Custom2, 4);

			if (MeshParticles)
			{
				particleSystemRender.SetActiveVertexStreams(new List<ParticleSystemVertexStream>(
					new ParticleSystemVertexStream[]
					{
						ParticleSystemVertexStream.Position, ParticleSystemVertexStream.Normal,
						ParticleSystemVertexStream.Color, ParticleSystemVertexStream.Custom1XYZW,
						ParticleSystemVertexStream.Custom2XYZW, ParticleSystemVertexStream.UV,
						ParticleSystemVertexStream.UV2, ParticleSystemVertexStream.UV3
					}));
				return;
			}

			particleSystemRender.SetActiveVertexStreams(new List<ParticleSystemVertexStream>(
				new ParticleSystemVertexStream[]
				{
					ParticleSystemVertexStream.Position, ParticleSystemVertexStream.Normal,
					ParticleSystemVertexStream.Color, ParticleSystemVertexStream.Custom1XYZW,
					ParticleSystemVertexStream.Custom2XYZW, ParticleSystemVertexStream.UV
				}));
		}

		private void MaterialSetup(bool particle, bool trail, bool line)
		{
			//Assign Material
			var materialType = MaterialDefault;

			if (trail || line)
			{
				materialType = TrailMaterialDefault;
			}

			if (UseForUi)
			{
				materialType = UiMaterialDefault;
			}

			var vfxMaterial = AssetDatabase.LoadAssetAtPath<Material>(materialType);

			if (assignMaterial)
			{
				var name = ParentName() + "_" + addName;
				var assetMaterial = PrefabFolder + name + ".mat";
				AssetDatabase.CopyAsset(materialType, assetMaterial);

				var lutTexName = name + "_Lut";
				var lutTextureAsset = PrefabFolder + lutTexName + ".asset";
				AssetDatabase.CopyAsset(LutDefault, lutTextureAsset);
				var lutTexture = AssetDatabase.LoadAssetAtPath<Texture>(lutTextureAsset);
				EditorUtility.SetDirty(lutTexture);

				vfxMaterial = AssetDatabase.LoadAssetAtPath<Material>(assetMaterial);
				vfxMaterial.SetTexture("_LookUpTex", lutTexture);
			}

			//Assign Material
			if (particle)
			{
				particleSystemRender.sharedMaterial = vfxMaterial;
			}

			if (trail)
			{
				trailRenderer.sharedMaterial = vfxMaterial;
			}

			if (line)
			{
				lineRenderer.sharedMaterial = vfxMaterial;
			}

			EditorUtility.SetDirty(vfxMaterial);
		}

		public void CreateChild(bool particle, bool trail, bool line)
		{
			//Add vfxObject
			GameObject vfxObject = new();
			vfxObject.transform.parent = transform;

			//Setup Child
			if (particle)
			{
				vfxObject.name = "PFX_" + addName;
				vfxObject.AddComponent(typeof(ParticleSystem));
				particleSystem = vfxObject.GetComponent<ParticleSystem>();
				particleSystemRender = particleSystem.GetComponent<ParticleSystemRenderer>();
			}

			if (trail)
			{
				vfxObject.name = "VFX_" + addName;
				trailRenderer = vfxObject.AddComponent<TrailRenderer>();
			}

			if (line)
			{
				vfxObject.name = "VFX_" + addName;
				lineRenderer = vfxObject.AddComponent<LineRenderer>();
			}

			if (UseForUi)
			{
				vfxObject.AddComponent<RectTransform>();

				if (particle)
				{
					//vfxObject.AddComponent<UIParticle>();
				}
			}

			if (particle)
			{
				ParticleSystemSetup();

				if (!UseForUi)
				{
					CustomDataSetup();
				}
			}
		}

		public void AddVFXParticles()
		{
			CreateChild(true, false, false);
			MaterialSetup(true, false, false);
			Debug.Log(ParentName());
		}

		public void AddVFXTrail()
		{
			CreateChild(false, true, false);
			MaterialSetup(false, true, false);
		}

		public void AddVFXLine()
		{
			CreateChild(false, false, true);
			MaterialSetup(false, false, true);
		}
	}
}
#endif
