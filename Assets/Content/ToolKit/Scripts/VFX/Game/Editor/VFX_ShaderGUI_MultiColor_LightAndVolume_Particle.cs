using UnityEditor;
using UnityEngine;

namespace InnoGames.VFX.Game.Editor
{
	public class VFX_ShaderGUI_MultiColor_LightAndVolume_Particle : VFX_ShaderEditorGlobal
	{
		//Compiling Properties
		private const string KeywordUseHeat = "_HEAT";
		private const string KeywordUsePointLight = "_POINT_LIGHT";

		//Geo Shading Properties
		private const string FolderNameShading = "SHADING PROPERTIES";
		private const string KeywordUseZWrite1 = "_ZWritePass1";
		private const string KeywordUseGeoBlendLayer1 = "_BlendLayer1";
		private const string KeywordUseZWrite2 = "_ZWritePass2";
		private const string KeywordUseGeoBlendLayer2 = "_BlendLayer2";
		private const string KeywordUseGeoPushEdge = "_GeoPush";
		private const string KeywordUseGeoRimMul = "_GeoRimMul";
		private const string KeywordUseGeoRimHardness = "_GeoRimHardness";
		private const string KeywordUseLookUpTex = "_LookUpTex";
		private const string KeywordUsePassLut = "_PassLUT";
		private const string KeywordUseMulPColor = "_MulPColor";
		private const string KeywordUseLutUseCd = "_LUTUseCd";
		private const string KeywordUseLutCustom = "_LUTCustom";

		//Geometry Deformation Properties
		private const string FolderNameGeo = "GEOMETRY PROPERTIES";
		private const string KeywordUseGeoDeformPhase = "_GeoDeformPhase";
		private const string KeywordUseGeoDeformAmplitude = "_GeoDeformAmplitude";
		private const string KeywordUseGeoAxis = "_GeoAxis";
		private const string KeywordUseGeoPush = "_GeoPush1";
		private const string KeywordUsGeoOffset = "_GeoOffset";
		private const string KeywordUseGeoUseCd = "_GeoUseCd";
		private const string KeywordUseGeoCustom = "_GeoCustom";

		//Gradient by Light Properties
		private const string KeywordUseGradientUseLut = "_GradientUseLUT";
		private const string KeywordUseGradientColor = "_GradientColor";
		private const string KeywordUseGradientStrength = "_GradientStrength";
		private const string KeywordUseGradientBrightness = "_GradientBrightness";
		private const string KeywordUseGradientBlendCd = "_GradientBlendCd";
		private const string KeywordUseGradientBlendChannel = "_GradientBlendChannel";
		private const string FolderNameGradientLight = "LIGHT PROPERTIES";
		private const string KeywordUseLightRangeMul = "_LightRangeMul";
		private const string KeywordUseSetPos = "_SetPos";
		private const string KeywordUseLightPos = "_LightPos";
		private const string KeywordUseLightRange = "_LightRange";
		private const string KeywordUseLightFallOff = "_LightFallOff";
		private const string KeywordUseLightHardness = "_LightHardness";

		//World Position Mask
		private const string FolderNameWorldPosition = "WORLD POSITION PROPERTIES";
		private const string KeywordUseWpMaskOffset = "_WpMaskOffset";
		private const string KeywordUseWpMaskMul = "_WpMaskMul";
		private const string KeywordUseWpGradientColor = "_WpGradientColor";
		private const string KeywordUseWpColorOffset = "_WpColorOffset";
		private const string KeywordUseWpColorMul = "_WpColorMul";

		//Alpha mask Properties
		private const string FolderNameAlphaMask = "ALPHA MASK PROPERTIES";
		private const string KeywordUseAMask = "_AMask";
		private const string KeywordUseAMaskUse = "_AMaskUse";
		private const string KeywordAMaskUseAlphaUv = "_AMaskUseAlphaUv";
		private const string KeywordAMaskTrans = "_AMaskTrans";
		private const string KeywordUseAMaskSqSw = "_AMaskSqSw";
		private const string KeywordUseAMaskCh = "_AMaskCh";

		//Temperature Properties
		private const string FolderNameTemperature = "TEMPERATURE PROPERTIES";
		private const string KeywordUseTemperatureMul = "_TemperatureMul";
		private const string KeywordUseTemperatureHardness = "_TemperatureHardness";
		private const string KeywordUseHeatColor = "_HeatColor";
		private const string KeywordUseHeatColorMultiplier = "_HeatColorMultiplier";
		private const string KeywordUseTemperatureMap = "_TemperatureMap";
		private const string KeywordUseTemperatureDirectionMap = "_TemperatureDirectionMap";
		private const string KeywordUseTempFlipU = "_TempFlipU";
		private const string KeywordUseTempFlipV = "_TempFlipV";
		private const string KeywordUseTempRot = "_TempRot";
		private const string KeywordUseTemperatureInv = "_TemperatureInv";
		private const string KeywordUseTemperatureUseCd = "_TemperatureUseCd";
		private const string KeywordUseTemperatureCustom = "_TemperatureCustom";
		private const string KeywordUseTemperatureStrength = "_TemperatureStrength";
		private const string KeywordUseTemperatureTrans = "_TemperatureTrans";
		private const string KeywordUseTemperatureFallOff = "_TemperatureFallOff";

		//Dissolve Properties
		private const string FolderNameDissolve = "DISSOLVE PROPERTIES";
		private const string KeywordUseDisTex = "_DisTex";
		private const string KeywordUseDisDirMap = "_DisDirectionMap";
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

		private bool showGeometry = false;
		private bool showGradient = false;
		private bool showGradientLight = false;
		private bool showGradientUv = false;
		private bool showShading = false;
		private bool showAlpha = false;
		private bool showAlphaMask = false;
		private bool showWpPosMask = false;
		private bool showTemperature = false;
		private bool showDissolve = false;
		private bool showDistortion = false;
		private bool showUvManipulation = false;
		private bool showRender = false;

		public override void OnGUI(MaterialEditor materialEditor, MaterialProperty[] properties)
		{
			base.OnGUI(materialEditor, properties);
			GUILayout.Label("Names", EditorStyles.boldLabel);

			//Compute Features
			HandleShaderToggle(KeywordUsePointLight, "Compute Point Light");
			HandleShaderToggle(KeywordUseHeat, "Compute Heat");

			//Shading
			SpaceStandard();
			showShading = FolderFoldOut(showShading, FolderNameShading);
			if (showShading)
			{
				ShaderProperty(KeywordUseZWrite1, "Z Write Solid Layer");
				ShaderProperty(KeywordUseGeoBlendLayer1, "Blend Solid Layer");
				ShaderProperty(KeywordUseGeoPushEdge, "Squeez Solid Layer");
				ShaderProperty(KeywordUseZWrite2, "Z Write Blur Layer");
				ShaderProperty(KeywordUseGeoBlendLayer2, "Blend Blur Layer");
				ShaderProperty(KeywordUseGeoRimMul, "Rim Multiplier");
				ShaderProperty(KeywordUseGeoRimHardness, "Rim Hardness");
				ShaderProperty(KeywordUseLookUpTex, "Look Up Table");
				ShaderProperty(KeywordUseAMaskUse, "Enable Alpha Mask");
				ShaderProperty(KeywordUsePassLut, "Switch LUT to Color Gradient");
				ShaderProperty(KeywordUseMulPColor, "Multiply Particle Color");
				ShaderProperty(KeywordUseLutUseCd, "LUT Use Custom Data 1");
				ShaderProperty(KeywordUseLutCustom, "LUT by CD1 Channel (0 - 3)");
			}

			//Geometry Deformantion
			SpaceStandard();
			showGeometry = FolderFoldOut(showGeometry, FolderNameGeo);
			if (showGeometry)
			{
				ShaderProperty(KeywordUseGeoDeformPhase, "Deformation  Frequency");
				ShaderProperty(KeywordUseGeoDeformAmplitude, "Deformation Amplitude");
				ShaderProperty(KeywordUseGeoAxis, "Deformation Axis");
				ShaderProperty(KeywordUseGeoPush, "Push Axis");
				ShaderProperty(KeywordUsGeoOffset, "Offset");
				ShaderProperty(KeywordUseGeoUseCd, "Geo Offset Use Custom Data 1");
				ShaderProperty(KeywordUseGeoCustom, "Geo Offset by CD1 Channel (0 - 3)");
			}

			//Light Properties
			if (GetShaderToggle(KeywordUsePointLight, 1))
			{
				SpaceStandard();
				showGradientLight = FolderFoldOut(showGradientLight, FolderNameGradientLight);
				if (showGradientLight)
				{
					ShaderProperty(KeywordUseSetPos, "Set Position");
					ShaderProperty(KeywordUseLightPos, "Light Source Position");
					ShaderProperty(KeywordUseGradientUseLut, "Use Look Up Texture As Color");
					ShaderProperty(KeywordUseGradientBlendCd, "Blend Use Custom Data 1");
					ShaderProperty(KeywordUseGradientBlendChannel, "Blend by CD1 Channel (0 - 3)");
					ShaderProperty(KeywordUseLightRangeMul, "Convert To A Light");
					ShaderProperty(KeywordUseLightRange, "Light Range");
					ShaderProperty(KeywordUseLightFallOff, "Light Fall Off");
					ShaderProperty(KeywordUseLightHardness, "Light Hardness");
					ShaderProperty(KeywordUseGradientColor, "Color");
					ShaderProperty(KeywordUseGradientStrength, "Strength");
					ShaderProperty(KeywordUseGradientBrightness, "Gradient Brightness");
				}
			}

			//World Position Properties
			SpaceStandard();
			showWpPosMask = FolderFoldOut(showWpPosMask, FolderNameWorldPosition);
			if (showWpPosMask)
			{
				ShaderProperty(KeywordUseWpMaskOffset, "Wp Mask Offset");
				ShaderProperty(KeywordUseWpMaskMul, "Wp Mask Multiply");
				ShaderProperty(KeywordUseWpGradientColor, "Wp Gradient Color");
				ShaderProperty(KeywordUseWpColorOffset, "Wp Color Offset");
				ShaderProperty(KeywordUseWpColorMul, "Wp Color Multiply");
			}

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

			//Temperature Properties
			if (GetShaderToggle(KeywordUseHeat, 1))
			{
				SpaceStandard();
				showTemperature = FolderFoldOut(showTemperature, FolderNameTemperature);
				if (showTemperature)
				{
					ShaderProperty(KeywordUseTemperatureMul, "Temperature Multiplier");
					ShaderProperty(KeywordUseTemperatureHardness, "Temperature Hardness");
					ShaderProperty(KeywordUseHeatColor, "Heat Color");
					ShaderProperty(KeywordUseHeatColorMultiplier, "Heat Color Multiplier");
					ShaderProperty(KeywordUseTemperatureMap, "Temperature Map");
					ShaderProperty(KeywordUseTemperatureDirectionMap, "Temperature Direction Map");
					ShaderProperty(KeywordUseTempFlipU, "Flip U");
					ShaderProperty(KeywordUseTempFlipV, "Flip V");
					ShaderProperty(KeywordUseTempRot, "Rotate 90 Degress");
					ShaderProperty(KeywordUseTemperatureInv, "Invert Map");
					ShaderProperty(KeywordUseTemperatureUseCd, "Use Custom Data 1");
					ShaderProperty(KeywordUseTemperatureCustom, "Strength by CD1 Channel (0 - 3)");
					ShaderProperty(KeywordUseTemperatureStrength, "Strength");
					ShaderProperty(KeywordUseTemperatureTrans, "Uv Tiling & Offset");
					ShaderProperty(KeywordUseTemperatureFallOff, "Fall Off");
				}
			}

			//Dissolve Properties
			SpaceStandard();
			showDissolve = FolderFoldOut(showDissolve, FolderNameDissolve);
			if (showDissolve)
			{
				ShaderProperty(KeywordUseDisTex, "Dissolve Ramp");
				ShaderProperty(KeywordUseDisDirMap, "Dissolve Direction Map");
				ShaderProperty(KeywordUseDisFlipU, "Dissolve Flip U");
				ShaderProperty(KeywordUseDisFlipV, "Dissolve Flip V");
				ShaderProperty(KeywordUseDisRot, "Dissolve Rotate 90 Degress");
				ShaderProperty(KeywordUseDisUseAlphaUv, "Dissolve use Alpha Uv");
				ShaderProperty(KeywordUseDisInv, "Dissolve Invert Ramp");
				ShaderProperty(KeywordUseDisUseCd, "Dissolve Use Custom Data 1");
				ShaderProperty(KeywordUseDisCustom, "Dissolve Strength by CD1 Channel (0 - 3)");
				ShaderProperty(KeywordUseDisStrength, "Dissolve Strength");
				ShaderProperty(KeywordUseDisTrans, "Dissolve Uv Tiling & Offset");
				ShaderProperty(KeywordUseDisFallOff, "Dissolve Fall Off");
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
				material.renderQueue = EditorGUILayout.IntField("Render Queue", material.renderQueue);
			}
		}
	}
}
