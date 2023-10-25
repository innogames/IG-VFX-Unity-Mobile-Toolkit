using UnityEngine;

namespace InnoGames.Game.VFX
{
    ///<summary>
    ///Passing the position from GameObject to the shader variable "_SetPos"
    ///</summary>
    [ExecuteAlways]
    public class VFX_GetTransform : MonoBehaviour
    {
        private static readonly int PositionPropertyID = Shader.PropertyToID("_SetPos");

        public GameObject Source;
        public Material TargetMaterial;

        private void Start()
        {
            TargetMaterial = GetComponent<Renderer>().material;
        }

        private void Update()
        {
            Vector3 getPos = Source.transform.position;
            Vector4 posToSend = new Vector4(getPos.x, getPos.y, getPos.z, 1.0f);

            TargetMaterial.SetVector(PositionPropertyID, posToSend);
        }
    }
}