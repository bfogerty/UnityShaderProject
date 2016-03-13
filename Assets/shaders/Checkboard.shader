Shader "Unlit/Checkboard"
{
	Properties
	{
		
	}

	SubShader
	{
		Tags { "RenderType"="Opaque" }
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
				float2 p = i.uv * 2.0 - 1.0;

				float3 finalColor = float3(p.x, p.x, p.x);
				
				return float4( finalColor, 1.0 );
			}
			ENDCG
		}
	}
}
