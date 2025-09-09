using UnityEditor;
using UnityEngine;

namespace InnoGames.VFX.Game.Editor
{
	public class VFX_ShaderGUI_MultiColor_LightAndMotion_VAT : VFX_ShaderEditorGlobal
	{
		private const string KeywordUseComputeGeometry = "_GEO";
		private const string KeywordUseComputeLight = "_LIGHT";
		private const string KeywordUseComputeUvColorRamp = "_UV_COLOR_RAMP";
		private const string KeywordUseComputeDissolve = "_DISSOLVE";
		private const string KeywordUseComputeDissolveClip = "_DISSOlVE_CLIP";

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
		private const string KeywordUsUvRampBlend = "_UvRampBlend";
		private const string KeywordUseUvRampOffset = "_UvRampOffset";
		private const string KeywordUseUvRampSet = "_UvRampSet";
		private const string KeywordUseLight = "_Light";

		//Shading
		private const string FolderNameShading = "SHADING PROPERTIES";
		private const string KeywordUseLookUpTex = "_LookUpTex";
		private const string KeywordUsePassLut = "_PassLUT";
		private const string KeywordUseLutAnimate = "_LUTAnimate";

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
		private bool showGradient;
		private bool showGradientLight;
		private bool showGradientUv;
		private bool showShading;
		private bool showDissolve;
		private bool showRender;

		public override void OnGUI(MaterialEditor materialEditor, MaterialProperty[] properties)
		{
			base.OnGUI(materialEditor, properties);
			GUILayout.Label("Names", EditorStyles.boldLabel);

			HandleShaderToggle(KeywordUseComputeGeometry, "Compute Geometry");
			HandleShaderToggle(KeywordUseComputeLight, "Compute Gradient By Light");
			HandleShaderToggle(KeywordUseComputeUvColorRamp, "Compute Gradient By Uv");


			HandleShaderToggle(KeywordUseComputeDissolve, "Compute Dissolve");

			if (GetShaderToggle(KeywordUseComputeDissolve, 1))
			{
				HandleShaderToggle(KeywordUseComputeDissolveClip, "Compute Dissolve Clip");
			}

			//Geometry Properties
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

			//Gradient Properties
			if (GetShaderToggle(KeywordUseComputeLight, 1) || GetShaderToggle(KeywordUseComputeUvColorRamp, 1))
			{
				SpaceStandard();
				showGradient = FolderFoldOut(showGradient, FolderNameGradient);
				if (showGradient)
				{
					ShaderProperty(KeywordUseGradientColor, "Gradient Color");
					ShaderProperty(KeywordUseGradientStrength, "Gradient Strength");
					ShaderProperty(KeywordUseGradientBrightness, "Gradient Brightness");
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
					ShaderProperty(KeywordUseSetPos, "Set Position");
					ShaderProperty(KeywordUseLightPos, "Light Source Position");
					ShaderProperty(KeywordUseLightRange, "Light Range");
					ShaderProperty(KeywordUseLightFallOff, "Light Fall Off");
					ShaderProperty(KeywordUseLightHardness, "Light Hardness");
				}
			}

			//Gradient Uv Properties
			if (GetShaderToggle(KeywordUseComputeUvColorRamp, 1))
			{
				SpaceStandard();
				showGradientUv = FolderFoldOut(showGradientUv, FolderNameGradientUv);
				if (showGradientUv)
				{
					ShaderProperty(KeywordUsUvRampBlend, "UV Ramp Axis Blend (X = Positive U, Y = Negative U, Z = Positive V, W = Negative W)");
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

			SpaceStandard();

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
