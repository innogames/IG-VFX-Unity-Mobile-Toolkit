Shader "InnoGames/VFX/Multi Color/Light And Motion"
{
    Properties
    {
        //Compile Features
        [Space(25)][Header(COMPUTE FEATURES)][Space(5)]
        [Toggle(GEO)] _GEO ("Compute Geometry", int) = 0
        [Toggle(GEO_TEX)]_GEO_TEX("Compute Geometry Add Texture", int) = 0
        [Toggle(UV_COLOR_RAMP)] _UV_COLOR_RAMP ("Compute Gradient by Uv", int) = 0
        [Toggle(UV_MANIPULATE)] _UV_MANIPULATE ("Compute Uv Manipulate", int) = 0
        [Toggle(DISSOLVE)] _DISSOLVE ("Compute Dissolve", int) = 0
        [Toggle(DISSOlVE_CLIP)]_DISSOlVE_CLIP("Compute Dissolve Clip", int) = 0
        [Toggle(DISTORTION)] _DISTORTION ("Compute Distortion", int) = 0
        [Toggle(LITSHADING)] _LITSHADING ("Compute Lit Shading", int) = 0
        //Geometry Properties
        _GeoDeformPhase("Deformation Phase ", range(-100.0, 100.0)) = 0.0
        _GeoDeformAmplitude("Deformation Amplitude ", range(0.0, 100.0)) = 0.0
        _GeoRimMul("Rim Multiplier", range(0.0, 2.0)) = 1.0
        _GeoRimHardness("Rim Hardness", range(0.0, 1.0)) = 0.0
        _GeoAxis("Deformation Axis ", vector) = (1.0, 0.0, 0.0, 0.0)
        _GeoPush("Push Axis", vector) = (0.0, 0.0, 0.0, 0.0)
        _GeoOffset("Offset", range(0.0, 100.0)) = 0.0
        //Gradient by Uv Properties
		[Space(25)][Header(GRADIENT PROPERTIES)][Space(10)]_GradientColor("Gradient Color", color) = (1.0, 1.0, 1.0, 1.0)
        _GradientStrength("Gradient Strength", range(0, 10)) = 0
        _GradientBrightness("Gradient Brightness", range(0, 1)) = 0
        [Space(10)][Header(Gradient by Uv)][Space(5)]_UvRampBlend("UV Ramp Axis Blend (X = Positive U, Y = Negative U, Z = Positive V, W = Negative W)", vector) = (0.0, 0.0, 0.0, 0.0)
		_UvRampOffset("Uv Ramp Offset", vector) = (0.0, 0.0, 0.0, 0.0)
		_UvRampSet("Uv Ramp Settings", vector)  = (1.0, 1.0, 0.0, 0.0)
        _Light("Light", vector)  = (1.0, 1.0, 0.0, 0.0)
        //Shading
        [NoScaleOffset]_LookUpTex ("Look Up Table", 2D) = "white" {}
        _GlowingStrength ("Glow Strength", range(1.0, 100.0)) = 1.0
        [Toggle]_PassLUT("Switch LUT to Color Gradient", int) = 0
        _LUTAnimate("LUT Animate Offset, X min, Y max range, Z speed", vector) = (0.0, 0.0, 0.0, 0.0)
        //Alpha Properties
        [Toggle]_DisableAlpha("Disable in Alpha", int) = 0
        [NoScaleOffset]_Alpha ("Packed Texture", 2D) = "white" {}
        _BlendChannels("Blend Packed Texture Channel", vector) = (0.0, 0.0, 0.0, 0.0)
        _AlphaTrans("Uv Tiling & Offset", vector) = (1.0, 1.0, 0.0, 0.0)
        [Space(5)][Header(Alpha Mask)][Space(5)]
        [NoScaleOffset]_AMask("Alpa Mask", 2D) = "white" {}
        [Toggle]_AMaskUse("Enable Alpha Mask", int ) = 0
        [Toggle]_AMaskUseAlphaUv("Alpha Mask use Alpha Uv", int ) = 0
        _AMaskTrans("Alpha Mask Uv Tiling & Offset", vector) = (1.0, 1.0, 0.0, 0.0)
        _AMaskSqSw("Alpha Mask Speed Squeez XY & Swipe ZW", vector ) = (0.0, 0.0, 0.0, 0.0)
        //Dissolve Properties
        [NoScaleOffset]_DisTex("Dissolve Ramp", 2D) = "gray" {}
        [Toggle]_DisFlipU("Dissolve Flip U", int )= 0
        [Toggle]_DisFlipV("Dissolve Flip V", int )= 0
        [Toggle]_DisRot("Dissolve Rotate 90 Degress", int )= 0
        [Toggle]_DisInv("Dissolve Invert Ramp", int )= 0
        [Toggle]_UseAlpha("Dissolve With Alpha Color", int )= 0
        _DisStrength("Dissolve Strength", Range(0, 3)) = 0
        _DisTrans("Dissolve Uv Tiling & Offset", vector) = (1.0, 1.0, 0.0, 0.0)
        _DisFallOff("Dissolve Fall Off", Range(1, 100)) = 1
        //Distortion Properties
        [NoScaleOffset]_DstTex ("Distortion Texture", 2D) = "gray" {}
        [NoScaleOffset]_DstMask ("Distortion Mask", 2D) = "white" {}
        [Toggle] _DstInvMask ("Distortion Mask Invert", int) = 0
        [Toggle]_DstAlpha("Distortion Enable for Alpha", int ) = 0
        [Toggle]_DstDis("Distortion Enable for Dissolve", int ) = 0
        _DstStrength("Distortion Strength", Range(0, 3)) = 0
        [Toggle]_DstWorldUv ("Distortion Set World Uv Cordinates", int) = 0
        _DstTrans ("Distortion Uv Tiling & Offset", vector) = (1.0, 1.0, 0.0, 0.0)
        //Uv Properties
        [Space(5)][Header(Uv Alpha)][Space(5)]_UvAlphaSqSw("Uv Alpha Enable Squeez XY & Swipe ZW", vector ) = (0.0, 0.0, 0.0, 0.0)
        [Space(5)][Header(Uv Distortion)][Space(5)]_UvDstSqSw("Uv Distortion Enable Squeez XY & Swipe ZW", vector ) = (0.0, 0.0, 0.0, 0.0)
        [Space(5)][Header(Uv Twist)][Space(5)][Toggle]_UvTwistUInv("Uv Twist Invert U", int ) = 0
        [Toggle]_UvTwistVInv("Uv Twist Invert V", int ) = 0
        [Toggle]_UvTwistAlphaCd("Uv Twist Alpha Use Custom Data", int ) = 0
        [Toggle]_UvTwistDisCd("Uv Twist Dissolve Use Custom Data", int ) = 0
        _UvTwist("Uv Twist", vector) = (0.0, 0.0, 0.0, 0.0)
        //Render Properties
        [Space(25)][Header(RENDER PROPERTIES)][Space(5)]
        [Toggle]_BlendAdd ("Premultiplied Mode", int) = 0
        [Toggle]_offVc("Disable Vertex Color", int ) = 0
        [Enum(UnityEngine.Rendering.CullMode)]_Cull("Cull Mode", Int) = 4
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
                    uniform half4 _GradientColor;
                    uniform half _GradientStrength;
                    uniform half _GradientBrightness;
                    uniform half _BlendAdd;
                    uniform half _offVc;
                    sampler2D _LookUpTex;
                    uniform half4 _LookUpTex_TexelSize;
                    uniform half _PassLUT;
                    uniform half4 _LUTAnimate;
                    uniform half _UseImage;
                    uniform half4 _Light;
                    uniform half _DisableAlpha;
                    uniform half _GlowingStrength;

                    #if GEO
                        uniform half _GeoDeformPhase;
                        uniform half _GeoDeformAmplitude;
                        uniform half4 _GeoAxis;
                        uniform half4 _GeoPush;
                        uniform half _GeoRimMul;
                        uniform half _GeoRimHardness;
                        uniform half _GeoOffset;
                    #endif

                    #if UV_COLOR_RAMP
                        uniform float4 _UvRampBlend;
                        uniform float4 _UvRampOffset;
                        uniform float4 _UvRampSet;
                        uniform float _UvRampEnable;
                    #endif

                    sampler2D _Alpha;
                    uniform half4 _AlphaTrans;
                    uniform half4 _BlendChannels;
                    uniform half _AMaskUse;
                    sampler2D _AMask;
                    uniform half4 _AMaskTrans;
                    uniform half4 _AMaskSqSw;
                    uniform half _AMaskUseAlphaUv;

                    #if DISSOLVE
                        sampler2D _DisTex;
                        uniform half _DisFlipU;
                        uniform half _DisFlipV;
                        uniform half _DisRot;
                        uniform half _DisInv;
                        uniform half _DisFallOff;
                        uniform float4 _DisTrans;
                        uniform half _DisStrength;
                        uniform half _UseAlpha;
                    #endif

                    #if DISTORTION
                        sampler2D _DstTex;
                        sampler2D _DstMask;
                        uniform half _DstInvMask;
                        uniform half _DstStrength;
                        uniform half _DstWorldUv;
                        uniform float4 _DstTrans;
                        uniform half _DstAlpha;
                        uniform half _DstDis;
                    #endif

                    #if UV_MANIPULATE
                        uniform float4 _UvAlphaSqSw;
                        uniform float4 _UvDstSqSw;
                        uniform float _UvTwistUInv;
                        uniform float _UvTwistVInv;
                        uniform float _UvTwistAlphaCd;
                        uniform float _UvTwistDisCd;
                        uniform float4 _UvTwist;
                    #endif
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
                CGPROGRAM

                #pragma vertex vert
                #pragma fragment frag
                #define _TRANSLUCENT

                #include "UnityCG.cginc"
                #include "UnityShaderVariables.cginc"
                #include "CoreLibrary/Effects_Library.cg"

                #pragma shader_feature_local __ GEO
                #pragma shader_feature_local __ GEO_TEX
                #pragma shader_feature_local __ UV_COLOR_RAMP
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
                    float2 texcoords : TEXCOORD0;
                    float texcoords2 : TEXCOORD1;
                };

                struct v2f
                {
                    float4 Position : SV_POSITION;
                    half4 Color : COLOR;
                    float2 UvPackedTex : TEXCOORD0;
                    half4 SecondColor : TEXCOORD1;
                    #if DISSOLVE
                        float3 Dissolve : TEXCOORD2;
                    #endif
                    #if DISTORTION
                        float4 UvDistortion : TEXCOORD3;
                    #endif
                    half Light : TEXCOORD4;
                    float4 CustomData1 : TEXCOORD5;
                    half2 AMask : TEXCOORD6;
                    #if GEO
                        half Rim : TEXCOORD7;
                    #endif
                    half LUTAnimate : TEXCOORD8;
                };

                v2f vert(appdata v)
                {
                    v2f o;
                    //Inputs
                    float time = _Time.y;
                    float2 uvs = v.texcoords;
                    float4 pos = v.Position;
                    float3 wPos = mul(unity_ObjectToWorld, pos.xyz);
                    float3 wNormal = normalize(mul(UNITY_MATRIX_M, v.Normal));

                    //Geo Deformation and Rim
                    #if GEO
                        half wave = saturate(WaveCurveVertex((uvs.x * _GeoDeformPhase), time, _GeoOffset, (_GeoDeformAmplitude / 100.0)) );
                        pos.xyz += lerp(_GeoAxis.xyz * -1, _GeoAxis.xyz, wave);
                        pos.xyz += v.Normal * (wave * _GeoPush.xyz);

                        half rim = FresnelVertexV2(v.Normal, pos);
                        rim *= _GeoRimMul;
                        rim += _GeoRimHardness;
                        rim = saturate(rim);
                    #endif

                    //Alpha Mask
                    float2 aMask =  UvTransform(uvs, _AMaskTrans);
                    float4 cdAMaskTrans = frac(time * _AMaskSqSw);
                    aMask = (aMask * (cdAMaskTrans.xy + _AMaskTrans.xy)) + cdAMaskTrans.zw;

                    //Uv Packed Texture
                    float2 uvPackedTex = UvTransform(uvs, _AlphaTrans);
                    #if UV_MANIPULATE
                        float4 cdTrans =  frac(time * _UvAlphaSqSw);
                        uvPackedTex = (uvPackedTex * (cdTrans.xy + _AlphaTrans.xy)) + cdTrans.zw;
                        uvPackedTex = UvTwistVertex(uvPackedTex, lerp(_UvTwist.xy, _UvTwist.xy, _UvTwistAlphaCd), _UvTwistUInv, _UvTwistVInv);
                    #endif

                    //Uv Dissolve
                    #if DISSOLVE
                        float2 uvDis = UvManipulation(uvs, _DisFlipU, _DisFlipV, _DisRot);
                        uvDis = UvTransform(uvDis, _DisTrans);
                        #if UV_MANIPULATE

                            uvDis = UvTwistVertex(uvDis, _UvTwist.zw, _UvTwistUInv, _UvTwistVInv);
                        #endif
                    #endif

                    //Uv Distortion
                    #if DISTORTION
                        float2 uvDst = UvTransform(lerp(uvs, wPos.xy, _DstWorldUv), _DstTrans);
                        #if UV_MANIPULATE
                            float4 dstCdTrans = frac(time * _UvDstSqSw);
                            uvDst = (uvDst * (dstCdTrans.xy + _DstTrans.xy)) + dstCdTrans.zw;
                        #endif
                    #endif

                    //Light Settings
                    float light = 0.0;
                    float wpRamp = 0.0;
                    float lightUv = 0.0;

                    #if UV_COLOR_RAMP
                        light = UvRampVertex(uvs, _UvRampBlend, _UvRampOffset, _UvRampSet);
                    #endif

                    //LUT Aniamtion
                    half lutAnimation = lerp(_LUTAnimate.x, _LUTAnimate.y, sin(time * _LUTAnimate.z));

                    //Outputs
                    o.Position = UnityObjectToClipPos(pos);
                    o.Color = AlphaVertex(v.Color, _offVc, v.texcoords2);
                    #if GEO
                        o.Rim = rim;
                    #endif
                    o.UvPackedTex = uvPackedTex;

                    #if DISSOLVE
                        o.Dissolve = float3(uvDis, 0.0);
                    #endif
                    #if DISTORTION
                        o.UvDistortion = float4(uvDst, uvs);
                    #endif
                    o.Light = light;
                    o.CustomData1 = float4(0.0, 0.0, 0.0, 0.0);
                    o.AMask = lerp(aMask, uvPackedTex, _AMaskUseAlphaUv);
                    o.LUTAnimate = lutAnimation;
                    return o;
                }

                half4 frag(v2f i) : SV_Target
                {
                    //return i.Color;
                    #if DISTORTION
                        float dstMaskTex = tex2D(_DstMask, i.UvDistortion.zw).r;
                        float2 dstTex = tex2D(_DstTex, i.UvDistortion.xy).rg;
                    #endif

                    #if DISTORTION
                            i.UvPackedTex = lerp(i.UvPackedTex, DistortionFragment(dstMaskTex, _DstInvMask, dstTex, _DstStrength, 1, i.UvPackedTex), _DstAlpha);
                    #endif

                    //Alpha
                    half mask;
                    half alpha = 1.0;
                    #if GEO != 1 || GEO_TEX == 1
                        half4 packedTex = tex2D( _Alpha, i.UvPackedTex);
                        mask = BlendTexChannelFragment(packedTex.rgb, _BlendChannels.rgb);
                        alpha = lerp(mask, alpha, _DisableAlpha);
                    #endif

                    #if GEO
                        i.Rim *= _GeoRimMul;
                        i.Rim += _GeoRimHardness;
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
                               i.AMask = (DistortionFragment(dstMaskTex, _DstInvMask, dstTex, _DstStrength, 1, i.AMask.xy)) * _DstAlpha;
                        #endif
                        //Alpha Mask
                        aMask = tex2D(_AMask, i.AMask).r;
                        aMask = lerp(1.0, aMask, _AMaskUse);
                    #endif

                    //Dissolve
                    half dissolve = 1.0;
                    #if DISSOLVE
                        #if DISTORTION
                            i.Dissolve.xy = (DistortionFragment(dstMaskTex, _DstInvMask, dstTex, _DstStrength, 1, i.Dissolve.xy)) * _DstDis;
                        #endif
                        half disTex = (tex2D(_DisTex, i.Dissolve.xy).r);
                        dissolve = DissolveFragment(disTex, _DisInv, _DisFallOff, lerp(_DisStrength, 1 - (i.Color.a * 2.0), _UseAlpha));
                        i.Color.a = lerp(i.Color.a, 1.0, _UseAlpha);
                    #endif

                    //Shading
                    half4 gradientMapping = GradientMappingFragment(mask, _LookUpTex, i.LUTAnimate,_LookUpTex_TexelSize.y, _PassLUT, i.UvPackedTex);
                    half4 mulColor = lerp(gradientMapping, gradientMapping, saturate(gradientMapping.a));

                    #if UV_COLOR_RAMP
                        mulColor.rgb += i.Light * ((_GradientColor * _GradientStrength) + _GradientBrightness);
                    #endif

                    half4 col = saturate(half4( mulColor.rgb * i.Color.rgb, lerp(1.0, mulColor.a, _BlendAdd)) * alpha * dissolve * i.Color.a * aMask);

                    #if LITSHADING
                        col = CalculateColor(col, 0.0, i.params, i.Position, 1 - (mask * 0.5));
                    #endif


                    col.rbg *= _GlowingStrength;

                    #if DISSOLVE
                        #if DISSOlVE_CLIP
                            clip(col.a - 0.1);
                            return col;
                        #endif
                    #endif

                    return col;
                }
                ENDCG
            }
        }
        CustomEditor "InnoGames.VFX.Game.Editor.VFX_ShaderGUI_MultiColor_LightAndMotion"
    }
}