Shader "InnoGames/VFX/True Color/Particle/Swipe Distortion" {
	Properties {
		_Alpha ("Alpha Texture", 2D) = "white" {}
		_Mask ("Mask ", 2D) = "white" {}
		_useRed ("blend Red Channel", range(0,2)) = 0
		_useGreen ("blend Green Channel", range (0,2)) = 0
		_useBlue ("blend Blue Channel", range (0,2)) = 0
		_DisortionDescription ("-------------Distortion SETUP--------------------------------------------------------------------------------------------------------", Int) =0
		_DistortionTex ("Distortion Texture", 2D) = "gray" {}
		_disHardness ("Dissolve Hardness", Range(1, 10)) = 1
		_offVc ("Disable Vertex Alpha", int )= 0
		[Enum(UnityEngine.Rendering.CompareFunction)] _ZTest ("ZTest", Int) = 4
	}

    Category {

		SubShader {
			Tags {"Queue"="Transparent" "IgnoreProjector"="True" "RenderType"="Transparent"}

			Blend One OneMinusSrcAlpha 
			Lighting Off
			ZWrite OFF
			ZTest [_ZTest]
			Cull off

			Pass {
			   	CGPROGRAM
				#pragma vertex vert
				#pragma fragment frag 
				#include "UnityCG.cginc"
				                
                uniform float4 _Alpha_ST;
               	sampler2D _Alpha;
				uniform float4 _Mask_ST;
               	sampler2D _Mask;
				uniform float _useRed;
				uniform float _useGreen;
				uniform float _useBlue;
				uniform float4 _DistortionTex_ST;
               	uniform sampler2D _DistortionTex;
				uniform float _offVc;
				uniform float _disHardness;
				
				struct appdata {
					float4 Position : POSITION;
					float4 Color : COLOR;
					float4 texcoords : TEXCOORD0;
					float4 texcoords1 : TEXCOORD1;
					float2 texcoords2 : TEXCOORD2;
					float texcoords3 : TEXCOORD3;
				};
                
                struct v2f {
					float4 Position : SV_POSITION;
					float4 Color : COLOR;
					float4 UV : TEXCOORD0;
					float4 UV2 : TEXCOORD1;				    
					float2 UV3 : TEXCOORD2;
					float2 UV4 : TEXCOORD3;
					float2 UV5 : TEXCOORD4;
				};
                
               	v2f vert (appdata v) {
					v2f o;
					//force to world space
					float4 posToWp = mul(UNITY_MATRIX_M,v.Position);

					float2 swipe =  TRANSFORM_TEX(float2(1-v.texcoords.x,v.texcoords.y), _DistortionTex);
					float2 uvTrans = TRANSFORM_TEX(v.texcoords2, _Alpha);
					
					o.Position = UnityObjectToClipPos(posToWp);
					o.Color = float4(v.Color.rgb,lerp(v.texcoords3.x*v.Color.a,v.Color.a,_offVc));
					o.UV = float4(uvTrans.x-swipe.x,uvTrans.y-swipe.y,v.texcoords.z,v.texcoords.w); 
					o.UV2 = v.texcoords1;
					o.UV3 = uvTrans; 
					o.UV4 = TRANSFORM_TEX(v.texcoords2, _DistortionTex);
					o.UV5 = TRANSFORM_TEX(v.texcoords2, _Mask);
					return o;
				}
                
                float4 frag (v2f i) : SV_Target {
					
					float4 disTex = tex2D(_DistortionTex, i.UV4)*i.UV.z;
					float maskTex = tex2D(_Mask, i.UV5).r;
					float4 tex = tex2D(_Alpha,float2(i.UV.x-disTex.y,i.UV.y+disTex.x));
					float channels =(tex.r*_useRed)+(tex.g*_useGreen)+(tex.b*_useBlue);
					float dissolve = saturate((maskTex*_disHardness)+(1-(i.UV.w)));
					float mask = channels*dissolve; 
					
					float burn = saturate(abs(mask)*i.UV2.a);
					float4 texTint = lerp(i.UV2,i.Color,burn);
					return saturate(texTint*mask*i.Color.a); 
				}
				ENDCG
			}
		}
	}
}