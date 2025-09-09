/*
NOTE: This shader needs to be optimized and to be cleaned up.
*/

Shader "InnoGames/VFX/Multi Color/Particle/Light And Volume"
{
    Properties
    {
        //Compile Properties
        [Toggle(HEAT)] _HEAT ("Compute Heat", int) = 0
        [Toggle(POINT_LIGHT)] _POINT_LIGHT ("Compute Point Light", int) = 0

        //Geometry Properties
        _GeoRimMul("Rim Multiplier", range(-10.0, 10.0)) = 1.0
        _GeoRimHardness("Rim Hardness", range(0.0, 10.0)) = 0.0
        _GeoPush("Push Edge", range(0.0, 1.0)) = 0.0
        _WpMaskOffset("Wp Mask Offset", range(-10.0, 10.0)) = 0.0
        _WpMaskMul("Wp Mask Multiply", range(0.0, 10.0)) = 0.0
        _WpGradientColor("Wp Gradient Color", color) = (0.0, 0.0, 0.0, 0.0)
        _WpColorOffset("Wp Color Offset", range(-10.0, 10.0)) = 0.0
        _WpColorMul("Wp Color Multiply", range(0.0, 10.0)) = 0.0
        _BlendLayer1("Blend Layer 01", range(0.0, 1.0)) = 0.0
        _BlendLayer2("Blend Layer 02", range(0.0, 1.0)) = 0.0
        _GeoDeformPhase("Deformation Phase ", range(-10.0, 10.0)) = 0.0
        _GeoDeformAmplitude("Deformation Amplitude ", range(0.0, 100.0)) = 0.0
        _GeoAxis("Deformation Axis ", vector) = (1.0, 0.0, 0.0, 0.0)
        _GeoPush1("Push Axis", vector) = (0.0, 0.0, 0.0, 0.0)
        _GeoOffset("Offset", range(0.0, 10.0)) = 0.0
        [Toggle]_GeoUseCd("Geo Offset Use Custom Data 1", int ) = 0
        _GeoCustom("Geo Offset by CD1 Channel (0 - 3)", int) = 0

        //Gradient by Light Properties
        [Toggle]_GradientUseLUT("Use Look Up Texture As Color", int) = 0
        _GradientColor("Gradient Color", color) = (1.0, 1.0, 1.0, 1.0)
        _GradientStrength("Gradient Strength", range(0, 10)) = 0
        _GradientBrightness("Gradient Brightness", range(0, 1)) = 0
        [Toggle]_GradientBlendCd("Gradient Blend Use Custom Data 1", int ) = 0
        _GradientBlendChannel("Gradient Blend by CD1 Channel (0 - 3)", int) = 0
        [Toggle]_LightRangeMul("Convert To A Light", int) = 0
        _SetPos("Set Position", vector) = (0.0, 0.0, 0.0, 0.0)
        _LightPos("Light Source Position", vector) = (0.0, 0.0, 0.0, 0.0)
        _LightRange("Light Range", range(0.0, 100.0)) = 0.0
        _LightFallOff("Light Fall Off", range(0.0, 10.0)) = 0.0
        _LightHardness("Light Hardness",range(0.0, 10.0)) = 0.0

        //Shading
        [NoScaleOffset]_LookUpTex ("Look Up Table", 2D) = "white" {}
        [Toggle]_PassLUT("Switch LUT to Color Gradient", int) = 0
        [Toggle]_MulPColor("Multiply Particle Color", int) = 0
        [Toggle]_LUTUseCd("LUT  Use Custom Data 1", int ) = 0
        _LUTCustom("LUT by CD1 Channel (0 - 3)", int) = 0

        //Alpha
        [NoScaleOffset]_AMask("Alpha Mask", 2D) = "white" {}
        [Toggle]_AMaskUse("Enable Alpha Mask", int ) = 0
        [Toggle]_AMaskUseAlphaUv("Alpha Mask use Alpha Uv", int ) = 0
        _AMaskTrans("Alpha Mask Uv Tiling & Offset", vector) = (1.0, 1.0, 0.0, 0.0)
        _AMaskSqSw("Alpha Mask Enable Squeez XY & Swipe ZW", vector ) = (0.0, 0.0, 0.0, 0.0)
        _AMaskCh("Alpha Mask Use Custom Data 1 Channel (0 - 3)", vector ) = (0, 1, 2, 3)

        //Temperature Properties
        _TemperatureMul("Temperature Multiplier", range(0.0, 1.0)) = 1.0
        _TemperatureHardness("Temperature Hardness", range(0.0, 1.0)) = 0.0
        _HeatColor("Heat Color", color) = (0.0, 0.0, 0.0, 0.0)
        _HeatColorMultiplier("Heat Color Multiplier", range(1.0, 100.0)) = 1.0
        [NoScaleOffset]_TemperatureMap("Temperature Map", 2D) = "gray" {}
        [NoScaleOffset]_TemperatureDirectionMap("Temperature Direction Map", 2D) = "white" {}
        [Toggle]_TempFlipU("Flip U", int )= 0
        [Toggle]_TempFlipV("Flip V", int )= 0
        [Toggle]_TempRot("Rotate 90 Degress", int )= 0
        [Toggle]_TemperatureInv("Invert Map", int ) = 0
        [Toggle]_TemperatureUseCd("Use Custom Data 1", int ) = 0
        _TemperatureCustom("Strength by CD1 Channel (0 - 3)", int) = 0
        _TemperatureStrength("Strength", Range(0, 2)) = 1
        _TemperatureTrans("Uv Tiling & Offset", vector) = (1.0, 1.0, 0.0, 0.0)
        _TemperatureFallOff("Fall Off", Range(1, 100)) = 1

        //Dissolve Properties
        [NoScaleOffset]_DisTex("Dissolve Ramp", 2D) = "gray" {}
        [NoScaleOffset]_DisDirectionMap("Dissolve Direction Map", 2D) = "white" {}
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
        [Space(5)][Header(Depth Buffer)][Space(5)][Enum(UnityEngine.Rendering.CompareFunction)] _ZTest ("ZTest", Int) = 4
        [Enum(Off,0,On,1)]_ZWritePass1("Z Write", Int) = 0
        [Enum(Off,0,On,1)]_ZWritePass2("Z Write", Int) = 0
    }

    Category
    {
        SubShader
        {
            CGINCLUDE
            sampler2D _LookUpTex;
            uniform half4 _LookUpTex_TexelSize;
            uniform half3 _WpGradientColor;
            uniform half _PassLUT;
            uniform half _LUTUseCd;
            uniform half _LUTCustom;
            uniform half _offVc;
            uniform half _GeoPush;
            uniform half _GeoRimMul;
            uniform half _GeoRimHardness;
            uniform half _GeoRimBlend;
            uniform half _WpMaskOffset;
            uniform half _WpMaskMul;
            uniform half _WpColorOffset;
            uniform half _WpColorMul;
            uniform half _BlendLayer1;
            uniform half _BlendLayer2;

            uniform half _GeoDeformPhase;
            uniform half _GeoDeformAmplitude;
            uniform half4 _GeoAxis;
            uniform half4 _GeoPush1;
            uniform half _GeoOffset;
            uniform half _GeoCustom;
            uniform half _GeoUseCd;

            uniform half _GradientUseLUT;
            uniform half4 _GradientColor;
            uniform half _GradientStrength;
            uniform half _GradientBrightness;
            uniform half _GradientBlendCd;
            uniform half _GradientBlendChannel;

            #if POINT_LIGHT
                //Point Light
                uniform half _LightRangeMul;
                uniform half _MulLight;
                uniform half _LightRange;
                uniform half _LightFallOff;
                uniform half _LightHardness;
                uniform float4 _LightPos;
                uniform float4 _SetPos;
            #endif

            uniform float _AMaskUse;
            sampler2D _AMask;
            uniform float4 _AMaskTrans;
            uniform float4 _AMaskSqSw;
            uniform half4 _AMaskCh;

            #if HEAT
                uniform half _TemperatureMul;
                uniform half _TemperatureHardness;
                uniform half4 _HeatColor;
                uniform half _HeatColorMultiplier;
                sampler2D _TemperatureMap;
                sampler2D _TemperatureDirectionMap;
                uniform half _TemperatureInv;
                uniform half _TemperatureUseCd;
                uniform half _TemperatureCustom;
                uniform half _TemperatureStrength;
                uniform half4 _TemperatureTrans;
                uniform half _TemperatureFallOff;
                uniform half _TempFlipU;
                uniform half _TempFlipV;
                uniform half _TempRot;
            #endif

            sampler2D _DisTex;
            sampler2D _DisDirectionMap;
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
            ENDCG


            Tags
            {
                "Queue"="Transparent" "IgnoreProjector"="True" "RenderType"="Transparent"
            }

            Blend One OneMinusSrcAlpha
            Lighting off


            ZTest [_ZTest]

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
                ZWrite [_ZWritePass1]
                Cull back
                CGPROGRAM
                #pragma vertex vert
                #pragma fragment frag

                #include "UnityCG.cginc"
                #include "SpecializedLibrary/Volume.cg"

                #pragma shader_feature_local __ HEAT
                #pragma shader_feature_local __ POINT_LIGHT

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
                    float4 CustomData1 : TEXCOORD0;
                    half4 Light : TEXCOORD1;
                    float4 DissolveFrontSide: TEXCOORD2;
                    float4 DissolveTop : TEXCOORD3;
                    half3 Normal : TEXCOORD4;
                    half4 RimAMaskColorMask : TEXCOORD05;
                    float2 PtLight : TEXCOORD6;
                    float4 TempFrontSide: TEXCOORD7;
                    float4 TempTop: TEXCOORD8;
                    half WpColor : TEXCOORD9;
                };

                v2f vert(appdata v)
                {
                    v2f o;
                    //Custom Data Usage
                    float2 uvs = v.texcoords2;
                    float4 pos = v.Position;
                    float3 wPos = mul(unity_ObjectToWorld, pos.xyz);
                    float4 customD1 = v.texcoords;

                    //Geo Deformation and Rim
                    pos.xyz = DeformationRimVertex(pos.xyz, v.Normal, uvs, _GeoDeformPhase, _GeoOffset,
                                                   _GeoDeformAmplitude,
                                                   _GeoAxis.xyz, _GeoPush1.xyz, v.texcoords, _GeoCustom, customD1);
                    //pos.xyz += _GeoAxis;
                    //Alpha Mask
                    float2 aMask = AlphaMaskVertex(uvs, _AMaskTrans, customD1, _AMaskCh, _AMaskSqSw);

                    //Dissolve
                    float2 uvDis, uvFront, uvSide, uvTop;
                    DissolveUvVertex(wPos.xyz, uvs, _DisFlipU, _DisFlipV, _DisRot, _DisTrans, uvDis, uvFront, uvSide,
                                     uvTop);

                    //Heat and Temperature
                    half heat = 0.0;
                    float2 uvTempDis = float2(0.0, 0.0), uvTempFront = float2(0.0, 0.0), uvTempSide = float2(0.0, 0.0),
                                        uvTempTop = float2(0.0, 0.0);
                    #if HEAT
                        heat = HeatVertex(pos, v.Normal);
                        DissolveUvVertex(wPos.xyz, uvs, _TempFlipU, _TempFlipV, _TempRot, _TemperatureTrans, uvTempDis,
                                         uvTempFront, uvTempSide, uvTempTop);
                    #endif

                    //Wp Mask
                    half wPosMask = WorldPositionMaskVertex(wPos.y, _WpMaskMul, _WpMaskOffset);
                    half wPosColorMask = WorldPositionMaskVertex(wPos.y, _WpColorMul, _WpColorOffset);
                    half rim = FresnelVertexV2(v.Normal, pos);
                    rim = saturate(rim * wPosMask);

                    half light = 0.0;
                    #if POINT_LIGHT
                        //Point Light Settings
                        light = PointLightVertex(pos.xyz, v.Normal, customD1, _GradientBlendChannel, _GradientBlendCd,
                                                  _SetPos.xyz, _LightPos.xyz, _LightRange, _LightFallOff, _LightHardness, _LightRangeMul);
                    #endif

                    //Outputs
                    o.Position = UnityObjectToClipPos(pos);
                    o.Color = AlphaVertex(v.Color, _offVc, v.texcoords3);
                    o.Normal = v.Normal;
                    o.Light = LightVertex(v.Normal, 0.5);
                    o.RimAMaskColorMask = half4(rim, aMask, saturate(wPosColorMask));
                    o.CustomData1 = v.texcoords;
                    o.DissolveFrontSide = float4(uvFront, uvSide);
                    o.DissolveTop = float4(uvTop, uvDis);
                    o.TempFrontSide = float4(uvTempFront, uvTempSide);
                    o.TempTop = float4(uvTempTop, uvTempDis);
                    o.PtLight = float2(light, heat * customD1.x);
                    o.WpColor = saturate(wPosColorMask);

                    return o;
                }

                float4 frag(v2f i) : SV_Target
                {
                    half4 col = half4(1.0, 1.0, 1.0, 1.0);

                    half alphaRim = i.RimAMaskColorMask.x;
                    alphaRim *= _GeoRimMul;
                    alphaRim += _GeoRimHardness * _GeoRimBlend;

                    half aMask = AlphaMaskFragment(_AMask, i.RimAMaskColorMask.yz, _AMaskUse);
                    half dissolve = DissolveTriplanarFragment(_DisTex, _DisDirectionMap, i.Normal, i.DissolveFrontSide,
                                        i.DissolveTop, i.CustomData1, _DisStrength, _DisCustom,
                                        _DisUseCd, _DisInv, _DisFallOff);

                    //Shading
                    half alpha = 1.0;
                    col = ShadingFragment(i.PtLight.x, col, _LookUpTex, _LookUpTex_TexelSize.w, _PassLUT, i.Light, 0.0,
                                                  alphaRim,
                                                  _BlendLayer2, i.WpColor, dissolve, aMask,
                                                  _GradientColor.rgb,
                                                  _GradientUseLUT, _GradientStrength, _GradientBrightness,
                                                  _WpGradientColor,
                                                  i.CustomData1,
                                                  _LUTCustom, _LUTUseCd, alpha);

                    #if HEAT
                        //Temperatur
                        col.rgb = TemperatureFragment(col, i.PtLight.y, _TemperatureMap, _TemperatureDirectionMap, i.Normal,
                                                      i.TempFrontSide, i.TempTop, i.CustomData1, _TemperatureStrength,
                                                      _TemperatureCustom, _TemperatureUseCd,
                                                      _HeatColor, _TemperatureInv, _TemperatureFallOff, _TemperatureMul, _TemperatureHardness, _HeatColorMultiplier);
                    #endif

                    col.rgb *= i.Color.rgb;
                    col *= alpha * i.Color.a;
                    return col;
                }
                ENDCG
            }

            Pass
            {
                ZWrite [_ZWritePass2]
                Cull back
                CGPROGRAM
                #pragma vertex vert
                #pragma fragment frag
                #include "UnityCG.cginc"
                //Fx Functions
                #include "CoreLibrary/Effects_Library.cg"
                #include "SpecializedLibrary/Volume.cg"

                #pragma shader_feature_local __ HEAT
                #pragma shader_feature_local __ POINT_LIGHT

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
                    half4 Light : TEXCOORD0;
                    half WpMask : TEXCOORD1;
                    float2 AMask : TEXCOORD2;
                    float4 CustomData1 : TEXCOORD3;
                    float4 DissolveFrontSide: TEXCOORD4;
                    float4 DissolveTop : TEXCOORD5;
                    half3 Normal : TEXCOORD6;
                    half WpColor : TEXCOORD7;
                    half2 PtLight : TEXCOORD8;
                    float4 TempFrontSide: TEXCOORD9;
                    float4 TempTop: TEXCOORD10;
                };

                v2f vert(appdata v)
                {
                    v2f o;
                    float2 uvs = v.texcoords2;
                    float4 pos = v.Position;
                    float4 customD1 = v.texcoords;
                    float3 wPos = mul(unity_ObjectToWorld, pos.xyz);

                    //Geo Deformation and Rim
                    pos.xyz = DeformationRimVertex(pos.xyz, v.Normal, uvs, _GeoDeformPhase, _GeoOffset,
                                                   _GeoDeformAmplitude,
                                                   _GeoAxis.xyz, _GeoPush1.xyz, v.texcoords, _GeoCustom, customD1);

                    //Alpha Mask
                    float2 aMask = AlphaMaskVertex(uvs, _AMaskTrans, customD1, _AMaskCh, _AMaskSqSw);

                    // //Wp Mask
                    half wPosMask = WorldPositionMaskVertex(wPos.y, _WpMaskMul, _WpMaskOffset);
                    half wPosColorMask = WorldPositionMaskVertex(wPos.y, _WpColorMul, _WpColorOffset);

                    pos.xyz = PushVertex(pos.xyz, v.Normal, _GeoPush);

                    //Uv Triplanar Dissolve 
                    float2 uvDis, uvFront, uvSide, uvTop;
                    DissolveUvVertex(wPos.xyz, uvs, _DisFlipU, _DisFlipV, _DisRot, _DisTrans, uvDis, uvFront, uvSide,
                                     uvTop);

                    //Heat and Temperature
                    half heat = 0.0;
                    float2 uvTempDis = float2(0.0, 0.0), uvTempFront = float2(0.0, 0.0), uvTempSide = float2(0.0, 0.0),
                                        uvTempTop = float2(0.0, 0.0);
                    #if HEAT
                        heat = HeatVertex(pos, v.Normal);
                        DissolveUvVertex(wPos.xyz, uvs, _TempFlipU, _TempFlipV, _TempRot, _TemperatureTrans, uvTempDis,
                                         uvTempFront, uvTempSide, uvTempTop);
                    #endif

                    half light = 0.0;
                    #if POINT_LIGHT
                        //Point Light Settings
                        light = PointLightVertex(pos.xyz, v.Normal, customD1, _GradientBlendChannel, _GradientBlendCd, _SetPos.xyz, _LightPos.xyz, _LightRange, _LightFallOff, _LightHardness, _LightRangeMul);
                    #endif

                    //Outputs
                    o.Position = UnityObjectToClipPos(pos);
                    o.Color = AlphaVertex(v.Color, _offVc, v.texcoords3);
                    o.Light = LightVertex(v.Normal, 0.5);
                    o.WpMask = wPosMask;
                    o.AMask = aMask;
                    o.CustomData1 = v.texcoords;
                    o.DissolveFrontSide = float4(uvFront, uvSide);
                    o.DissolveTop = float4(uvTop, uvDis);
                    o.TempFrontSide = float4(uvTempFront, uvTempSide);
                    o.TempTop = float4(uvTempTop, uvTempDis);
                    o.Normal = v.Normal;
                    o.WpColor = saturate(wPosColorMask);
                    o.PtLight = float2(light, heat * customD1.x);
                    return o;
                }

                float4 frag(v2f i) : SV_Target
                {
                    half4 col = half4(1.0, 1.0, 1.0, 1.0);
                    half aMask = AlphaMaskFragment(_AMask, i.AMask, _AMaskUse);

                    //Dissolve
                    half dissolve = DissolveTriplanarFragment(_DisTex, _DisDirectionMap, i.Normal, i.DissolveFrontSide,
                        i.DissolveTop, i.CustomData1, _DisStrength,
                        _DisCustom, _DisUseCd, _DisInv, _DisFallOff);

                    //Shading
                    half alpha = 0.0;
                    col = ShadingFragment(i.PtLight.x, col, _LookUpTex, _LookUpTex_TexelSize.w, _PassLUT, i.Light, 0.0,
                                                                       i.WpMask,
                                                                       _BlendLayer1, i.WpColor, dissolve, aMask,
                                                                       _GradientColor.rgb, _GradientUseLUT,
                                                                       _GradientStrength, _GradientBrightness,
                                                                       _WpGradientColor, i.CustomData1,
                                                                       _LUTCustom, _LUTUseCd, alpha);

                    #if HEAT
                        //Temperatur
                        col.rgb = TemperatureFragment(col, i.PtLight.y, _TemperatureMap, _TemperatureDirectionMap, i.Normal,
                                                      i.TempFrontSide, i.TempTop, i.CustomData1, _TemperatureStrength,
                                                      _TemperatureCustom, _TemperatureUseCd,
                                                      _HeatColor, _TemperatureInv, _TemperatureFallOff, _TemperatureMul, _TemperatureHardness, _HeatColorMultiplier);
                    #endif

                    col.rgb *= i.Color.rgb;
                    col *= alpha * i.Color.a;
                    return col;
                }
                ENDCG
            }
        }
        CustomEditor "InnoGames.VFX.Game.Editor.VFX_ShaderGUI_MultiColor_LightAndVolume_Particle"
    }
}