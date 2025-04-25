Shader "Custom/WaveVertex"
{
    Properties
    {
        _MainTex ("Main Texture", 2D) = "white" {}
        _NoiseTex ("Noise Texture", 2D) = "white" {}
        _Color ("Color", Color) = (1,1,1,1)
        _Scale ("Noise Scale", Range(0.01, 1.0)) = 0.1
        _Amplitude ("Amplitude", Range(0.01, 1.0)) = 0.1
        _Speed ("Speed", Range(0.0, 2.0)) = 1.0
    }

    SubShader
    {
        Tags { "RenderType" = "Opaque" }
        LOD 200

        Pass
        {
            Tags { "Queue"="Transparent" "RenderType"="Transparent" }
            Blend SrcAlpha OneMinusSrcAlpha
            ZWrite Off
            CGPROGRAM
            #pragma vertex vert
            #pragma fragment frag
            #include "UnityCG.cginc"

            sampler2D _MainTex;
            sampler2D _NoiseTex;
            float4 _Color;
            float _Scale;
            float _Amplitude;
            float _Speed;
            float4 _MainTex_ST;

            struct appdata
            {
                float4 vertex : POSITION;
                float2 uv : TEXCOORD0;
            };

            struct v2f
            {
                float2 uv : TEXCOORD0;
                float4 vertex : SV_POSITION;
            };

            v2f vert (appdata v)
            {
                 v2f o;

                // Position monde (pour pouvoir faire l'effet basé sur distance)
                float3 worldPos = mul(unity_ObjectToWorld, v.vertex).xyz;

                // Calculer la position relative au centre (assume que le centre est en (0,0,0))
                float2 centerOffset = worldPos.xz; // XZ pour un plane à l’horizontale

                float distToCenter = length(centerOffset);

                // Générer l'onde en fonction de la distance
               float wave = sin(((worldPos.x + worldPos.z) - _Time.y * _Speed) * 4.0);
                float noise = tex2Dlod(_NoiseTex, float4(v.uv * _Scale, 0, 0)).r;


                // Appliquer la déformation
                v.vertex.y += wave * _Amplitude * noise;

                o.vertex = UnityObjectToClipPos(v.vertex);
                o.uv = TRANSFORM_TEX(v.uv, _MainTex);
                return o;
            }


            fixed4 frag(v2f i) : SV_Target
            {
                fixed4 col = tex2D(_MainTex, i.uv) * _Color;
                col.a *= 1; // Ex: réduire l'opacité à 50%
                return col;
            }
            ENDCG
        }
    }
}
