using System;
using UnityEngine;

namespace InnoGames.VFX.Rendering
{
	[CreateAssetMenu(fileName = "New GradientLUT", menuName = "VFX/GradientLUT", order = 0)]
	public class GradientLUT : ScriptableObject
	{
		[SerializeField]
		private Gradient[] gradients = Array.Empty<Gradient>();

		[Range(8, 256)]
		[SerializeField]
		private int width = 16;

		[SerializeField]
		private Texture2D texture;

#if UNITY_EDITOR
		public void CreateTexture()
		{
			if (texture == null)
			{
				texture = new Texture2D(1, 1, TextureFormat.RGBA32, false);
				texture.wrapMode = TextureWrapMode.Clamp;
				UnityEditor.AssetDatabase.AddObjectToAsset(texture, this);
			}

			texture.name = $"{name}_Texture";
			var height = Math.Max(1, gradients.Length);
			texture.Reinitialize(width, height);

			for (var y = 0; y < gradients.Length; y++)
			{
				var gradient = gradients[y];
				for (var x = 0; x < width; x++)
				{
					var interp = x / (float)(width - 1);
					var color = gradient.Evaluate(interp).linear;
					texture.SetPixel(x, y, color);
				}
			}

			texture.Apply();
		}

		private void OnDestroy()
		{
			if (texture != null)
			{
				Destroy(texture);
			}
		}
#endif
	}
}
