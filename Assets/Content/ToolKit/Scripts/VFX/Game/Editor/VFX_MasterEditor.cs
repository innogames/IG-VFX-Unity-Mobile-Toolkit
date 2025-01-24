using InnoGames.VFX.Game;
using UnityEditor;
using UnityEngine;

/// <summary>
/// This script is used with VFX_Master class.
/// It is creating a buttons in the inspector.
/// </summary>
[CustomEditor(typeof(VFX_Master))]
public class VFX_MasterEditor : Editor
{
	public override void OnInspectorGUI()
	{
		base.OnInspectorGUI();
		var script = (VFX_Master) target;

		if (GUILayout.Button("Add VFX Master", GUILayout.Height(20)))
		{
			script.AddMaster();
		}

		if (GUILayout.Button("Add VFX Material", GUILayout.Height(20)))
		{
			script.AddMaterial();
		}

		if (GUILayout.Button("Add VFX LUT Texture", GUILayout.Height(20)))
		{
			script.AddLutTexture();
		}

		// if (GUILayout.Button("Add VFX Variant", GUILayout.Height(20)))
		// {
		// 	script.AddVariant();
		// }
	}
}
