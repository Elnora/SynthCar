// Shader created with Shader Forge v1.38 
// Shader Forge (c) Neat Corporation / Joachim Holmer - http://www.acegikmo.com/shaderforge/
// Note: Manually altering this data may prevent you from opening it in Shader Forge
/*SF_DATA;ver:1.38;sub:START;pass:START;ps:flbk:,iptp:0,cusa:False,bamd:0,cgin:,lico:1,lgpr:1,limd:0,spmd:1,trmd:0,grmd:0,uamb:True,mssp:True,bkdf:False,hqlp:False,rprd:False,enco:False,rmgx:True,imps:True,rpth:0,vtps:0,hqsc:True,nrmq:1,nrsp:0,vomd:0,spxs:False,tesm:0,olmd:1,culm:0,bsrc:0,bdst:1,dpts:2,wrdp:True,dith:0,atcv:False,rfrpo:True,rfrpn:Refraction,coma:15,ufog:True,aust:True,igpj:False,qofs:0,qpre:2,rntp:3,fgom:False,fgoc:False,fgod:False,fgor:False,fgmd:0,fgcr:0.5,fgcg:0.5,fgcb:0.5,fgca:1,fgde:0.01,fgrn:0,fgrf:300,stcl:False,atwp:False,stva:128,stmr:255,stmw:255,stcp:6,stps:0,stfa:0,stfz:0,ofsf:0,ofsu:0,f2p0:False,fnsp:False,fnfb:False,fsmp:False;n:type:ShaderForge.SFN_Final,id:9361,x:33238,y:32756,varname:node_9361,prsc:2|emission-8527-OUT,clip-1177-OUT;n:type:ShaderForge.SFN_Tex2d,id:3629,x:32776,y:32850,ptovrint:False,ptlb:Texture,ptin:_Texture,varname:node_3629,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,tex:c70af0d55019ba542acdc30a24c8cc6b,ntxv:0,isnm:False|UVIN-6542-OUT;n:type:ShaderForge.SFN_Color,id:7243,x:32787,y:32603,ptovrint:False,ptlb:Wire color,ptin:_Wirecolor,varname:node_7243,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,c1:1,c2:0,c3:0,c4:1;n:type:ShaderForge.SFN_Multiply,id:8527,x:33002,y:32751,varname:node_8527,prsc:2|A-7243-RGB,B-3629-A;n:type:ShaderForge.SFN_Multiply,id:6542,x:32582,y:32867,varname:node_6542,prsc:2|A-6647-UVOUT,B-4366-OUT;n:type:ShaderForge.SFN_TexCoord,id:6647,x:32348,y:32695,varname:node_6647,prsc:2,uv:0,uaff:False;n:type:ShaderForge.SFN_ValueProperty,id:4366,x:32362,y:32901,ptovrint:False,ptlb:Tiling,ptin:_Tiling,varname:node_4366,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,v1:5;n:type:ShaderForge.SFN_Multiply,id:1177,x:32873,y:33121,varname:node_1177,prsc:2|A-7398-OUT,B-6042-OUT;n:type:ShaderForge.SFN_Add,id:7398,x:32653,y:33076,varname:node_7398,prsc:2|A-3629-A,B-6042-OUT;n:type:ShaderForge.SFN_Slider,id:6042,x:32241,y:33098,ptovrint:False,ptlb:Cutoff,ptin:_Cutoff,varname:node_6042,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,min:0,cur:0.4247863,max:0.7;proporder:3629-7243-4366-6042;pass:END;sub:END;*/

Shader "Shader Forge/GlowingWireframe" {
    Properties {
        _Texture ("Texture", 2D) = "white" {}
        _Wirecolor ("Wire color", Color) = (1,0,0,1)
        _Tiling ("Tiling", Float ) = 5
        _Cutoff ("Cutoff", Range(0, 0.7)) = 0.4247863
        [HideInInspector]_Cutoff ("Alpha cutoff", Range(0,1)) = 0.5
    }
    SubShader {
        Tags {
            "Queue"="AlphaTest"
            "RenderType"="TransparentCutout"
        }
        Pass {
            Name "FORWARD"
            Tags {
                "LightMode"="ForwardBase"
            }
            
            
            CGPROGRAM
            #pragma vertex vert
            #pragma fragment frag
            #define UNITY_PASS_FORWARDBASE
            #include "UnityCG.cginc"
            #pragma multi_compile_fwdbase_fullshadows
            #pragma multi_compile_fog
            #pragma only_renderers d3d9 d3d11 glcore gles 
            #pragma target 3.0
            uniform sampler2D _Texture; uniform float4 _Texture_ST;
            uniform float4 _Wirecolor;
            uniform float _Tiling;
            uniform float _Cutoff;
            struct VertexInput {
                float4 vertex : POSITION;
                float2 texcoord0 : TEXCOORD0;
            };
            struct VertexOutput {
                float4 pos : SV_POSITION;
                float2 uv0 : TEXCOORD0;
                UNITY_FOG_COORDS(1)
            };
            VertexOutput vert (VertexInput v) {
                VertexOutput o = (VertexOutput)0;
                o.uv0 = v.texcoord0;
                o.pos = UnityObjectToClipPos( v.vertex );
                UNITY_TRANSFER_FOG(o,o.pos);
                return o;
            }
            float4 frag(VertexOutput i) : COLOR {
                float2 node_6542 = (i.uv0*_Tiling);
                float4 _Texture_var = tex2D(_Texture,TRANSFORM_TEX(node_6542, _Texture));
                clip(((_Texture_var.a+_Cutoff)*_Cutoff) - 0.5);
////// Lighting:
////// Emissive:
                float3 emissive = (_Wirecolor.rgb*_Texture_var.a);
                float3 finalColor = emissive;
                fixed4 finalRGBA = fixed4(finalColor,1);
                UNITY_APPLY_FOG(i.fogCoord, finalRGBA);
                return finalRGBA;
            }
            ENDCG
        }
        Pass {
            Name "ShadowCaster"
            Tags {
                "LightMode"="ShadowCaster"
            }
            Offset 1, 1
            Cull Back
            
            CGPROGRAM
            #pragma vertex vert
            #pragma fragment frag
            #define UNITY_PASS_SHADOWCASTER
            #include "UnityCG.cginc"
            #include "Lighting.cginc"
            #pragma fragmentoption ARB_precision_hint_fastest
            #pragma multi_compile_shadowcaster
            #pragma multi_compile_fog
            #pragma only_renderers d3d9 d3d11 glcore gles 
            #pragma target 3.0
            uniform sampler2D _Texture; uniform float4 _Texture_ST;
            uniform float _Tiling;
            uniform float _Cutoff;
            struct VertexInput {
                float4 vertex : POSITION;
                float2 texcoord0 : TEXCOORD0;
            };
            struct VertexOutput {
                V2F_SHADOW_CASTER;
                float2 uv0 : TEXCOORD1;
            };
            VertexOutput vert (VertexInput v) {
                VertexOutput o = (VertexOutput)0;
                o.uv0 = v.texcoord0;
                o.pos = UnityObjectToClipPos( v.vertex );
                TRANSFER_SHADOW_CASTER(o)
                return o;
            }
            float4 frag(VertexOutput i) : COLOR {
                float2 node_6542 = (i.uv0*_Tiling);
                float4 _Texture_var = tex2D(_Texture,TRANSFORM_TEX(node_6542, _Texture));
                clip(((_Texture_var.a+_Cutoff)*_Cutoff) - 0.5);
                SHADOW_CASTER_FRAGMENT(i)
            }
            ENDCG
        }
    }
    FallBack "Diffuse"
    CustomEditor "ShaderForgeMaterialInspector"
}
