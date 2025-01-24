Shader "InnoGames/VFX/UI/Image/Glitch"
{
    Properties
    {
        //Texture Properties
        [HideInInspector]_MainTex ("MainTex", 2D) = "white" {}
        [Header (JITTER)][Space(10)]
        _DisStrength ("Jittering Amplitude", range (0,1)) = 0
        _GlitchY ("Jittering Frequency", range (-20,20)) = 0
        [HideInInspector][Toggle]_InvMask ("Invert Mask", int) = 0
        [Header (DISTORTION)][Space(10)]
        _GlitchX ("Distortion Frequency", range (-20,20)) = 0
        _DisX ("Distortion Speed X", range (-10,10)) = 0
        _DisY ("Distortion Speed Y", range (-10,10)) = 0
        [Header (COLOR)][Space(10)]
        [Toggle] _EnableTint ("Enable Tint", int) = 0
        _TintStrength ("Tint Strength", range(0, 1)) = 0
        _GlitchBlend ("Flickering Frequency", range (0,100)) = 0
        _MulOrAdd ("Multiply or Add Tint Texture", range (0, 1)) = 1
        _Desaturation ("Desaturation Strength", range (0,1)) = 0
        [Header (TEXTURE)][Space(10)]_DistortionTex ("Distortion Texture", 2D) = "gray" {}
        _Mask ("Mask Distortion", 2D) = "white" {}
        [NoScaleOffset] _TintTex ("Tint Texture", 2D) = "gray" {}
        //Render Properties
        [Space(150)]_StencilComp ("Stencil Comparison", Float) = 8
        _Stencil ("Stencil ID", Float) = 0
        _StencilOp ("Stencil Operation", Float) = 0
        _StencilWriteMask ("Stencil Write Mask", Float) = 255
        _StencilReadMask ("Stencil Read Mask", Float) = 255
        _ColorMask ("Color Mask", Float) = 15
    }
    Category
    {
        SubShader
        {
            Tags
            {
                "Queue"="Transparent" "IgnoreProjector"="True" "RenderType"="Transparent"
            }
            Lighting Off
            ZWrite OFF
            Cull off
            
            Stencil
            {
                Ref [_Stencil]
                Comp [_StencilComp]
                Pass [_StencilOp]
                ReadMask [_StencilReadMask]
                WriteMask [_StencilWriteMask]
            }

            Pass
            {
                CGPROGRAM
                #pragma vertex vert
                #pragma fragment frag
                #include "UnityCG.cginc"

                uniform float4 _MainTex_ST;
                uniform sampler2D _MainTex;
                uniform float4 _DistortionTex_ST;
                uniform sampler2D _DistortionTex;
                uniform float4 _Mask_ST;
                uniform sampler2D _Mask;
                uniform half _InvMask;
                uniform sampler2D _TintTex;
                uniform half _DisStrength;
                uniform half _DisX;
                uniform half _DisY;
                uniform half _Desaturation;
                uniform half _MulOrAdd;
                uniform half _EnableTint;
                uniform half _TintStrength;
                uniform half _GlitchX;
                uniform half _GlitchY;
                uniform half _GlitchBlend;

                float4 _ClipRect;

                struct appdata
                {
                    float4 Position : POSITION;
                    half4 Color : COLOR;
                    float2 texcoords : TEXCOORD0;
                    float4 texcoords1 : TEXCOORD1;
                    float4 texcoords2 : TEXCOORD2;
                };

                struct v2f
                {
                    float4 Position : SV_POSITION;
                    half4 Color : COLOR;
                    float4 UV : TEXCOORD0;
                    float2 UV2 : TEXCOORD1;
                    half Time : TEXCOORD3;
                };

                v2f vert(appdata v)
                {
                    v2f o;
                    float time = _Time.y;
                    float disX = frac(time * _DisX);
                    float disY = frac(time * _DisY);
                    float2 uvAtlas = v.texcoords;

                    float2 uvDis = TRANSFORM_TEX(uvAtlas, _DistortionTex);
                    float2 uvTrans = TRANSFORM_TEX(uvAtlas, _MainTex);

                    float2 uvSwipe = float2(uvDis.x - disX.x, uvDis.y - disY);
                    uvSwipe.y *= floor((abs((cos(time))) + 0.5) * _GlitchX);
                    uvSwipe.x *= ceil(abs((sin(time))) + 0.1) * _GlitchX;
                    uvSwipe.y += (sin(time * _GlitchY) + 1);

                    o.Position = UnityObjectToClipPos(v.Position);
                    o.Color = v.Color;
                    o.UV = float4(uvSwipe, uvTrans);
                    o.UV2 = uvTrans;
                    o.Time = time;
                   
                    return o;
                }

                half4 frag(v2f i) : SV_Target
                {
                    half mask = tex2D(_Mask, i.UV.xy).r;
                    float4 disTex = tex2D(_DistortionTex, i.UV.xy);
                    float2 uv = i.UV.zw + (disTex - 0.5) * (_DisStrength * (lerp(mask, 1 - mask, _InvMask)));
 
                    half4 tex = tex2D(_MainTex, uv);
                    half4 tintTex = tex2D(_TintTex, i.UV.xy) * _TintStrength;
                    half grayTex = (tex.r * 0.25) + (tex.g * 0.25) + (tex.b * 0.25);
                    half4 desaturate = lerp(tex, grayTex, _Desaturation);
                    half4 tint = lerp(desaturate * tintTex, desaturate + tintTex, _MulOrAdd * (sin(i.Time * _GlitchBlend) + 2));
                    half4 color = lerp(tex, tint, _EnableTint);

                    return color;
                }
                ENDCG
            }
        }
    }
}