Shader "InnoGames/VFX/Particle/Multi Color/Light And Motion"
{
    Properties
    {
        //Compile Features
        [Space(10)][Header(COMPUTE FEATURES)][Space(5)]
        [Toggle(GEO)] _GEO ("Compute Geometry", int) = 0
        [Toggle(GEO_TEX)]_GEO_TEX("Compute Geometry Add Texture", int) = 0  
        [Toggle(LIGHT)] _LIGHT ("Compute Gradient by Light", int) = 0
        [Toggle(UV_COLOR_RAMP)] _UV_COLOR_RAMP ("Compute Gradient by Uv", int) = 0
        [Toggle(UV_MANIPULATE)] _UV_MANIPULATE ("Compute Uv Manipulate", int) = 0
        [Toggle(DISSOLVE)] _DISSOLVE ("Compute Dissolve", int) = 0
        [Toggle(DISTORTION)] _DISTORTION ("Compute Distortion", int) = 0
        //Geometry Properties
        [Space(5)]_GeoDeformPhase("Deformation Phase ", range(-10.0, 10.0)) = 0.0
        _GeoDeformAmplitude("Deformation Amplitude ", range(0.0, 100.0)) = 0.0
        _GeoAxis("Deformation Axis ", vector) = (1.0, 0.0, 0.0, 0.0)
        _GeoPush("Push Axis", vector) = (0.0, 0.0, 0.0, 0.0)
        _GeoOffset("Offset", range(0.0, 10.0)) = 0.0
        [Toggle]_GeoUseCd("Geo Offset Use Custom Data 1", int ) = 0
        _GeoCustom("Geo Offset by CD1 Channel (0 - 3)", int) = 0
        _GeoRimMul("Rim Multiplier", range(0.0, 2.0)) = 1.0
        _GeoRimHardness("Rim Hardness", range(0.0, 1.0)) = 0.0
        _GeoRimBlend("Rim Blend Strength", range(0.0, 100.0)) = 1.0
        //Gradient Properties
		[Space(5)]_GradientColor("Gradient Color", color) = (1.0, 1.0, 1.0, 1.0)
        _GradientStrength("Gradient Strength", range(0, 10)) = 0
        _GradientBrightness("Gradient Brightness", range(0, 1)) = 0
        //Gradient by Light Properties
        [Space(5)][Toggle]_LightRangeMul("Convert To A Light", int) = 0
        _SetPos("Set Position", vector) = (0.0, 0.0, 0.0, 0.0)
        _LightPos("Light Source Position", vector) = (0.0, 0.0, 0.0, 0.0)
        _LightRange("Light Range", range(0.0, 100.0)) = 0.0
        _LightFallOff("Light Fall Off", range(0.0, 10.0)) = 0.0
        _LightHardness("Light Hardness",range(0.0, 10.0)) = 0.0
        //Gradient by Uv Properties
        [Space(5)][Toggle]_MulLight("Multiply Uv Ramp to Light Sources", int) = 0
        _UvRampBlend("UV Ramp Axis Blend (X = Positive U, Y = Negative U, Z = Positive V, W = Negative W)", vector) = (0.0, 0.0, 0.0, 0.0)
		_UvRampOffset("Uv Ramp Offset", vector) = (0.0, 0.0, 0.0, 0.0)
		_UvRampSet("Uv Ramp Settings", vector)  = (1.0, 1.0, 0.0, 0.0)
        //Shading
        [Space(5)][NoScaleOffset]_LookUpTex ("Look Up Table", 2D) = "white" {}
        [Toggle]_PassLUT("Switch LUT to Color Gradient", int) = 0
        [Toggle]_MulPColor("Multiply Particle Color", int) = 0
        [Toggle]_DisableAlpha("Disable in Alpha", int) = 0
        //Alpha Properties
        [Space(5)][Toggle]_AMaskUse("Enable Alpha Mask", int ) = 0
        [NoScaleOffset]_Alpha ("Packed Texture", 2D) = "white" {}
        _BlendChannels("Blend Packed Texture Channel", vector) = (0.0, 0.0, 0.0, 0.0)
        _AlphaTrans("Uv Tiling & Offset", vector) = (1.0, 1.0, 0.0, 0.0)
        [Space(5)][NoScaleOffset]_AMask("Alpa Mask", 2D) = "white" {}
        [Toggle]_AMaskUseAlphaUv("Alpha Mask use Alpha Uv", int ) = 0
        _AMaskTrans("Alpha Mask Uv Tiling & Offset", vector) = (1.0, 1.0, 0.0, 0.0)
        _AMaskSqSw("Alpha Mask Enable Squeez XY & Swipe ZW", vector ) = (0.0, 0.0, 0.0, 0.0)
        _AMaskCh("Alpha Mask Use Custom Data 1 Channel (0 - 3)", vector ) = (0, 1, 2, 3)
        //Dissolve Properties
        [Space(5)][NoScaleOffset]_DisTex("Dissolve Ramp", 2D) = "gray" {}
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
        [Space(5)][NoScaleOffset]_DstTex ("Distortion Texture", 2D) = "gray" {}
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
        [Space(5)][Header(Uv Alpha)][Space(5)]_UvAlphaSqSw("Enable Squeez XY & Swipe ZW", vector ) = (0.0, 0.0, 0.0, 0.0)
        _UvAlphaCh("Use Custom Data 1 Channel (0 - 3)", vector ) = (0, 1, 2, 3)
        [Space(5)][Header(Uv Distortion)][Space(5)]_UvDstSqSw("Enable Squeez XY & Swipe ZW", vector ) = (0.0, 0.0, 0.0, 0.0)
        _UvDstCh("Use Custom Data 1 Channel (0 - 3)", vector ) = (0, 1, 2, 3)
        [Space(5)][Header(Uv Twist)][Space(5)][Toggle]_UvTwistUInv("Uv Twist Invert U", int ) = 0
        [Toggle]_UvTwistVInv("Uv Twist Invert V", int ) = 0
        [Toggle]_UvTwistAlphaCd("Uv Twist Alpha Use Custom Data", int ) = 0
        [Toggle]_UvTwistDisCd("Uv Twist Dissolve Use Custom Data", int ) = 0
        _UvTwist("Uv Twist", vector) = (0.0, 0.0, 0.0, 0.0)
        _UvTwistCh("Uv Distortion Use Custom Data 1 Channel (0 - 3)", vector ) = (0, 1, 2, 3)
        //Render Properties
        [Space(5)]
        [Toggle]_BlendAdd ("Premultiplied Mode", int) = 0
        [Toggle]_OffVc("Disable Vertex Color", int ) = 0
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
                    uniform float4 _GradientColor;
                    uniform float _GradientStrength;
                    uniform float _GradientBrightness;
                    uniform float _BlendAdd;
                    uniform float _OffVc;
                    sampler2D _LookUpTex;
                    uniform float4 _LookUpTex_TexelSize;
                    uniform float _PassLUT;
                    uniform float _UseImage;
                    uniform float _MulPColor;
                    uniform half _DisableAlpha;
                    uniform half _AMaskUseAlphaUv;

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

                    #if LIGHT
                        uniform float _LightRange;
                        uniform float _LightFallOff;
                        uniform float _LightHardness;
                        uniform float4 _LightPos;
                        uniform float4 _SetPos;
                    #endif
                
                    sampler2D _Alpha;
                    uniform float4 _AlphaTrans;
                    uniform float4 _BlendChannels;
                    uniform float _AMaskUse;
                    sampler2D _AMask;
                    uniform float4 _AMaskTrans;
                    uniform float4 _AMaskSqSw;
                    uniform float4 _AMaskCh;

                    #if DISSOLVE
                        sampler2D _DisTex;
                        uniform float4 _DisTex_ST;
                        uniform float _DisFlipU;
                        uniform float _DisFlipV;
                        uniform float _DisRot;
                        uniform float _DisInv;
                        uniform float _DisFallOff;
                        uniform float4 _DisTrans;
                        uniform float _DisCustom;
                        uniform float _DisUseCd;
                        uniform float _DisStrength;
                        uniform float _DisUseAlphaUv;
                    #endif

                    #if DISTORTION
                        sampler2D _DstTex;
                        sampler2D _DstMask;
                        uniform float _DstInvMask;
                        uniform float _DstCustom;
                        uniform float _DstUseCd;
                        uniform float _DstStrength;
                        uniform float _DstWorldUv;
                        uniform float4 _DstTrans;
                        uniform float _DstAlpha;
                        uniform float _DstDis;
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
                #include "UnityCG.cginc"
                //Fx Functions
                #include "Global_Functions/AlphaVertex.cg"
                #include "Global_Functions/BlendTextChannelFragment.cg"
                #include "Global_Functions/DissolveFragment.cg"
                #include "Global_Functions/UvTwistVertex.cg"
                #include "Global_Functions/LightGradient.cg"
                #include "Global_Functions/UvRamp.cg"
                #include "Global_Functions/DistortionFragment.cg"
                #include "Global_Functions/UvAdvancedTransformVertex.cg"
                #include "Global_Functions/GradientMapping.cg"
                #include "Global_Functions/CurveFunctionsVertex.cg"
                #include "Global_Functions/Fresnel.cg"

                #pragma shader_feature_local __ GEO
                #pragma shader_feature_local __ GEO_TEX
                #pragma shader_feature_local __ LIGHT
                #pragma shader_feature_local __ UV_COLOR_RAMP
                #pragma shader_feature_local __ UV_MANIPULATE
                #pragma shader_feature_local __ DISSOLVE
                #pragma shader_feature_local __ DISTORTION
                
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
                    float2 UvPackedTex : TEXCOORD0;
                    float4 SecondColor : TEXCOORD1;
                    #if DISSOLVE
                        float3 Dissolve : TEXCOORD2;
                    #endif
                    #if DISTORTION
                        float4 UvDistortion : TEXCOORD3;
                    #endif
                    float Light : TEXCOORD4;
                    float4 CustomData1 : TEXCOORD5;
                    float2 AMask : TEXCOORD6;
                    #if GEO
                        half Rim : TEXCOORD7;
                    #endif
                };

                v2f vert(appdata v)
                {
                    v2f o;
                    //Custom Data Usage
                    float4 customD1 = v.texcoords;
                    float2 uvs = v.texcoords2;
                                        
                    //force to world space
                    float4 pos = v.Position;

                    //Geo Deformation and Rim
                    #if GEO
                        half2 geiUseCd = half2(_GeoOffset, v.texcoords[_GeoCustom]);
                
                        half wave = saturate(WaveCurveVertex((uvs.x * _GeoDeformPhase) + (lerp(_GeoOffset, v.texcoords[_GeoCustom], _GeoUseCd)), 1.0, customD1, (_GeoDeformAmplitude / 100.0)) );
                        pos.xyz += wave * _GeoAxis.xyz;
                        pos.xyz += v.Normal * (wave * _GeoPush.xyz);
                        
                        half rim = FresnelVertexV2(v.Normal, pos);
                        rim *= _GeoRimMul;
                        rim += _GeoRimHardness;
                        rim = saturate(rim);
                    #endif

                    //Alpha Mask
                    float2 aMask =  UvTransform(uvs, _AMaskTrans);
                    float4 cd1AMask = float4(customD1[_AMaskCh.x], customD1[_AMaskCh.y], customD1[_AMaskCh.z], customD1[_AMaskCh.w]);
                    float4 cdAMaskTrans = cd1AMask * _AMaskSqSw;
                    aMask = (aMask * (cdAMaskTrans.xy + _AMaskTrans.xy)) + cdAMaskTrans.zw;
                    
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
                        light = light + wpRamp;
                        light = saturate(light);
                    #endif

                    v.Color.rgb = lerp(1, v.Color.rgb, _MulPColor);
                    
                    //Outputs
                    o.Position = UnityObjectToClipPos(pos);
                    o.Color = AlphaVertex(v.Color, v.texcoords3);
                    #if GEO
                        o.Rim = rim;
                    #endif
                    o.UvPackedTex = uvPackedTex;
                    o.SecondColor = v.texcoords1;
                    #if DISSOLVE
                        o.Dissolve = float3(lerp(uvDis, uvPackedTex, _DisUseAlphaUv), v.texcoords.w);
                    #endif
                    #if DISTORTION
                        o.UvDistortion = float4(uvDst.xy, v.texcoords2);
                    #endif
                    o.Light = light;
                    o.CustomData1 = v.texcoords;
                    o.AMask =  float2(lerp(aMask, uvPackedTex, _AMaskUseAlphaUv));
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

                    #if DISTORTION
                            i.UvPackedTex.xy = lerp(i.UvPackedTex.xy, DistortionFragment(dstMaskTex, _DstInvMask, dstTex, dstUseCd[_DstUseCd], 1, i.UvPackedTex.xy), _DstAlpha);
                    #endif
                    
                    //Alpha
                    half mask;
                    half alpha = 1.0;
                    half4 mulColor;
                    
                    #if GEO != 1 || GEO_TEX == 1
                        #if TEX != 1
                            half4 packedTex = tex2D( _Alpha, i.UvPackedTex.xy);
                            mask = BlendTexChannelFragment(packedTex.rgb, _BlendChannels.rgb);
                            alpha = lerp(mask, alpha, _DisableAlpha);
                        #endif

                        #if TEX == 1
                            mulColor = tex2D(_Alpha, i.UvPackedTex.xy);
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
                            aMask = tex2D(_AMask,  i.AMask.xy).r;
                        #endif
                      
                        #if TEX == 1
                            aMask = tex2D( _Alpha,  i.AMask.xy).a;
                        #endif
                    
                        aMask = lerp(1.0, aMask, _AMaskUse);
                  
                    #endif

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
                    float4 gradientMapping = GradientMappingFragment(mask, _LookUpTex, 0,_LookUpTex_TexelSize.w, _PassLUT, i.UvPackedTex);
                    mulColor = lerp(gradientMapping, gradientMapping, saturate(gradientMapping.a));

                    #if LIGHT || UV_COLOR_RAMP
                        mulColor.rgb += i.Light * ((_GradientColor * _GradientStrength) + _GradientBrightness);
                    #endif

                    return saturate(float4(mulColor.rgb * i.Color.rgb, lerp(1.0, mulColor.a, _BlendAdd)) * alpha * dissolve * i.Color.a * aMask);
                }
                ENDCG
            }
        }
       CustomEditor "InnoGames.VFX.Game.Editor.VFX_ShaderGUI_Particle_MulitColor_LightAndMotion"
    }
}