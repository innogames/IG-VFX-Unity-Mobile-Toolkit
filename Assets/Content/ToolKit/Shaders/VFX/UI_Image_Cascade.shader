Shader "InnoGames/VFX/UI/Image/Cascade"
{
    Properties
    {
        //Cascade Properties
        [HideInInspector]_MainTex ("MainTex", 2D) = "white" {}
        [Header(CASCADE)][Space(10)]_Solve ("Solve ", range (0.0, 2.0)) = 0.0
        _DisTex ("Delay Thin Layer", range (0,1)) = 0.25
        _DisThin ("Delay Distortion", range (0,1)) = 0.5
        //Layer Properties
        [Space(50)][Header(LAYERS)][Space(10)]_Color ("Color", color) = (0,0,0,0)
        _ThinStrength ("Thin Strength", range (0,3)) = 0
        _DisStrength ("Distortion Strength", range (0,1)) = 0
        [Toggle]_DisAlpha ("Distort Alpha Channel", int) = 0
        //Texture Properties
        [Space(50)][Header(TEXTURES)][Space(10)]_RampTex("Ramp", 2D) = "white" {}
        _ColorTex("Color", 2D) = "white" {}
        _DistortionTex ("Motion Vector", 2D) = "gray" {}
    }

    Category
    {
        SubShader
        {
            Tags
            {
                "Queue"="Transparent" "IgnoreProjector"="True" "RenderType"="Transparent"
            }
            Blend SrcAlpha OneMinusSrcAlpha
            Lighting Off
            ZWrite OFF
            Cull back
            
            Pass
            {
                CGPROGRAM
                #pragma vertex vert
                #pragma fragment frag
                #include "UnityCG.cginc"
                
                uniform half4 _MainTex_ST;
                uniform sampler2D _MainTex;
                uniform float4 _DistortionTex_ST;
                uniform sampler2D _DistortionTex;
                uniform float4 _RampTex_ST;
                uniform sampler2D _RampTex;
                uniform float4 _ColorTex_ST;
                uniform sampler2D _ColorTex;
                uniform half4 _Color;
                uniform half _DisStrength;
                uniform half _ThinStrength;
                uniform half _Solve;
                uniform half _DisTex;
                uniform half _DisThin;
                uniform half _DisAlpha;
                uniform half4 _ClipRect;

                struct appdata
                {
                    float4 Position : POSITION;
                    half4 Color : COLOR;
                    float2 texcoords : TEXCOORD0;
                    float4 texcoords1 : TEXCOORD1;
                    float4 texcoords2 : TEXCOORD2;
                };

                struct v2f
                {
                    float4 Position : SV_POSITION;
                    half4 Color : COLOR;
                    float2 UV : TEXCOORD0;
                    float2 UV2 : TEXCOORD1;
                    float2 Alpha : TEXCOORD2;
                    float2 Dissolve : TEXCOORD3;
                    float4 worldPosition : TEXCOORD4;
                };

                v2f vert(appdata v)
                {
                    v2f o;

                    float2 uvAtlas = v.texcoords;
                    float2 uvTrans = TRANSFORM_TEX(v.texcoords, _MainTex);
                    float2 uvDis = TRANSFORM_TEX(uvAtlas, _DistortionTex);
                    float2 uvramp = TRANSFORM_TEX(uvAtlas, _RampTex);
                    float2 uvthin = TRANSFORM_TEX(uvAtlas, _ColorTex);

                    o.Position = mul(unity_MatrixVP, mul(unity_ObjectToWorld, v.Position));
                    o.Color = v.Color;
                    o.UV = uvDis;
                    o.UV2 = uvTrans;
                    o.Alpha = uvramp;
                    o.Dissolve = uvthin;
                    o.worldPosition = v.Position;

                    return o;
                }

                half4 frag(v2f i) : SV_Target
                {
                    //Distortion
                    float2 disTex = tex2D(_DistortionTex, i.UV).xy;
                    disTex = (disTex - 0.5) / 2;
                    disTex = i.UV2 - disTex;
                    
                    //Cascade
                    half distortion = (_DisStrength) * saturate(1 - (_Solve - _DisThin));
                    half alpha = tex2D(_MainTex, lerp(i.UV2, lerp(i.UV2, disTex, _DisAlpha), distortion)).a;

                    //Textures
                    half ramp = tex2D(_RampTex, i.Alpha).r;
                    half4 thin = tex2D(_ColorTex, lerp(i.Dissolve, disTex, distortion)) * _ThinStrength;
                    half4 tex = tex2D(_MainTex, lerp(i.UV2, disTex, distortion));

                    //Color
                    half4 color = (thin * saturate(ramp * 10) * 2) * saturate(_Solve - _DisTex);
                    color = lerp(_Color + color, tex, saturate(ramp - (1 - _Solve)));
                    
                    return half4(color.rgb, alpha);
                }
                ENDCG
            }
        }
    }
}