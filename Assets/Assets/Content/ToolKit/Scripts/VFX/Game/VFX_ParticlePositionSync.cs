using UnityEngine;

namespace InnoGames.Game.VFX
{
    ///<summary>
    ///This script is synchronizing the target particles position with the source position.
    ///</summary>
    [ExecuteAlways]
    public class VFX_ParticlePositionSync : MonoBehaviour
    {
        private static readonly ParticleSystem.Particle[] SourceParticles = new ParticleSystem.Particle[512];
        private static readonly ParticleSystem.Particle[] TargetParticles = new ParticleSystem.Particle[512];

        [SerializeField] 
        [Space(5)] 
        
        [Header("Particles Systems To Sync")]
        [Space(20)]
        
        public GameObject SourceParticleSystem;
        public GameObject[] TargetParticleSystems;

        [SerializeField]
        [Space(5)]
        
        [Header("Synced Emission Module")] [Space(20)]
        private float rateOverTime = 0.0f;

        [SerializeField] 
        private float burstTime;
        [SerializeField]
        private int burstCount;
        [Space(5)]
        
        [Header("Target Particles Manipultion")]
        [Space(20)]
        
        [SerializeField]
        private Vector2 offset;

        [SerializeField]
        private ParticleSystem sourceSys;

        private void Start()
        {
            sourceSys = SourceParticleSystem.GetComponent<ParticleSystem>();

            //Set Emission on all Particle Systems
            ParticleSystem.EmissionModule sourceEmission = sourceSys.emission;
            sourceEmission.enabled = true;
            sourceEmission.rateOverTime = rateOverTime;
            sourceEmission.SetBursts(new ParticleSystem.Burst[] {new ParticleSystem.Burst(burstTime, burstCount)});

            foreach (GameObject TargetParticleSystem in TargetParticleSystems)
            {
                var particleSystem = TargetParticleSystem.GetComponent<ParticleSystem>();
                var targetEmission = particleSystem.emission;
                targetEmission.enabled = true;
                targetEmission.rateOverTime = rateOverTime;
                targetEmission.SetBursts(new ParticleSystem.Burst[] {new ParticleSystem.Burst(burstTime, burstCount)});
            }
        }

        private void Update()
        {
            //Get particles from source system		
            sourceSys.GetParticles(SourceParticles);

            //Get each target particle system
            foreach (GameObject TargetParticleSystem in TargetParticleSystems)
            {
                var particleSystem = TargetParticleSystem.GetComponent<ParticleSystem>();
                particleSystem.GetParticles(TargetParticles);

                //Get each particles of each target particle system 
                for (int targetId = 0; targetId < particleSystem.particleCount; targetId++)
                {
                    //Get each particles of each source particle system 
                    for (int sourceId = 0; sourceId < sourceSys.particleCount; sourceId++)
                    {
                        Vector3 sourceVelocity = (SourceParticles[sourceId].totalVelocity).normalized;
                        Vector3 sourcePos = SourceParticles[sourceId].position;
                        Vector3 tangentU = Vector3.Cross(Vector3.up, sourceVelocity);

                        tangentU = new Vector3(tangentU.y, tangentU.z, tangentU.x);
                        tangentU *= offset.y;
                        sourcePos += tangentU;
                        sourcePos += sourceVelocity.normalized * offset.x;

                        //Set new source pos for each target particles 
                        if (targetId == sourceId)
                        {
                            TargetParticles[targetId].position = sourcePos;
                        }
                    }
                }
                particleSystem.SetParticles(TargetParticles, particleSystem.particleCount);
            }
        }
    }
}