using UnityEngine;

namespace InnoGames.Game.VFX
{
    ///<summary>
    ///The Rotation of the Source GameObject is scaling tge traget object by a curve.
    ///<summary>
    [ExecuteAlways]
    public class VFX_ScaleByRotation : MonoBehaviour
    {
        public GameObject Target;
        public Vector2 AnglesRangeX, AnglesRangeY, AnglesRangeZ;
        [SerializeField]
        private AnimationCurve curveScaleX, curveScaleY, curveScaleZ;
        private Vector3 angles;
        private float normalY, remapY, normalZ, remapZ, normalX, remapX;

        private void Update()
        {
            angles = Target.transform.eulerAngles;
            normalX = Mathf.InverseLerp(AnglesRangeX.x, AnglesRangeX.y, angles.x);
            normalY = Mathf.InverseLerp(AnglesRangeY.x, AnglesRangeY.y, angles.y);
            normalZ = Mathf.InverseLerp(AnglesRangeZ.x, AnglesRangeZ.y, angles.z);

            remapX = Mathf.Lerp(0, 1, normalX);
            remapY = Mathf.Lerp(0, 1, normalY);
            remapZ = Mathf.Lerp(0, 1, normalZ);

            float scaleX = curveScaleX.Evaluate(remapX);
            float scaleY = curveScaleY.Evaluate(remapY);
            float scaleZ = curveScaleZ.Evaluate(remapZ);
            transform.localScale = new Vector3(scaleX + scaleY + scaleZ, scaleX + scaleY + scaleZ, scaleX + scaleY + scaleZ);
        }
    }
}