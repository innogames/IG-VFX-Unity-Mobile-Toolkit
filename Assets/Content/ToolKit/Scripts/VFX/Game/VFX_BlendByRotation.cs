using UnityEngine;

namespace InnoGames.Game.VFX
{
	/// <summary>
	/// The rotation of the source gameObject is driving target particle material vector4 property.
	/// <summary>
	[ExecuteAlways]
	public class VFX_BlendByRotation : MonoBehaviour
	{
		[SerializeField]
		private GameObject Source;
		[SerializeField]
		private string PropertyName;
		[SerializeField]
		private Vector4 MinBlend;
		[SerializeField]
		private Vector4 MaxBlend;
		[SerializeField]
		private Vector2 AnglesRangeX, AnglesRangeY, AnglesRangeZ;
		[SerializeField]
		private AnimationCurve CurveScaleX, CurveScaleY, CurveScaleZ;
		private Vector3 angles;
		private float normalY, remapY, normalZ, remapZ, normalX, remapX;
		private MaterialPropertyBlock propertyBlock;
		private ParticleSystemRenderer targetRenderer;

		private void Start()
		{
			propertyBlock = new MaterialPropertyBlock();

			targetRenderer = GetComponent<ParticleSystemRenderer>();
			targetRenderer.GetPropertyBlock(propertyBlock);
		}

		private void Update()
		{
			angles = Source.transform.eulerAngles;
			normalX = Mathf.InverseLerp(AnglesRangeX.x, AnglesRangeX.y, angles.x);
			normalY = Mathf.InverseLerp(AnglesRangeY.x, AnglesRangeY.y, angles.y);
			normalZ = Mathf.InverseLerp(AnglesRangeZ.x, AnglesRangeZ.y, angles.z);

			remapX = Mathf.Lerp(0, 1, normalX);
			remapY = Mathf.Lerp(0, 1, normalY);
			remapZ = Mathf.Lerp(0, 1, normalZ);

			var scaleX = CurveScaleX.Evaluate(remapX);
			var scaleY = CurveScaleY.Evaluate(remapY);
			var scaleZ = CurveScaleZ.Evaluate(remapZ);
			var blend = Vector4.Lerp(MinBlend, MaxBlend, scaleX + scaleY + scaleZ);

			propertyBlock.SetVector(PropertyName, blend);
			targetRenderer.SetPropertyBlock(propertyBlock);
		}
	}
}
