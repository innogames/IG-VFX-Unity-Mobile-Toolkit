using UnityEngine;

namespace InnoGames.Game.VFX
{
    ///<summary>
    ///It is aliging particles between two vectors.
    ///</summary>
    [ExecuteAlways]
    public class VFX_ParticleConstantPosition : MonoBehaviour
    {
        private static readonly ParticleSystem.Particle[] TargetParticles = new ParticleSystem.Particle[512];
        [Space(20)] 
        
        public GameObject[] TargetParticleSystems;
        [Space(25)] 
        
        public Vector3 EndPosition;

        [SerializeField]
        private Vector3 offset;
        [SerializeField]
        private float phase;
        [SerializeField]
        private float frequency;
        [SerializeField]
        private float amplitude;

        private void Update()
        {
            foreach (var targetParticleSystem in TargetParticleSystems)
            {
                ParticleSystem particleSystem = targetParticleSystem.GetComponent<ParticleSystem>();
                particleSystem.GetParticles(TargetParticles);

                const float pi = Mathf.PI;
                int totalParticles = particleSystem.particleCount;
                Vector3 posEach = EndPosition / totalParticles;
                Vector3 startPosition = new Vector3(0.0f, 0.0f, 0.0f);

                //Compute particle position
                for (int targetId = 0; targetId < particleSystem.particleCount; targetId++)
                {
                    Vector3 getVelocity = TargetParticles[targetId].totalVelocity;
                    Vector3 setPos = TargetParticles[targetId].position;
                    float iter = targetId;
                    setPos = posEach * iter;

                    TargetParticles[targetId].position = setPos + getVelocity;
                }

                //set particle count
                particleSystem.SetParticles(TargetParticles, particleSystem.particleCount);

                //Compute ramp by particle count
                for (int targetId = 0; targetId < particleSystem.particleCount; targetId++)
                {
                    Vector3 getPos = TargetParticles[targetId].position;
                    float normalX = Mathf.InverseLerp(startPosition.x, EndPosition.x, getPos.x);
                    float remapX = Mathf.Lerp(0.0f, 1.0f, normalX);
                    remapX = Mathf.Pow(Mathf.Max(0, Mathf.Cos(pi * ((remapX * frequency) + phase) / 2.0f)), amplitude);

                    TargetParticles[targetId].position += offset * remapX;
                }

                // set offset position
                particleSystem.SetParticles(TargetParticles, particleSystem.particleCount);
            }
        }
    }
}