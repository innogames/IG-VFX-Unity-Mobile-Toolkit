using UnityEngine;

namespace InnoGames.Game.VFX
{
    ///<summary>
    ///This script synchronizes the target object's transform with the source object's transform.
    ///</summary>
    [ExecuteAlways]
    public class VFX_LinkTransform : MonoBehaviour
    {
        [SerializeField] 
        private GameObject Source;
        [SerializeField] 
        private GameObject Target;

        private void Update()
        {
            Vector3 sourcePos = Source.transform.position;
            Vector3 sourceAngles = Source.transform.eulerAngles;
            Vector3 sourceScale = Source.transform.localScale;

            Target.transform.position = sourcePos;
            Target.transform.eulerAngles = sourceAngles;
            Target.transform.localScale = sourceScale;
        }
    }
}