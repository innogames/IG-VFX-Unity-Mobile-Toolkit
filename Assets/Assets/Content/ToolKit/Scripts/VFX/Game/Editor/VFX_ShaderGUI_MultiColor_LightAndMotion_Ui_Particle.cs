using UnityEngine;
using UnityEditor;

namespace InnoGames.VFX.Game.Editor
{
    public class VFX_ShaderGUI_MultiColor_LightAndMotion_Ui_Particle : VFX_ShaderEditorGlobal
    {
        // Property keys as private constants
        private const string PropDebug = "_DEBUG";
        private const string PropVisDis = "_VisDis";
        private const string PropVisDst = "_VisDst";
        private const string PropVisDstMask = "_VisDstMask";
        private const string PropLookUpTex = "_LookUpTex";
        private const string PropPassLUT = "_PassLUT";
        private const string PropOffsetV = "_OffsetV";
        private const string PropMainTex = "_MainTex";
        private const string PropBlendChannels = "_BlendChannels";
        private const string PropAlphaTrans = "_AlphaTrans";
        private const string PropUvAlphaSqSw = "_UvAlphaSqSw";
        private const string PropUvAlphaCh = "_UvAlphaCh";
        private const string PropDisTex = "_DisTex";
        private const string PropDisFlipU = "_DisFlipU";
        private const string PropDisFlipV = "_DisFlipV";
        private const string PropDisRot = "_DisRot";
        private const string PropDisInv = "_DisInv";
        private const string PropDisUseCd = "_DisUseCd";
        private const string PropDisCustom = "_DisCustom";
        private const string PropDisStrength = "_DisStrength";
        private const string PropDisTrans = "_DisTrans";
        private const string PropDisFallOff = "_DisFallOff";
        private const string PropDstTex = "_DstTex";
        private const string PropDstMask = "_DstMask";
        private const string PropDstInvMask = "_DstInvMask";
        private const string PropDstAlpha = "_DstAlpha";
        private const string PropDstDis = "_DstDis";
        private const string PropDstWorld = "_DstWorld";
        private const string PropDstStrength = "_DstStrength";
        private const string PropDstStrengthDis = "_DstStrengthDis";
        private const string PropDstTrans = "_DstTrans";
        private const string PropUvDstSqSw = "_UvDstSqSw";
        private const string PropParticleA = "_ParticleA";
        private const string PropParticleCdStrength = "_ParticleCdStrength";
        private const string PropStencilComp = "_StencilComp";
        private const string PropStencil = "_Stencil";
        private const string PropStencilOp = "_StencilOp";
        private const string PropStencilWriteMask = "_StencilWriteMask";
        private const string PropStencilReadMask = "_StencilReadMask";
        private const string PropColorMask = "_ColorMask";
        private const string PropClipRect = "_ClipRect";

        private bool showDebugFeatures = false;
        private bool showLookAndFeel = false;
        private bool showAlphaProperties = false;
        private bool showDissolveProperties = false;
        private bool showDistortionProperties = false;
        private bool showUVManipulateProperties = false;
        private bool showParticleProperties = false;
        private bool showUIRenderProperties = false;

        public override void OnGUI(MaterialEditor materialEditor, MaterialProperty[] properties)
        {
            base.OnGUI(materialEditor, properties); // Initialize base class members

            // Debug Features
            showDebugFeatures = FolderFoldOut(showDebugFeatures, "Debug Features");
            if (showDebugFeatures)
            {
                HandleShaderToggle(PropDebug, "Compute Debug");
                HandleShaderToggle(PropVisDis, "Visualize Dissolve");
                HandleShaderToggle(PropVisDst, "Visualize Distortion");
                HandleShaderToggle(PropVisDstMask, "Visualize Distortion Mask");
            }

            // Look and Feel
            showLookAndFeel = FolderFoldOut(showLookAndFeel, "Look and Feel Properties");
            if (showLookAndFeel)
            {
                ShaderProperty(PropLookUpTex, "Look Up Table");
                HandleShaderToggle(PropPassLUT, "Switch LUT to Color Gradient");
                ShaderProperty(PropOffsetV, "Select Ramp");
            }

            // Alpha Properties
            showAlphaProperties = FolderFoldOut(showAlphaProperties, "Alpha Properties");
            if (showAlphaProperties)
            {
                ShaderProperty(PropMainTex, "Packed Texture");
                ShaderProperty(PropBlendChannels, "Blend Packed Texture Channel");
                ShaderProperty(PropAlphaTrans, "Uv Tiling & Offset");
                ShaderProperty(PropUvAlphaSqSw, "Uv Alpha Enable Squeez XY & Swipe ZW");
                ShaderProperty(PropUvAlphaCh, "Uv Alpha Use Custom Data 1 Channel (0 - 3)");
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
                HandleShaderToggle(PropDisUseCd, "Dissolve Use Custom Data 1");
                ShaderProperty(PropDisCustom, "Dissolve Strength by CD1 Channel (0 - 3)");
                ShaderProperty(PropDisStrength, "Dissolve Strength");
                ShaderProperty(PropDisTrans, "Dissolve Uv Tiling & Offset");
                ShaderProperty(PropDisFallOff, "Dissolve Fall Off");
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
                HandleShaderToggle(PropDstWorld, "Distortion Set to World Coords");
                ShaderProperty(PropDstStrength, "Distortion Strength Alpha");
                ShaderProperty(PropDstStrengthDis, "Distortion Strength Dissolve");
                ShaderProperty(PropDstTrans, "Distortion Uv Tiling & Offset");
            }

            // Uv Manipulate Properties
            showUVManipulateProperties = FolderFoldOut(showUVManipulateProperties, "Uv Manipulate Properties");
            if (showUVManipulateProperties)
            {
                ShaderProperty(PropUvDstSqSw, "Uv Distortion Enable Squeez XY & Swipe ZW");
            }

            // Particle Properties
            showParticleProperties = FolderFoldOut(showParticleProperties, "Particle Properties");
            if (showParticleProperties)
            {
                HandleShaderToggle(PropParticleA, "Enable Particle Alpha");
                ShaderProperty(PropParticleCdStrength, "Enable Particle Color Strength");
            }

            // UI Render Properties
            showUIRenderProperties = FolderFoldOut(showUIRenderProperties, "UI Render Properties");
            if (showUIRenderProperties)
            {
                ShaderProperty(PropStencilComp, "Stencil Comparison");
                ShaderProperty(PropStencil, "Stencil ID");
                ShaderProperty(PropStencilOp, "Stencil Operation");
                ShaderProperty(PropStencilWriteMask, "Stencil Write Mask");
                ShaderProperty(PropStencilReadMask, "Stencil Read Mask");
                ShaderProperty(PropColorMask, "Color Mask");
                ShaderProperty(PropClipRect, "Clip Rect");
            }
        }
    }
}