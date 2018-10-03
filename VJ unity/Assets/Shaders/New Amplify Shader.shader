// Made with Amplify Shader Editor
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "New Amplify Shader"
{
	Properties
	{
		_Color1("Color 1", Color) = (0,0.8666668,1,0)
		_Color0("Color 0", Color) = (0,0.7259934,1,0)
		_Float1("Float 1", Float) = 0
		[HideInInspector] __dirty( "", Int ) = 1
	}

	SubShader
	{
		Tags{ "RenderType" = "Opaque"  "Queue" = "Geometry+0" "IsEmissive" = "true"  }
		Cull Back
		CGPROGRAM
		#pragma target 3.0
		#pragma surface surf StandardSpecular keepalpha addshadow fullforwardshadows 
		struct Input
		{
			half filler;
		};

		uniform float4 _Color0;
		uniform float4 _Color1;
		uniform float _Float1;

		void surf( Input i , inout SurfaceOutputStandardSpecular o )
		{
			float4 lerpResult15 = lerp( _Color0 , _Color1 , _Float1);
			o.Emission = lerpResult15.rgb;
			o.Alpha = 1;
		}

		ENDCG
	}
	Fallback "Diffuse"
	CustomEditor "ASEMaterialInspector"
}
/*ASEBEGIN
Version=15600
93;35;1742;972;1575.761;225.1678;1;True;False
Node;AmplifyShaderEditor.ColorNode;6;-594.47,-155.2442;Float;False;Property;_Color0;Color 0;1;0;Create;True;0;0;False;0;0,0.7259934,1,0;0,0.3540874,1,0;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;20;-797.761,-74.16776;Float;False;Property;_Float1;Float 1;3;0;Create;True;0;0;False;0;0;0.81;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.ColorNode;10;-831.4814,491.8412;Float;False;Property;_Color1;Color 1;0;0;Create;True;0;0;False;0;0,0.8666668,1,0;0,0.8666668,1,0;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.FresnelNode;12;-545.8613,281.2412;Float;False;Standard;WorldNormal;ViewDir;False;5;0;FLOAT3;0,0,1;False;4;FLOAT3;0,0,0;False;1;FLOAT;0;False;2;FLOAT;1;False;3;FLOAT;5;False;1;FLOAT;0
Node;AmplifyShaderEditor.OneMinusNode;19;-862.635,317.5439;Float;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.TimeNode;17;-1150.635,513.5439;Float;False;0;5;FLOAT4;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;14;-1333.635,89.5439;Float;False;Property;_Float0;Float 0;2;0;Create;True;0;0;False;0;2.41;0.4691062;0;2;0;1;FLOAT;0
Node;AmplifyShaderEditor.FresnelNode;3;-991.47,61.75583;Float;False;Standard;WorldNormal;ViewDir;False;5;0;FLOAT3;0,0,1;False;4;FLOAT3;0,0,0;False;1;FLOAT;0;False;2;FLOAT;1;False;3;FLOAT;5;False;1;FLOAT;0
Node;AmplifyShaderEditor.FractNode;18;-1175.635,338.5439;Float;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;13;-256.4814,372.8412;Float;False;2;2;0;FLOAT;0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;1;-438,65.5;Float;False;2;2;0;COLOR;0,0,0,0;False;1;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.LerpOp;15;-539.635,137.5439;Float;False;3;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;2;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.DynamicAppendNode;8;-962.4814,457.8412;Float;False;FLOAT4;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT4;0
Node;AmplifyShaderEditor.SimpleTimeNode;16;-1027.635,263.5439;Float;False;1;0;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.StandardSurfaceOutputNode;0;0,0;Float;False;True;2;Float;ASEMaterialInspector;0;0;StandardSpecular;New Amplify Shader;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;Back;0;False;-1;0;False;-1;False;0;False;-1;0;False;-1;False;0;Opaque;0.5;True;True;0;False;Opaque;;Geometry;All;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;0;False;-1;False;0;False;-1;255;False;-1;255;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;False;2;15;10;25;False;0.5;True;0;0;False;-1;0;False;-1;0;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;0;0,0,0,0;VertexOffset;True;False;Cylindrical;False;Relative;0;;-1;-1;-1;-1;0;False;0;0;False;-1;-1;0;False;-1;0;0;0;16;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;3;FLOAT3;0,0,0;False;4;FLOAT;0;False;5;FLOAT;0;False;6;FLOAT3;0,0,0;False;7;FLOAT3;0,0,0;False;8;FLOAT;0;False;9;FLOAT;0;False;10;FLOAT;0;False;13;FLOAT3;0,0,0;False;11;FLOAT3;0,0,0;False;12;FLOAT3;0,0,0;False;14;FLOAT4;0,0,0,0;False;15;FLOAT3;0,0,0;False;0
WireConnection;12;0;10;0
WireConnection;19;0;18;0
WireConnection;18;0;17;3
WireConnection;13;0;12;0
WireConnection;13;1;10;0
WireConnection;1;0;6;0
WireConnection;1;1;3;0
WireConnection;15;0;6;0
WireConnection;15;1;10;0
WireConnection;15;2;20;0
WireConnection;16;0;14;0
WireConnection;0;2;15;0
ASEEND*/
//CHKSM=14D75C8087EA12AEBF57282B58D09DEE1F4841B4