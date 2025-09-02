Shader "InnoGames/VFX/Multi Color/Light And Motion VAT Experimental"
{
    Properties
    {
        //Compile Features
        [Space(25)][Header(COMPUTE FEATURES)][Space(5)]
        [Toggle(GEO)] _GEO ("Compute Geometry", int) = 0
        [Toggle(SOFTBODY)] _SOFTBODY ("Compute VAT Softbody", int) = 0
        [Toggle(LIGHT)] _LIGHT ("Compute Gradient by Light", int) = 0
        [Toggle(UV_COLOR_RAMP)] _UV_COLOR_RAMP ("Compute Gradient by Uv", int) = 0
        [Toggle(UV_MANIPULATE)] _UV_MANIPULATE ("Compute Uv Manipulate", int) = 0
        [Toggle(DISSOLVE)] _DISSOLVE ("Compute Dissolve", int) = 0
        [Toggle(DISSOlVE_CLIP)]_DISSOlVE_CLIP("Compute Dissolve Clip", int) = 0
        [Toggle(DISTORTION)] _DISTORTION ("Compute Distortion", int) = 0
        
        //VAT Softbody
        [Space(25)][Header(VAT SOfTBODY PROPERTIES)][Space(10)]_SoftbodyTimeposition("Time", range( 0 , 1)) = 0
        _SoftbodyFramecount("Total Frame count", float) = 240
        _SoftbodyPos("VAT Softody Positions", 2D) = "white" {}
        _SoftbodyNormals("VAT Softbody Normals", 2D) = "white" {}
        
        //Geometry Properties
        _GeoDeformPhase("Deformation Phase ", range(-100.0, 100.0)) = 0.0
        _GeoDeformAmplitude("Deformation Amplitude ", range(0.0, 100.0)) = 0.0
        _GeoRimMul("Rim Multiplier", range(0.0, 2.0)) = 1.0
        _GeoRimHardness("Rim Hardness", range(0.0, 1.0)) = 0.0
        _GeoAxis("Deformation Axis ", vector) = (1.0, 0.0, 0.0, 0.0)
        _GeoPush("Push Axis", vector) = (0.0, 0.0, 0.0, 0.0)
        _GeoOffset("Offset", range(0.0, 100.0)) = 0.0
        
        //Gradient Properties
		_GradientColor("Gradient Color", color) = (1.0, 1.0, 1.0, 1.0)
        _GradientStrength("Gradient Strength", range(0, 10)) = 0
        _GradientBrightness("Gradient Brightness", range(0, 1)) = 0
        
        //Gradient by Light Properties
        [Toggle]_LightRangeMul("Convert To A Light", int) = 0
        _SetPos("Set Position", vector) = (0.0, 0.0, 0.0, 0.0)
        _LightPos("Light Source Position", vector) = (0.0, 0.0, 0.0, 0.0)
        _LightRange("Light Range", range(0.0, 100.0)) = 0.0
        _LightFallOff("Light Fall Off", range(0.0, 10.0)) = 0.0
        _LightHardness("Light Hardness",range(0.0, 10.0)) = 0.0
        
        //Gradient by Uv Properties
        _UvRampBlend("UV Ramp Axis Blend (X = Positive U, Y = Negative U, Z = Positive V, W = Negative W)", vector) = (0.0, 0.0, 0.0, 0.0)
		_UvRampOffset("Uv Ramp Offset", vector) = (0.0, 0.0, 0.0, 0.0)
		_UvRampSet("Uv Ramp Settings", vector)  = (1.0, 1.0, 0.0, 0.0)
        _Light("Light", vector)  = (1.0, 1.0, 0.0, 0.0)
        
        //Shading
        [Toggle]_DisableAlpha("Disable in Alpha", int) = 0
        [NoScaleOffset]_LookUpTex ("Look Up Table", 2D) = "white" {}
        _GlowingStrength ("Glow Strength", range(1.0, 100.0)) = 1.0
        [Toggle]_PassLUT("Switch LUT to Color Gradient", int) = 0
        _LUTAnimate("LUT Animate Offset, X min, Y max range, Z speed", vector) = (0.0, 0.0, 0.0, 0.0)
        
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
        
        //Render Properties
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
                    uniform half _GradientUseLUT;
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


                        uniform half _SoftbodyTimeposition;
                        uniform half _SoftbodyFramecount;
                        sampler2D _SoftbodyPos;
                        uniform float4 _SoftbodyPos_TexelSize;
                        sampler2D _SoftbodyNormals;

                    #if LIGHT
                        uniform half _LightRange;
                        uniform half _LightFallOff;
                        uniform half _LightHardness;
                        uniform float4 _LightPos;
                        uniform float4 _SetPos;
                    #endif
                    
                    #if UV_COLOR_RAMP
                        uniform float4 _UvRampBlend;
                        uniform float4 _UvRampOffset;
                        uniform float4 _UvRampSet;
                        uniform float _UvRampEnable;
                    #endif

                    uniform float _LightRangeMul;
                    uniform float _MulLight;

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
                #pragma shader_feature_local __ SOFTBODY
                #pragma shader_feature_local __ LIGHT
                #pragma shader_feature_local __ UV_COLOR_RAMP
                #pragma shader_feature_local __ UV_MANIPULATE
                #pragma shader_feature_local __ DISSOLVE
                #pragma shader_feature_local __ DISSOlVE_CLIP
                #pragma shader_feature_local __ DISTORTION

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
                    half4 Color : COLOR;
                    float2 UvPackedTex : TEXCOORD0;
                    #if DISSOLVE
                        float3 Dissolve : TEXCOORD2;
                    #endif
                    #if DISTORTION
                        float4 UvDistortion : TEXCOORD3;
                    #endif
                    half Light : TEXCOORD4;
                    float4 CustomData1 : TEXCOORD5;
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
                    
   

                    //VAT Softbody
                    float uvPos = _SoftbodyPos_TexelSize.y * (((_SoftbodyFramecount - 1) * _SoftbodyTimeposition) * -1);
                    float2 vatUv = float2(v.texcoords1.x, uvPos + v.texcoords1.y);
                    float3 animationPos = tex2Dlod(_SoftbodyPos, float4(vatUv, 0, 0.0)).rgb;
                    float3 normal = tex2Dlod(_SoftbodyNormals, float4(vatUv, 0, 0.0)).rgb;

                    normal = v.Normal + normal;
                    float4 pos = v.Position;
                    pos.xyz += animationPos;
                    float3 wPos = mul(unity_ObjectToWorld, animationPos);
                    float3 wNormal = normalize(mul(UNITY_MATRIX_M, normal));
                    //Geo Deformation and Rim
                    #if GEO
                        half wave = saturate(WaveCurveVertex((uvs.x * _GeoDeformPhase), time, _GeoOffset, (_GeoDeformAmplitude / 100.0)) );
                        pos.xyz += lerp(_GeoAxis.xyz * -1, _GeoAxis.xyz, wave);
                        pos.xyz += wNormal * (wave * _GeoPush.xyz);

                        half rim = FresnelVertexV2(wNormal, pos);
                        rim *= _GeoRimMul;
                        rim += _GeoRimHardness;
                        rim = saturate(rim);
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

                    #if LIGHT
                        wpRamp = LightGradientVertex(pos, wNormal, (_SetPos.xyz + _LightPos.xyz), _LightRange, _LightFallOff, _LightHardness, _LightRangeMul);
                    #endif
                    #if UV_COLOR_RAMP
                        light = UvRampVertex(uvs, _UvRampBlend, _UvRampOffset, _UvRampSet);
                    #endif
                                      #if LIGHT || UV_COLOR_RAMP
                        light = lerp(light + lightUv, light * lightUv, _MulLight);
                        light = lerp(light + wpRamp, (light + wpRamp) * wpRamp, _LightRangeMul);
                        light = saturate(light);
                        //light *= lerp(1.0, customD1[_GradientBlendChannel], _GradientBlendCd);
                    #endif
                    

                    //LUT Aniamtion
                    half lutAnimation = lerp(_LUTAnimate.x, _LUTAnimate.y, sin(time * _LUTAnimate.z));

                    //Outputs
                   
                    o.Position = UnityObjectToClipPos(pos);
                    o.Color = v.Color;
                    #if GEO
                        o.Rim = rim;
                    #endif


                    #if DISSOLVE
                        o.Dissolve = float3(uvDis, 0.0);
                    #endif
                    #if DISTORTION
                        o.UvDistortion = float4(uvDst, uvs);
                    #endif
                    o.Light = light;
                    o.CustomData1 = float4(0.0, 0.0, 0.0, 0.0);
                    o.LUTAnimate = lutAnimation;
                    o.UvPackedTex = 0;
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
                    half mask = 1.0;
                    half alpha = 1.0;

                    #if GEO
                        i.Rim *= _GeoRimMul;
                        i.Rim += _GeoRimHardness;
                        mask = saturate(i.Rim);
                        alpha = lerp(mask, alpha, _DisableAlpha);
                    #endif

                    half aMask = 1.0;

                    //Dissolve
                    half dissolve = 1.0;
                    #if DISSOLVE
                        #if DISTORTION
                            i.Dissolve.xy = (DistortionFragment(dstMaskTex, _DstInvMask, dstTex, 0, 1, i.Dissolve.xy)) * _DstDis;
                        #endif
                        half disTex = (tex2D(_DisTex, i.Dissolve.xy).r);
                        dissolve = DissolveFragment(disTex, _DisInv, _DisFallOff, lerp(_DisStrength, 1 - (i.Color.a * 2.0), _UseAlpha));
                        i.Color.a = lerp(i.Color.a, 1.0, _UseAlpha);
                    #endif
                    
                    //Shading
                    half4 gradientMapping = GradientMappingFragment(mask, _LookUpTex, i.LUTAnimate,_LookUpTex_TexelSize.y, _PassLUT, i.UvPackedTex);
                    half4 mulColor = lerp(gradientMapping, gradientMapping, saturate(gradientMapping.a));

         
                    #if UV_COLOR_RAMP || LIGHT
                        half3 gradientColor = lerp(_GradientColor.rgb, mulColor.rgb, _GradientUseLUT);
                        mulColor.rgb += i.Light * ((gradientColor * _GradientStrength) + _GradientBrightness);
                    #endif

                    half4 col = saturate(half4( mulColor.rgb * i.Color.rgb, lerp(1.0, mulColor.a, _BlendAdd)) * alpha * dissolve * i.Color.a * aMask);

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
      CustomEditor "InnoGames.VFX.Game.Editor.VFX_ShaderGUI_MultiColor_LightAndMotion_VAT"
    }
}