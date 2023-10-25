Shader "InnoGames/VFX/UI/Image/Desaturation"
{
    Properties
    {
        [HideInInspector]_MainTex ("MainTex", 2D) = "white" {}
        [Header(IMAGE DESATURATION)][Space(5)]
        _Strength("Strength", range(0.0, 1.0)) = 0.0
        _Channels("Source Texture Channels", vector) = (0.25, 0.25, 0.25, 0.0)
        //Render Properties
        [Space(25)][Header(RENDER PROPERTIES)][Space(5)]_StencilComp ("Stencil Comparison", Float) = 8.0
        _Stencil ("Stencil ID", Float) = 0.0
        _StencilOp ("Stencil Operation", Float) = 0.0
        _StencilWriteMask ("Stencil Write Mask", Float) = 255.0
        _StencilReadMask ("Stencil Read Mask", Float) = 255.0
        _ColorMask ("Color Mask", Float) = 15.0
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
                uniform sampler2D _MainTex;
                uniform half _Strength;
                uniform half4 _Channels;
                uniform float4 _ClipRect;

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
                    float4 worldPosition : TEXCOORD1;
                };

                v2f vert(appdata v)
                {
                    v2f o;
                    float2 getAtlas = float2((v.texcoords.x - v.texcoords1.x) / v.texcoords1.y, (v.texcoords.y - v.texcoords2.x) / v.texcoords2.y);
                    float2 uvTrans = TRANSFORM_TEX(v.texcoords, _MainTex);

                    o.Position = UnityObjectToClipPos(v.Position);
                    o.Color = v.Color;
                    o.UV = uvTrans;
                    o.worldPosition = v.Position;
                    return o;
                }

                half4 frag(v2f i) : SV_Target
                {
                    half4 tex = tex2D(_MainTex, i.UV);
                    half3 channels = tex.rgb * _Channels.rgb;
                    half gray = channels.r + channels.g + channels.r;
                    half3 col = lerp(tex.rgb, gray, _Strength);

                    return half4(col, tex.a);
                }
                ENDCG
            }
        }
    }
}