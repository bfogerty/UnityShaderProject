Shader "Unlit/CellShader"
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
				float3 worldPosition : TEXCOORD0;
				float3 worldNormal : TEXCOORD1;
			};

			sampler2D _RampTex;
			float4 _RampTex_ST;
			float4 _DiffuseintColor;
			
			v2f vert (appdata v)
			{
				v2f o;

				v.vertex.w = 1.0;
				v.normal.w = 0.0;

				o.vertex = mul(UNITY_MATRIX_MVP, v.vertex);
				o.worldPosition = mul( _Object2World, v.vertex );
				o.worldNormal = normalize( mul(_Object2World, v.normal) );

				return o;
			}

			//-----------------------------------------------------------------------------------------------
			// Standard Blinn lighting model.
			// This model computes the diffuse and specular components of the final surface color.
			float3 calculateLighting(float3 diffuseTintColor, float3 pointOnSurface, float3 surfaceNormal, float3 lightPosition, float3 cameraPosition)
			{
			    float3 fromPointToLight = normalize(lightPosition - pointOnSurface);
			    float diffuseStrength = clamp( dot( surfaceNormal, fromPointToLight ), 0.3, 1.0 );

			    diffuseStrength = tex2D(_RampTex, float2(diffuseStrength, 0.5));
			    float3 diffuseColor = diffuseStrength * diffuseTintColor;
			    float3 reflectedLightVector = normalize( reflect( -fromPointToLight, surfaceNormal ) );
			    
			    float3 fromPointToCamera = normalize( cameraPosition - pointOnSurface );
			    float specularStrength = pow( clamp( dot(reflectedLightVector, fromPointToCamera), 0.0, 1.0 ), 10.0 );

			    specularStrength = tex2D(_RampTex, float2(specularStrength, 0.5));
			    // Ensure that there is no specular lighting when there is no diffuse lighting.
			    specularStrength = min( diffuseStrength, specularStrength );
			    float3 specularColor = specularStrength * float3( 1.0, 1.0, 1.0 );
			    
			    float3 finalColor = diffuseColor + specularColor; 
			 
			    // Draw a thick silhouette around our object
			    if( dot( fromPointToCamera, surfaceNormal ) < 0.6 )
			    {
			        finalColor = float3( 0.0, 0.0, 0.0 );
			    }
			    
			    return finalColor;
			}

			float4 frag (v2f i) : SV_Target
			{
				// sample the texture
				float3 col = calculateLighting( _DiffuseintColor.rgb,
												i.worldPosition, 
												normalize(i.worldNormal), 
												_WorldSpaceLightPos0, 
												_WorldSpaceCameraPos );




				return float4( col.r, col.g, col.b, 1.0 );
			}
			ENDCG
		}
	}
}
