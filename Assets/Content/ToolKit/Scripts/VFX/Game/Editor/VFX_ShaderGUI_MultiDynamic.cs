using UnityEngine;
using UnityEditor;

namespace InnoGames.VFX.Game.Editor
{
    public class VFX_ShaderGUI_MultiDynamic : VFX_ShaderEditorGlobal
    {
        // Property keys as private constants
        private const string PropDebug = "_Debug";
        private const string PropDebugGlow = "_DebugGlow";
        private const string PropDebugColor = "_DebugColor";
        private const string PropDebugAlpha = "_DebugAlpha";
        private const string PropDebugVAlpha = "_DebugVAlpha";
        private const string PropDebugMask = "_DebugMask";
        private const string PropDebugDis = "_DebugDis";
        private const string PropDebugDist = "_DebugDist";
        private const string PropGlowRed = "_GlowRed";
        private const string PropGlowGreen = "_GlowGreen";
        private const string PropGlowBlue = "_GlowBlue";
        private const string PropColorTint = "_ColorTint";
        private const string PropColorAdd = "_ColorAdd";
        private const string PropRampColor = "_RampColor";
        private const string PropRampBlend = "_RampBlend";
        private const string PropRampOffset = "_RampOffset";
        private const string PropRampSet = "_RampSet";
        private const string PropAlphaFlipU = "_AlphaFlipU";
        private const string PropAlphaFlipV = "_AlphaFlipV";
        private const string PropAlphaRotate = "_AlphaRotate";
        private const string PropAlphaSwirlInv = "_AlphaSwirlInv";
        private const string PropAlphaSwirl = "_AlphaSwirl";
        private const string PropAlphaBlendChannels = "_AlphaBlendChannels";
        private const string PropAlphaTrans = "_AlphaTrans";
        private const string PropAlphaTex = "_AlphaTex";
        private const string PropMaskFlipU = "_MaskFlipU";
        private const string PropMaskFlipV = "_MaskFlipV";
        private const string PropMaskRotate = "_MaskRotate";
        private const string PropMaskStretchU = "_MaskStretchU";
        private const string PropMaskSwipeU = "_MaskSwipeU";
        private const string PropMaskSyncAlpha = "_MaskSyncAlpha";
        private const string PropMaskTrans = "_MaskTrans";
        private const string PropMaskTex = "_MaskTex";
        private const string PropDisFlipU = "_DisFlipU";
        private const string PropDisFlipV = "_DisFlipV";
        private const string PropDisRotate = "_DisRotate";
        private const string PropDisInvert = "_DisInvert";
        private const string PropDisFallOff = "_DisFallOff";
        private const string PropDisTrans = "_DisTrans";
        private const string PropDisTex = "_DisTex";
        private const string PropDistAlpha = "_DistAlpha";
        private const string PropDistDis = "_DistDis";
        private const string PropDistMask = "_DistMask";
        private const string PropDistTrans = "_DistTrans";
        private const string PropDistTex = "_DistTex";
        private const string PropOffVc = "_OffVc";
        private const string PropCull = "_Cull";
        private const string PropStencilMask = "_StencilMask";
        private const string PropStencilComp = "_StencilComp";
        private const string PropStencilPass = "_StencilPass";
        private const string PropStencilWrite = "_StencilWrite";
        private const string PropStencilRead = "_StencilRead";
        private const string PropZTest = "_ZTest";
        private const string PropZWrite = "_ZWrite";

        private bool showDebugFeatures = false;
        private bool showShadingProperties = false;
        private bool showAlphaProperties = false;
        private bool showMaskProperties = false;
        private bool showDissolveProperties = false;
        private bool showDistortionProperties = false;
        private bool showRenderProperties = false;

        public override void OnGUI(MaterialEditor materialEditor, MaterialProperty[] properties)
        {
            base.OnGUI(materialEditor, properties); // Initialize base class members

            // Debug Features
            showDebugFeatures = FolderFoldOut(showDebugFeatures, "Debug Features");
            if (showDebugFeatures)
            {
                HandleShaderToggle(PropDebug, "Compute Debug Mode");
                HandleShaderToggle(PropDebugGlow, "Debug Glow");
                HandleShaderToggle(PropDebugColor, "Debug Color");
                HandleShaderToggle(PropDebugAlpha, "Debug Alpha");
                HandleShaderToggle(PropDebugVAlpha, "Debug Vertex Alpha");
                HandleShaderToggle(PropDebugMask, "Debug Mask");
                HandleShaderToggle(PropDebugDis, "Debug Dissolve");
                HandleShaderToggle(PropDebugDist, "Debug Distortion");
            }

            // Shading Properties
            showShadingProperties = FolderFoldOut(showShadingProperties, "Shading Properties");
            if (showShadingProperties)
            {
                HandleShaderToggle(PropGlowRed, "Use Red Channel As Glow");
                HandleShaderToggle(PropGlowGreen, "Use Green Channel As Glow");
                HandleShaderToggle(PropGlowBlue, "Use Blue Channel As Glow");
                ShaderProperty(PropColorTint, "Additive Tint Color");
                ShaderProperty(PropColorAdd, "Additive Blend");
                ShaderProperty(PropRampColor, "Second Color");
                ShaderProperty(PropRampBlend, "Ramp Blend");
                ShaderProperty(PropRampOffset, "Ramp Offset");
                ShaderProperty(PropRampSet, "Ramp Multiplier");
            }

            // Alpha Properties
            showAlphaProperties = FolderFoldOut(showAlphaProperties, "Alpha Properties");
            if (showAlphaProperties)
            {
                HandleShaderToggle(PropAlphaFlipU, "Uv Flip U");
                HandleShaderToggle(PropAlphaFlipV, "Uv Flip V");
                HandleShaderToggle(PropAlphaRotate, "Uv Rotate 90 Degrees");
                HandleShaderToggle(PropAlphaSwirlInv, "Invert Swirl");
                ShaderProperty(PropAlphaSwirl, "Swirl Direction U");
                ShaderProperty(PropAlphaBlendChannels, "Blend Channels");
                ShaderProperty(PropAlphaTrans, "Transform");
                ShaderProperty(PropAlphaTex, "Texture Pack");
            }

            // Mask Properties
            showMaskProperties = FolderFoldOut(showMaskProperties, "Mask Properties");
            if (showMaskProperties)
            {
                HandleShaderToggle(PropMaskFlipU, "Uv Flip U");
                HandleShaderToggle(PropMaskFlipV, "Uv Flip V");
                HandleShaderToggle(PropMaskRotate, "Uv Rotate 90 Degrees");
                HandleShaderToggle(PropMaskStretchU, "Overwrite Custom Data X for Stretch");
                HandleShaderToggle(PropMaskSwipeU, "Overwrite Custom Data Y for Swipe");
                HandleShaderToggle(PropMaskSyncAlpha, "Sync with Alpha");
                ShaderProperty(PropMaskTrans, "Transform");
                ShaderProperty(PropMaskTex, "Mask");
            }

            // Dissolve Properties
            showDissolveProperties = FolderFoldOut(showDissolveProperties, "Dissolve Properties");
            if (showDissolveProperties)
            {
                HandleShaderToggle(PropDisFlipU, "Uv Flip U");
                HandleShaderToggle(PropDisFlipV, "Uv Flip V");
                HandleShaderToggle(PropDisRotate, "Uv Rotate 90 Degrees");
                HandleShaderToggle(PropDisInvert, "Invert");
                ShaderProperty(PropDisFallOff, "Fall Off");
                ShaderProperty(PropDisTrans, "Transform");
                ShaderProperty(PropDisTex, "Ramp");
            }

            // Distortion Properties
            showDistortionProperties = FolderFoldOut(showDistortionProperties, "Distortion Properties");
            if (showDistortionProperties)
            {
                HandleShaderToggle(PropDistAlpha, "Enable for Alpha");
                HandleShaderToggle(PropDistDis, "Enable for Dissolve");
                HandleShaderToggle(PropDistMask, "Enable for Mask");
                ShaderProperty(PropDistTrans, "Transform");
                ShaderProperty(PropDistTex, "Distortion Map");
            }

            // Render Properties
            showRenderProperties = FolderFoldOut(showRenderProperties, "Render Properties");
            if (showRenderProperties)
            {
                HandleShaderToggle(PropOffVc, "Disable Vertex Alpha");
                ShaderProperty(PropCull, "Cull Mode");
                ShaderProperty(PropStencilMask, "Stencil Mask");
                ShaderProperty(PropStencilComp, "Stencil Compare");
                ShaderProperty(PropStencilPass, "Stencil Pass");
                ShaderProperty(PropStencilWrite, "Stencil Write");
                ShaderProperty(PropStencilRead, "Stencil Read");
                ShaderProperty(PropZTest, "Z Test");
                ShaderProperty(PropZWrite, "Z Write");
            }
        }
    }
}