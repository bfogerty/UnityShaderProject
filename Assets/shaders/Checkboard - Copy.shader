Shader "Unlit/Checkboard"
{
	Properties
	{
		_AspectRatio("Aspect Ratio", FLOAT) = 1
	}

		SubShader
	{
		Tags { "RenderType" = "Opaque" }
		LOD 100

		Pass
		{
			CGPROGRAM
			#pragma vertex vert
			#pragma fragment frag

			#include "UnityCG.cginc"

			float _AspectRatio;

			struct appdata
			{
				float4 vertex : POSITION;
				float2 uv : TEXCOORD0;
			};

			struct v2f
			{
				float4 vertex : SV_POSITION;
				float2 uv : TEXCOORD0;
			};
			
			v2f vert (appdata v)
			{
				v2f o;
				o.vertex = mul(UNITY_MATRIX_MVP, v.vertex);
				o.uv = v.uv;
				
				return o;
			}
			
			float4 frag (v2f i) : SV_Target
			{
				float2 uv = i.uv;
				uv.x *= _AspectRatio;

				float scale = 10.0;
				float d = floor(fmod(floor(uv.x * scale) + floor(uv.y * scale), 2.0));

				float3 finalColor = float3(d, d, d);
				
				return float4( finalColor, 1.0 );
			}
			ENDCG
		}
	}
}
