Shader "InnoGames/VFX/UI/Image/Fluid" {
   Properties {
              
        [Header(Fluid)][Space(10)][HideInInspector]_MainTex ("MainTex", 2D) = "white" {}
        _Enable ("Enable Shader", int) = 0
        _Fusion ("Fusion Strengh", range(0,2)) = 0.25
        [Header(Shading Properties)][Space(10)]_MainC ("Tint Color", color) = (1,1,1,1)
        _Edge ("Blend Edge", Range (0,1)) = 0
        _EdgeC ("Tint Edge", color) = (1,0,0,0)
        _Glow ("Blend Glow", Range (0,10)) = 0
        _GlowC ("Tint Glow", color) = (0,0,0,0)
        [Header(Animation Properties)][Space(10)]_Swipe ("Swipe Source (X & Y), Target (Z & W)", vector) = (0,0,0,0)       
        _GlowSwipe ("Swipe Glow (X & Y), Direction (Z)",Vector) = (0,0,0,0)
        [Header(Main Texture Properties)][Space(10)][NoScaleOffset]_Source ("Fusion Source", 2D) = "white" {}
        _SourceOffScale ("Offset (X & Y), Scale (Z & W)",Vector) = (0,0,1,1)
        _SourceChannel ("Blend Channel (X & Y & Z)",Vector) = (1,0,0,0)
        [Header(Second Texture Properties)][Space(10)][NoScaleOffset]_Target ("Fusion Target", 2D) = "white" {}
        _TargetOffScale ("Offset (X & Y), Scale (Z & W)",Vector) = (0,0,1,1)
        _TargetChannel ("Blend Channel (X & Y & Z)",Vector) = (1,0,0,0)
        [Header(Glow Properties)][Space(10)][NoScaleOffset]_GlowTex ("Glow Mask", 2D) = "white" {}
        _GlowOffScale ("Offset (X & Y), Scale (Z & W)",Vector) = (0,0,1,1)
        [Header(Render Properties)][Space(10)] _StencilComp ("Stencil Comparison", Float) = 8
        _Stencil ("Stencil ID", Float) = 0
        _StencilOp ("Stencil Operation", Float) = 0
        _StencilWriteMask ("Stencil Write Mask", Float) = 255
        _StencilReadMask ("Stencil Read Mask", Float) = 255
        _ColorMask ("Color Mask", Float) = 15
   }
   
   Category {
       SubShader { 
           Tags {"Queue"="Transparent" "IgnoreProjector"="True" "RenderType"="Transparent"}
           Blend SrcAlpha OneMinusSrcAlpha
           
           Stencil
           {
               Ref [_Stencil]
               Comp [_StencilComp]
               Pass [_StencilOp]
               ReadMask [_StencilReadMask]
               WriteMask [_StencilWriteMask]
           }
                 
           Lighting Off
           ZWrite OFF
           ColorMask [_ColorMask]
           Cull off
             
           Pass {
                CGPROGRAM
                #pragma vertex vert
                #pragma fragment frag
                #include "UnityCG.cginc"

                uniform float4 _MainTex_ST;
                sampler2D _MainTex;
                uniform float _Enable;
                uniform float _Fusion;
                                
                uniform float4 _MainC;
                uniform float _Edge;
                uniform float4 _EdgeC;
                uniform float _Glow;
                uniform float4 _GlowC;

                uniform float4 _Swipe;
                uniform float4 _GlowSwipe;

                uniform float4 _Source_ST;
                sampler2D _Source;
				uniform float4 _SourceOffScale;
                uniform float4 _SourceChannel;
                                
                uniform float4 _Target_ST;
               	sampler2D _Target;
                uniform float4 _TargetOffScale;
                uniform float4 _TargetChannel;
                
                sampler2D _GlowTex;
                uniform float4 _GlowOffScale;
                                                                                                 
                struct appdata {
                   float4 Position : POSITION;
                   float4 Color : COLOR;
                   float2 texcoords : TEXCOORD0;
                   float4 texcoords1 : TEXCOORD1;
                   float4 texcoords2 : TEXCOORD2;
                };
                struct v2f {
                   float4 Position : SV_POSITION;
                   float4 Color : COLOR;
                   float2 UV : TEXCOORD0;
                   float2 UvSource : TEXCOORD1;
                   float2 UvTarget : TEXCOORD2;
                   float2 UvGlow : TEXCOORD3;
                };
               
               v2f vert (appdata v) {
                    v2f o;
                    //get Image Pos and Size
                    float2 getAtlas = float2((v.texcoords.x-v.texcoords1.x)/v.texcoords1.y,(v.texcoords.y-v.texcoords2.x)/v.texcoords2.y);
                    
                    //time
                    float time = _Time.y;
                    
                    //Rotation
					float2 pivot = float2(0.5,0.5);
					float cosAngle = cos(_GlowSwipe.z);
					float sinAngle = sin(_GlowSwipe.z);
					
					float2x2 rot = float2x2(cosAngle, -sinAngle,sinAngle,cosAngle);
					
					//rotation consedering pivot
					float2 piv = getAtlas - pivot;
					getAtlas = mul(rot,piv);
					getAtlas += pivot;
                    
                    
                    float2 uvR = float2(getAtlas.x*_SourceOffScale.z, getAtlas.y*_SourceOffScale.w); 
                    uvR += _SourceOffScale.xy;
                    uvR += frac(float2(time*_Swipe.x,time*_Swipe.y));

                    float2 uvG = float2(getAtlas.x*_TargetOffScale.z, getAtlas.y*_TargetOffScale.w); 
                    uvG += _TargetOffScale.xy;
                    uvG += frac(float2(time*_Swipe.z,time*_Swipe.w));

                    float2 uvGlow = float2(getAtlas.x*_GlowOffScale.z, getAtlas.y*_GlowOffScale.w); 
                    uvGlow += _GlowOffScale.xy;
                    uvGlow += frac(float2(time*_GlowSwipe.x,time*_GlowSwipe.y));

                    o.Position = UnityObjectToClipPos(v.Position);
                    o.Color = v.Color;
                    o.UV =  TRANSFORM_TEX(v.texcoords, _MainTex);
                    o.UvSource =  uvR;
                    o.UvTarget = uvG;
                    o.UvGlow = uvGlow;
                    return o;
               }
               
               float4 frag (v2f i) : SV_Target {
                    float4 tex = tex2D(_MainTex, i.UV);
                                        
                    //Use Channels 
                    float4 source = tex2D(_Source, i.UvSource);
                    float4 target = tex2D(_Target, i.UvTarget);
                    float glowTex = tex2D(_GlowTex, i.UvGlow).r*_Glow;
                                       
                    source *= _SourceChannel;
                    target *= _TargetChannel;
                                        
                    //Make Mask
					float maskSource = saturate(source.r+source.g+source.b)*tex.a;
					float maskTarget = saturate(target.r+target.g+target.b)*tex.a;
					                   
                    //Fusion Effect
					float fusion = saturate(maskSource+maskTarget); 
					float alpha = (saturate(fusion-_Fusion));
					float alphaHard = saturate((alpha*100));
                    
                    //Glow
                    float glow =  saturate(glowTex)*tex.a;

                    // Edge
					bool b = saturate(maskSource+maskTarget) < _Edge;
					float edge = saturate(b*alphaHard);
               //return edge;
                                       
                    //Shading
                    float4 image = (tex*i.Color);
                    image += (glow*_GlowC);
                    float4 col = lerp(image,lerp(image*_MainC,image*_EdgeC,edge),alphaHard); 

                    return lerp(tex*i.Color, col, _Enable);
               }
               ENDCG
           }
       }
   }
}