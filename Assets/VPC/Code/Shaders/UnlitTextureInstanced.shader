// Made with Amplify Shader Editor
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "Custom/Unlit/TextureInstanced"
{
	Properties
	{
		[HideInInspector] __dirty( "", Int ) = 1
		_Texture("Texture", 2D) = "white" {}
		_Tint("Tint", Color) = (1,1,1,1)
		[HideInInspector] _texcoord( "", 2D ) = "white" {}
	}

	SubShader
	{
		Tags{ "RenderType" = "Transparent"  "Queue" = "Transparent+0" "IgnoreProjector" = "True" "IsEmissive" = "true"  }
		Cull Off
		CGPROGRAM
		#pragma target 3.0
		#pragma surface surf Unlit alpha:fade keepalpha noshadow 
		struct Input
		{
			float2 uv_texcoord;
		};

		uniform float4 _Tint;
		uniform sampler2D _Texture;
		uniform float4 _Texture_ST;

		inline fixed4 LightingUnlit( SurfaceOutput s, half3 lightDir, half atten )
		{
			return fixed4 ( 0, 0, 0, s.Alpha );
		}

		void surf( Input i , inout SurfaceOutput o )
		{
			float2 uv_Texture = i.uv_texcoord * _Texture_ST.xy + _Texture_ST.zw;
			float4 temp_output_5_0 = ( _Tint * tex2D( _Texture, uv_Texture ) );
			o.Emission = temp_output_5_0.rgb;
			o.Alpha = temp_output_5_0.a;
		}

		ENDCG
	}
	CustomEditor "ASEMaterialInspector"
}
/*ASEBEGIN
Version=11001
1927;29;1666;1004;913;379;1;True;True
Node;AmplifyShaderEditor.ColorNode;4;-544,-128;Float;False;Property;_Tint;Tint;1;0;1,1,1,1;0;5;COLOR;FLOAT;FLOAT;FLOAT;FLOAT
Node;AmplifyShaderEditor.SamplerNode;2;-544,43;Float;True;Property;_Texture;Texture;0;0;None;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;1.0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1.0;False;5;FLOAT4;FLOAT;FLOAT;FLOAT;FLOAT
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;5;-223,-123;Float;False;2;2;0;COLOR;0.0;False;1;FLOAT4;0,0,0,0;False;1;COLOR
Node;AmplifyShaderEditor.BreakToComponentsNode;6;-77,-13;Float;False;COLOR;1;0;COLOR;0.0;False;16;FLOAT;FLOAT;FLOAT;FLOAT;FLOAT;FLOAT;FLOAT;FLOAT;FLOAT;FLOAT;FLOAT;FLOAT;FLOAT;FLOAT;FLOAT;FLOAT
Node;AmplifyShaderEditor.StandardSurfaceOutputNode;0;224,-128;Float;False;True;2;Float;ASEMaterialInspector;0;Unlit;Custom/Unlit/TextureInstanced;False;False;False;False;False;False;False;False;False;False;False;False;False;False;True;False;Off;0;0;False;0;0;Transparent;0.5;True;False;0;False;Transparent;Transparent;All;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;False;0;255;255;0;0;0;0;False;0;4;10;25;False;0.5;False;0;One;OneMinusSrcAlpha;2;SrcAlpha;OneMinusSrcAlpha;Add;Add;0;False;0;0,0,0,0;VertexOffset;False;Cylindrical;Relative;0;;-1;-1;-1;-1;0;14;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;3;FLOAT;0.0;False;4;FLOAT;0.0;False;6;FLOAT3;0,0,0;False;7;FLOAT3;0,0,0;False;8;FLOAT;0.0;False;9;FLOAT;0.0;False;10;OBJECT;0.0;False;11;FLOAT3;0,0,0;False;12;FLOAT3;0,0,0;False;14;FLOAT4;0,0,0,0;False;15;FLOAT3;0,0,0;False;0
WireConnection;5;0;4;0
WireConnection;5;1;2;0
WireConnection;6;0;5;0
WireConnection;0;2;5;0
WireConnection;0;9;6;3
ASEEND*/
//CHKSM=31DC3AF27D04A1581E467FBBEBBA907923A723C7