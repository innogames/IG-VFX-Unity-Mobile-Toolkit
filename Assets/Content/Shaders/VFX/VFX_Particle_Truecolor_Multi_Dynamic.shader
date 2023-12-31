Shader "InnoGames/VFX/Particle/Multi Dynamic" {
	Properties {
		//Debug Properties
		[Space(25)][Header(DEBUG)][Space(5)][Toggle(DEBUG)]_Debug("Compute Debug Mode", int) = 0
		[Toggle(DEBUG_GLOW)]_DebugGlow("Debug Glow", int) = 0
		[Toggle(DEBUG_COLOR)]_DebugColor("Debug Color", int) = 0
		[Toggle(DEBUG_ALPHA)]_DebugAlpha("Debug Alpha", int) = 0
		[Toggle(DEBUG_VALPHA)]_DebugVAlpha("Debug Vertex Alpha", int) = 0
		[Toggle(DEBUG_MASK)]_DebugMask("Debug Mask", int) = 0
		[Toggle(DEBUG_DIS)]_DebugDis("Debug Dissolve", int) = 0
		[Toggle(DEBUG_DST)]_DebugDist("Debug Distortion", int) = 0
		//Shading Properties
		[Space(5)][Toggle]_GlowRed("Use Red Channel As Glow ", int) = 0
		[Toggle]_GlowGreen("Use Green Channel As Glow ", int) = 0
		[Toggle]_GlowBlue("Use Blue Channel As Glow ", int) = 0
		[Space(20)]_ColorTint("Additive Tint Color", color) = (0.0, 0.0, 0.0, 1.0)
		_ColorAdd("Additve Blend", range(0.0, 1.0)) = 0.0
		[Space(20)][Header(Color Ramp)][Space(5)]_RampColor("Second Color", color) = (1.0, 1.0, 1.0, 1.0)
		_RampBlend("Ramp Blend", vector) = (1.0, 1.0, 1.0, 1.0)
		_RampOffset("Ramp Offset", vector) = (0.0, 0.0, 0.0, 0.0)
		_RampSet("Ramp Multiplier", vector)  = (1.0, 1.0, 0.0, 0.0)
		//Alpha Properties
		[Space(5)][Toggle]_AlphaFlipU("Uv Flip U", int) = 0
		[Toggle]_AlphaFlipV("Uv Flip V", int) = 0
		[Toggle]_AlphaRotate("Uv Rotate 90 Degrees", int) = 0
		[Toggle]_AlphaSwirlInv("Invert Swirl", int) = 0
		_AlphaSwirl("Swirl Direction U", range(-1, 1)) = 0
		_AlphaBlendChannels("Blend Channels (X = Red, Y = Green, Z = Blue, W = Not In Use)", vector) = (1.0, 0.0, 0.0, 0.0)
		_AlphaTrans("Transform (X Custom Data 1.y, Y Tiling, Z & W Offset)", vector) = (1.0, 1.0, 0.0, 0.0)
		[NoScaleOffset]_AlphaTex ("Texture Pack", 2D) = "white" {}
		//Mask Properties
		[Space(5)]
		[Toggle]_MaskFlipU("Uv Flip U", int) = 0
		[Toggle]_MaskFlipV("Uv Flip V", int) = 0
		[Toggle]_MaskRotate("Uv Rotate 90 Degrees", int) = 0
		[Toggle]_MaskStretchU("Overwrite Custom Data X for Stretch", int) = 0
		[Toggle]_MaskSwipeU("Overwrite Custom Data Y for Swipe", int) = 1
		[Toggle]_MaskSyncAlpha("Sync with Alpha", int) = 0
		_MaskTrans("Transform (X & Y Tiling, Z Custom Data 1 Y, W Offset)", vector) = (1.0, 1.0, 0.0, 0.0)
		[NoScaleOffset]_MaskTex ("Mask", 2D) = "white" {}
		//Dissolve Properties
		[Space(5)][Toggle]_DisFlipU("Uv Flip U", int) = 0
		[Toggle]_DisFlipV("Uv Flip V", int) = 0
		[Toggle]_DisRotate("Uv Rotate 90 Degrees", int) = 0
		[Toggle]_DisInvert ("Invert", int )= 0
		_DisFallOff ("Fall Off", Range(1, 10)) = 1
		_DisTrans("Transform (X & Y Tiling, Z & W Offset)", vector) = (1.0, 1.0, 0.0, 0.0)
		[NoScaleOffset]_DisTex ("Ramp", 2D) = "gray" {}
		//Distortion Properties
		[Space(5)]
		[Toggle]_DistAlpha("Enbale for Alpha", int) = 0
		[Toggle]_DistDis("Enbale for Dissolve", int) = 0
		[Toggle]_DistMask("Enbale for Mask", int) = 0
		_DistTrans("Transform (X & Y Tiling, Z & W Offset)", vector) = (1.0, 1.0, 0.0, 0.0)
		[NoScaleOffset]_DistTex ("Distortion Map", 2D) = "gray" {}
		//Render Properties
		[Space(5)][Header(Vertex Input)][Space(5)][Toggle]_OffVc("Disable Vertex Alpha", int ) = 0
		[Enum(UnityEngine.Rendering.CullMode)]_Cull("Cull Mode", Int) = 4
		[Space(5)][Header(Stencil Buffer)][Space(5)]_StencilMask("Stencil Mask", Int) = 0
        [Enum(UnityEngine.Rendering.CompareFunction)]_StencilComp("Stencil Compare", int) = 0
        [Enum(UnityEngine.Rendering.StencilOp)]_StencilPass("Stencil Pass", int) = 0
        _StencilWrite("Stencil Write", Int) = 0
        _StencilRead("Stencil Read", Int) = 0
		[Space(5)][Header(Depth Buffer)][Space(5)][Enum(UnityEngine.Rendering.CompareFunction)] _ZTest ("ZTest", Int) = 4
		[Enum(Off,0,On,1)]_ZWrite("Z Write", Int) = 0
		
	}

    Category {

		SubShader {
			CGINCLUDE
				sampler2D _AlphaTex;
				sampler2D _DisTex;
				sampler2D _MaskTex;
				sampler2D _DistTex;

				uniform float4 _AlphaTrans;
				uniform half4 _AlphaBlendChannels;
				uniform half _AlphaRotate;
				uniform half _AlphaFlipU;
				uniform half _AlphaFlipV;
				uniform half _MaskSwipeU;
				uniform half _MaskStretchU;
				uniform half _AlphaSwirl;
				uniform half _AlphaSwirlInv;
				uniform float4 _DisTrans;
               	uniform half _DisRotate;
				uniform half _DisFlipU;
				uniform half _DisFlipV;
				uniform half _GlowRed;
				uniform half _GlowGreen;
				uniform half _GlowBlue;
				uniform float4 _MaskTrans;
				uniform half _MaskRotate;
				uniform half _MaskFlipU;
				uniform half _MaskFlipV;
				uniform half _MaskSyncAlpha;
				uniform float4 _DistTrans;
				uniform half _DisRotateDist;
				uniform half _DisFlipUDist;
				uniform half _DisFlipVDist;
				uniform half _DistAlpha;
				uniform half _DistDis;
				uniform half _DistMask;
				uniform half4 _ColorTint;
				uniform half _ColorAdd;
				uniform half4 _RampColor;
				uniform half4 _RampBlend;
				uniform half4 _RampOffset;
				uniform half4 _RampSet;
				uniform half _DisFallOff;
				uniform half _DisInvert;
				uniform half _OffVc;
			ENDCG
			
			Tags {"Queue"="Transparent" "IgnoreProjector"="True" "RenderType"="Transparent"}

			Blend One OneMinusSrcAlpha 
			Lighting Off
			ZWrite [_ZWrite]
			ZTest [_ZTest]
			Cull [_Cull]

			Pass {

				Stencil{
					Ref[_StencilMask]
					Comp Always
					Pass Replace
					ReadMask [_StencilMask]
				}

			   	CGPROGRAM
				#pragma vertex vert
				#pragma fragment frag
			   	#include "UnityCG.cginc"

			   	//Fx Functions
			   	#include "Global_Functions/AlphaVertex.cg"
			   	#include "Global_Functions/BlendTextChannelFragment.cg"
			   	#include "Global_Functions/DissolveFragment.cg"
			   	#include "Global_Functions/UvAdvancedTransformVertex.cg"
			   	#include "Global_Functions/Invert.cg"
			   	#include "Global_Functions/TrueColorFragment.cg"
			   	#include "Global_Functions/DistortionFragment.cg"

			   	#pragma shader_feature_local __ DEBUG
			   	#pragma shader_feature_local __ DEBUG_GLOW
			   	#pragma shader_feature_local __ DEBUG_COLOR
                #pragma shader_feature_local __ DEBUG_ALPHA
			   	#pragma shader_feature_local __ DEBUG_VALPHA
                #pragma shader_feature_local __ DEBUG_MASK
                #pragma shader_feature_local __ DEBUG_DIS
                #pragma shader_feature_local __ DEBUG_DST
               			        						
				struct appdata {
					float4 Position : POSITION;
					half4 Color : COLOR;
					float4 texcoords : TEXCOORD0;
					float4 texcoords1 : TEXCOORD1;
					float2 texcoords2 : TEXCOORD2;
					half texcoords3 : TEXCOORD3;
				};
                
                struct v2f {
					float4 Position : SV_POSITION;
					half4 Color : COLOR;
					half4 CustomData1 : TEXCOORD0;
					half4 CustomData2 : TEXCOORD1;				    
					float2 Alpha : TEXCOORD2;
					float2 Dissolve : TEXCOORD3;
					float2 Mask : TEXCOORD4;
					float2 Distortion : TEXCOORD5;
                	float Ramp : TEXCOORD6;
				};
  
				v2f vert (appdata v) {
					v2f o;
					//force to world space
					float4 posToWp = mul(unity_ObjectToWorld, v.Position);

                	//Uv Ramp
                	float4 rampChannels = (float4(v.texcoords2.x, 1 - v.texcoords2.x, v.texcoords2.y, 1 - v.texcoords2.y) * _RampBlend) + _RampOffset;
					float ramp =   rampChannels.x + rampChannels.y + rampChannels.z + rampChannels.w;
					ramp = pow(saturate(abs(ramp)), _RampSet.x);
                	ramp *= _RampSet.y;
                	ramp += _RampSet.z;
                	ramp = saturate(ramp);
                  	
					//Swizzles Custom Data with Tranforms
                	float4 transTex = float4(lerp( v.texcoords.x, _AlphaTrans.x, _MaskStretchU), _AlphaTrans.y, lerp(v.texcoords.y, _AlphaTrans.z, _MaskSwipeU), _AlphaTrans.w);
					float4 transMask = float4(lerp(_MaskTrans.x, v.texcoords.x, _MaskStretchU), _MaskTrans.y, lerp( _MaskTrans.z, v.texcoords.y, _MaskSwipeU), _MaskTrans.w);
					float4 transDst = float4(v.texcoords1.x, _DistTrans.y, v.texcoords1.y, _DistTrans.w);
					                	
					o.Position = UnityObjectToClipPos(posToWp);
					o.Color = AlphaVertex(v.Color, v.texcoords3);
					#if DEBUG
						#if DEBUG_VALPHA
							o.Color = float4(v.texcoords3, 0.0, 0.0, 1.0);
						#endif
					#endif
					o.CustomData1 = v.texcoords;
					o.CustomData2 = v.texcoords1;
					o.Alpha = UvTransform(UvManipulation(float2(lerp(v.texcoords2.x, v.texcoords2.x + _AlphaSwirl,  InvertFloat(v.texcoords2.y, _AlphaSwirlInv)), v.texcoords2.y), _AlphaFlipU, _AlphaFlipV, _AlphaRotate), transTex);
					o.Dissolve = UvTransform(UvManipulation(v.texcoords2, _DisFlipU, _DisFlipV, _DisRotate), _DisTrans);
					o.Mask = lerp(UvTransform(UvManipulation(v.texcoords2, _MaskFlipU, _MaskFlipV, _MaskRotate), transMask), o.Alpha, _MaskSyncAlpha);
					o.Distortion = UvTransform(v.texcoords2, transDst);
                	o.Ramp= ramp;
					return o;
				}
                
                half4 frag (v2f i) : SV_Target {
                	#if DEBUG
                		#if DEBUG_VALPHA
                			return i.Color;
                		#endif
                	#endif

                	//Distortion
					float2 motionTex = tex2D(_DistTex, i.Distortion).rg;
					float2 distortion = SimpleDistortionFragment(motionTex, i.CustomData2.z);
                	#if DEBUG
                		#if DEBUG_DST
                			return float4(motionTex.xy, 0.0, 1.0);
                		#endif
                	#endif

					half maskTex = tex2D(_MaskTex, i.Mask + (distortion * _DistMask)).r;
					#if DEBUG
                		#if DEBUG_MASK
                			return maskTex;
                		#endif
                	#endif
                	
                	half4 tex = tex2D(_AlphaTex, i.Alpha + (distortion * _DistAlpha));
                	half4 cust2 = ((i.Color + _ColorAdd) * _ColorTint) ;
					half3 glow = tex.rgb * (half3(_GlowRed, _GlowGreen, _GlowBlue) * i.CustomData1.z);
					#if DEBUG
                		#if DEBUG_GLOW
                			return half4(glow, 1.0);  
                		#endif
                	#endif

                	half alpha = BlendTexChannelFragment(tex.rgb,_AlphaBlendChannels.rgb);
					#if DEBUG
                		#if DEBUG_ALPHA
                			return half4(alpha.xxx, 1.0); 
                		#endif
                	#endif
                	alpha += glow.r + glow.g + glow.b;

                	//dissolve function & Uv link to Particle Custom Data & Amplitude control 
					half dissolve = tex2D(_DisTex, i.Dissolve + (distortion * _DistDis)).r;
					#if DEBUG
                		#if DEBUG_DIS
                			return half4(dissolve.xxx, 1.0);
                		#endif
                	#endif
                	
                	half mask = DissolveFragment(dissolve, _DisInvert, _DisFallOff, i.CustomData1.w);
                	#if DEBUG
                		#if DEBUG_MASK
                			return half4(mask.xxx, 1.0);;
                		#endif
                	#endif

                	half4 texTint = TrueColorFragment(i.Color, cust2, alpha * i.CustomData2.w);
					#if DEBUG
                		#if DEBUG_COLOR
                			return lerp(_RampColor, texTint, i.Ramp);
                		#endif
                	#endif

                	return saturate(lerp(_RampColor, texTint, i.Ramp) * alpha * i.Color.a * mask * maskTex);
                }
				ENDCG
			}
		}
    	CustomEditor "InnoGames.VFX.Game.Editor.VFX_ShaderGUI_Particle_Truecolor_Multi_Dynamic"
	}
}