Shader "InnoGames/VFX/UI/Image/Shine"
{
    Properties
    {
        //Shading Properties
        [HideInInspector]_MainTex ("MainTex", 2D) = "white" {}
        [Header(IMAGE SHINE)][Space(5)]
        [Toggle]_Enable ("Enable Shine", int) = 0
        [Toggle]_EnableTransparency("Enable Transparency", int) = 0
        [Space(25)][Header(SHADING PROPERTIES)][Space(5)]
        _GlowC ("Tint Glow", color) = (0.0, 0.0, 0.0, 0.0)
        _Glow ("Blend Glow", range (0,10)) = 0.0
        //Animation Properties
        [Space(25)][Header(ANIMATION PROPERTIES)][Space(5)]_AnimationDelay ("Animation Delay", range(1.0, 10.0)) = 1.0
        [Header(Swipe X and Y. Direction Z)][Space(5)]_GlowSwipe ("Animation", vector) = (0.0, 0.0, 0.0 ,0.0)
        //Texture Properties
        [Space(25)][Header(TEXTURE PROPERTIES)][Space(5)]
        [NoScaleOffset]_GlowTex ("Glow Mask", 2D) = "white" {}
        _GlowOffScale ("Tiling (X & Y), Offset (Z & W)", vector) = (0.5, 1.0, -0.5, 0.0)
        //Render Properties
        [Space(25)][Header(RENDER PROPERTIES)][Space(5)]_StencilComp ("Stencil Comparison", float) = 8.0
        _Stencil ("Stencil ID", float) = 0.0
        _StencilOp ("Stencil Operation", float) = 0.0
        _StencilWriteMask ("Stencil Write Mask", float) = 255.0
        _StencilReadMask ("Stencil Read Mask", float) = 255.0
        _ColorMask ("Color Mask", float) = 15.0
    }

    Category
    {
        SubShader
        {
            Tags
            {
                "Queue"="Transparent" "IgnoreProjector"="True" "RenderType"="Transparent"
            }
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

            Pass
            {
                CGPROGRAM
                #pragma vertex vert
                #pragma fragment frag
                #include "UnityCG.cginc"

                uniform half4 _MainTex_ST;
                sampler2D _MainTex;
                uniform half _Enable;
                uniform half _AnimationDelay;
                uniform half _Glow;
                uniform half4 _GlowC;
                uniform float4 _GlowSwipe;
                sampler2D _GlowTex;
                uniform float4 _GlowOffScale;
                uniform half4 _ClipRect;
                uniform half _EnableTransparency;

                struct appdata
                {
                    float4 Position : POSITION;
                    float4 Color : COLOR;
                    float2 texcoords : TEXCOORD0;
                    float4 texcoords1 : TEXCOORD1;
                    float4 texcoords2 : TEXCOORD2;
                };

                struct v2f
                {
                    float4 Position : SV_POSITION;
                    half4 Color : COLOR;
                    float2 UV : TEXCOORD0;
                    float2 UvGlow : TEXCOORD1;
                    float4 worldPosition : TEXCOORD2;
                };

                v2f vert(appdata v)
                {
                    v2f o;
                    //Get image pos and size
                    float2 getAtlas = float2((v.texcoords.x - v.texcoords1.x) / v.texcoords1.y, (v.texcoords.y - v.texcoords2.x) / v.texcoords2.y);
                     
                    //Time
                    float time = _Time.y;
                    
                    //Uv rotation
                    float2 pivot = float2(0.5, 0.5);
                    float cosAngle = cos(_GlowSwipe.z);
                    float sinAngle = sin(_GlowSwipe.z);

                    float2x2 rot = float2x2(cosAngle, -sinAngle, sinAngle, cosAngle);

                    //Rotation consedering pivot.
                    float2 piv = getAtlas + pivot;
                    getAtlas = mul(rot, piv);
                    getAtlas += pivot;

                    //Tiling / offset uv.
                    float2 uvGlow = float2(getAtlas.x * _GlowOffScale.x, getAtlas.y * _GlowOffScale.y);
                    uvGlow += _GlowOffScale.zw;
                    uvGlow += clamp(frac(_GlowSwipe.xy * time * (1.0 / _AnimationDelay)) * _AnimationDelay, 0.0, 1.0);

                    o.Position = mul(unity_MatrixVP, mul(unity_ObjectToWorld, v.Position));
                    o.Color = v.Color;
                    o.UV = TRANSFORM_TEX(v.texcoords, _MainTex);
                    o.UvGlow = uvGlow;
                    o.worldPosition = v.Position;
                    
                    return o;
                }

                half4 frag(v2f i) : SV_Target
                {
                    half4 color;
                    half4 tex = tex2D(_MainTex, i.UV) * i.Color;
                    half glowTex = tex2D(_GlowTex, i.UvGlow).r * _Glow;

                    color.rgb = lerp(tex.rgb, tex.rgb + tex.rgb + (_GlowC.rgb * glowTex), glowTex);
                    color.a = tex.a * lerp(1.0, glowTex, _EnableTransparency);

                   return lerp(tex, color, _Enable);
                }
                ENDCG
            }
        }
    }
}