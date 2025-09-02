using UnityEditor;
using UnityEngine;

namespace InnoGames.VFX.Game.Editor
{
	public class VFX_ShaderGUI_MultiColor_LightAndMotion : VFX_ShaderEditorGlobal
	{
		private const string KeywordUseComputeGeometry = "_GEO";
		private const string KeywordUseComputeGeometryTexture = "_GEO_TEX";
		private const string KeywordUseComputeUvColorRamp = "_UV_COLOR_RAMP";
		private const string KeywordUseComputeDissolve = "_DISSOLVE";
		private const string KeywordUseComputeDissolveClip = "_DISSOlVE_CLIP";
		private const string KeywordUseComputeDistortion = "_DISTORTION";
		private const string KeywordUseComputeUvManipulation = "_UV_MANIPULATE";

		//Geometry Properties
		private const string FolderNameGeo = "GEOMETRY PROPERTIES";
		private const string KeywordUseGeoDeformPhase = "_GeoDeformPhase";
		private const string KeywordUseGeoDeformAmplitude = "_GeoDeformAmplitude";
		private const string KeywordUseGeoRimMul = "_GeoRimMul";
		private const string KeywordUseGeoRimHardness = "_GeoRimHardness";
		private const string KeywordUseGeoAxis = "_GeoAxis";
		private const string KeywordUseGeoPush = "_GeoPush";
		private const string KeywordUsGeoOffset = "_GeoOffset";

		//Gradient Properties
		private const string FolderNameGradient = "GRADIENT PROPERTIES";
		private const string KeywordUseGradientColor = "_GradientColor";
		private const string KeywordUseGradientStrength = "_GradientStrength";
		private const string KeywordUseGradientBrightness = "_GradientBrightness";

		//Gradient by Uv Properties
		private const string FolderNameGradientUv = "GRADIENT BY UV PROPERTIES";
		private const string KeywordUsUvRampBlend = "_UvRampBlend";
		private const string KeywordUseUvRampOffset = "_UvRampOffset";
		private const string KeywordUseUvRampSet = "_UvRampSet";
		private const string KeywordUseLight = "_Light";

		//Shading
		private const string FolderNameShading = "SHADING PROPERTIES";
		private const string KeywordUseLookUpTex = "_LookUpTex";
		private const string KeywordUsePassLut = "_PassLUT";
		private const string KeywordUseLutAnimate = "_LUTAnimate";

		//Alpha Properties
		private const string FolderNameAlpha = "ALPHA PROPERTIES";
		private const string KeywordUseDisableAlpha = "_DisableAlpha";
		private const string KeywordUseAlpha = "_Alpha";
		private const string KeywordUseBlendChannels = "_BlendChannels";
		private const string KeywordUseAlphaTrans = "_AlphaTrans";
		private const string FolderNameAlphaMask = "ALPHA MASK PROPERTIES";
		private const string KeywordUseAMask = "_AMask";
		private const string KeywordUseAMaskUse = "_AMaskUse";
		private const string KeywordAMaskTrans = "_AMaskTrans";
		private const string KeywordUseAMaskSqSw = "_AMaskSqSw";

		//Dissolve Properties
		private const string FolderNameDissolve = "DISSOLVE PROPERTIES";
		private const string KeywordUseDisTex = "_DisTex";
		private const string KeywordUseDisFlipU = "_DisFlipU";
		private const string KeywordUseDisFlipV = "_DisFlipV";
		private const string KeywordUseDisRot = "_DisRot";
		private const string KeywordUseDisInv = "_DisInv";
		private const string KeywordUseDisAlphaColor = "_UseAlpha";
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
		private const string KeywordUseDstStrength = "_DstStrength";
		private const string KeywordUseDstWorldUv = "_DstWorldUv";
		private const string KeywordUseDstTrans = "_DstTrans";

		//Uv Properties
		private const string FolderNameUvManipulation = "UV MANIPULATION PROPERTIES";
		private const string KeywordUseUvAlphaSqSw = "_UvAlphaSqSw";
		private const string KeywordUseUvDstSqSw = "_UvDstSqSw";
		private const string KeywordUseUvTwistUInv = "_UvTwistUInv";
		private const string KeywordUseUvTwistVInv = "_UvTwistVInv";
		private const string KeywordUseUvTwistAlphaCd = "_UvTwistAlphaCd";
		private const string KeywordUseUvTwistDisCd = "_UvTwistDisCd";
		private const string KeywordUseUvTwist = "_UvTwist";

		//Render Properties
		private const string FolderNameRender = "RENDER PROPERTIES";
		private const string KeywordUseBlendAdd = "_BlendAdd";
		private const string KeywordUseOffVc = "_offVc";
		private const string KeywordUseCull = "_Cull";
		private const string KeywordUseStencilMask = "_StencilMask";
		private const string KeywordUseStencilComp = "_StencilComp";
		private const string KeywordUseStencilPass = "_StencilPass";
		private const string KeywordUseStencilWrite = "_StencilWrite";
		private const string KeywordUseStencilRead = "_StencilRead";
		private const string KeywordUseZTest = "_ZTest";
		private const string KeywordUseZWrite = "_ZWrite";

		private bool showGeometry;
		private bool showGradientUv;
		private bool showShading;
		private bool showAlpha;
		private bool showAlphaMask;
		private bool showDissolve;
		private bool showDistortion;
		private bool showUvManipulation;
		private bool showRender;

		public override void OnGUI(MaterialEditor materialEditor, MaterialProperty[] properties)
		{
			base.OnGUI(materialEditor, properties);
			GUILayout.Label("Names", EditorStyles.boldLabel);

			HandleShaderToggle(KeywordUseComputeGeometry, "Compute Geometry");
			if (GetShaderToggle(KeywordUseComputeGeometry, 1))
			{
				HandleShaderToggle(KeywordUseComputeGeometryTexture, "Compute Geometry Add Texture");
			}

			HandleShaderToggle(KeywordUseComputeUvColorRamp, "Compute Gradient By Uv");

			if (GetShaderToggle(KeywordUseComputeGeometry, 0) || GetShaderToggle(KeywordUseComputeGeometryTexture, 1))
			{
				HandleShaderToggle(KeywordUseComputeDissolve, "Compute Dissolve");

				if (GetShaderToggle(KeywordUseComputeDissolve, 1))
				{
					HandleShaderToggle(KeywordUseComputeDissolveClip, "Compute Dissolve Clip");
				}
				HandleShaderToggle(KeywordUseComputeDistortion, "Compute Distortion");
				HandleShaderToggle(KeywordUseComputeUvManipulation, "Compute Uv Manipulation");
			}

			if (GetShaderToggle(KeywordUseComputeGeometry, 1))
			{
				SpaceStandard();
				showGeometry = FolderFoldOut(showGeometry, FolderNameGeo);
				if (showGeometry)
				{
					ShaderProperty(KeywordUseGeoDeformPhase, "Deformation  Frequency");
					ShaderProperty(KeywordUseGeoDeformAmplitude, "Deformation Amplitude");
					ShaderProperty(KeywordUseGeoRimMul, "Rim Multiplier");
					ShaderProperty(KeywordUseGeoRimHardness, "Rim Hardness");
					ShaderProperty(KeywordUseGeoAxis, "Deformation Axis");
					ShaderProperty(KeywordUseGeoPush, "Push Axis");
					ShaderProperty(KeywordUsGeoOffset, "Offset");
				}
			}

			//Gradient Uv Properties
			if (GetShaderToggle(KeywordUseComputeUvColorRamp, 1))
			{
				SpaceStandard();
				showGradientUv = FolderFoldOut(showGradientUv, FolderNameGradientUv);
				if (showGradientUv)
				{
					ShaderProperty(KeywordUseGradientColor, "Gradient Color");
					ShaderProperty(KeywordUseGradientStrength, "Gradient Strength");
					ShaderProperty(KeywordUseGradientBrightness, "Gradient Brightness");
					ShaderProperty(KeywordUsUvRampBlend,
						"UV Ramp Axis Blend (X = Positive U, Y = Negative U, Z = Positive V, W = Negative W)");
					ShaderProperty(KeywordUseUvRampOffset, "Uv Ramp Offset");
					ShaderProperty(KeywordUseUvRampSet, "Uv Ramp Settings");
					ShaderProperty(KeywordUseLight, "Uv Ramp Settings");
				}
			}

			SpaceStandard();

			//Shading
			showShading = FolderFoldOut(showShading, FolderNameShading);
			if (showShading)
			{
				ShaderProperty(KeywordUseLookUpTex, "Look Up Table");
				ShaderProperty(KeywordUsePassLut, "Switch LUT to Color Gradient");
				ShaderProperty(KeywordUseLutAnimate, "LUT Animate Offset, X min, Y max range, Z speed");
			}

			if (GetShaderToggle(KeywordUseComputeGeometry, 0) || GetShaderToggle(KeywordUseComputeGeometryTexture, 1))
			{
				SpaceStandard();
				//Alpha Properties
				showAlpha = FolderFoldOut(showAlpha, FolderNameAlpha);
				if (showAlpha)
				{
					ShaderProperty(KeywordUseAMaskUse, "Enable Alpha Mask");
					ShaderProperty(KeywordUseDisableAlpha, "Disable Alpha");
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
							ShaderProperty(KeywordAMaskTrans, "Alpha Mask Uv Tiling & Offset");
							ShaderProperty(KeywordUseAMaskSqSw, "Alpha Mask Enable Squeez XY & Swipe ZW");
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
						ShaderProperty(KeywordUseDisTex, "Dissolve Ramp");
						ShaderProperty(KeywordUseDisFlipU, "Dissolve Flip U");
						ShaderProperty(KeywordUseDisFlipV, "Dissolve Flip V");
						ShaderProperty(KeywordUseDisRot, "Dissolve Rotate 90 Degress");
						ShaderProperty(KeywordUseDisInv, "Dissolve Invert Ramp");
						ShaderProperty(KeywordUseDisAlphaColor, "Dissolve With Alpha Color");
						ShaderProperty(KeywordUseDisStrength, "Dissolve Strength");
						ShaderProperty(KeywordUseDisTrans, "Dissolve Uv Tiling & Offset");
						ShaderProperty(KeywordUseDisFallOff, "Dissolve Fall Off");
					}
				}

				//Distortion Properties
				if (GetShaderToggle(KeywordUseComputeDistortion, 1))
				{
					SpaceStandard();
					showDistortion = FolderFoldOut(showDistortion, FolderNameDistortion);
					if (showDistortion)
					{
						ShaderProperty(KeywordUseDstTex, "Distortion Texture");
						ShaderProperty(KeywordUseDstMask, "Distortion Mask");
						ShaderProperty(KeywordUseDstInvMask, "Distortion Mask Invert");
						ShaderProperty(KeywordUseDstAlpha, "Distortion Enable for Alpha");
						ShaderProperty(KeywordUseDstDis, "Distortion Enable for Dissolve");
						ShaderProperty(KeywordUseDstStrength, "Distortion Strength");
						ShaderProperty(KeywordUseDstWorldUv, "Distortion Set World Uv Coordinates");
						ShaderProperty(KeywordUseDstTrans, "Distortion Uv Tiling & Offset");
					}
				}

				//Uv Manipulation Properties
				if (GetShaderToggle(KeywordUseComputeUvManipulation, 1))
				{
					SpaceStandard();
					showUvManipulation = FolderFoldOut(showUvManipulation, FolderNameUvManipulation);
					if (showUvManipulation)
					{
						ShaderProperty(KeywordUseUvAlphaSqSw, "Uv Alpha Enable Squeez XY & Swipe ZW");
						ShaderProperty(KeywordUseUvDstSqSw, "Uv Distortion Enable Squeez XY & Swipe ZW");
						ShaderProperty(KeywordUseUvTwistUInv, "Uv Twist Invert U");
						ShaderProperty(KeywordUseUvTwistVInv, "Uv Twist Invert V");
						ShaderProperty(KeywordUseUvTwistAlphaCd, "Uv Twist Alpha Use Custom Data");
						ShaderProperty(KeywordUseUvTwistDisCd, "Uv Twist Dissolve Use Custom Data");
						ShaderProperty(KeywordUseUvTwist, "Uv Twist");
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
