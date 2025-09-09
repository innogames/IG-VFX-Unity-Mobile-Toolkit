#if UNITY_EDITOR

using System.Collections.Generic;
using UnityEditor;
using UnityEngine;

namespace InnoGames.VFX.Rendering
{
	[CustomEditor(typeof(GradientLUT))]
	[CanEditMultipleObjects]
	public class GradientLUTInspector : UnityEditor.Editor
	{
		private readonly List<SerializedObject> serializedObjects = new();

		private void OnEnable()
		{
			serializedObjects.Clear();

			foreach (var subTarget in targets)
			{
				var sObject = new SerializedObject(subTarget);
				serializedObjects.Add(sObject);
			}
		}

		private void OnDisable()
		{
			serializedObjects.Clear();
		}

		private float DrawModifierOption(string label)
		{
			float result = 0;

			EditorGUILayout.BeginHorizontal();

			EditorGUILayout.LabelField(label);

			if (GUILayout.Button("+", GUILayout.MaxWidth(50f)))
			{
				result = 0.025f;
			}

			if (GUILayout.Button("-", GUILayout.MaxWidth(50f)))
			{
				result = -0.025f;
			}
			EditorGUILayout.EndHorizontal();

			return result;
		}

		public override void OnInspectorGUI()
		{
			EditorGUILayout.BeginVertical("Box");
			var hueShift = DrawModifierOption("Hue");
			var valueShift = DrawModifierOption("Value");
			var saturationShift = DrawModifierOption("Saturation");
			EditorGUILayout.EndVertical();

			var valuesChanged = hueShift != 0.0f || valueShift != 0.0f || saturationShift != 0.0f;

			foreach (var sObject in serializedObjects)
			{
				sObject.Update();

				var nameProperty = sObject.FindProperty("m_Name");
				var gradientsProperty = sObject.FindProperty("gradients");
				var textureWidthProperty = sObject.FindProperty("width");

				EditorGUILayout.BeginVertical("Box");
				EditorGUILayout.LabelField(nameProperty.stringValue);
				EditorGUILayout.PropertyField(gradientsProperty);
				EditorGUILayout.PropertyField(textureWidthProperty);
				EditorGUILayout.EndVertical();
				EditorGUILayout.Space(10);

				for (var i = 0; i < gradientsProperty.arraySize; ++i)
				{
					var gradientProperty = gradientsProperty.GetArrayElementAtIndex(i);

					for (var k = 0; k < 8; ++k)
					{
						var keyProperty = gradientProperty.FindPropertyRelative($"key{k}");
						var keyColor = keyProperty.colorValue;

						Color.RGBToHSV(keyColor, out var h, out var s, out var v);

						if (valuesChanged)
						{
							var newColor = Color.HSVToRGB(h + hueShift, s + saturationShift, v + valueShift);
							newColor.a = keyColor.a;
							keyProperty.colorValue = newColor;
						}
					}
				}

				sObject.ApplyModifiedProperties();

				(sObject.targetObject as GradientLUT).CreateTexture();
			}
		}
	}
}
#endif