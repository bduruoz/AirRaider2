// Made with Amplify Shader Editor v1.9.1
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "BUDU/PaintedColor"
{
	Properties
	{
		[HDR][Header(Main)]_MainColor("Main Color", Color) = (1,1,1,1)
		_MainTexture("Main Texture", 2D) = "white" {}
		[Toggle]_SecondColorToggle("Second Color Toggle", Float) = 0
		[Toggle]_NegativeMask("Negative Mask", Float) = 0
		[HDR]_SecondColor("Second Color", Color) = (0,0,0,0)
		_MaskTexture("Mask Texture", 2D) = "white" {}
		[Toggle]_Emission("Emission", Float) = 0
		_EmissionIntensity("Emission Intensity", Range( 0 , 2)) = 1
		[HDR]_EmissionColor("Emission Color", 2D) = "white" {}
		[HideInInspector] _texcoord( "", 2D ) = "white" {}
		[HideInInspector] __dirty( "", Int ) = 1
	}

	SubShader
	{
		Tags{ "RenderType" = "Opaque"  "Queue" = "Geometry+0" "IsEmissive" = "true"  }
		Cull Back
		CGPROGRAM
		#pragma target 3.0
		#pragma surface surf Standard keepalpha addshadow fullforwardshadows 
		struct Input
		{
			float2 uv_texcoord;
		};

		uniform float _SecondColorToggle;
		uniform float4 _MainColor;
		uniform sampler2D _MainTexture;
		uniform float4 _MainTexture_ST;
		uniform float4 _SecondColor;
		uniform float _NegativeMask;
		uniform sampler2D _MaskTexture;
		uniform float4 _MaskTexture_ST;
		uniform float _Emission;
		uniform float _EmissionIntensity;
		uniform sampler2D _EmissionColor;
		uniform float4 _EmissionColor_ST;

		void surf( Input i , inout SurfaceOutputStandard o )
		{
			float2 uv_MainTexture = i.uv_texcoord * _MainTexture_ST.xy + _MainTexture_ST.zw;
			float4 temp_output_4_0 = ( _MainColor * tex2D( _MainTexture, uv_MainTexture ) );
			float2 uv_MaskTexture = i.uv_texcoord * _MaskTexture_ST.xy + _MaskTexture_ST.zw;
			float ifLocalVar16 = 0;
			UNITY_BRANCH 
			if( 1.0 > 0.0 )
				ifLocalVar16 = tex2D( _MaskTexture, uv_MaskTexture ).a;
			float4 lerpResult9 = lerp( temp_output_4_0 , _SecondColor , (( _NegativeMask )?( ( 1.0 - ifLocalVar16 ) ):( ifLocalVar16 )));
			o.Albedo = (( _SecondColorToggle )?( lerpResult9 ):( temp_output_4_0 )).rgb;
			float4 temp_cast_1 = (0.0).xxxx;
			float2 uv_EmissionColor = i.uv_texcoord * _EmissionColor_ST.xy + _EmissionColor_ST.zw;
			o.Emission = (( _Emission )?( ( _EmissionIntensity * tex2D( _EmissionColor, uv_EmissionColor ) ) ):( temp_cast_1 )).rgb;
			o.Alpha = 1;
		}

		ENDCG
	}
	Fallback "Diffuse"
	CustomEditor "ASEMaterialInspector"
}
/*ASEBEGIN
Version=19100
Node;AmplifyShaderEditor.SamplerNode;2;-623.6081,129.864;Inherit;True;Property;_MainTexture;Main Texture;1;0;Create;True;0;0;0;False;0;False;-1;None;58c7b0ded06e0234b9fac7b93dfd4b31;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;4;-288.6081,65.86401;Inherit;False;2;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.ColorNode;3;-536.6081,-42.13608;Inherit;False;Property;_MainColor;Main Color;0;2;[HDR];[Header];Create;True;1;Main;0;0;False;0;False;1,1,1,1;1,1,1,1;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.ColorNode;19;-545.6086,355.8638;Inherit;False;Property;_SecondColor;Second Color;4;1;[HDR];Create;True;0;0;0;False;0;False;0,0,0,0;0.28,0.28,0.28,1;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.LerpOp;9;-183.6086,283.8638;Inherit;True;3;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;2;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.ToggleSwitchNode;6;265.3328,16.83337;Inherit;False;Property;_SecondColorToggle;Second Color Toggle;2;0;Create;False;0;0;0;False;0;False;0;True;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.ToggleSwitchNode;21;-526.2086,562.9638;Inherit;False;Property;_NegativeMask;Negative Mask;3;0;Create;True;0;0;0;False;0;False;0;True;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.ConditionalIfNode;16;-953.9084,572.3635;Inherit;True;True;5;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;4;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;13;-1144.008,620.7635;Inherit;False;Constant;_Black;Black;7;0;Create;True;0;0;0;False;0;False;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;18;-1141.008,540.7638;Inherit;False;Constant;_White;White;8;0;Create;True;0;0;0;False;0;False;1;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SamplerNode;8;-1295.008,717.2633;Inherit;True;Property;_MaskTexture;Mask Texture;5;0;Create;True;0;0;0;False;0;False;-1;None;995a1b4f21559924289741e1c1c03620;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.OneMinusNode;20;-685.7087,701.8634;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.ToggleSwitchNode;12;290.6329,618.233;Inherit;False;Property;_Emission;Emission;6;0;Create;True;0;0;0;False;0;False;0;True;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;15;87.39152,740.4633;Inherit;False;2;2;0;FLOAT;0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.SamplerNode;10;-230.6086,782.4633;Inherit;True;Property;_EmissionColor;Emission Color;8;1;[HDR];Create;True;0;0;0;False;0;False;-1;None;None;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;14;-214.6086,693.4633;Inherit;False;Property;_EmissionIntensity;Emission Intensity;7;0;Create;True;0;0;0;False;0;False;1;1;0;2;0;1;FLOAT;0
Node;AmplifyShaderEditor.StandardSurfaceOutputNode;30;576.9001,218.3001;Float;False;True;-1;2;ASEMaterialInspector;0;0;Standard;BUDU/PaintedColor;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;Back;0;False;;0;False;;False;0;False;;0;False;;False;0;Opaque;0.5;True;True;0;False;Opaque;;Geometry;All;12;all;True;True;True;True;0;False;;False;0;False;;255;False;;255;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;False;2;15;10;25;False;0.5;True;0;0;False;;0;False;;0;0;False;;0;False;;0;False;;0;False;;0;False;0;0,0,0,0;VertexOffset;True;False;Cylindrical;False;True;Relative;0;;-1;-1;-1;-1;0;False;0;0;False;;-1;0;False;;0;0;0;False;0.1;False;;0;False;;False;16;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;3;FLOAT;0;False;4;FLOAT;0;False;5;FLOAT;0;False;6;FLOAT3;0,0,0;False;7;FLOAT3;0,0,0;False;8;FLOAT;0;False;9;FLOAT;0;False;10;FLOAT;0;False;13;FLOAT3;0,0,0;False;11;FLOAT3;0,0,0;False;12;FLOAT3;0,0,0;False;14;FLOAT4;0,0,0,0;False;15;FLOAT3;0,0,0;False;0
WireConnection;4;0;3;0
WireConnection;4;1;2;0
WireConnection;9;0;4;0
WireConnection;9;1;19;0
WireConnection;9;2;21;0
WireConnection;6;0;4;0
WireConnection;6;1;9;0
WireConnection;21;0;16;0
WireConnection;21;1;20;0
WireConnection;16;0;18;0
WireConnection;16;1;13;0
WireConnection;16;2;8;4
WireConnection;20;0;16;0
WireConnection;12;0;13;0
WireConnection;12;1;15;0
WireConnection;15;0;14;0
WireConnection;15;1;10;0
WireConnection;30;0;6;0
WireConnection;30;2;12;0
ASEEND*/
//CHKSM=C87D79BE4813500E41731854FA6350356C802BE8