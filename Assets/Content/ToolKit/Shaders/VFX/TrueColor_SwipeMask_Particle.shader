Shader "InnoGames/VFX/True Color/Particle/Swipe Mask" {
	Properties {
		_MainTex ("Texture", 2D) = "white" {}
		_Mask ("Mask", 2D) = "white" {}
		_offVc ("Disable Vertex Alpha", int )= 0
		[Enum(UnityEngine.Rendering.CompareFunction)] _ZTest ("Z Test", Int) = 4
	

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
				                
                uniform float4 _MainTex_ST;
               	sampler2D _MainTex;
				uniform float4 _Mask_ST;
               	sampler2D _Mask;
				uniform float _offVc;
        						
				struct appdata {
					float4 Position : POSITION;
					float4 Color : COLOR;
					float4 texcoords : TEXCOORD0;
					float4 texcoords1 : TEXCOORD1;
					float2 texcoords2 : TEXCOORD2;
					float2 texcoords3 : TEXCOORD3;
					float texcoords4 : TEXCOORD4;
					
				};
                
                struct v2f {
					float4 Position : SV_POSITION;
					float4 Color : COLOR;
					float4 UV : TEXCOORD0;
					float4 UV2 : TEXCOORD1;				    
					float2 UV3 : TEXCOORD2;
					float2 UV4 : TEXCOORD3;
					
				};
                               	               
               	v2f vert (appdata v) {
					v2f o;
					//force to world space
					float4 posToWp = mul(UNITY_MATRIX_M,v.Position);

					float swipe =  1-v.texcoords.w;
					float2 uvTrans = TRANSFORM_TEX(v.texcoords2, _Mask);
					
					o.Position = UnityObjectToClipPos(posToWp);
					o.Color = float4(v.Color.rgb,lerp(v.texcoords4.x*v.Color.a,v.Color.a,_offVc));
					o.UV = v.texcoords;
					o.UV2 = v.texcoords1;
					o.UV3 =float2(uvTrans.x-swipe,uvTrans.y);
					o.UV4 = TRANSFORM_TEX(v.texcoords3, _MainTex);
					return o;
				}
                
                float4 frag (v2f i) : SV_Target {
					float4 tex = tex2D(_MainTex, i.UV4);
					float4 mask = tex2D(_Mask, i.UV3);
					float4 cust1 = i.UV;
					float4 cust2 = i.UV2;
					float4 value = float4(tex.r*cust1.r,tex.g*cust1.g,tex.b*cust1.b,1)*mask;
					float col = value.r+value.g+value.b;
					float burn = saturate(abs(col)*i.UV2.a);
					float4 texTint = lerp(cust2,i.Color,burn);
					return saturate(texTint*col*(i.Color.a)); 
				}
				ENDCG
			}
		}
	}
}