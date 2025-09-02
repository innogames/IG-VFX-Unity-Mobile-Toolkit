using UnityEngine;
using UnityEditor;

namespace InnoGames.VFX.Game.Editor
{
    public class VFX_ShaderGUI_MultiColor_LightAndMotion_Ui_Image : VFX_ShaderEditorGlobal
    {
        // Property keys as private constants
        private const string PropDebug = "_DEBUG";
        private const string PropVisDissolve = "_VisDis";
        private const string PropVisDistortion = "_VisDst";
        private const string PropVisDistortionMask = "_VisDstMask";
        private const string PropLookUpTex = "_LookUpTex";
        private const string PropUseImage = "_useImage";
        private const string PropPassLUT = "_PassLUT";
        private const string PropOffsetV = "_OffsetV";
        private const string PropMainTex = "_MainTex";
        private const string PropFlickering = "_Flickering";
        private const string PropBlendChannels = "_BlendChannels";
        private const string PropAlphaTrans = "_AlphaTrans";
        private const string PropAlphaSpeed = "_AlphaSpeed";
        private const string PropAlphaRadial = "_AlphaRadial";
        private const string PropDisTex = "_DisTex";
        private const string PropDisFlipU = "_DisFlipU";
        private const string PropDisFlipV = "_DisFlipV";
        private const string PropDisRot = "_DisRot";
        private const string PropDisInv = "_DisInv";
        private const string PropDisStrength = "_DisStrength";
        private const string PropDisFallOff = "_DisFallOff";
        private const string PropDisTrans = "_DisTrans";
        private const string PropDstTex = "_DstTex";
        private const string PropDstMask = "_DstMask";
        private const string PropDstInvMask = "_DstInvMask";
        private const string PropDstAlpha = "_DstAlpha";
        private const string PropDstDis = "_DstDis";
        private const string PropDstStrength = "_DstStrength";
        private const string PropDstStrengthDis = "_DstStrengthDis";
        private const string PropDstTrans = "_DstTrans";
        private const string PropUvRadialDst = "_UvRadialDst";
        private const string PropUvDstSqSw = "_UvDstSqSw";
        private const string PropDstBlend = "_DstBlend";
        private const string PropStencilComp = "_StencilComp";
        private const string PropStencil = "_Stencil";
        private const string PropStencilOp = "_StencilOp";
        private const string PropStencilWriteMask = "_StencilWriteMask";
        private const string PropStencilReadMask = "_StencilReadMask";
        private const string PropColorMask = "_ColorMask";

        private bool showDebugFeatures = false;
        private bool showLookAndFeel = false;
        private bool showAlphaProperties = false;
        private bool showDissolveProperties = false;
        private bool showDistortionProperties = false;
        private bool showUVManipulateProperties = false;
        private bool showRenderProperties = false;

        public override void OnGUI(MaterialEditor materialEditor, MaterialProperty[] properties)
        {
            base.OnGUI(materialEditor, properties); // Initialize base class members

            // Debug Features
            showDebugFeatures = FolderFoldOut(showDebugFeatures, "Debug Features");
            if (showDebugFeatures)
            {
                HandleShaderToggle(PropDebug, "Compute Debug");
                HandleShaderToggle(PropVisDissolve, "Visualize Dissolve");
                HandleShaderToggle(PropVisDistortion, "Visualize Distortion");
                HandleShaderToggle(PropVisDistortionMask, "Visualize Distortion Mask");
            }

            // Look and Feel
            showLookAndFeel = FolderFoldOut(showLookAndFeel, "Look and Feel Properties");
            if (showLookAndFeel)
            {
                ShaderProperty(PropLookUpTex, "Look Up Table");
                HandleShaderToggle(PropUseImage, "Use Image");
                HandleShaderToggle(PropPassLUT, "Switch LUT to Color Gradient");
                ShaderProperty(PropOffsetV, "Select Ramp");
            }

            // Alpha Properties
            showAlphaProperties = FolderFoldOut(showAlphaProperties, "Alpha Properties");
            if (showAlphaProperties)
            {
                ShaderProperty(PropMainTex, "Packed Texture");
                ShaderProperty(PropFlickering, "Flickering, X = Speed, Y = Strength, Z = Min Value");
                ShaderProperty(PropBlendChannels, "Blend Packed Texture Channel");
                ShaderProperty(PropAlphaTrans, "Uv Tiling & Offset");
                ShaderProperty(PropAlphaSpeed, "Alpha Radial Speed");
                HandleShaderToggle(PropAlphaRadial, "Enable Radial Uv");
            }

            // Dissolve Properties
            showDissolveProperties = FolderFoldOut(showDissolveProperties, "Dissolve Properties");
            if (showDissolveProperties)
            {
                ShaderProperty(PropDisTex, "Dissolve Ramp");
                HandleShaderToggle(PropDisFlipU, "Dissolve Flip U");
                HandleShaderToggle(PropDisFlipV, "Dissolve Flip V");
                HandleShaderToggle(PropDisRot, "Dissolve Rotate 90 Degrees");
                HandleShaderToggle(PropDisInv, "Dissolve Invert Ramp");
                ShaderProperty(PropDisStrength, "Dissolve Strength");
                ShaderProperty(PropDisFallOff, "Dissolve Fall Off");
                ShaderProperty(PropDisTrans, "Dissolve Uv Tiling & Offset");
            }

            // Distortion Properties
            showDistortionProperties = FolderFoldOut(showDistortionProperties, "Distortion Properties");
            if (showDistortionProperties)
            {
                ShaderProperty(PropDstTex, "Distortion Texture");
                ShaderProperty(PropDstMask, "Distortion Mask");
                HandleShaderToggle(PropDstInvMask, "Distortion Mask Invert");
                HandleShaderToggle(PropDstAlpha, "Distortion Enable for Alpha");
                HandleShaderToggle(PropDstDis, "Distortion Enable for Dissolve");
                ShaderProperty(PropDstStrength, "Distortion Strength Alpha");
                ShaderProperty(PropDstStrengthDis, "Distortion Strength Dissolve");
                ShaderProperty(PropDstTrans, "Distortion Uv Tiling & Offset");
            }

            // Uv Manipulate Properties
            showUVManipulateProperties = FolderFoldOut(showUVManipulateProperties, "Uv Manipulate Properties");
            if (showUVManipulateProperties)
            {
                HandleShaderToggle(PropUvRadialDst, "Uv Radial Distortion");
                ShaderProperty(PropUvDstSqSw, "Uv Distortion Enable Squeez XY & Swipe ZW");
            }

            // Render Properties
            showRenderProperties = FolderFoldOut(showRenderProperties, "Render Properties");
            if (showRenderProperties)
            {
                ShaderProperty(PropDstBlend, "DestBlend");
                ShaderProperty(PropStencilComp, "Stencil Comparison");
                ShaderProperty(PropStencil, "Stencil ID");
                ShaderProperty(PropStencilOp, "Stencil Operation");
                ShaderProperty(PropStencilWriteMask, "Stencil Write Mask");
                ShaderProperty(PropStencilReadMask, "Stencil Read Mask");
                ShaderProperty(PropColorMask, "Color Mask");
            }
        }
    }
}