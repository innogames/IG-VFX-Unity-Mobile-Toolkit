Shader "InnoGames/VFX/Specialized/Polar Lights"
{
    Properties
    {
        //Shading
        [Header(LOOK AND FEEL PROPERTIES)][Space(5)][NoScaleOffset]_LookUpTex ("Look Up Table", 2D) = "white" {}
        //Alpha Properties
        [HideInInspector][Space(25)][Header(ALPHA PROPERTIES)][Space(10)][NoScaleOffset]_Alpha ("Packed Texture", 2D) = "white" {}
        [HideInInspector]_BlendChannels("Blend Packed Texture Channel", vector) = (0.0, 0.0, 0.0, 0.0)
        //Render Properties
        [Space(25)][Header(RENDER PROPERTIES)][Space(5)]
        [Space(5)][Header(Depth Buffer)][Space(5)][Enum(UnityEngine.Rendering.CompareFunction)] _ZTest ("ZTest", Int) = 4
    }

    Category
    {
        SubShader
        {
            CGINCLUDE
                uniform float _BlendAdd;
                sampler2D _LookUpTex;
                uniform float4 _LookUpTex_TexelSize;
                sampler2D _Alpha;
                uniform float4 _AlphaRTrans;
                uniform float4 _AlphaGTrans;
                uniform float4 _AlphaBTrans;
                uniform float4 _BlendChannels;
            ENDCG
            
            Tags
            {
                "Queue"="Transparent" "IgnoreProjector"="True" "RenderType"="Transparent"
            }

            Blend One OneMinusSrcAlpha
            Lighting Off
            ZWrite Off
            ZTest [_ZTest]
            Cull off

            Pass
            {
                CGPROGRAM
                #pragma vertex vert
                #pragma fragment frag

                #include "UnityCG.cginc"
                #include "CoreLibrary/Effects_Library.cg"
                
                struct appdata
                {
                    float4 Position : POSITION;
                    float4 Color : COLOR;
                    float3 Normal : NORMAL;
                    float2 texcoords : TEXCOORD0;
                    float2 texcoords1 : TEXCOORD1;
                };

                struct v2f
                {
                    float4 Position : SV_POSITION;
                    float4 Color : COLOR;
                    float4 UvPackedTex : TEXCOORD0;
                    float2 UvPackedTexB : TEXCOORD1;
                    float OverTimeMask : TEXCOORD2;
                };

                v2f vert(appdata v)
                {
                    v2f o;
                    //Inputs
                    float2 uvs = v.texcoords;
                    float vAlpha = v.texcoords1;
                    float time = _Time.y;
                    float4 pos= v.Position;
                    float offsetX = frac(time * 0.020);
                    
                    //Over Time Mask
                    float overTimeMask =  saturate(cos((uvs.x) + (time * 0.5)));
                    
                    //Uv Transform
                    float2 uvPackedTexR = float2(uvs.x * 20.0, uvs.y);
                    float2 uvPackedTexG = float2((uvs.x  - offsetX) * 8.0, uvs.y);
                    float2 uvPackedTexB = float2((uvs.x + offsetX) * 5.0 , uvs.y);

                    //Vertex Alpha
                    float alphaOverTime =  saturate(sin((uvs.x * 3.5) + (time * 0.25)));
                    float fresnel =  FresnelVertexV2(v.Normal * 2.0, pos);
                    v.Color.a = (vAlpha * alphaOverTime) * fresnel;
                    
                    //Outputs
                    o.Position = UnityObjectToClipPos(pos);
                    o.Color = v.Color;
                    o.UvPackedTex = float4(uvPackedTexR, uvPackedTexG);
                    o.UvPackedTexB = uvPackedTexB;
                    o.OverTimeMask = lerp(0.0, 4.0, overTimeMask);
                    return o;
                }

                float4 frag(v2f i) : SV_Target
                {
                    float packedTexR = tex2D( _Alpha, i.UvPackedTex.rg).r;
                    packedTexR *= _BlendChannels.r;
                    float packedTexG = tex2D( _Alpha, i.UvPackedTex.ba).g;
                    packedTexG *= _BlendChannels.g;
                    float packedTexB = tex2D( _Alpha, i.UvPackedTexB).b;
                    packedTexB *= _BlendChannels.b;
                    float alpha = (packedTexR + packedTexG) * packedTexG * packedTexB;
                    alpha *= i.Color.a;
                                        
                    //Shading
                    float4 gradientMapping = RampMappingFragment( _LookUpTex, i.OverTimeMask, _LookUpTex_TexelSize.y, i.UvPackedTex.g);
                    return saturate(gradientMapping * alpha);
                }
                ENDCG
            }
        }
    }
}