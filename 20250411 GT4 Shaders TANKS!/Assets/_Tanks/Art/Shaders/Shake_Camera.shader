Shader "Hidden/ShakeEffect"
{
    SubShader
    {
        Tags { "RenderType" = "Opaque" }
        Pass
        {
            ZTest Always Cull Off ZWrite Off

            CGPROGRAM
            #pragma vertex vert
            #pragma fragment frag
            #include "UnityCG.cginc"

            sampler2D _MainTex;
            float4 _MainTex_TexelSize;
            float _ShakeIntensity;
            float _ShakeSpeed;
            float _ShakeTime;


            struct MyVertexData {
                float4 vertex : POSITION;
                float2 uv : TEXCOORD0;
            };

            struct v2f {
                float2 uv : TEXCOORD0;
                float4 vertex : SV_POSITION;
            };

            v2f vert(MyVertexData v)
            {
                v2f o;
                o.vertex = UnityObjectToClipPos(v.vertex);
                o.uv = v.uv;
                return o;
            }

            fixed4 frag(v2f i) : SV_Target
            {
                float shakeX = sin(_ShakeTime * _ShakeSpeed) * _ShakeIntensity;
                float shakeY = cos(_ShakeTime * _ShakeSpeed * 1.2) * _ShakeIntensity;

                float2 shakenUV = i.uv + float2(shakeX, shakeY);
                return tex2D(_MainTex, shakenUV);
            }
            ENDCG
        }
    }
}
