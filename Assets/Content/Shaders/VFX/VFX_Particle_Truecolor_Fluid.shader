Shader "InnoGames/VFX/Particle/Fluid"
{
    Properties
    {
        //Main Texture Properties
        [Space(20)][Header(MAIN TEXTURE)][Space(5)]
        [Toggle]_multiAlpha ("Multiply to Mask", int) = 0
        [Toggle]_useCustom ("use Custom Data 2 (Z, W) For Stretch And Squash", int) = 0
        _useAlphaRChannel ("Blend Channels",Vector) = (1.0, 0.0, 0.0, 1.0)
        _TransUvR ("Tiling / Offset", Vector) = (1.0, 1.0, 0.0, 0.0)
        [NoScaleOffset]_AlphaR ("Packed Texture", 2D) = "white" {}
        //Second Texture Properties
        [Space(20)][Header(SECOND TEXTURE)][Space(5)]
        [Toggle]_useCustomG ("use Custom Data 2 (Z, W) For Stretch And Squash", int) = 0
        _useAlphaGChannel ("Blend Channels ",Vector) = (0.0, 1.0, 0.0, 0.0)
        _TransUvG ("Tiling / Offset", Vector) = (1.0, 1.0, 0.0, 0.0)
        [NoScaleOffset]_AlphaG ("Packed Texture", 2D) = "white" {}
        //Mask  Properties
        [Space(20)][Header(MASK)][Space(5)]
        _shrinkM ("Shrink Mask", range(0.0, 2.0)) = 0.0
        _TransMask ("Tiling / Offset", Vector) = (1.0, 1.0, 0.0, 0.0)
        [NoScaleOffset]_Mask ("Mask", 2D) = "white" {}
        //Fusion Properties
        [Space(20)][Header(FUSION)][Space(5)]
        [Toggle]_UseVtxA ("Use Standard Alpha of Life", int) = 0
        _Fusion ("Fusion Strength", range(0.0, 2.0)) = 0.0
        _MainA ("Alpha Blend", range (0.0, 1.0)) = 0.0
        _Edge ("Edge Blend", range (0.0, 1.0)) = 0.0
        _EdgeC ("Edge Tint", color) = (1.0, 0.0, 0.0, 0.0)
        _ShadeEdge ("Edge Brightness", range(0.0, 2.0)) = 0.0
        //Light Properties
        [Space(20)][Header(LIGHT)][Space(5)][Toggle]_LightEnable ("Light Enable", int) = 0
        _LightDir ("Light Direction",Vector) = (1.0, 0.0, 0.0, 1.0)
        _LightShadow ("Shadow Color", color) = (1.0, 0.0, 0.0, 1.0)
        _LightHardness ("Shadow Blend", range(0.0, 10.0)) = 0.0
        //Render Properties
        [Space(20)][Header(RENDER)][Header(Vertex Input)][Space(5)][Toggle]_OffVc("Disable Vertex Alpha", int ) = 0
        [Enum(UnityEngine.Rendering.CullMode)]_Cull("Cull Mode", Int) = 4
        [Space(5)][Header(Stencil Buffer)][Space(5)]_StencilMask("Stencil Mask", Int) = 0
        [Enum(UnityEngine.Rendering.CompareFunction)]_StencilComp("Stencil Compare", int) = 0
        [Enum(UnityEngine.Rendering.StencilOp)]_StencilPass("Stencil Pass", int) = 0
        _StencilWrite("Stencil Write", Int) = 0
        _StencilRead("Stencil Read", Int) = 0
        [Space(5)][Header(Depth Buffer)][Space(5)][Enum(UnityEngine.Rendering.CompareFunction)] _ZTest ("ZTest", Int) = 4
        [Enum(Off,0,On,1)]_ZWrite("Z Write", Int) = 0
        
    }

    Category
    {
        SubShader
        {
           CGINCLUDE
                sampler2D _AlphaR;
                sampler2D _AlphaG;
                sampler2D _Mask;
                uniform float4 _TransMask;
                uniform half _UseVtxA;
                uniform half4 _useAlphaRChannel;
                uniform float4 _TransUvR;
                uniform half4 _useAlphaGChannel;
                uniform float4 _TransUvG;
                uniform half4 _EdgeC;
                uniform half _Fusion;
                uniform half _Softness;
                uniform half _Edge;
                uniform half _ShadeEdge;
                uniform half _multiAlpha;
                uniform half _shrinkM;
                uniform half _MainA;
                uniform half _useCustom;
                uniform half _useCustomG;
                uniform half3 _LightDir;
                uniform half4 _LightShadow;
                uniform half _LightHardness;
                uniform half _LightEnable;
                uniform half _OffVc;
            ENDCG

            Tags
            {
                "Queue"="Transparent" "IgnoreProjector"="True" "RenderType"="Transparent"
            }

            Blend SrcAlpha OneMinusSrcAlpha
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
                CGPROGRAM
                #pragma vertex vert
                #pragma fragment frag
                #include "UnityCG.cginc"
                //Fx Functions
                #include "Global_Functions/FusionFragment.cg"
                #include "Global_Functions/AlphaVertex.cg"
                #include "Global_Functions/BlendTextChannelFragment.cg"
                #include "Global_Functions/UvAdvancedTransformVertex.cg"

                struct appdata
                {
                    float4 Position : POSITION;
                    half4 Color : COLOR;
                    float3 Normal : NORMAL;
                    float4 texcoords : TEXCOORD0;
                    float4 texcoords1 : TEXCOORD1;
                    float2 texcoords2 : TEXCOORD2;
                    half texcoords3 : TEXCOORD3;
                };

                struct v2f
                {
                    float4 Position : SV_POSITION;
                    float3 Normal : NORMAL;
                    half4 Color : COLOR;
                    float4 UV : TEXCOORD0;
                    float4 UV2 : TEXCOORD1;
                    float2 Alpha : TEXCOORD2;
                    float2 Dissolve : TEXCOORD3;
                    float2 Mask : TEXCOORD4;
                };

                v2f vert(appdata v)
                {
                    v2f o;
                    //force to world space
                    float4 posToWp = mul(unity_ObjectToWorld, v.Position);

                    //vertex stream uv panner
                    _TransUvR.zw += v.texcoords.xy;
                    _TransUvG.zw += v.texcoords.zw;
                    _TransUvR.xy *= lerp(1.0, v.texcoords1.zw,  _useCustom);
                    _TransUvG.xy *= lerp(1.0, v.texcoords1.zw,  _useCustomG);

                    o.Position = UnityObjectToClipPos(posToWp);
                    o.Normal = v.Normal;
                    o.Color = AlphaVertex(v.Color, v.texcoords3);
                    o.UV = v.texcoords;
                    o.UV2 = v.texcoords1;
                    o.Alpha = UvTransform(v.texcoords2, _TransUvR);
                    o.Dissolve = UvTransform(v.texcoords2, _TransUvG);
                    o.Mask = UvTransform(v.texcoords2, _TransMask);
                    return o;
                }

                half4 frag(v2f i) : SV_Target
                {
                    //Vertex Stream 
                    half4 cust2 = i.UV2;

                    //Mask Texture and Vertex Alpha use to Scale
                    half texMask = tex2D(_Mask, i.Mask).r;
                    half subMask = saturate(texMask - _shrinkM);
                    half mask = FusionMaskFragment(subMask, i.Color.a, _UseVtxA);
                   
                    //use Channels 
                    half4 alphaR = saturate(tex2D(_AlphaR, i.Alpha) - cust2.x);
                    half4 alphaG = saturate(tex2D(_AlphaG, i.Dissolve) - cust2.y);

                    //Add Channels
                    half addR = BlendTexChannelFragment(alphaR.rgb, _useAlphaRChannel.rgb);
                    half texR = addR * mask;
                    half addG = BlendTexChannelFragment(alphaG.rgb, _useAlphaGChannel.rgb);
                    half texG = addG * mask;

                    //fusion effect
                    half mulAlpha = FusionFragment(texR, texG, _Fusion, _multiAlpha);

                    // Shading
                    half4 col = FusionShadingFragment(mulAlpha, texR, texG, _Edge, _ShadeEdge, _EdgeC, i.Color, _MainA, i.Normal, _LightDir.rgb, _LightEnable, _LightHardness, _LightShadow);
                    return half4(col.rgb, lerp(col.a, col.a * i.Color.a, _UseVtxA));
                }
                ENDCG
            }
        }
    }
}