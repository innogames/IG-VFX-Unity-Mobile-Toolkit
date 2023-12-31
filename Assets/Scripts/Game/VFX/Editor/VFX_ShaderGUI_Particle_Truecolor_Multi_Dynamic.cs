using System.Collections.Generic;
using UnityEditor;
using UnityEngine;
using InnoGames.VFX.Game.Editor;
using System;

namespace InnoGames.VFX.Game.Editor
{
    public class VFX_ShaderGUI_Particle_Truecolor_Multi_Dynamic :  VFX_ShaderEditorGlobal
    {
        private const string KeywordUseComputeDebug = "_Debug";
        private const string KeywordUseComputeDebugGlow = "_DebugGlow";
        private const string KeywordUseComputeDebugColor = "_DebugColor";
        private const string KeywordUseComputeDebugAlpha = "_DebugAlpha";
        private const string KeywordUseComputeDebugVAlpha = "_DebugVAlpha";
        private const string KeywordUseComputeDebugMask = "_DebugMask";
        private const string KeywordUseComputeDebugDis = "_DebugDis";
        private const string KeywordUseComputeDebugDist = "_DebugDist";

        //Shading
        private const string FolderNameShading = "SHADING PROPERTIES";
        private const string KeywordUseGlowRed = "_GlowRed";
        private const string KeywordUseGlowGreen = "_GlowGreen";
        private const string KeywordUseGlowBlue = "_GlowBlue";
        private const string KeywordUseColorTint = "_ColorTint";
        private const string KeywordUseColorAdd = "_ColorAdd";
        private const string KeywordUseRampColor = "_RampColor";
        private const string KeywordUseRampBlend = "_RampBlend";
        private const string KeywordUseRampOffset = "_RampOffset";
        private const string KeywordUseRampSet = "_RampSet";

        //Alpha Properties
        private const string FolderNameAlpha = "ALPHA PROPERTIES";
        private const string KeywordUseAlphaFlipU = "_AlphaFlipU";
        private const string KeywordUseAlphaFlipV = "_AlphaFlipV";
        private const string KeywordUseAlphaRotate = "_AlphaRotate";
        private const string KeywordUseAlphaSwirlInv = "_AlphaSwirlInv";
        private const string KeywordUseAlphaSwirl = "_AlphaSwirl";
        private const string KeywordUseAlphaBlendChannels = "_AlphaBlendChannels";
        private const string KeywordUseAlphaTrans = "_AlphaTrans";
        private const string KeywordUseAlphaTex = "_AlphaTex";

        //Mask Properties
        private const string FolderNameAlphaMask = "ALPHA MASK PROPERTIES";
        private const string KeywordUseMaskFlipU = "_MaskFlipU";
        private const string KeywordUseMaskFlipV = "_MaskFlipV";
        private const string KeywordUseMaskRotate = "_MaskRotate";
        private const string KeywordUseMaskStretchU = "_MaskStretchU";
        private const string KeywordUseMaskSwipeU = "_MaskSwipeU";
        private const string KeywordUseMaskSyncAlpha = "_MaskSyncAlpha";
        private const string KeywordUseMaskTrans = "_MaskTrans";
        private const string KeywordUseMaskTex = "_MaskTex";

        //Dissolve Properties
        private const string FolderNameDissolve = "DISSOLVE PROPERTIES";
        private const string KeywordUseDisFlipU = "_DisFlipU";
        private const string KeywordUseDisFlipV = "_DisFlipV";
        private const string KeywordUseDisRotate = "_DisRotate";
        private const string KeywordUseDisInvert = "_DisInvert";
        private const string KeywordUseDisFallOff = "_DisFallOff";
        private const string KeywordUseDisTrans = "_DisTrans";
        private const string KeywordUseDissolveTex = "_DisTex";

        //Distortion Properties
        private const string FolderNameDistortion = "DISTORTION PROPERTIES";
        private const string KeywordUseDistAlpha = "_DistAlpha";
        private const string KeywordUseDistDis = "_DistDis";
        private const string KeywordUseDistMask = "_DistMask";
        private const string KeywordUseDistTrans = "_DistTrans";
        private const string KeywordUseDistTex = "_DistTex";

        //Render Properties
        private const string FolderNameRender = "RENDER PROPERTIES";
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

            HandleShaderToggle(KeywordUseComputeDebug, "Compute Debug Mode");
            if (GetShaderToggle(KeywordUseComputeDebug, 1))
            {
                HandleShaderToggle(KeywordUseComputeDebugGlow, "Debug Glow");
                HandleShaderToggle(KeywordUseComputeDebugColor, "Debug Color");
                HandleShaderToggle(KeywordUseComputeDebugAlpha, "Debug Alpha");
                HandleShaderToggle(KeywordUseComputeDebugVAlpha, "Debug Vertex Alpha");
                HandleShaderToggle(KeywordUseComputeDebugMask, "Debug Mask");
                HandleShaderToggle(KeywordUseComputeDebugDis, "Debug Dissolve");
                HandleShaderToggle(KeywordUseComputeDebugDist, "Debug Distortion");
            }

            SpaceStandard();

            //Shading
            showShading = FolderFoldOut(showShading, FolderNameShading);
            if (showShading)
            {
                ShaderProperty(KeywordUseGlowRed, "Use Red Channel As Glow");
                ShaderProperty(KeywordUseGlowGreen, "Use Red Channel As Glow");
                ShaderProperty(KeywordUseGlowBlue, "Use Blue Channel As Glow");
                ShaderProperty(KeywordUseColorTint, "Additive Tint Color");
                ShaderProperty(KeywordUseColorAdd, "Additve Blend");
                ShaderProperty(KeywordUseRampColor, "Second Color");
                ShaderProperty(KeywordUseRampBlend, "Ramp Blend");
                ShaderProperty(KeywordUseRampOffset, "Ramp Offset");
                ShaderProperty(KeywordUseRampSet, "Ramp Multiplier");
            }

            SpaceStandard();
            //Alpha Properties
            showAlpha = FolderFoldOut(showAlpha, FolderNameAlpha);
            if (showAlpha)
            {
                ShaderProperty(KeywordUseAlphaFlipU, "Uv Flip U");
                ShaderProperty(KeywordUseAlphaFlipV, "Uv Flip V");
                ShaderProperty(KeywordUseAlphaRotate, "Uv Rotate 90 Degrees");
                ShaderProperty(KeywordUseAlphaSwirlInv, "Invert Swirl");
                ShaderProperty(KeywordUseAlphaSwirl, "Swirl Direction U");
                ShaderProperty(KeywordUseAlphaBlendChannels, "Blend Channels (X = Red, Y = Green, Z = Blue, W = Not In Use)");
                ShaderProperty(KeywordUseAlphaTrans, "Swirl Direction U");
                ShaderProperty(KeywordUseAlphaTrans, "Transform (X Custom Data 1.y, Y Tiling, Z & W Offset)");
                ShaderProperty(KeywordUseAlphaTex, "Texture Pack");
            }

            SpaceStandard();
            //Mask Properties
            showAlphaMask = FolderFoldOut(showAlphaMask, FolderNameAlphaMask);
            if (showAlphaMask)
            {
                ShaderProperty(KeywordUseMaskFlipU, "Uv Flip U");
                ShaderProperty(KeywordUseMaskFlipV, "Uv Flip V");
                ShaderProperty(KeywordUseMaskRotate, "Uv Rotate 90 Degrees");
                ShaderProperty(KeywordUseMaskStretchU, "Overwrite Custom Data X for Stretch");
                ShaderProperty(KeywordUseMaskSwipeU, "Overwrite Custom Data Y for Swipe");
                ShaderProperty(KeywordUseMaskSyncAlpha, "Sync with Alpha");
                ShaderProperty(KeywordUseMaskTrans, "Transform (X & Y Tiling, Z Custom Data 1 Y, W Offset)");
                ShaderProperty(KeywordUseMaskTex, "Mask");
            }


            //Dissolve Properties

            SpaceStandard();
            showDissolve = FolderFoldOut(showDissolve, FolderNameDissolve);
            if (showDissolve)
            {
                ShaderProperty(KeywordUseDisFlipU, "Uv Flip U");
                ShaderProperty(KeywordUseDisFlipV, "Uv Flip V");
                ShaderProperty(KeywordUseDisRotate, "Uv Rotate 90 Degrees");
                ShaderProperty(KeywordUseDisInvert, "Invert");
                ShaderProperty(KeywordUseDisFallOff, "Fall Off");
                ShaderProperty(KeywordUseDisTrans, "Transform (X & Y Tiling, Z & W Offset)");
                ShaderProperty(KeywordUseDissolveTex, "Ramp");
            }

            //Distortion Properties

            SpaceStandard();
            showDistortion = FolderFoldOut(showDistortion, FolderNameDistortion);
            if (showDistortion)
            {
                ShaderProperty(KeywordUseDistAlpha, "Enbale for Alpha");
                ShaderProperty(KeywordUseDistDis, "Enbale for Dissolve");
                ShaderProperty(KeywordUseDistMask, "Enbale for Mask");
                ShaderProperty(KeywordUseDistTrans, "Transform (X & Y Tiling, Z & W Offset");
                ShaderProperty(KeywordUseDistTex, "Distortion Map");
            }

            SpaceStandard();

            //Render Properties
            showRender = FolderFoldOut(showRender, FolderNameRender);
            if (showRender)
            {
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