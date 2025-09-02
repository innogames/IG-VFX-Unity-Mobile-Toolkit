Shader "InnoGames/VFX/True Color/Particle/Distortion" {
	Properties {
		_alpha ("Alpha Texture", 2D) = "white" {}
		_Mask ("Mask Texture", 2D) = "white" {}
		_invMask ("Invert Mask", int) = 0
		_useRed ("Blend Red Channel", range(0,10)) = 0
		_useGreen ("Blend Green Channel", range (0,10)) = 0
		_useBlue ("Blend Blue Channel", range (0,10)) = 0
		[Header(Distortion Properties)]
		_DistortionTex ("Distortion Map", 2D) = "gray" {}
		_offVc ("Disable Vertex Alpha", int )= 0
		[Enum(UnityEngine.Rendering.CompareFunction)] _ZTest ("Z Test", Int) = 4
	
	}

    Category {

		SubShader {
			Tags {"Queue"="Transparent" "IgnoreProjector"="True" "RenderType"="Transparent"}

			Blend One OneMinusSrcalpha 
			Lighting Off
			ZWrite OFF
			ZTest [_ZTest]
			Cull off

			Pass {
			   	CGPROGRAM
				#pragma vertex vert
				#pragma fragment frag 
				#include "UnityCG.cginc"
				                
                uniform float4 _alpha_ST;
               	sampler2D _alpha;
				uniform float4 _Mask_ST;
               	sampler2D _Mask;
				uniform float _useRed;
				uniform float _useGreen;
				uniform float _useBlue;
				uniform float4 _DistortionTex_ST;
               	uniform sampler2D _DistortionTex;
				uniform float _offVc;
				uniform float _invMask;
				
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
					float2 UV : TEXCOORD0;
					float4 UV2 : TEXCOORD1;				    
					float2 UV3 : TEXCOORD2;
					float2 UV4 : TEXCOORD3;
					float UV5 : TEXCOORD4;
					float2 UV6 : TEXCOORD5;
				};
                
               	v2f vert (appdata v) {
					v2f o;
					//force to world space
					float4 posToWp = mul(UNITY_MATRIX_M,v.Position);

					float2 swipe =  TRANSFORM_TEX(float2(1-v.texcoords.x,v.texcoords.y), _DistortionTex);
					float2 uvTrans = TRANSFORM_TEX(v.texcoords2, _alpha);
					
					o.Position = UnityObjectToClipPos(posToWp);
					o.Color = float4(v.Color.rgb,lerp(v.texcoords3.x*v.Color.a,v.Color.a,_offVc));
					o.UV = float2(uvTrans.x-swipe.x,uvTrans.y-swipe.y); 
					o.UV2 = v.texcoords1;
					o.UV3 = uvTrans; 
					o.UV4 = v.texcoords2; 
					o.UV5 = float(v.texcoords.z);
					o.UV6 = TRANSFORM_TEX(v.texcoords2, _Mask); 
					return o;
				}
                
                float4 frag (v2f i) : SV_Target {
					
					//distortion function & Uv link to Particle Custom Data 
					float alphaTex = tex2D(_Mask,i.UV6).r;
					float alpha = lerp(alphaTex,1-alphaTex,_invMask);
					float4 disTex = tex2D(_DistortionTex, float2(i.UV.x,i.UV.y))*alpha*i.UV5.x;
									
					float4 tex = tex2D(_alpha,float2(i.UV3.x-disTex.r,i.UV3.y+disTex.g));
					float4 cust2 = i.UV2;
					float mask =(tex.r*_useRed)+(tex.g*_useGreen)+(tex.b*_useBlue);
					float col = mask*alpha;
                	
					float burn = saturate(abs(col)*i.UV2.a);
					float4 texTint = lerp(cust2,i.Color,burn);
					return saturate(texTint*col*i.Color.a); 
				}
				ENDCG
			}
		}
	}
}