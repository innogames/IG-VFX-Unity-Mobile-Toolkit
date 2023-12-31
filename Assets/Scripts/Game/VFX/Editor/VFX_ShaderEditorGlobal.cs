using System.Collections.Generic;
using UnityEditor;
using UnityEngine;

namespace InnoGames.VFX.Game.Editor
{
	/// <summary>
	/// Base class for shader editors, containing some helper methods like shader properties, showing a common footer etc
	/// </summary>

	public class VFX_ShaderEditorGlobal : ShaderGUI
	{
		protected static readonly Dictionary<string, MaterialProperty> propertyDict = new Dictionary<string, MaterialProperty>();
		protected MaterialEditor materialEditor;
		protected Material material;
		protected MaterialProperty[] properties;
		protected delegate void ToggleChangeDelegate(bool value);
		private static bool ShowDefaultGui;

		public override void OnGUI(MaterialEditor materialEditor, MaterialProperty[] properties)
		{
			this.properties = properties;
			propertyDict.Clear();
			foreach (var property in properties) propertyDict.Add(property.name, property);
			this.materialEditor = materialEditor;
			this.material = (Material) materialEditor.target;
		}

		protected bool FolderFoldOut(bool showPosition, string status)
		{
			return EditorGUILayout.Foldout(showPosition, status);
		}

		protected void SpaceStandard()
		{
			EditorGUILayout.Space(15);
		}

		protected void SpaceSmall()
		{
			EditorGUILayout.Space(10);
		}

		protected bool HandleShaderToggle(string keyword, string label, ToggleChangeDelegate onToggleChange)
		{
			Debug.Assert(propertyDict.ContainsKey(keyword));
			var property = propertyDict[keyword];

			bool before = GetShaderToggle(keyword, 1);
			materialEditor.ShaderProperty(property, label);
			bool result = GetShaderToggle(keyword, 1);
			if (result != before)
			{
				onToggleChange?.Invoke(result);
			}

			return result;
		}

		protected bool HandleShaderToggle(string keyword, string label, bool setKeyword = true)
		{
			ToggleChangeDelegate deleg = null;
			if (setKeyword)
			{
				deleg = (enabled) => SetShaderKeyword(keyword, enabled);
			}

			return HandleShaderToggle(keyword, label, deleg);
		}

		protected void ShaderProperty(string keyword, string label)
		{
			Debug.Assert(propertyDict.ContainsKey(keyword));
			var property = propertyDict[keyword];
			materialEditor.ShaderProperty(property, label);
		}

		protected bool GetShaderToggle(string keyword, int condition)
		{
			return Mathf.Approximately(material.GetFloat(keyword), condition);
		}

		protected void SetShaderKeyword(string keyword, bool isEnabled)
		{
			if (isEnabled)
			{
				material.EnableKeyword(keyword);
				return;
			}

			material.DisableKeyword(keyword);
		}


	}
}

