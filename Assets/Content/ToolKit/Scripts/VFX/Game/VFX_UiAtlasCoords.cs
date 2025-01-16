using UnityEngine;
using UnityEngine.UI;

namespace InnoGames.VFX.Game
{
	public class VFX_UiAtlasCoords : BaseMeshEffect
	{
		[SerializeField]
		private Image target;

		private Vector2 _xValues;
		private Vector2 _yValues;
		private Sprite _lastSprite;

		private static UIVertex _vertex;

		// Note: Start() is not necessary here, since the values are set in Update() anyway.
		// But since Update() may be too expensive, I leave it here. Remove either Start() or Update() or both depending on how you update
		// the sprite.
		protected override void Start()
		{
			base.Start();
			SetValues();
		}

		protected virtual void Update()
		{
			if (target == null || target.sprite == null || target.sprite == _lastSprite)
			{
				return;
			}

			_lastSprite = target.sprite;
			SetValues();
		}

		public void SetTarget(Image value)
		{
			target = value;
		}

		public void SetValues()
		{
			if (target == null || target.sprite == null)
			{
				return;
			}

			var sprite = target.sprite;

			var atlasWidth = sprite.texture.width;
			var atlasHeight = sprite.texture.height;

			var normalizedX = sprite.textureRect.x / atlasWidth;
			var normalizedW = sprite.textureRect.width / atlasWidth;
			var normalizedY = sprite.textureRect.y / atlasHeight;
			var normalizedH = sprite.textureRect.height / atlasHeight;

			_xValues = new Vector2(normalizedX, normalizedW);
			_yValues = new Vector2(normalizedY, normalizedH);

			SetDirty();
		}

		public override void ModifyMesh(VertexHelper _vh)
		{
			var vertexCount = _vh.currentVertCount;

			if (vertexCount < 1)
			{
				return;
			}

			if (graphic != null && graphic.canvas != null)
			{
				graphic.canvas.additionalShaderChannels |= AdditionalCanvasShaderChannels.TexCoord1 |
					AdditionalCanvasShaderChannels.TexCoord2;
			}

			var numVertices = _vh.currentVertCount;
			for (var i = 0; i < numVertices; i++)
			{
				_vh.PopulateUIVertex(ref _vertex, i);
				_vertex.uv1 = _xValues;
				_vertex.uv2 = _yValues;
				_vh.SetUIVertex(_vertex, i);
			}
		}

#if UNITY_EDITOR
		protected override void Reset()
		{
			if (target != null)
			{
				return;
			}

			if (TryGetComponent(out Image image))
			{
				target = image;
			}
		}
#endif

		private void SetDirty()
		{
			var graphicComponent = GetComponent<Graphic>();
			graphicComponent.SetVerticesDirty();
		}
	}
}
