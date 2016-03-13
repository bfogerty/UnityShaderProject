Shader "Unlit/CellTest"
{
	Properties
	{
		_RampTex ("Texture", 2D) = "white" {}
		_DiffuseintColor ("Diffuse Tint Color", COLOR) = (1.0, 0.0, 0.0, 1.0)
	}
	SubShader
	{
		Tags { "RenderType"="Opaque" "LightMode" = "ForwardAdd" }
		LOD 100

		Pass
		{
			CGPROGRAM
			#pragma vertex vert
			#pragma fragment frag

			#include "UnityCG.cginc"

			struct appdata
			{
				float4 vertex : POSITION;
				float4 normal : NORMAL;
			};

			struct v2f
			{
				float4 vertex : SV_POSITION;
				float4 position : TEXCOORD0;
			};

			sampler2D _RampTex;
			float4 _RampTex_ST;
			float4 _DiffuseintColor;
			
			v2f vert (appdata v)
			{
				v2f o;
				o.vertex = mul(UNITY_MATRIX_MVP, v.vertex);
				o.position = o.vertex;

				return o;
			}

			float3 hsv2rgb(float3 c) 
			{
				float4 K = float4(1.0, 2.0 / 3.0, 1.0 / 3.0, 3.0);
				float3 p = abs(frac(c.xxx + K.xyz) * 6.0 - K.www);
				return c.z * lerp(K.xxx, clamp(p - K.xxx, 0.0, 1.0), c.y);
			}

			float4 frag (v2f i) : SV_Target
			{
				// sample the texture
				float2 uv = float2( i.position.x/i.position.w, i.position.y/i.position.w );
				uv = uv * 0.5 + 0.5;

				float x = floor( uv.x + 0.5 ) / 8.0;

				float3 col = float3( hsv2rgb(float3(x, 1.0, 1.0) ) );




				return float4( col.r, col.g, col.b, 1.0 );
			}
			ENDCG
		}
	}
}
