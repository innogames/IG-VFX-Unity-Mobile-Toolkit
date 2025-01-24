using InnoGames.VFX.Game;
using UnityEditor;
using UnityEngine;

namespace InnoGames.VFX.Editor
{
	/// <summary>
	/// This class is create to make the VFX workflow simpler.
	/// This code creates a new game object with a "VFX_Master" component attached to it.
	/// The script is meant to be used by VFX Artist to quickly create VFX assets with the appropriate components for particle
	/// systems with the right settings.
	/// </summary>
	public static class VFX_CreateObject
	{
		private const string ContextMenuPath = "Assets/Create/VFX/";
		private const string CreateWorldObjectMenuPoint = "Create World Object";
		private const string CreateUiObjectMenuPoint = "Create UI Object";
		private const string CreateProjectileObjectMenuPoint = "Create World Projectile Object";
		private const string CreateSpawnObjectMenuPoint = "Create World Spawn Object";
		private const string VfxObjectPrefix = "VFX_";
		private static GameObject root;

		public static string GetCurrentPath()
		{
			string assetPath;

			assetPath = AssetDatabase.GUIDToAssetPath(Selection.assetGUIDs[0]);
			assetPath += "/";

			return assetPath;
		}

		public static void SavePrefab()
		{
			var assetPath = GetCurrentPath();

			var prefabPath = assetPath + root.name + ".prefab";
			PrefabUtility.SaveAsPrefabAsset(root, prefabPath);

			Object.DestroyImmediate(root);
		}

		public static void CreateGameObject(bool useForUi)
		{
			root = new GameObject();
			root.name = VfxObjectPrefix;

			if (useForUi)
			{
				root.AddComponent<RectTransform>();
			}

			root.AddComponent<VFX_Master>();
			var masterComponent = root.GetComponent<VFX_Master>();
			masterComponent.UseForUi = useForUi;

			SavePrefab();
		}

		[MenuItem(ContextMenuPath, false, 1)]
		public static void Seperator()
		{
		}

		[MenuItem(ContextMenuPath + CreateWorldObjectMenuPoint, false, 10)]
		public static void CreateVFXObject(MenuCommand context)
		{
			CreateGameObject(false);
		}

		[MenuItem(ContextMenuPath + CreateUiObjectMenuPoint, false, 11)]
		public static void CreateVFXUiObject()
		{
			CreateGameObject(true);
		}
	}
}
