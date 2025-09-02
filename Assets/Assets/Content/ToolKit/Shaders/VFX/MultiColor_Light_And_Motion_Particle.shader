Shader "InnoGames/VFX/Multi Color/Particle/Light And Motion Particle"
{
    Properties
    {
        //Compile Features
        [Space(25)][Header(COMPUTE FEATURES)][Space(5)]
        [Toggle(GEO)] _GEO ("Compute Geometry", int) = 0
        [Toggle(GEO_TEX)]_GEO_TEX("Compute Geometry Add Texture", int) = 0
        [Toggle(LIGHT)] _LIGHT ("Compute Gradient by Light", int) = 0
        [Toggle(UV_COLOR_RAMP)] _UV_COLOR_RAMP ("Compute Gradient by Uv", int) = 0
        [Toggle(GLOW)]_GLOW("Compute Glow", int) = 0
        [Toggle(UV_MANIPULATE)] _UV_MANIPULATE ("Compute Uv Manipulate", int) = 0
        [Toggle(DISSOLVE)] _DISSOLVE ("Compute Dissolve", int) = 0
        [Toggle(DISSOlVE_CLIP)]_DISSOlVE_CLIP("Dissolve Clip", int) = 0
        [Toggle(DISTORTION)] _DISTORTION ("Compute Distortion", int) = 0
        [Toggle(LITSHADING)] _LITSHADING ("Compute Lit Shading", int) = 0

        //Geometry Properties
        _GeoRimMul("Rim Multiplier", range(-10.0, 10.0)) = 1.0
        _GeoRimHardness("Rim Hardness", range(0.0, 10.0)) = 0.0
        _GeoRimBlend("Rim Blend Strength", range(0.0, 100.0)) = 1.0
        _GeoDeformPhase("Deformation Frequency ", range(-10.0, 10.0)) = 0.0
        _GeoDeformAmplitude("Deformation Amplitude ", range(0.0, 100.0)) = 0.0
        _GeoAxis("Deformation Axis ", vector) = (1.0, 0.0, 0.0, 0.0)
        _GeoPush("Push Axis", vector) = (0.0, 0.0, 0.0, 0.0)
        _GeoOffset("Offset", range(0.0, 10.0)) = 0.0
        [Toggle]_GeoUseCd("Geo Offset Use Custom Data 1", int ) = 0
        _GeoCustom("Geo Offset by CD1 Channel (0 - 3)", int) = 0

        //Gradient Properties
        [Toggle]_GradientUseLUT("Use Look Up Texture As Color", int) = 0
        _GradientColor("Gradient Color", color) = (1.0, 1.0, 1.0, 1.0)
        _GradientStrength("Gradient Strength", range(0, 10)) = 0
        _GradientBrightness("Gradient Brightness", range(0, 1)) = 0
        [Toggle]_GradientBlendCd("Gradient Blend Use Custom Data 1", int ) = 0
        _GradientBlendChannel("Gradient Blend by CD1 Channel (0 - 3)", int) = 0

        //Gradient by Light Properties
        [Toggle]_LightRangeMul("Convert To A Light", int) = 0
        _SetPos("Set Position", vector) = (0.0, 0.0, 0.0, 0.0)
        _LightPos("Light Source Position", vector) = (0.0, 0.0, 0.0, 0.0)
        _LightRange("Light Range", range(0.0, 100.0)) = 0.0
        _LightFallOff("Light Fall Off", range(0.0, 10.0)) = 0.0
        _LightHardness("Light Hardness",range(0.0, 10.0)) = 0.0

        //Gradient by Uv Properties
        [Toggle]_MulLight("Multiply Uv Ramp to Light Sources", int) = 0
        _UvRampBlend("UV Ramp Axis Blend (X = Positive U, Y = Negative U, Z = Positive V, W = Negative W)", vector) = (0.0, 0.0, 0.0, 0.0)
        _UvRampOffset("Uv Ramp Offset", vector) = (0.0, 0.0, 0.0, 0.0)
        _UvRampSet("Uv Ramp Settings", vector) = (1.0, 1.0, 0.0, 0.0)

        //Shading
        [NoScaleOffset]_LookUpTex ("Look Up Table", 2D) = "white" {}
        [Toggle]_PassLUT("Switch LUT to Color Gradient", int) = 0
        [Toggle]_MulPColor("Multiply Particle Color", int) = 0
        [Toggle]_DisableAlpha("Disable in Alpha", int) = 0
        _LUTOffset ("LUT Offset Row", float) = 0
        [Toggle]_LUTUseCd("LUT  Use Custom Data 1", int ) = 0
        _LUTCustom("LUT by CD1 Channel (0 - 3)", int) = 0

        //Glow
        _GlowTint("Tint Glow", color) = (1.0, 1.0, 1.0, 1.0)
        [Toggle]_GlowUseCd("Use Custom Data 1", int ) = 0
        _GlowCustom("Strength by CD1 Channel (0 - 3)", int) = 0
        _GlowStr("Strength", range(1.0, 10.0)) = 1.0
        _GlowLut("Glow Blend From LUT Alpha", range(0.0, 1.0)) = 0
        _GlowAlpha("Glow Blend From Alpha Channels", vector ) = (0.0, 0.0, 0.0, 0.0)
        _GlowAMask("Glow Blend From Alpha Mask", range(0.0, 1.0)) = 0
        _GlowGradient("Glow Blend From Gradient", range(0.0, 1.0)) = 0
        _GlowRimBlend("Glow Blend From Rim", range(0.0, 1.0)) = 0.0
        [Toggle]_GlowRimInvert("Rim Invert", int) = 0.0
        _GlowRimMul("Rim Multiplier", range(0.0, 10.0)) = 1.0
        _GlowRimHardness("Rim Hardness", range(0.0, 1.0)) = 0.0

        //Alpha Properties
        [NoScaleOffset]_Alpha ("Packed Texture", 2D) = "white" {}
        _BlendChannels("Blend Packed Texture Channel", vector) = (0.0, 0.0, 0.0, 0.0)
        _AlphaTrans("Uv Tiling & Offset", vector) = (1.0, 1.0, 0.0, 0.0)
        [Space(5)][Header(Alpha Mask)][Space(5)]
        [NoScaleOffset]_AMask("Alpa Mask", 2D) = "white" {}
        [Toggle]_AMaskUse("Enable Alpha Mask", int ) = 0
        [Toggle]_AMaskUseAlphaUv("Alpha Mask use Alpha Uv", int ) = 0
        _AMaskTrans("Alpha Mask Uv Tiling & Offset", vector) = (1.0, 1.0, 0.0, 0.0)
        _AMaskSqSw("Alpha Mask Enable Squeez XY & Swipe ZW", vector ) = (0.0, 0.0, 0.0, 0.0)
        _AMaskCh("Alpha Mask Use Custom Data 1 Channel (0 - 3)", vector ) = (0, 1, 2, 3)

        //World Position Properties
        [Toggle]_AWpMaskUse("Enable World Position Mask", int ) = 0
        [Toggle]_AWpMaskLut("Set Look Up Table to World Position", int ) = 0
        _AWpMaskAxis("World Position Mask Axis", vector ) = (0.0, 0.0, 0.0, 0.0)
        _AWpMaskOffset("World Position Mask Offset", vector ) = (0.0, 0.0, 0.0, 0.0)
        _AWpMaskMultiplier("World Position Mask Multiplier", Range(0, 10)) = 0
        _AWpMaskHardness("World Position Hardness", Range(0, 1)) = 0

        //Dissolve Properties
        [NoScaleOffset]_DisTex("Dissolve Ramp", 2D) = "gray" {}
        [Toggle]_DisFlipU("Dissolve Flip U", int )= 0
        [Toggle]_DisFlipV("Dissolve Flip V", int )= 0
        [Toggle]_DisRot("Dissolve Rotate 90 Degress", int )= 0
        [Toggle]_DisUseAlphaUv("Dissolve use Alpha Uv", int ) = 0
        [Toggle]_DisInv("Dissolve Invert Ramp", int )= 0
        [Toggle]_DisUseCd("Dissolve Use Custom Data 1", int ) = 0
        _DisCustom("Dissolve Strength by CD1 Channel (0 - 3)", int) = 0
        _DisStrength("Dissolve Strength", Range(0, 3)) = 0
        _DisTrans("Dissolve Uv Tiling & Offset", vector) = (1.0, 1.0, 0.0, 0.0)
        _DisFallOff("Dissolve Fall Off", Range(1, 100)) = 1

        //Distortion Properties
        [NoScaleOffset]_DstTex ("Distortion Texture", 2D) = "gray" {}
        [NoScaleOffset]_DstMask ("Distortion Mask", 2D) = "white" {}
        [Toggle] _DstInvMask ("Distortion Mask Invert", int) = 0
        [Toggle]_DstAlpha("Distortion Enable for Alpha", int ) = 0
        [Toggle]_DstDis("Distortion Enable for Dissolve", int ) = 0
        [Toggle]_DstUseCd("Distortion Use Custom Data 1", int ) = 0
        _DstCustom("Distortion Strength by CD1 Channel (0 - 3)", int) = 0
        _DstStrength("Distortion Strength", Range(0, 3)) = 0
        [Toggle]_DstWorldUv ("Distortion Set World Uv Cordinates", int) = 0
        _DstTrans ("Distortion Uv Tiling & Offset", vector) = (1.0, 1.0, 0.0, 0.0)

        //Uv Properties
        [Space(5)][Header(Uv Alpha)][Space(5)]_UvAlphaSqSw("Uv Alpha Enable Squeez XY & Swipe ZW", vector ) = (0.0, 0.0, 0.0, 0.0)
        _UvAlphaCh("Uv Alpha Use Custom Data 1 Channel (0 - 3)", vector ) = (0, 1, 2, 3)
        [Space(5)][Header(Uv Distortion)][Space(5)]_UvDstSqSw("Uv Distortion Enable Squeez XY & Swipe ZW", vector ) = (0.0, 0.0, 0.0, 0.0)
        _UvDstCh("Uv Distortion Use Custom Data 1 Channel (0 - 3)", vector ) = (0, 1, 2, 3)
        [Space(5)][Header(Uv Twist)][Space(5)][Toggle]_UvTwistUInv("Uv Twist Invert U", int ) = 0
        [Toggle]_UvTwistVInv("Uv Twist Invert V", int ) = 0
        [Toggle]_UvTwistAlphaCd("Uv Twist Alpha Use Custom Data", int ) = 0
        [Toggle]_UvTwistDisCd("Uv Twist Dissolve Use Custom Data", int ) = 0
        _UvTwist("Uv Twist", vector) = (0.0, 0.0, 0.0, 0.0)
        _UvTwistCh("Uv Distortion Use Custom Data 1 Channel (0 - 3)", vector ) = (0, 1, 2, 3)

        //Render Properties
        [Toggle]_BlendAdd ("Premultiplied Mode", int) = 0
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

    Category
    {
        SubShader
        {
            CGINCLUDE
            uniform half _GradientUseLUT;
            uniform half4 _GradientColor;
            uniform half _GradientStrength;
            uniform half _GradientBrightness;
            uniform half _DisableAlpha;
            uniform half _BlendAdd;
            uniform half _offVc;
            sampler2D _LookUpTex;
            uniform half4 _LookUpTex_TexelSize;
            uniform half _PassLUT;
            uniform half _UseImage;
            uniform half _MulPColor;
            uniform half _GradientBlendCd;
            uniform half _GradientBlendChannel;
            uniform half _LUTOffset;
            uniform half _LUTUseCd;
            uniform half _LUTCustom;
            uniform half _AMaskUseAlphaUv;
            uniform half _AWpMaskUse;
            uniform half _AWpMaskAlpha;
            uniform half _AWpMaskLut;
            uniform half3 _AWpMaskAxis;
            uniform half3 _AWpMaskOffset;
            uniform half _AWpMaskMultiplier;
            uniform half _AWpMaskHardness;

            #if GEO
                        uniform half _GeoDeformPhase;
                        uniform half _GeoDeformAmplitude;
                        uniform half4 _GeoAxis;
                        uniform half4 _GeoPush;
                        uniform half _GeoRimMul;
                        uniform half _GeoRimHardness;
                        uniform half _GeoRimBlend;
                        uniform half _GeoOffset;
                        uniform half _GeoCustom;
                        uniform half _GeoUseCd;
            #endif

            #if UV_COLOR_RAMP
                        uniform float4 _UvRampBlend;
                        uniform float4 _UvRampOffset;
                        uniform float4 _UvRampSet;
                        uniform float _UvRampEnable;
            #endif

            uniform float _LightRangeMul;
            uniform float _MulLight;

            #if GLOW
                        uniform half4 _GlowTint;
                        uniform half _GlowUseCd;
                        uniform half _GlowCustom;
                        uniform half _GlowStr;
                        uniform half _GlowGradient;
                        uniform half _GlowLut;
                        uniform half4 _GlowAlpha;
                        uniform half _GlowAMask;
                        uniform half _GlowRimInvert;
                        uniform half _GlowRimMul;
                        uniform half _GlowRimHardness;
                        uniform half _GlowRimBlend;
            #endif

            #if LIGHT
                        uniform half _LightRange;
                        uniform half _LightFallOff;
                        uniform half _LightHardness;
                        uniform float4 _LightPos;
                        uniform float4 _SetPos;
            #endif

            sampler2D _Alpha;
            uniform float4 _AlphaTrans;
            uniform half4 _BlendChannels;
            uniform half _AMaskUse;
            sampler2D _AMask;
            uniform float4 _AMaskTrans;
            uniform float4 _AMaskSqSw;
            uniform half4 _AMaskCh;

            #if DISSOLVE
                        sampler2D _DisTex;
                        uniform half _DisFlipU;
                        uniform half _DisFlipV;
                        uniform half _DisRot;
                        uniform half _DisInv;
                        uniform half _DisFallOff;
                        uniform float4 _DisTrans;
                        uniform half _DisCustom;
                        uniform half _DisUseCd;
                        uniform half _DisStrength;
                        uniform half _DisUseAlphaUv;
            #endif

            #if DISTORTION
                        sampler2D _DstTex;
                        sampler2D _DstMask;
                        uniform half _DstInvMask;
                        uniform half _DstCustom;
                        uniform half _DstUseCd;
                        uniform half _DstStrength;
                        uniform float _DstWorldUv;
                        uniform float4 _DstTrans;
                        uniform half _DstAlpha;
                        uniform half _DstDis;
            #endif

            #if UV_MANIPULATE
                        uniform float4 _UvAlphaSqSw;
                        uniform float4 _UvAlphaCh;
                        uniform float4 _UvDstSqSw;
                        uniform float4 _UvDstCh;
                        uniform float _UvTwistUInv;
                        uniform float _UvTwistVInv;
                        uniform float _UvTwistAlphaCd;
                        uniform float _UvTwistDisCd;
                        uniform float4 _UvTwist;
                        uniform float4 _UvTwistCh;
            #endif
            ENDCG
            Tags
            {
                "Queue"="Transparent" "IgnoreProjector"="True" "RenderType"="Transparent" "LightMode" = "ForwardBase"
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
                CGPROGRAM
                #pragma vertex vert
                #pragma fragment frag
                #define _TRANSLUCENT

                #include "UnityCG.cginc"
                #include "CoreLibrary/Effects_Library.cg"

                #pragma shader_feature_local __ GEO
                #pragma shader_feature_local __ GEO_TEX
                #pragma shader_feature_local __ LIGHT
                #pragma shader_feature_local __ UV_COLOR_RAMP
                #pragma shader_feature_local __ GLOW
                #pragma shader_feature_local __ UV_MANIPULATE
                #pragma shader_feature_local __ DISSOLVE
                #pragma shader_feature_local __ DISSOlVE_CLIP
                #pragma shader_feature_local __ DISTORTION
                #pragma shader_feature_local __ LITSHADING

                struct appdata
                {
                    float4 Position : POSITION;
                    float4 Color : COLOR;
                    float3 Normal : NORMAL;
                    float4 texcoords : TEXCOORD0;
                    float4 texcoords1 : TEXCOORD1;
                    float2 texcoords2 : TEXCOORD2;
                    float texcoords3 : TEXCOORD3;
                };

                struct v2f
                {
                    float4 Position : SV_POSITION;
                    float4 Color : COLOR;
                    float4 UvPackedTex : TEXCOORD0;
                    float4 SecondColor : TEXCOORD1;
                    #if DISSOLVE
                        float3 Dissolve : TEXCOORD2;
                    #endif
                    #if DISTORTION
                        float4 UvDistortion : TEXCOORD3;
                    #endif
                    float Light : TEXCOORD4;
                    float4 CustomData1 : TEXCOORD5;
                    float3 AMask : TEXCOORD6;
                    #if GEO
                        half Rim : TEXCOORD7;
                    #endif
                    float4 CustomData2 : TEXCOORD8;
                    #if GLOW
                        half Glow : TEXCOORD9;
                    #endif
                };

                v2f vert(appdata v)
                {
                    v2f o;
                    //Inputs
                    float4 customD1 = v.texcoords;
                    float4 customD2 = v.texcoords1;
                    float2 uvs = v.texcoords2;

                    float4 pos = v.Position;
                    float3 wPos = mul(UNITY_MATRIX_M, pos.xyz);
                    float3 wNormal = normalize(mul(UNITY_MATRIX_M, v.Normal));

                    //Geo Deformation and Rim
                    #if GEO
                        half2 geiUseCd = half2(_GeoOffset, v.texcoords[_GeoCustom]);

                        half wave = saturate(WaveCurveVertex((uvs.x * _GeoDeformPhase) + (lerp(_GeoOffset, v.texcoords[_GeoCustom], _GeoUseCd)), 1.0, customD1, (_GeoDeformAmplitude / 100.0)) );
                        pos.xyz += wave * _GeoAxis.xyz;
                        pos.xyz += v.Normal * (wave * _GeoPush.xyz);

                        half rim = FresnelVertexV2(v.Normal, pos);
                        rim = saturate(rim);
                    #endif

                    //Alpha Mask
                    float2 aMask = UvTransform(uvs, _AMaskTrans);
                    float4 cd1AMask = float4(customD1[_AMaskCh.x], customD1[_AMaskCh.y], customD1[_AMaskCh.z],
                                             customD1[_AMaskCh.w]);
                    float4 cdAMaskTrans = cd1AMask * _AMaskSqSw;
                    aMask = (aMask * (cdAMaskTrans.xy + _AMaskTrans.xy)) + cdAMaskTrans.zw;

                    //World Position Mask
                    float3 wpAxis = ((wPos / 10.0) + _AWpMaskOffset) * _AWpMaskAxis;
                    half wpMask = saturate(wpAxis.x + wpAxis.y + wpAxis.z);
                    float2 wpUv = float2(wpMask, uvs.y);

                    //Uv Packed Texture
                    float2 uvPackedTex = UvTransform(uvs, _AlphaTrans);
                    #if UV_MANIPULATE
                        float4 cd1Alpha = float4(customD1[_UvAlphaCh.x], customD1[_UvAlphaCh.y], customD1[_UvAlphaCh.z], customD1[_UvAlphaCh.w]);
                        float4 cdTrans = cd1Alpha * _UvAlphaSqSw;
                        uvPackedTex = (uvPackedTex * (cdTrans.xy + _AlphaTrans.xy)) + cdTrans.zw;
                        float2 cd1Twist = float2(customD1[_UvTwistCh.x], customD1[_UvTwistCh.y]);
                        uvPackedTex = UvTwistVertex(uvPackedTex, lerp(_UvTwist.xy, _UvTwist.xy * cd1Twist, _UvTwistAlphaCd), _UvTwistUInv, _UvTwistVInv);
                    #endif

                    //Uv Dissolve
                    #if DISSOLVE
                        float2 uvDis = UvManipulation(uvs, _DisFlipU, _DisFlipV, _DisRot);
                        uvDis = UvTransform(uvDis, _DisTrans);
                    #if UV_MANIPULATE
                            float2 cd1TwistDis = float2(customD1[_UvTwistCh.z], customD1[_UvTwistCh.w]);
                            uvDis = UvTwistVertex(uvDis, lerp(_UvTwist.zw, _UvTwist.zw * cd1TwistDis, _UvTwistDisCd), _UvTwistUInv, _UvTwistVInv);
                    #endif
                    #endif

                    //Uv Distortion
                    #if DISTORTION
                        float2 uvDst = UvTransform(uvs, _DstTrans);
                    #if UV_MANIPULATE
                            float4 cd1Dst = float4(customD1[_UvDstCh.x], customD1[_UvDstCh.y], customD1[_UvDstCh.z], customD1[_UvDstCh.w]);
                            float4 dstCdTrans = cd1Dst * _UvDstSqSw;
                            uvDst = (uvDst * (dstCdTrans.xy + _DstTrans.xy)) + dstCdTrans.zw;
                    #endif
                    #endif

                    //Light Settings
                    float light = 0.0;
                    float wpRamp = 0.0;
                    float lightUv = 0.0;
                    #if LIGHT
                        wpRamp = LightGradientVertex(pos.xyz, v.Normal, (_SetPos.xyz + _LightPos.xyz), _LightRange, _LightFallOff, _LightHardness, _LightRangeMul);
                    #endif
                    #if UV_COLOR_RAMP
                        lightUv = UvRampVertex(v.texcoords2, _UvRampBlend, _UvRampOffset, _UvRampSet);
                    #endif
                    #if LIGHT || UV_COLOR_RAMP
                        light = lerp(light + lightUv, light * lightUv, _MulLight);
                        light = lerp(light + wpRamp, (light + wpRamp) * wpRamp, _LightRangeMul);
                        light = saturate(light);
                        light *= lerp(1.0, customD1[_GradientBlendChannel], _GradientBlendCd);
                    #endif

                    //Glow
                    half glowRim = FresnelVertexV2(v.Normal, pos);
                    glowRim = saturate(glowRim);

                    v.Color.rgb = lerp(1, v.Color.rgb, _MulPColor);

                    //Outputs
                    o.Position = UnityObjectToClipPos(pos);
                    o.Color = AlphaVertex(v.Color, _offVc, v.texcoords3);
                    #if GEO
                        o.Rim = rim;
                    #endif
                    o.UvPackedTex = float4(uvPackedTex, wpUv);
                    o.SecondColor = v.texcoords1;
                    #if DISSOLVE
                        o.Dissolve = float3(lerp(uvDis, uvPackedTex, _DisUseAlphaUv), v.texcoords.w);
                    #endif
                    #if DISTORTION
                        o.UvDistortion = float4(uvDst.xy, v.texcoords2);
                    #endif
                    o.Light = light;
                    o.CustomData1 = v.texcoords;
                    o.CustomData2 = v.texcoords1;
                    o.AMask = float3(lerp(aMask, uvPackedTex, _AMaskUseAlphaUv), wpMask);
                    #if GLOW
                        o.Glow = glowRim;
                    #endif
                    return o;
                }

                float4 frag(v2f i) : SV_Target
                {
                    #if DISTORTION
                        //Distortion function & link to Particle Custom Data
                        float2 dstUseCd = float2(_DstStrength, i.CustomData1[_DstCustom]);
                        float dstMaskTex = tex2D(_DstMask, i.UvDistortion.zw).r;
                        float2 dstTex = tex2D(_DstTex, i.UvDistortion.xy).rg;
                    #endif

                    //Alpha
                    #if DISTORTION
                            i.UvPackedTex.xy = lerp(i.UvPackedTex.xy, DistortionFragment(dstMaskTex, _DstInvMask, dstTex, dstUseCd[_DstUseCd], 1, i.UvPackedTex.xy), _DstAlpha);
                    #endif

                    //Alpha
                    half mask;
                    half alpha = 1.0;
                    half4 mulColor;

                    #if GEO != 1 || GEO_TEX == 1
                    #if TEX != 1
                    half4 packedTex = tex2D(_Alpha, i.UvPackedTex.xy);
                    mask = BlendTexChannelFragment(packedTex.rgb, _BlendChannels.rgb);
                    alpha = lerp(mask, alpha, _DisableAlpha);
                    #endif

                    #if TEX == 1
                            mulColor = tex2D( _Alpha, i.UvPackedTex.xy);
                    #endif

                    #endif

                    #if GEO
                        i.Rim *= _GeoRimMul;
                        i.Rim += _GeoRimHardness * _GeoRimBlend;

                    #if GEO_TEX != 1
                            mask = saturate(i.Rim);
                    #endif
                    #if GEO_TEX == 1
                           mask *= saturate(i.Rim);
                    #endif
                        alpha = lerp(mask, alpha, _DisableAlpha);
                    #endif

                    half aMask = 1.0;

                    #if GEO != 1 || GEO_TEX == 1
                    #if DISTORTION
                               i.AMask.xy = (DistortionFragment(dstMaskTex, _DstInvMask, dstTex,  dstUseCd[_DstUseCd], 1, i.AMask.xy)) * _DstAlpha;
                    #endif

                    //Alpha Mask
                    #if TEX != 1
                    aMask = tex2D(_AMask, i.AMask.xy).r;
                    #endif

                    #if TEX == 1
                            aMask = tex2D( _Alpha,  i.AMask.xy).a;
                    #endif

                    aMask = lerp(1.0, aMask, _AMaskUse);

                    #endif

                    //Wp Mask
                    half wpMask = i.AMask.z;
                    wpMask *= _AWpMaskMultiplier;
                    wpMask += _AWpMaskHardness;
                    aMask *= lerp(1.0, saturate(wpMask), _AWpMaskUse);

                    //Dissolve
                    float dissolve = 1.0;
                    #if DISSOLVE
                    #if DISTORTION
                            i.Dissolve.xy = (DistortionFragment(dstMaskTex, _DstInvMask, dstTex, dstUseCd[_DstUseCd], 1, i.Dissolve.xy)) * _DstDis;
                    #endif
                        float2 disUseCd = float2(_DisStrength, i.CustomData1[_DisCustom]);
                        float disTex = (tex2D(_DisTex, i.Dissolve.xy).r);
                        dissolve = DissolveFragment(disTex, _DisInv, _DisFallOff, disUseCd[_DisUseCd]);
                    #endif

                    //Shading
                    #if TEX != 1
                    half2 useCustomDataOffset = half2(_LUTOffset, i.CustomData1[_LUTCustom]);
                    half offsetV = useCustomDataOffset[_LUTUseCd]; //lerp(0, i.CustomData1[_LUTCustom], _LUTUseCd);
                    half4 gradientMapping = GradientMappingFragment(mask, _LookUpTex, offsetV, _LookUpTex_TexelSize.y,
                                                                    _PassLUT, lerp(
                                                                        i.UvPackedTex.xy, i.UvPackedTex.zw,
                                                                        _AWpMaskLut));
                    mulColor = lerp(gradientMapping, gradientMapping, saturate(gradientMapping.a));
                    #endif

                    #if UV_COLOR_RAMP || LIGHT
                        half3 gradientColor = lerp(_GradientColor.rgb, mulColor.rgb, _GradientUseLUT);
                        mulColor.rgb += i.Light * ((gradientColor * _GradientStrength) + _GradientBrightness);
                    #endif

                    half4 col = saturate(
                        half4(mulColor.rgb * i.Color.rgb, lerp(1.0, mulColor.a, _BlendAdd)) * alpha * dissolve * i.Color
                        .a * aMask);

                    #if DISSOLVE
                    #if DISSOlVE_CLIP
                            clip(col.a - 0.1);
                            return col;
                    #endif
                    #endif

                    #if LITSHADING
                        col = CalculateColor(col, 0.0, i.params, i.Position, 1 - (mask * 0.5));
                    #endif

                    #if GLOW
                            //Glow
                            i.Glow *= _GlowRimMul;
                            i.Glow = lerp(i.Glow, 1 -  i.Glow, _GlowRimInvert);
                            i.Glow += _GlowRimHardness;
                            half glowRange = 0.0;
                            glowRange += i.Glow * _GlowRimBlend;
                            glowRange += i.Light * _GlowGradient;
                            glowRange += (1 - mulColor.a) * _GlowLut;
                    #if GEO != 1 || GEO_TEX == 1
                            glowRange += BlendTexChannelFragment(packedTex.rgb, _GlowAlpha.rgb);
                            glowRange += aMask * _GlowAMask;
                    #endif
                            glowRange = saturate(glowRange);
                            half2 glowStrength = float2(_GlowStr, i.CustomData1[_GlowCustom] + 1.0);
                            col.rgb *= (lerp(1.0, glowStrength[_GlowUseCd] * _GlowTint, glowRange));
                    #endif

                    return col;
                }
                ENDCG
            }
        }
        CustomEditor "InnoGames.VFX.Game.Editor.VFX_ShaderGUI_MultiColor_LightAndMotion_Particle"
    }
}