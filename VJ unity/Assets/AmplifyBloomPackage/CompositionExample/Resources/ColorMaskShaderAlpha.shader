// Upgrade NOTE: replaced 'mul(UNITY_MATRIX_MVP,*)' with 'UnityObjectToClipPos(*)'

// Amplify Bloom - Advanced Bloom Post-Effect for Unity
// Copyright (c) Amplify Creations, Lda <info@amplify.pt>

Shader "Hidden/ColorMaskShaderAlpha" {
	Properties {
		_MainTex ("", 2D) = "white" {}
		_Cutoff ("", Float) = 0.5
		_COLORMASK_Color ("", Color) = (1,1,1,1)
	}
	CGINCLUDE
		#pragma multi_compile _ PIXELSNAP_ON
		#include "UnityCG.cginc"

		sampler2D _MainTex;
		fixed _Cutoff;
		fixed4 _COLORMASK_Color;
								
		struct v2f
		{
			float4 vertex  : SV_POSITION;					
			float2 texcoord : TEXCOORD0;
		};
								
		v2f vert( appdata_base v )
		{
			v2f o;
			o.vertex = UnityObjectToClipPos( v.vertex );
			o.texcoord = v.texcoord;
		#ifdef PIXELSNAP_ON
			o.vertex = UnityPixelSnap( o.vertex );
		#endif
			return o;
		}		
	ENDCG
	SubShader {
		Tags { "Queue"="Transparent" "IgnoreProjector"="True" "RenderType"="Transparent" }
		Blend SrcAlpha OneMinusSrcAlpha
		Cull Off ZWrite Off Lighting Off Fog { Mode Off  }
		ColorMask RGB
		Pass {			
			CGPROGRAM
				#pragma vertex vert
				#pragma fragment frag				

				fixed4 frag( v2f i ) : SV_Target
				{
					return fixed4( _COLORMASK_Color.rgb, tex2D( _MainTex, i.texcoord ).a );
				}
			ENDCG
		}
	}
}
