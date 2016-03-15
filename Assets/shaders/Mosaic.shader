Shader "Unlit/Mosaic"
{
	Properties
	{
		_AspectRatio("Aspect Ratio", FLOAT) = 1
		_Resolution("Resolution", FLOAT) = 40
		_SrcTex("Source Texture", 2D) = "white" {}
	}

		SubShader
	{
		Tags{ "RenderType" = "Opaque" }
		LOD 100

		Pass
	{
		CGPROGRAM
#pragma vertex vert
#pragma fragment frag

#include "UnityCG.cginc"

	float _AspectRatio;
	float _Resolution;
	sampler2D _SrcTex;

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

	v2f vert(appdata v)
	{
		v2f o;
		o.vertex = mul(UNITY_MATRIX_MVP, v.vertex);
		o.uv = v.uv;

		return o;
	}

	float4 frag(v2f i) : SV_Target
	{
		float2 uv = i.uv;

		uv = floor(uv * _Resolution) * (1.0 / _Resolution);

		float3 finalColor = tex2D(_SrcTex, uv).rgb;

		return float4(finalColor, 1.0);
	}
		ENDCG
	}
	}
}
