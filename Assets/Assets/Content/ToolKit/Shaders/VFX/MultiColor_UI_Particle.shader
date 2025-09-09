Shader "InnoGames/VFX/Multi Color/UI/Particle"
{
    Properties
    {
        //Description Properties
        [Header(SHADER FEATURE AND DESCRIPTION)][Space(5)]
        //Compile Features
        [Space(25)][Header(COMPUTE FEATURES)][Space(5)]
        [Toggle(DEBUG)] _DEBUG ("Compute Debug", int) = 0
        [Toggle(UV_MANIPULATE)] _UV_MANIPULATE ("Compute Uv Manipulate", int) = 0
        [Toggle(DISSOLVE)] _DISSOLVE ("Compute Dissolve", int) = 0
        [Toggle(DISTORTION)] _DISTORTION ("Compute Distortion", int) = 0
        //Debug Features
        [Space(25)][Header(DEBUG)][Space(5)][Toggle]_VisDis("Visualize Dissolve", int )= 0
        [Toggle]_VisDst("Visualize Distortion", int )= 0
        [Toggle]_VisDstMask("Visualize Distortion Mask", int )= 0
        //LOOK AND FEEL Properties
        [Space(50)][Header(LOOK AND FEEL PROPERTIES)][Space(5)][NoScaleOffset]_LookUpTex ("Look Up Table", 2D) = "white" {}
        [Toggle]_PassLUT("Switch LUT to Color Gradient", int) = 0
        _OffsetV ("Select Ramp", range (0,4)) = 0
        //Alpha Properties
        [Space(25)][Header(ALPHA PROPERTIES)][Space(5)][NoScaleOffset]_MainTex("Packed Texture", 2D) = "white" {}
        _BlendChannels("Blend Packed Texture Channel", vector) = (0.0, 0.0, 0.0, 0.0)
        _AlphaTrans("Uv Tiling & Offset", vector) = (1.0, 1.0, 0.0, 0.0)
        [Space(5)][Header(Uv Alpha)][Space(5)]_UvAlphaSqSw("Uv Alpha Enable Squeez XY & Swipe ZW", vector ) = (0.0, 0.0, 0.0, 0.0)
        _UvAlphaCh("Uv Alpha Use Custom Data 1 Channel (0 - 3)", vector ) = (0, 1, 2, 3)
        //Dissolve Properties
        [Space(25)][Header(DISSOLVE PROPERTIES)][Space(10)][NoScaleOffset]_DisTex("Dissolve Ramp", 2D) = "gray" {}
        [Toggle]_DisFlipU("Dissolve Flip U", int )= 0
        [Toggle]_DisFlipV("Dissolve Flip V", int )= 0
        [Toggle]_DisRot("Dissolve Rotate 90 Degress", int )= 0
        [Toggle]_DisInv("Dissolve Invert Ramp", int )= 0
        [Toggle]_DisUseCd("Dissolve Use Custom Data 1", int ) = 0
        _DisCustom("Dissolve Strength by CD1 Channel (0 - 3)", int) = 0
        _DisStrength("Dissolve Strength", Range(0, 3)) = 0
        _DisTrans("Dissolve Uv Tiling & Offset", vector) = (1.0, 1.0, 0.0, 0.0)
        _DisFallOff("Dissolve Fall Off", Range(1, 100)) = 1
        //Distortion Properties
        [Space(25)][Header(DISTORTION PROPERTIES)][Space(5)][NoScaleOffset]_DstTex ("Distortion Texture", 2D) = "gray" {}
        [NoScaleOffset]_DstMask ("Distortion Mask", 2D) = "white" {}
        [Toggle] _DstInvMask ("Distortion Mask Invert", int) = 0
        [Toggle]_DstAlpha("Distortion Enable for Alpha", int ) = 0
        [Toggle]_DstDis("Distortion Enable for Dissolve", int ) = 0
        [Toggle]_DstWorld("Distortion set to World Coords", int) = 0
        _DstStrength("Distortion Strength Alpha", Range(-2.0, 2.0)) = 0.0
        _DstStrengthDis("Distortion Strength Dissolve", Range(-2.0, 2.0)) = 0.0
        _DstTrans ("Distortion Uv Tiling & Offset", vector) = (1.0, 1.0, 0.0, 0.0)
        //Uv Manipulate Properties
        [Space(10)][Header(UV MANIPULATE PROPERTIES)][Space(5][Header(Uv Distortion)]_UvDstSqSw("Uv Distortion Enable Squeez XY & Swipe ZW", vector ) = (0.0, 0.0, 0.0, 0.0)
        //Particle Properties
        [Space(50)][Header(PARTICLE PROPERTIES)][Space(5)][Toggle]_ParticleA("Enalbe Particle Alpha", int) = 0
        _ParticleCdStrength("Enalbe Particle Color Strength", Range(1.0, 10.0)) = 1
        //UI Render Properties
        _StencilComp ("Stencil Comparison", Float) = 8
        _Stencil ("Stencil ID", Float) = 0
        _StencilOp ("Stencil Operation", Float) = 0
        _StencilWriteMask ("Stencil Write Mask", Float) = 255
        _StencilReadMask ("Stencil Read Mask", Float) = 255
        _ColorMask ("Color Mask", Float) = 15
        _ClipRect ("Clip Rect", Vector) = (-32767, -32767, 32767, 32767)
    }

    SubShader
    {
        Tags
        {
            "Queue"="Transparent" "IgnoreProjector"="True" "RenderType"="Transparent" "PreviewType"="Plane" "CanUseSpriteAtlas"="True"
        }

        Stencil
        {
            Ref [_Stencil]
            Comp [_StencilComp]
            Pass [_StencilOp]
            ReadMask [_StencilReadMask]
            WriteMask [_StencilWriteMask]
        }

        Cull Off
        Lighting Off
        ZWrite Off
        ZTest [unity_GUIZTestMode]
        Fog
        {
            Mode Off
        }
        Blend One OneMinusSrcAlpha

        ColorMask [_ColorMask]

        Pass
        {
            CGPROGRAM
            #pragma vertex vert
            #pragma fragment frag
            #include "UnityUI.cginc"
            #include "UnityCG.cginc"
            #include "CoreLibrary/Effects_Library.cg"

            #pragma multi_compile __ UNITY_UI_CLIP_RECT
            #pragma multi_compile __ UNITY_UI_ALPHACLIP

            //Fx Features
            #pragma shader_feature_local __ DEBUG
            #pragma shader_feature_local __ UV_MANIPULATE
            #pragma shader_feature_local __ DISSOLVE
            #pragma shader_feature_local __ DISTORTION

            #if DEBUG
                uniform half _VisDis;
                uniform half _VisDst;
                uniform half _VisDstMask;
            #endif

            uniform float4 _AlphaTrans;
            uniform sampler2D _MainTex;
            sampler2D _LookUpTex;
            uniform half4 _LookUpTex_TexelSize;
            uniform half4 _ClipRect;
            uniform half4 _BlendChannels;
            uniform half _PassLUT;
            uniform half _OffsetV;
            uniform half _ParticleA;
            uniform half _ParticleCdStrength;

            #if DISSOLVE
                sampler2D _DisTex;
                uniform float4 _DisTex_ST;
                uniform half _DisFlipU;
                uniform half _DisFlipV;
                uniform half _DisRot;
                uniform half _DisInv;
                uniform half _DisFallOff;
                uniform float4 _DisTrans;
                uniform half _DisCustom;
                uniform half _DisUseCd;
                uniform half _DisStrength;
            #endif

            #if DISTORTION
                    sampler2D _DstTex;
                    sampler2D _DstMask;
                    uniform half _DstInvMask;
                    uniform half _DstCustom;
                    uniform half _DstUseCd;
                    uniform half _DstStrength;
                    uniform half _DstStrengthDis;
                    uniform float4 _DstTrans;
                    uniform half _DstAlpha;
                    uniform half _DstDis;
                    uniform half _DstWorld;
            #endif

            #if UV_MANIPULATE
                    uniform half4 _UvAlphaSqSw;
                    uniform half4 _UvAlphaCh;
                    uniform half4 _UvDstSqSw;
                    uniform half _UvRadialDst;
            #endif

            struct appdata_t
            {
                float4 Position : POSITION;
                float4 Color : COLOR;
                float4 texcoord : TEXCOORD0;
            };

            struct v2f
            {
                float4 Position : SV_POSITION;
                half4 Color : COLOR;
                float2 UvPackedTex : TEXCOORD0;
                float4 worldPosition : TEXCOORD1;
                half2 CustomData1 : TEXCOORD2;
                #if DISSOLVE
                    float2 Dissolve : TEXCOORD4;
                #endif
                #if DISTORTION
                        float2 UvDistortion : TEXCOORD5;
                #endif
                #if UV_MANIPULATE
                    float2 Uv : TEXCOORD6;
                    half Time : TEXCOORD7;
                #endif
            };

            v2f vert(appdata_t v)
            {
                v2f o;
                //Uv
                float2 customD1 = v.texcoord.zw;
                float2 uv = v.texcoord.xy;
                float time = _Time.y;

                //Uv Packed Texture
                float2 uvPackedTex = UvTransform(uv, _AlphaTrans);
                #if UV_MANIPULATE
                    float4 cd1Alpha = float4(customD1[_UvAlphaCh.x], customD1[_UvAlphaCh.y], customD1[_UvAlphaCh.z], customD1[_UvAlphaCh.w]);
                    float4 cdTrans = cd1Alpha * _UvAlphaSqSw;
                    uvPackedTex = (uvPackedTex * (cdTrans.xy + _AlphaTrans.xy)) + cdTrans.zw;
                #endif

                //Uv Dissolve
                #if DISSOLVE
                    float2 uvDis = UvManipulation(uv, _DisFlipU, _DisFlipV, _DisRot);
                    uvDis = UvTransform(uvDis, _DisTrans);
                #endif

                //Uv Distortion
                #if DISTORTION
                    uv = lerp(uv, (float2(v.Position.x, v.Position.y) / 100.0), _DstWorld);
                    float2 uvDst = UvTransform(uv, _DstTrans);
                #if UV_MANIPULATE
                        float4 dstTime = frac(time * _UvDstSqSw);
                        uvDst = UvTransform(uv, float4(_DstTrans.x + dstTime.x, _DstTrans.y + dstTime.y, _DstTrans.z + dstTime.z, _DstTrans.w + dstTime.w));
                  #endif
                #endif

                #ifdef UNITY_HALF_TEXEL_OFFSET
					o.Position.xy += (_ScreenParams.zw-1.0)*float2(-1,1);
                #endif

                o.worldPosition = v.Position;
                o.Position = UnityObjectToClipPos(v.Position);
                o.UvPackedTex = uvPackedTex;
                o.Color = v.Color * _ParticleCdStrength;
                o.CustomData1 = v.texcoord.zw;

                #if DISSOLVE
                    o.Dissolve = uvDis;
                #endif
                #if DISTORTION
                    o.UvDistortion = uvDst;
                #endif
                #if UV_MANIPULATE
                    o.Uv = uv;
                    o.Time = time;
                #endif
                return o;
            }

            float4 frag(v2f i) : SV_Target
            {
                //Distortion Textures
                #if DISTORTION
                    float2 dstUseCd = float2(_DstStrength,0.0);
                    float dstMaskTex = tex2D(_DstMask, i.UvPackedTex).r;
                    float2 dstTex = tex2D(_DstTex, i.UvDistortion).rg;
                #endif

                #if DISTORTION
                        i.UvPackedTex = lerp(i.UvPackedTex, DistortionFragment(dstMaskTex, _DstInvMask, dstTex, dstUseCd, 1, i.UvPackedTex), _DstAlpha);
                #endif

                //Alpha
                half4 texPack = tex2D(_MainTex, i.UvPackedTex);
                half gradient = Blend4TexChannelFragment(texPack, _BlendChannels);

                //Dissolve
                half dissolve = 1.0;
                #if DISSOLVE
                    #if DISTORTION
                            i.Dissolve = (DistortionFragment(dstMaskTex, _DstInvMask, dstTex, dstUseCd[_DstUseCd], 1, i.Dissolve)) * _DstDis;
                    #endif
                    half2 disUseCd = float2(_DisStrength, i.CustomData1[_DisCustom]);
                    half disTex = (tex2D(_DisTex, i.Dissolve).r);
                    dissolve = DissolveFragment(disTex, _DisInv, _DisFallOff, disUseCd[_DisUseCd]);
                #endif

                //Look and Feel
                half4 gradientMapping = GradientMappingFragment(gradient, _LookUpTex, _OffsetV, _LookUpTex_TexelSize.y,
                                                                 _PassLUT, i.UvPackedTex);
                half4 mulColor = lerp(gradientMapping, gradientMapping, saturate(gradientMapping.a));
                half4 color = half4(mulColor.rgb + i.Color.rgb, 1.0) * saturate(
                    gradient * dissolve * lerp(1.0, i.Color.a, _ParticleA));

                //Debug
                #if DEBUG
                    half4 toggles = float4(_VisDis, _VisDst, _VisDstMask, 0.0);
                #if DISSOLVE
                        color = lerp(0.0, float4(dissolve, 0.0, 0.0, 1.0), toggles.x);
                #endif
                #if DISTORTION
                        color += lerp(0.0, float4(dstTex, 0.0, 1.0), toggles.y) + lerp(0.0, float4( dstMaskTex, 0.0, 0.0,1.0), toggles.z);
                #endif
                #endif

                #ifdef UNITY_UI_CLIP_RECT
                    color.xyz *= UnityGet2DClipping(i.worldPosition.xy, _ClipRect);
                #endif

                #ifdef UNITY_UI_ALPHACLIP
                    clip (color.a - 0.01);
                #endif

                return color;
            }
            ENDCG
        }
        
    }
     CustomEditor "InnoGames.VFX.Game.Editor.VFX_ShaderGUI_MultiColor_LightAndMotion_Ui_Particle"
}