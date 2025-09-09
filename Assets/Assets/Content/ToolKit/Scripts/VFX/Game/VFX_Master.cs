#if UNITY_EDITOR
using System.IO;
using UnityEditor;
using UnityEngine;

namespace InnoGames.VFX.Game
{
	/// <summary>
	/// This script is used with VFX_CreateObject class.
	/// This class is just used in the editor. For usability and workflow reasons this it is written as a MonoBehaviour.
	/// It is creating and modifying VFX assets, such as particle systems and materials, using the Unity AssetDatabase API.
	/// </summary>
	public class VFX_Master : MonoBehaviour
	{
		private const string MasterPrefix = "Master";
		private const string LookUpTextureSuffix = "_Lut";
		
		[Header("VFX Master Creator")]
		[Space(25)]
		[Header("Set Names")]
		[SerializeField]
		private string masterName;
		[SerializeField]
		private string materialName;
		[SerializeField]
		private string lutTextureName;
		[Space(25)]
		[Header("Global Properties")]
		[SerializeField]
		private string materialDefault = "Assets/Assets/Content/ToolKit/VFX/Template/VFX_Template_Particle.mat";
		[SerializeField]
		private string trailMaterialDefault = "Assets/Assets/Content/ToolKit/VFX/Template/VFX_Template_Trail.mat";
		[SerializeField]
		private string lutDefault = "Assets/Assets/Content/ToolKit/VFX/Template/VFX_Template_LUT_01.asset";

		public string PrefabFolder
		{
			get
			{
				var assetPath = PrefabUtility.GetPrefabAssetPathOfNearestInstanceRoot(gameObject);
				var result = Path.GetDirectoryName(assetPath) + "\\";
				return result;
			}
		}

		private GameObject GetRoot()
		{
			return gameObject;
		}

		public void AddMaster()
		{
			var master = new GameObject();

			master.transform.parent = gameObject.transform;
			master.name = MasterPrefix + "_" + masterName;
			var vfxParticleSystemTypes = master.AddComponent<VFX_ParticleSystemTypes>();
			ParticleSystem masterPs = master.AddComponent<ParticleSystem>();
			ParticleSystemRenderer psRenderer = masterPs.GetComponent<ParticleSystemRenderer>();

			var emission = masterPs.emission;
			var shape = masterPs.shape;
			var rendererMode = ParticleSystemRenderMode.None;
			emission.enabled = false;
			shape.enabled = false;
			psRenderer.enabled = false;
			psRenderer.renderMode = rendererMode;
			
			vfxParticleSystemTypes.MaterialDefault = materialDefault;
			vfxParticleSystemTypes.TrailMaterialDefault = trailMaterialDefault;
			vfxParticleSystemTypes.LutDefault = lutDefault;
		}

		public void AddMaterial()
		{
			string materialPath;
			materialPath = materialDefault;
			
			var matName = GetRoot().name + "_" + materialName;
			var assetMaterial = PrefabFolder + matName + ".mat";
			AssetDatabase.CopyAsset(materialPath, assetMaterial);
			var vfxMaterial = AssetDatabase.LoadAssetAtPath<Material>(assetMaterial);
			EditorUtility.SetDirty(vfxMaterial);
		}

		public void AddLutTexture()
		{
			var lutTexName = GetRoot().name + "_" + lutTextureName + LookUpTextureSuffix;
			var lutTextureAsset = PrefabFolder + lutTexName + ".asset";
			AssetDatabase.CopyAsset(lutDefault, lutTextureAsset);
			var lutTexture = AssetDatabase.LoadAssetAtPath<Texture>(lutTextureAsset);

			EditorUtility.SetDirty(lutTexture);
		}
	}
}
#endif
