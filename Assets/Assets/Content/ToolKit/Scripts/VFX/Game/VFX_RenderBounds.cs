using UnityEngine;

namespace InnoGames.Game.VFX
{
    ///<summary>
    /// Getting the RenderBounds of a Source Game Object, and passing them in to Target Material.
    ///  The material needs following variables: ' _BoundsMin, _BoundsMax, _BoundsCtr, _BoundsSize '
    ///</summary>
    [ExecuteAlways]
    public class VFX_RenderBounds : MonoBehaviour
    {
        private static readonly int BoundsMinPropertyID = Shader.PropertyToID("_BoundsMin");
        private static readonly int BoundsMaxPropertyID = Shader.PropertyToID("_BoundsMax");
        private static readonly int BoundsCtrPropertyID = Shader.PropertyToID("_BoundsCtr");
        private static readonly int BoundsSizePropertyID = Shader.PropertyToID("_BoundsSize");

        [SerializeField] 
        private bool useSkinnedMesh;
        [SerializeField] 
        private GameObject source;
        private MeshRenderer targetMeshRenderer;
        private SkinnedMeshRenderer targetSkinnedMeshRenderer;
        private MaterialPropertyBlock propertyBlock;

        private void Start()
        {
            targetMeshRenderer = source.GetComponent<MeshRenderer>();
            targetSkinnedMeshRenderer = source.GetComponent<SkinnedMeshRenderer>();
            propertyBlock = new MaterialPropertyBlock();
        }

        private void Update()
        {
            Bounds bbox = source.GetComponent<Renderer>().bounds;
            propertyBlock.SetVector(BoundsMinPropertyID, bbox.min);
            propertyBlock.SetVector(BoundsMaxPropertyID, bbox.max);
            propertyBlock.SetVector(BoundsCtrPropertyID, bbox.center);
            propertyBlock.SetVector(BoundsSizePropertyID, bbox.size);

            if (useSkinnedMesh)
            {
                targetSkinnedMeshRenderer.SetPropertyBlock(propertyBlock);
            }

            if (!useSkinnedMesh)
            {
                targetMeshRenderer.SetPropertyBlock(propertyBlock);
            }
        }
    }
}