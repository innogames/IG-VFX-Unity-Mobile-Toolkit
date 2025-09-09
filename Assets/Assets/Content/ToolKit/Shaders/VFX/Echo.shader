Shader "InnoGames/VFX/Specialized/Fake Eco Experimental"
{
    Properties
    {
        _OffsetMin("Offset Min", vector) = (0.0, 0.0, 0.0, 0.0)
        _OffsetMax("Offset Max", vector) = (1.0, 1.0, 1.0, 1.0)
        _Animation("Animation (X = Layers, Y = Min / Max, Z = Opacity)", vector) = (0.0, 0.0, 0.0, 0.0)
    }

    Category
    {
        SubShader
        {

            CGINCLUDE
            float4 _OffsetMin;
              float4 _OffsetMax;
            float4 _Animation;

            #include "UnityCG.cginc"
            #include "SpecializedLibrary/Echo.cg"
            ENDCG
                        Tags
            {
                "Queue"="Transparent" "IgnoreProjector"="True" "RenderType"="Transparent" "LightMode" = "ForwardBase"
            }

            Blend One One ///MinusSrcAlpha

            Pass
            {
                CGPROGRAM
                #pragma vertex vert
                #pragma fragment frag

                struct appdata
                {
                    float4 vertex : POSITION;
                    float4 Color : TEXCOORD1;
                };

                struct v2f
                {
                    float4 vertex : SV_POSITION;
                    half4 Color : COLOR;
                };

                v2f vert(appdata v)
                {
                    v2f o;
                    float4 pos = v.vertex;
                    float opacity;
                    float4 finalpos = OffsetPos(pos, v.Color.a, _OffsetMin.x, _OffsetMax.x, _Animation, opacity);

                    o.vertex = UnityObjectToClipPos(finalpos);
                    o.Color = half4(1.0, 1.0, 1.0, opacity);

                    return o;
                }

                fixed4 frag(v2f i) : SV_Target
                {
                    float opacity = AlphaFragment(i.Color.a);
                    
                    return float4(1.0, 0.0, 0.0, 1.0) * opacity;
                }
                ENDCG
            }

            Pass
            {
                CGPROGRAM
                #pragma vertex vert
                #pragma fragment frag

                struct appdata
                {
                    float4 vertex : POSITION;
                    float4 Color : TEXCOORD1;
                };

                struct v2f
                {
                    float4 vertex : SV_POSITION;
                    half4 Color : COLOR;
                };

                v2f vert(appdata v)
                {
                    v2f o;
                    float4 pos = v.vertex;
                    float opacity;
                    float4 finalpos = OffsetPos(pos, v.Color.a, _OffsetMin.y, _OffsetMax.y, _Animation, opacity);
                    
                    o.vertex = UnityObjectToClipPos(finalpos);
                    o.Color = half4(1.0, 1.0, 1.0, opacity);
                    
                    return o;
                }

                fixed4 frag(v2f i) : SV_Target
                {
                    float opacity = AlphaFragment(i.Color.a);
                   
                    return float4(0.0, 1.0, 0.0, 1.0) * opacity;
                }
                ENDCG
            }

            Pass
            {
                CGPROGRAM
                #pragma vertex vert
                #pragma fragment frag

                struct appdata
                {
                    float4 vertex : POSITION;
                    float4 Color : TEXCOORD1;
                };

                struct v2f
                {
                    float4 vertex : SV_POSITION;
                    half4 Color : COLOR;
                };

                v2f vert(appdata v)
                {
                    v2f o;
                    float4 pos = v.vertex;

                    float opacity;
                    float4 finalpos = OffsetPos(pos, v.Color.a, _OffsetMin.z, _OffsetMax.z, _Animation, opacity);

                    o.vertex = UnityObjectToClipPos(finalpos);
                    o.Color = half4(1.0, 1.0, 1.0, opacity);

                    return o;
                }

                fixed4 frag(v2f i) : SV_Target
                {
                    float opacity = AlphaFragment(i.Color.a);
                    
                    return float4(0.0, 0.0, 1.0, 1.0) * opacity;
                }
                ENDCG
            }
        }
    }
}