using System.Collections.Generic;
using UnityEditor;
using UnityEngine;
using System;

namespace InnoGames.VFX.Game.Editor
{
    public class VFX_ShaderGUI_Particle_MulitColor_LightAndMotion : VFX_ShaderEditorGlobal
    {
        private const string KeywordUseComputeGeometry = "_GEO";
        private const string KeywordUseComputeGeometryTexture = "_GEO_TEX";
        private const string KeywordUseComputeLight = "_LIGHT";
        private const string KeywordUseComputeUvColorRamp = "_UV_COLOR_RAMP";
        private const string KeywordUseComputeDissolve = "_DISSOLVE";
        private const string KeywordUseComputeDistortion = "_DISTORTION";
        private const string KeywordUseComputeUvManipulation = "_UV_MANIPULATE";

        //Geometry Properties
        private const string FolderNameGeo = "GEOMETRY PROPERTIES";
        private const string KeywordUseGeoDeformPhase = "_GeoDeformPhase";
        private const string KeywordUseGeoDeformAmplitude = "_GeoDeformAmplitude";
        private const string KeywordUseGeoRimMul = "_GeoRimMul";
        private const string KeywordUseGeoRimHardness = "_GeoRimHardness";
        private const string KeywordUseGeoRimBlend = "_GeoRimBlend";
        private const string KeywordUseGeoAxis = "_GeoAxis";
        private const string KeywordUseGeoPush = "_GeoPush";
        private const string KeywordUsGeoOffset = "_GeoOffset";
        private const string KeywordUseGeoUseCd = "_GeoUseCd";
        private const string KeywordUseGeoCustom = "_GeoCustom";

        //Gradient Properties
        private const string FolderNameGradient = "GRADIENT PROPERTIES";
        private const string KeywordUseGradientColor = "_GradientColor";
        private const string KeywordUseGradientStrength = "_GradientStrength";
        private const string KeywordUseGradientBrightness = "_GradientBrightness";

        //Gradient by Light Properties
        private const string FolderNameGradientLight = "GRADIENT BY LIGHT PROPERTIES";
        private const string KeywordUseLightRangeMul = "_LightRangeMul";
        private const string KeywordUseSetPos = "_SetPos";
        private const string KeywordUseLightPos = "_LightPos";
        private const string KeywordUseLightRange = "_LightRange";
        private const string KeywordUseLightFallOff = "_LightFallOff";
        private const string KeywordUseLightHardness = "_LightHardness";

        //Gradient by Uv Properties
        private const string FolderNameGradientUv = "GRADIENT BY UV PROPERTIES";
        private const string KeywordUseMulLight = "_MulLight";
        private const string KeywordUsUvRampBlend = "_UvRampBlend";
        private const string KeywordUseUvRampOffset = "_UvRampOffset";
        private const string KeywordUseUvRampSet = "_UvRampSet";

        //Shading
        private const string FolderNameShading = "SHADING PROPERTIES";
        private const string KeywordUseLookUpTex = "_LookUpTex";
        private const string KeywordUsePassLut = "_PassLUT";
        private const string KeywordUseMulPColor = "_MulPColor";

        //Alpha Properties
        private const string FolderNameAlpha = "ALPHA PROPERTIES";
        private const string KeywordUseDisableAlpha = "_DisableAlpha";
        private const string KeywordUseAlpha = "_Alpha";
        private const string KeywordUseBlendChannels = "_BlendChannels";
        private const string KeywordUseAlphaTrans = "_AlphaTrans";
        private const string FolderNameAlphaMask = "ALPHA MASK PROPERTIES";
        private const string KeywordUseAMask = "_AMask";
        private const string KeywordUseAMaskUse = "_AMaskUse";
        private const string KeywordAMaskUseAlphaUv = "_AMaskUseAlphaUv";
        private const string KeywordAMaskTrans = "_AMaskTrans";
        private const string KeywordUseAMaskSqSw = "_AMaskSqSw";
        private const string KeywordUseAMaskCh = "_AMaskCh";

        //Dissolve Properties
        private const string FolderNameDissolve = "DISSOLVE PROPERTIES";
        private const string KeywordUseDisTex = "_DisTex";
        private const string KeywordUseDisFlipU = "_DisFlipU";
        private const string KeywordUseDisFlipV = "_DisFlipV";
        private const string KeywordUseDisRot = "_DisRot";
        private const string KeywordUseDisUseAlphaUv = "_DisUseAlphaUv";
        private const string KeywordUseDisInv = "_DisInv";
        private const string KeywordUseDisUseCd = "_DisUseCd";
        private const string KeywordUseDisCustom = "_DisCustom";
        private const string KeywordUseDisStrength = "_DisStrength";
        private const string KeywordUseDisTrans = "_DisTrans";
        private const string KeywordUseDisFallOff = "_DisFallOff";

        //Distortion Properties
        private const string FolderNameDistortion = "DISTORTION PROPERTIES";
        private const string KeywordUseDstTex = "_DstTex";
        private const string KeywordUseDstMask = "_DstMask";
        private const string KeywordUseDstInvMask = "_DstInvMask";
        private const string KeywordUseDstAlpha = "_DstAlpha";
        private const string KeywordUseDstDis = "_DstDis";
        private const string KeywordUseDstUseCd = "_DstUseCd";
        private const string KeywordUseDstCustom = "_DstCustom";
        private const string KeywordUseDstStrength = "_DstStrength";
        private const string KeywordUseDstWorldUv = "_DstWorldUv";
        private const string KeywordUseDstTrans = "_DstTrans";

        //Uv Properties
        private const string FolderNameUvManipulation = "UV MANIPULATION PROPERTIES";
        private const string KeywordUseUvAlphaSqSw = "_UvAlphaSqSw";
        private const string KeywordUseUvAlphaCh = "_UvAlphaCh";
        private const string KeywordUseUvDstSqSw = "_UvDstSqSw";
        private const string KeywordUseUvDstCh = "_UvDstCh";
        private const string KeywordUseUvTwistUInv = "_UvTwistUInv";
        private const string KeywordUseUvTwistVInv = "_UvTwistVInv";
        private const string KeywordUseUvTwistAlphaCd = "_UvTwistAlphaCd";
        private const string KeywordUseUvTwistDisCd = "_UvTwistDisCd";
        private const string KeywordUseUvTwist = "_UvTwist";
        private const string KeywordUseUvTwistCh = "_UvTwistCh";

        //Render Properties
        private const string FolderNameRender = "RENDER PROPERTIES";
        private const string KeywordUseBlendAdd = "_BlendAdd";
        private const string KeywordUseOffVc = "_OffVc";
        private const string KeywordUseCull = "_Cull";
        private const string KeywordUseStencilMask = "_StencilMask";
        private const string KeywordUseStencilComp = "_StencilComp";
        private const string KeywordUseStencilPass = "_StencilPass";
        private const string KeywordUseStencilWrite = "_StencilWrite";
        private const string KeywordUseStencilRead = "_StencilRead";
        private const string KeywordUseZTest = "_ZTest";
        private const string KeywordUseZWrite = "_ZWrite";

        private bool showGeometry = false;
        private bool showGradient = false;
        private bool showGradientLight = false;
        private bool showGradientUv = false;
        private bool showShading = false;
        private bool showAlpha = false;
        private bool showAlphaMask = false;
        private bool showWpPosMask = false;
        private bool showDissolve = false;
        private bool showDistortion = false;
        private bool showUvManipulation = false;
        private bool showRender = false;

        public override void OnGUI(MaterialEditor materialEditor, MaterialProperty[] properties)
        {
            base.OnGUI(materialEditor, properties);
            GUILayout.Label("Names", EditorStyles.boldLabel);

            HandleShaderToggle(KeywordUseComputeGeometry, "Compute Geometry");
            if (GetShaderToggle(KeywordUseComputeGeometry, 1))
            {
                HandleShaderToggle(KeywordUseComputeGeometryTexture, "Compute Geometry Add Texture");
            }

            HandleShaderToggle(KeywordUseComputeLight, "Compute Gradient By Light");
            HandleShaderToggle(KeywordUseComputeUvColorRamp, "Compute Gradient By Uv");
            if (GetShaderToggle(KeywordUseComputeGeometry, 0) || GetShaderToggle(KeywordUseComputeGeometryTexture, 1))
            {
                HandleShaderToggle(KeywordUseComputeDissolve, "Compute Dissolve");
                HandleShaderToggle(KeywordUseComputeDistortion, "Compute Distortion");
                HandleShaderToggle(KeywordUseComputeUvManipulation, "Compute Uv Manipulation");
            }


            if (GetShaderToggle(KeywordUseComputeGeometry, 1))
            {
                SpaceStandard();
                showGeometry = FolderFoldOut(showGeometry, FolderNameGeo);
                if (showGeometry)
                {
                    ShaderProperty(KeywordUseGeoRimMul, "Rim Multiplier");
                    ShaderProperty(KeywordUseGeoRimHardness, "Rim Hardness");
                    ShaderProperty(KeywordUseGeoRimBlend, "Rim Blend Strength");
                    ShaderProperty(KeywordUseGeoDeformPhase, "Deformation Frequency");
                    ShaderProperty(KeywordUseGeoDeformAmplitude, "Deformation Amplitude");
                    ShaderProperty(KeywordUseGeoAxis, "Deformation Axis");
                    ShaderProperty(KeywordUseGeoPush, "Push Axis");
                    ShaderProperty(KeywordUsGeoOffset, "Offset");
                    ShaderProperty(KeywordUseGeoUseCd, "Geo Offset Use Custom Data 1");
                    ShaderProperty(KeywordUseGeoCustom, "Geo Offset by CD1 Channel (0 - 3)");
                }
            }

            //Gradient Properties
            if (GetShaderToggle(KeywordUseComputeLight, 1) || GetShaderToggle(KeywordUseComputeUvColorRamp, 1))
            {
                SpaceStandard();
                showGradient = FolderFoldOut(showGradient, FolderNameGradient);
                if (showGradient)
                {
                    ShaderProperty(KeywordUseGradientColor, "Color");
                    ShaderProperty(KeywordUseGradientStrength, "Strength");
                    ShaderProperty(KeywordUseGradientBrightness, "Brightness");
                }
            }


            //Gradient Light Properties
            if (GetShaderToggle(KeywordUseComputeLight, 1))
            {
                SpaceStandard();
                showGradientLight = FolderFoldOut(showGradientLight, FolderNameGradientLight);
                if (showGradientLight)
                {
                    ShaderProperty(KeywordUseLightRangeMul, "Convert To A Light");
                    ShaderProperty(KeywordUseSetPos, "Set Local Position");
                    ShaderProperty(KeywordUseLightPos, "Source Position");
                    ShaderProperty(KeywordUseLightRange, "Range");
                    ShaderProperty(KeywordUseLightFallOff, "Fall Off");
                    ShaderProperty(KeywordUseLightHardness, "Hardness");
                }
            }


            //Gradient Uv Properties
            if (GetShaderToggle(KeywordUseComputeUvColorRamp, 1))
            {
                SpaceStandard();
                showGradientUv = FolderFoldOut(showGradientUv, FolderNameGradientUv);
                if (showGradientUv)
                {
                    ShaderProperty(KeywordUseMulLight, "Multiply Uv Ramp to Light Sources");
                    ShaderProperty(KeywordUsUvRampBlend, "Axis Blend (X = Positive U, Y = Negative U, Z = Positive V, W = Negative W)");
                    ShaderProperty(KeywordUseUvRampOffset, "Offset");
                    ShaderProperty(KeywordUseUvRampSet, "Settings");
                }
            }

            SpaceStandard();

            //Shading
            showShading = FolderFoldOut(showShading, FolderNameShading);
            if (showShading)
            {
                ShaderProperty(KeywordUseLookUpTex, "Look Up Table");
                ShaderProperty(KeywordUsePassLut, "Switch LUT to Color Gradient");
                ShaderProperty(KeywordUseMulPColor, "Multiply Particle Color");
                ShaderProperty(KeywordUseDisableAlpha, "Disable Alpha");
            }


            if (GetShaderToggle(KeywordUseComputeGeometry, 0) || GetShaderToggle(KeywordUseComputeGeometryTexture, 1))
            {
                SpaceStandard();
                //Alpha Properties
                showAlpha = FolderFoldOut(showAlpha, FolderNameAlpha);
                if (showAlpha)
                {
                    ShaderProperty(KeywordUseAMaskUse, "Enable Alpha Mask");
                    ShaderProperty(KeywordUseAlpha, "Packed Texture");
                    ShaderProperty(KeywordUseBlendChannels, "Blend Packed Texture Channel");
                    ShaderProperty(KeywordUseAlphaTrans, "Uv Tiling & Offset");

                    if (GetShaderToggle(KeywordUseAMaskUse, 1))
                    {
                        SpaceStandard();
                        showAlphaMask = FolderFoldOut(showAlphaMask, FolderNameAlphaMask);
                        if (showAlphaMask)
                        {
                            ShaderProperty(KeywordUseAMask, "Alpha Mask");
                            ShaderProperty(KeywordAMaskUseAlphaUv, "Alpha Mask use Alpha Uv");
                            ShaderProperty(KeywordAMaskTrans, "Alpha Mask Uv Tiling & Offset");
                            ShaderProperty(KeywordUseAMaskSqSw, "Alpha Mask Enable Squeez XY & Swipe ZW");
                            ShaderProperty(KeywordUseAMaskCh, "Alpha Mask Use Custom Data 1 Channel (0 - 3)");
                        }
                    }
                }


                //Dissolve Properties
                if (GetShaderToggle(KeywordUseComputeDissolve, 1))
                {
                    SpaceStandard();
                    showDissolve = FolderFoldOut(showDissolve, FolderNameDissolve);
                    if (showDissolve)
                    {
                        ShaderProperty(KeywordUseDisTex, "Map");
                        ShaderProperty(KeywordUseDisFlipU, "Flip U");
                        ShaderProperty(KeywordUseDisFlipV, "Flip V");
                        ShaderProperty(KeywordUseDisRot, "Rotate 90 Degress");
                        ShaderProperty(KeywordUseDisUseAlphaUv, "Use Alpha Uv");
                        ShaderProperty(KeywordUseDisInv, "Invert Ramp");
                        ShaderProperty(KeywordUseDisUseCd, "Use Custom Data 1");
                        ShaderProperty(KeywordUseDisCustom, "Strength by CD1 Channel (0 - 3)");
                        ShaderProperty(KeywordUseDisStrength, "Strength");
                        ShaderProperty(KeywordUseDisTrans, "Uv Tiling & Offset");
                        ShaderProperty(KeywordUseDisFallOff, "Fall Off");
                    }
                }


                //Distortion Properties
                if (GetShaderToggle(KeywordUseComputeDistortion, 1))
                {
                    SpaceStandard();
                    showDistortion = FolderFoldOut(showDistortion, FolderNameDistortion);
                    if (showDistortion)
                    {
                        ShaderProperty(KeywordUseDstTex, "Map");
                        ShaderProperty(KeywordUseDstMask, "Mask");
                        ShaderProperty(KeywordUseDstInvMask, "Mask Invert");
                        ShaderProperty(KeywordUseDstAlpha, "Enable for Alpha");
                        ShaderProperty(KeywordUseDstDis, "Enable for Dissolve");
                        ShaderProperty(KeywordUseDstUseCd, "Use Custom Data 1");
                        ShaderProperty(KeywordUseDstCustom, "Strength by CD1 Channel (0 - 3)");
                        ShaderProperty(KeywordUseDstStrength, "Strength");
                        ShaderProperty(KeywordUseDstWorldUv, "Set World Uv Coordinates");
                        ShaderProperty(KeywordUseDstTrans, "Uv Tiling & Offset");
                    }
                }

                //Uv Manipulation Properties
                if (GetShaderToggle(KeywordUseComputeUvManipulation, 1))
                {
                    SpaceStandard();
                    showUvManipulation = FolderFoldOut(showUvManipulation, FolderNameUvManipulation);
                    if (showUvManipulation)
                    {
                        ShaderProperty(KeywordUseUvAlphaSqSw, "Enable Squeez XY & Swipe ZW");
                        ShaderProperty(KeywordUseUvAlphaCh, "Use Custom Data 1 Channel (0 - 3)");
                        ShaderProperty(KeywordUseUvDstSqSw, "Enable Squeez XY & Swipe ZW");
                        ShaderProperty(KeywordUseUvDstCh, "Use Custom Data 1 Channel (0 - 3)");
                        ShaderProperty(KeywordUseUvTwistUInv, "Invert U");
                        ShaderProperty(KeywordUseUvTwistVInv, "Invert V");
                        ShaderProperty(KeywordUseUvTwistAlphaCd, "Alpha Use Custom Data");
                        ShaderProperty(KeywordUseUvTwistDisCd, "Dissolve Use Custom Data");
                        ShaderProperty(KeywordUseUvTwist, "Twist");
                        ShaderProperty(KeywordUseUvTwistCh, "Use Custom Data 1 Channel (0 - 3)");
                    }
                }
            }

            SpaceStandard();

            //Render Properties
            showRender = FolderFoldOut(showRender, FolderNameRender);
            if (showRender)
            {
                ShaderProperty(KeywordUseBlendAdd, "Premultiplied Mode");
                ShaderProperty(KeywordUseOffVc, "Disable Vertex Color");
                ShaderProperty(KeywordUseCull, "Cull Mode");
                ShaderProperty(KeywordUseStencilMask, "Stencil Mask");
                ShaderProperty(KeywordUseStencilComp, "Stencil Compare");
                ShaderProperty(KeywordUseStencilPass, "Stencil Pass");
                ShaderProperty(KeywordUseStencilWrite, "Stencil Write");
                ShaderProperty(KeywordUseStencilRead, "Stencil Read");
                ShaderProperty(KeywordUseZTest, "Z Test");
                ShaderProperty(KeywordUseZWrite, "Z Write");
                material.renderQueue = EditorGUILayout.IntField("Render Queue", material.renderQueue);
            }
        }
    }
}