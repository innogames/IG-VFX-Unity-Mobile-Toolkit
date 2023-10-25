Shader "InnoGames/VFX/Particle/True Color/Dissolve"
{
    Properties
    {
        //Texture Properties
        [Space(25)][Header(ALPHA PROPERTIES)][Space(5)]_AlphaTrans("Transform X & Y Tiling, Z & W Offset", vector) = (1.0, 1.0, 0.0, 0.0)
        [NoScaleOffset]_AlphaTex ("Packed Texture", 2D) = "white" {}
        [Space(25)][Header(DISSOLVE PROPERTIES)][Space(5)][Toggle]_Invert ("Invert", int )= 0
        _FallOff ("Fall Off", Range(1, 10)) = 1
        _DissolveTrans("Transform X & Y Tiling, Z & W Offset", vector) = (1.0, 1.0, 0.0, 0.0)
        [NoScaleOffset]_DissolveTex ("Ramp", 2D) = "gray" {}
        //Render Properties
        [Space(25)][Header(RENDER PROPERTIES)][Space(5)]
        [Toggle]_OffVc("Disable Vertex Color", int ) = 0
        [Enum(UnityEngine.Rendering.CullMode)]_Cull("Cull Mode", float) = 0
        [Space(5)][Header(Stencil Buffer)][Space(5)]_StencilMask("Stencil Mask", Int) = 0
        [Enum(UnityEngine.Rendering.CompareFunction)]_StencilComp("Stencil Compare", int) = 0
        [Enum(UnityEngine.Rendering.StencilOp)]_StencilPass("Stencil Pass", int) = 0
        _StencilWrite("Stencil Write", Int) = 0
        _StencilRead("Stencil Read", Int) = 0
        [Space(5)][Header(Depth Buffer)][Space(5)][Enum(UnityEngine.Rendering.CompareFunction)]_ZTest ("Z Test", Int) = 4
        [Enum(Off,0,On,1)]_ZWrite("Z Write", Int) = 0
    }

    Category
    {
        SubShader
        {
            CGINCLUDE
                sampler2D _MainTex;
                sampler2D _DissolveTex;
                uniform float4 _AlphaTrans;
                uniform float4 _DissolveTrans;
                uniform half _FallOff;
                uniform half _Invert;
                uniform half _OffVc;
            ENDCG

            Tags
            {
                "Queue"="Transparent" "IgnoreProjector"="True" "RenderType"="Transparent"
            }

            Blend One OneMinusSrcAlpha
            Lighting Off
            ZWrite [_ZWrite]
            ZTest [_ZTest]
            Cull [_Cull]

            Stencil
            {
                Ref[_StencilMask]
                Comp [_StencilComp]
                Pass [_StencilPass]
                WriteMask [_StencilWrite]
                ReadMask [_StencilRead]
            }

            Pass
            {

                Stencil
                {
                    Ref[_StencilMask]
                    Comp Always
                    Pass Replace
                    ReadMask [_StencilMask]
                }

                CGPROGRAM
                #pragma vertex vert
                #pragma fragment frag
                #include "UnityCG.cginc"
                //Fx Functions
                #include "Global_Functions/AlphaVertex.cg"
                #include "Global_Functions/BlendTextChannelFragment.cg"
                #include "Global_Functions/TrueColorFragment.cg"
                #include "Global_Functions/DissolveFragment.cg"
                #include "Global_Functions/UvAdvancedTransformVertex.cg"

                struct appdata
                {
                    float4 Position : POSITION;
                    float4 Color : COLOR;
                    float4 texcoords : TEXCOORD0;
                    float4 texcoords1 : TEXCOORD1;
                    float2 texcoords2 : TEXCOORD2;
                    float texcoords3 : TEXCOORD3;
                };

                struct v2f
                {
                    float4 Position : SV_POSITION;
                    float4 Color : COLOR;
                    float4 UV : TEXCOORD0;
                    float4 UV2 : TEXCOORD1;
                    float2 UV3 : TEXCOORD2;
                    float2 UV4 : TEXCOORD3;
                };

                v2f vert(appdata v)
                {
                    v2f o;
                    //force to world space
                    float4 posToWp = mul(unity_ObjectToWorld, v.Position);

                    o.Position =  UnityObjectToClipPos(posToWp);
                    o.Color = AlphaVertex(v.Color, v.texcoords3);
                    o.UV = v.texcoords;
                    o.UV2 = v.texcoords1;
                    o.UV3 = UvTransform(v.texcoords2, _AlphaTrans);
                    o.UV4 = UvTransform(v.texcoords2, _DissolveTrans);
                    return o;
                }

                float4 frag(v2f i) : SV_Target
                {
                    float4 tex = tex2D(_MainTex, i.UV3);
                    float4 cust1 = i.UV;
                    float4 cust2 = i.UV2;
                    float alpha = BlendTexChannelFragment(tex.rgb, cust1.rgb);

                    //dissolve function & Uv link to Particle Custom Data & Amplitude control 
                    float dissolve = (tex2D(_DissolveTex, i.UV4).r);
                    float mask = DissolveFragment(dissolve, _Invert, _FallOff, i.UV.w);
                    float4 texTint = TrueColorFragment(i.Color, cust2, alpha);

                    return saturate(texTint * alpha * i.Color.a * mask);
                }
                ENDCG
            }
        }
    }
}