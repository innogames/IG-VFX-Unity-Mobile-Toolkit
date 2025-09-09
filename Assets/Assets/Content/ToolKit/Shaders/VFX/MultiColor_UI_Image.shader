Shader "InnoGames/VFX/Multi Color/UI/Image "
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
        [Toggle(UV_RADIAl)] _UV_RADIAl ("Compute Uv Radial", int) = 0
        [Toggle(UV_ATLAS)] _UV_ATLAS ("Compute Uv Atlas", int) = 0
        //Debug Features
        [Space(25)][Header(DEBUG)][Space(5)][Toggle]_VisDis("Visualize Dissolve", int )= 0
        [Toggle]_VisDst("Visualize Distortion", int )= 0
        [Toggle]_VisDstMask("Visualize Distortion Mask", int )= 0
        //LOOK AND FEEL Properties
        [Space(50)][Header(LOOK AND FEEL PROPERTIES)][Space(5)][NoScaleOffset]_LookUpTex ("Look Up Table", 2D) = "white" {}
        [Toggle]_useImage("Use Image", int) = 0
        [Toggle]_PassLUT("Switch LUT to Color Gradient", int) = 0
        _OffsetV ("Select Ramp", range (0,4)) = 0
        //Alpha Properties
        [Space(25)][Header(ALPHA PROPERTIES)][Space(5)][NoScaleOffset]_MainTex("Packed Texture", 2D) = "white" {}
        _Flickering("Flickering ,X = Speed, Y = Strength, Z = Min Value", vector) = (0.0, 0.0, 0.0, 0.0)
        _BlendChannels("Blend Packed Texture Channel", vector) = (0.0, 1.0, 0.0, 1.0)
        _AlphaTrans("Uv Tiling & Offset", vector) = (1.0, 1.0, 0.0, 0.0)
        _AlphaSpeed("Alpha Radial Speed", vector) = (1.0, 1.0, 0.0, 0.0)
        [Toggle]_AlphaRadial("Enable Radial Uv", int) = 0
        //Dissolve Properties
        [Space(25)][Header(DISSOLVE PROPERTIES)][Space(5)][NoScaleOffset]_DisTex("Dissolve Ramp", 2D) = "gray" {}
        [Toggle]_DisFlipU("Dissolve Flip U", int )= 0
        [Toggle]_DisFlipV("Dissolve Flip V", int )= 0
        [Toggle]_DisRot("Dissolve Rotate 90 Degress", int )= 0
        [Toggle]_DisInv("Dissolve Invert Ramp", int )= 0
        _DisStrength("Dissolve Strength", Range(0, 3)) = 0
        _DisFallOff("Dissolve Fall Off", Range(1, 100)) = 1
        _DisTrans("Dissolve Uv Tiling & Offset", vector) = (1.0, 1.0, 0.0, 0.0)
        //Distortion Properties
        [Space(25)][Header(DISTORTION PROPERTIES)][Space(5)][NoScaleOffset]_DstTex ("Distortion Texture", 2D) = "gray" {}
        [NoScaleOffset]_DstMask ("Distortion Mask", 2D) = "white" {}
        [Toggle] _DstInvMask ("Distortion Mask Invert", int) = 0
        [Toggle]_DstAlpha("Distortion Enable for Alpha", int ) = 0
        [Toggle]_DstDis("Distortion Enable for Dissolve", int ) = 0
        _DstStrength("Distortion Strength Alpha", Range(-2.0, 2.0)) = 0.0
        _DstStrengthDis("Distortion Strength Dissolve", Range(-2.0, 2.0)) = 0.0
        _DstTrans ("Distortion Uv Tiling & Offset", vector) = (1.0, 1.0, 0.0, 0.0)
        //Uv Manipulate Properties
        [Space(10)][Header(UV MANIPULATE PROPERTIES)][Space(5][Header(Uv Distortion)][Toggle]_UvRadialDst("Uv Radial Distortion", int ) = 0
        _UvDstSqSw("Uv Distortion Enable Squeez XY & Swipe ZW", vector ) = (0.0, 0.0, 0.0, 0.0)
        //Particle Properties
        [Space(50)][Header(PARTICLE PROPERTIES)][Space(5)][Toggle]_ParticleA("Enable Particle Alpha", int) = 0
        //Render Properties
        [Space(50)][Header(RENDER PROPERTIES)][Space(5)]
        // Blend mode values
        [Enum(UnityEngine.Rendering.BlendMode)] 
        [Enum(One,1,SrcAlpha,5)] _DstBlend("DestBlend", Float) = 0
        _StencilComp ("Stencil Comparison", Float) = 8
        _Stencil ("Stencil ID", Float) = 0
        _StencilOp ("Stencil Operation", Float) = 0
        _StencilWriteMask ("Stencil Write Mask", Float) = 255
        _StencilReadMask ("Stencil Read Mask", Float) = 255
        _ColorMask ("Color Mask", Float) = 15
    }
    Category
    {
        SubShader
        {
            Tags
            {
                "Queue"="Transparent" "IgnoreProjector"="True" "RenderType"="Transparent"
            }
            Blend[_DstBlend] OneMinusSrcAlpha
            Lighting Off
            ZWrite Off
            Cull off

            Stencil
            {
                Ref [_Stencil]
                Comp [_StencilComp]
                Pass [_StencilOp]
                ReadMask [_StencilReadMask]
                WriteMask [_StencilWriteMask]
            }

            Pass
            {

                CGPROGRAM
                #pragma vertex vert
                #pragma fragment frag
                #include "UnityCG.cginc"
                #include "CoreLibrary/Effects_Library.cg"

                //Ui Image Features
                #pragma multi_compile __ UNITY_UI_CLIP_RECT
                #pragma multi_compile __ UNITY_UI_ALPHACLIP

                //Fx Features
                #pragma shader_feature_local __ DEBUG
                #pragma shader_feature_local __ UV_MANIPULATE
                #pragma shader_feature_local __ DISSOLVE
                #pragma shader_feature_local __ DISTORTION
                #pragma shader_feature_local __ UV_RADIAL
                #pragma shader_feature_local __ UV_ATLAS

                uniform float4 _AlphaTrans;
                uniform sampler2D _MainTex;
                uniform half4 _Flickering;
                uniform half _AlphaRadial;
                uniform half4 _AlphaSpeed;
                sampler2D _LookUpTex;
                uniform float4 _LookUpTex_TexelSize;
                uniform half4 _ClipRect;
                uniform half4 _BlendChannels;
                uniform half _PassLUT;
                uniform half _useImage;
                uniform half _OffsetV;
                uniform half _ParticleA;
                
                #if DEBUG
                    uniform half _VisDis;
                    uniform half _VisDst;
                    uniform half _VisDstMask;
                #endif

                #if DISSOLVE
                    sampler2D _DisTex;
                    uniform half _DisFlipU;
                    uniform half _DisFlipV;
                    uniform half _DisRot;
                    uniform half _DisInv;
                    uniform half _DisFallOff;
                    uniform float4 _DisTrans;
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
                #endif

                #if UV_MANIPULATE
                    uniform float4 _UvDstSqSw;
                    uniform float _UvRadialDst;
                #endif

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
                    float2 UvPackedTex : TEXCOORD0;
                    #if DISTORTION
                        float2 UvDistortion : TEXCOORD3;
                    #endif
                    #if DISSOLVE
                        float2 Dissolve : TEXCOORD4;
                    #endif
                    #if UV_MANIPULATE
                        float2 Uv : TEXCOORD5;
                        half Time : TEXCOORD6;
                    #endif
                    half4 Flickering : TEXCOORD7;
                    float2 AtlasUv : TEXCOORD8;
                };

                v2f vert(appdata v)
                {
                    v2f o;
                    //Uv
                    float2 uv = v.texcoords;
                    float2 atlasUv = uv;
                    #if UV_ATLAS
                        atlasUv = float2((v.texcoords.x - v.texcoords1.x) / v.texcoords1.y, (v.texcoords.y - v.texcoords2.x) / v.texcoords2.y);
                    #endif
                    float time = _Time.y;

                    //Uv Dissolve
                    #if DISSOLVE
                        float2 uvDis = UvManipulation(atlasUv, _DisFlipU, _DisFlipV, _DisRot);
                        uvDis = UvTransform(uvDis, _DisTrans);
                    #endif

                    //Uv Distortion
                    #if DISTORTION
                        float2 uvDst = UvTransform(atlasUv, _DstTrans);
                        #if UV_MANIPULATE
                            float4 dstTime = frac(time * _UvDstSqSw);
                    dstTime = time * _UvDstSqSw;
                            float4 dstCdTrans = dstTime * _UvDstSqSw;
                            uvDst = UvTransform(atlasUv, float4(_DstTrans.x + dstTime.x, _DstTrans.y + dstTime.y, _DstTrans.z + dstTime.z, _DstTrans.w + dstTime.w));
                        #endif
                    #endif

                    //Look and Feel
                    float2 uvPacked = UvTransform(uv, _AlphaTrans);
                    half flickering = WaveCurveVertex(0, time, _Flickering.x, _Flickering.y);
                    flickering += _Flickering.z;

                    o.Position = UnityObjectToClipPos(v.Position);
                    o.Color = v.Color;
                    o.UvPackedTex = uvPacked;
                    o.AtlasUv = atlasUv;
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
                    o.Flickering = flickering;
                    return o;
                }

                float4 frag(v2f i) : SV_Target
                {
                    //Uv Polar
                    #if UV_MANIPULATE
                        float4 alphaTime = frac(_Time.y * _AlphaSpeed);
                        float2 uvRot = UvToCtr(i.Uv);
                        uvRot = UvToPolar(uvRot);
                        uvRot = UvTransform(uvRot, _AlphaTrans);
                        uvRot = UvTransform(uvRot, float4(_AlphaTrans.x + alphaTime.x, _AlphaTrans.y + alphaTime.y, _AlphaTrans.z + alphaTime.z, _AlphaTrans.w + alphaTime.w));
                        i.UvPackedTex = lerp(i.UvPackedTex, uvRot, _AlphaRadial);
                        #if DISTORTION
                            half4 dstTime = frac(i.Time * _UvDstSqSw);
                            uvRot = UvToCtr(i.Uv);
                            uvRot = lerp(uvRot, UvToPolar(uvRot), _UvRadialDst);
                            uvRot = UvTransform(uvRot, _DstTrans);
                            uvRot = UvTransform(uvRot, float4(_DstTrans.x + dstTime.x, _DstTrans.y + dstTime.y, _DstTrans.z + dstTime.z, _DstTrans.w + dstTime.w));
                            i.UvDistortion = uvRot;
                        #endif
                    #endif

                    //Distortion Textures
                    #if DISTORTION
                        half2 dstUseCd = float2(_DstStrength,0.0);
                        half dstMaskTex = tex2D(_DstMask, i.AtlasUv).r;
                        float2 dstTex = tex2D(_DstTex, i.UvDistortion).rg;
                    #endif

                    #if DISTORTION
                            i.UvPackedTex = lerp(i.UvPackedTex, DistortionFragment(dstMaskTex, _DstInvMask, dstTex, dstUseCd, 1, i.UvPackedTex), _DstAlpha);
                    #endif

                    //Alpha
                    half4 texPack = tex2D(_MainTex, i.UvPackedTex);
                    half gradient = Blend4TexChannelFragment(texPack, _BlendChannels);
                    gradient *= i.Flickering;
                    
                    //Dissolve
                    half dissolve = 1.0;
                    #if DISSOLVE
                        #if DISTORTION
                            i.Dissolve = lerp(i.Dissolve, DistortionFragment(dstMaskTex, _DstInvMask, dstTex, _DstStrengthDis, 1, i.Dissolve),     _DstDis);
                        #endif
                        half disTex = (tex2D(_DisTex, i.Dissolve).r);
                        dissolve = DissolveFragment(disTex, _DisInv, _DisFallOff, _DisStrength);
                    #endif

                    //Look and Feel
                    half4 gradientMapping = GradientMappingFragment(gradient, _LookUpTex, _OffsetV,_LookUpTex_TexelSize.y, _PassLUT, i.UvPackedTex);
                    half4 mulColor = lerp(gradientMapping, gradientMapping, saturate(gradientMapping.a));
                    half  alpha = dissolve * lerp(1.0, i.Color.a, _ParticleA);
                    half4 color = mulColor * saturate(gradient * alpha);
                    color = lerp(color, float4(texPack.rgb, texPack.a * alpha), _useImage);
                        
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
                        color.a *= UnityGet2DClipping(i.worldPosition.xy, _ClipRect);
                    #endif

                    #ifdef UNITY_UI_ALPHACLIP
                        clip (color.a - 0.001);
                    #endif

                    return color;
                }
                ENDCG
            }
        }
         CustomEditor "InnoGames.VFX.Game.Editor.VFX_ShaderGUI_MultiColor_LightAndMotion_Ui_Image"
    }
}