Shader "InnoGames/VFX/Specialized/Particle/Screen Position Distortion"
{
    Properties
    {
        //Distortion Properties
        [NoScaleOffset]_DstMap ("Distortion Texture", 2D) = "gray" {}

        [Toggle]_DstWorldUv ("Distortion Set World Uv Cordinates", int) = 0
        _DstStrength("Distortion Strength", Range(0, 3)) = 0
        _DstTrans ("Distortion Uv Tiling & Offset", vector) = (1.0, 1.0, 0.0, 0.0)

        //Distortion Mask Properties
        [NoScaleOffset]_DstMask ("Distortion Mask", 2D) = "white" {}
        [Toggle]_EnableRimMask("Enable Rim Mask", int) = 0
        [Toggle] _DstInvMask ("Distortion Mask Invert", int) = 0
        _GeoRimMul("Rim Mask Multiplier", range(-10.0, 10.0)) = 1.0
        _GeoRimHardness("Rim Mask Hardness", range(0.0, 10.0)) = 0.0
        _DstMaskTrans ("Distortion Mask Uv Tiling & Offset", vector) = (1.0, 1.0, 0.0, 0.0)

        //Render Properties
        [Toggle]_offVc("Disable Vertex Color", int ) = 0
        [Enum(UnityEngine.Rendering.CullMode)]_Cull("Cull Mode", Int) = 4
        [Space(5)][Header(Stencil Buffer)][Space(5)]_StencilMask("Stencil Mask", Int) = 0
        [Enum(UnityEngine.Rendering.CompareFunction)]_StencilComp("Stencil Compare", int) = 0
        [Enum(UnityEngine.Rendering.StencilOp)]_StencilPass("Stencil Pass", int) = 0
        _StencilWrite("Stencil Write", Int) = 0
        _StencilRead("Stencil Read", Int) = 0
        [Space(5)][Header(Depth Buffer)][Space(5)][Enum(UnityEngine.Rendering.CompareFunction)] _ZTest ("ZTest", Int) = 4
        [Enum(Off,0,On,1)]_ZWrite("Z Write", Int) = 0
    }
    SubShader
    {
        CGINCLUDE
        uniform half _GeoRimMul;
        uniform half _GeoRimHardness;
        uniform half _GeoRimBlend;
        uniform half _EnableRimMask;
        uniform half _offVc;

        sampler2D _DstMap;
        sampler2D _DstMask;
        uniform half _DstInvMask;
        uniform half _DstCustom;
        uniform half _DstUseCd;
        uniform half _DstStrength;
        uniform half _DstWorldUv;
        uniform float4 _DstTrans;
        uniform float4 _DstMaskTrans;

        sampler2D _BackgroundTexture;
        ENDCG

        GrabPass
        {
            "_BackgroundTexture"
        }

        Tags
        {
            "RenderType"="Opaque"
        }
        LOD 100

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
            #include "CoreLibrary/Effects_Library.cg"

            struct appdata
            {
                float4 Position : POSITION;
                float4 Color : COLOR0;
                float3 Normal : NORMAL;
                float4 texcoords : TEXCOORD0;
                float2 texcoords1 : TEXCOORD1;
            };

            struct v2f
            {
                float4 Position : SV_POSITION;
                half4 Color : COLOR0;
                float4 Uv : TEXCOORD0;
                UNITY_FOG_COORDS(1)
                float4 GrabPos : TEXCOORD2;
                float4 GrabPosCenter : TEXCOORD3;
                half Rim : TEXCOORD4;
                half4 CustomData1 : TEXCOORD5;
            };

            v2f vert(appdata v)
            {
                v2f o;
                float4 pos = v.Position;
                float2 uv = v.texcoords1;

                half rim = FresnelVertexV2(v.Normal, pos);
                rim = saturate(rim);

                float2 distortionUv = lerp(uv, float2(pos.x, pos.y), _DstWorldUv);
                _DstTrans = float4(_DstTrans.x, _DstTrans.y, _DstTrans.z + v.texcoords.y, _DstTrans.w + v.texcoords.z);
                distortionUv = UvTransform(distortionUv, _DstTrans);
                float2 distortionMaskUv = UvTransform(uv, _DstMaskTrans);

                o.Position = UnityObjectToClipPos(pos);
                o.Color = v.Color;
                o.Uv = float4(distortionUv, distortionMaskUv);

                // grab coordinates
                o.GrabPos = ComputeGrabScreenPos(o.Position);
                o.GrabPosCenter = ComputeGrabScreenPos(UnityObjectToClipPos(float4(0, 0, 0, 1)));
                o.GrabPos.xy /= o.GrabPos.w;
                o.GrabPosCenter.xy /= o.GrabPosCenter.w;
                o.Rim = rim;
                o.CustomData1 = v.texcoords;
                return o;
            }

            half4 frag(v2f i) : SV_Target
            {
                i.Rim *= _GeoRimMul;
                i.Rim += _GeoRimHardness * _GeoRimBlend;

                half2 screenPos = (i.GrabPos.xy);
                half dstMask = tex2D(_DstMask, i.Uv.zw).r;
                half2 mask = half2(dstMask, i.Rim);
                clip(abs(mask) - 0.001);
                half4 dstMap = tex2D(_DstMap, i.Uv.xy);
                float2 uvs = DistortionFragmentV2(mask[_EnableRimMask] * _DstStrength, _DstInvMask, dstMap, i.CustomData1.x,screenPos);

                half4 col = tex2D(_BackgroundTexture, uvs);
                col *= i.Color;
                return col;
            }
            ENDCG
        }
    }
}