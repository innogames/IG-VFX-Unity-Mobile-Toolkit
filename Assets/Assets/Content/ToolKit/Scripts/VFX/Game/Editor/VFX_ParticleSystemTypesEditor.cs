using InnoGames.VFX.Game;
using UnityEditor;
using UnityEngine;

/// <summary>
/// This script is used with VFX_ParticleSystemTypes class.
/// It is creating a button in the inspector.
/// </summary>
[CustomEditor(typeof(VFX_ParticleSystemTypes))]
public class VFX_ParticleSystemTypesEditor : Editor
{
	public override void OnInspectorGUI()
	{
		base.OnInspectorGUI();
		var script = (VFX_ParticleSystemTypes) target;

		if (GUILayout.Button("Add Particle System", GUILayout.Height(20)))
		{
			script.AddVFXParticles();
		}

		if (GUILayout.Button("Add VFX Trail Renderer", GUILayout.Height(20)))
		{
			script.AddVFXTrail();
		}

		if (GUILayout.Button("Add VFX Line Renderer", GUILayout.Height(20)))
		{
			script.AddVFXLine();
		}
	}
}
