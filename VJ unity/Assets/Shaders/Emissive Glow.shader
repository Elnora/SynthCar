// Shader created with Shader Forge v1.38 
// Shader Forge (c) Neat Corporation / Joachim Holmer - http://www.acegikmo.com/shaderforge/
// Note: Manually altering this data may prevent you from opening it in Shader Forge
/*SF_DATA;ver:1.38;sub:START;pass:START;ps:flbk:,iptp:0,cusa:False,bamd:0,cgin:,lico:1,lgpr:1,limd:3,spmd:1,trmd:0,grmd:0,uamb:True,mssp:True,bkdf:True,hqlp:False,rprd:True,enco:False,rmgx:True,imps:True,rpth:0,vtps:0,hqsc:True,nrmq:1,nrsp:0,vomd:0,spxs:False,tesm:0,olmd:1,culm:0,bsrc:0,bdst:1,dpts:2,wrdp:True,dith:0,atcv:False,rfrpo:True,rfrpn:Refraction,coma:15,ufog:True,aust:True,igpj:False,qofs:0,qpre:1,rntp:1,fgom:False,fgoc:False,fgod:False,fgor:False,fgmd:0,fgcr:0.5,fgcg:0.5,fgcb:0.5,fgca:1,fgde:0.01,fgrn:0,fgrf:300,stcl:False,atwp:False,stva:128,stmr:255,stmw:255,stcp:6,stps:0,stfa:0,stfz:0,ofsf:0,ofsu:0,f2p0:False,fnsp:False,fnfb:False,fsmp:False;n:type:ShaderForge.SFN_Final,id:2865,x:32755,y:32655,varname:node_2865,prsc:2|emission-2869-OUT;n:type:ShaderForge.SFN_Color,id:1186,x:32190,y:32558,ptovrint:False,ptlb:__Edge Color,ptin:___EdgeColor,varname:node_1186,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,c1:1,c2:0,c3:0,c4:1;n:type:ShaderForge.SFN_Fresnel,id:8460,x:32051,y:33101,varname:node_8460,prsc:2|EXP-3571-OUT;n:type:ShaderForge.SFN_Slider,id:3571,x:31696,y:33083,ptovrint:False,ptlb:__Fresnel Power,ptin:___FresnelPower,varname:node_3571,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,min:0,cur:0.5641026,max:1;n:type:ShaderForge.SFN_Multiply,id:2168,x:32239,y:32939,varname:node_2168,prsc:2|A-4939-RGB,B-5783-OUT;n:type:ShaderForge.SFN_OneMinus,id:5783,x:32239,y:33101,varname:node_5783,prsc:2|IN-8460-OUT;n:type:ShaderForge.SFN_Lerp,id:2869,x:32580,y:32755,varname:node_2869,prsc:2|A-1186-RGB,B-5253-OUT,T-2168-OUT;n:type:ShaderForge.SFN_Slider,id:9784,x:31817,y:32694,ptovrint:False,ptlb:__Inner Glow,ptin:___InnerGlow,varname:node_9784,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,min:-2,cur:1.076923,max:2;n:type:ShaderForge.SFN_Color,id:4939,x:31895,y:32846,ptovrint:False,ptlb:__Center Color,ptin:___CenterColor,varname:node_4939,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,c1:0.8665187,c2:1,c3:0,c4:1;n:type:ShaderForge.SFN_Multiply,id:5253,x:32266,y:32768,varname:node_5253,prsc:2|A-9784-OUT,B-4939-RGB;proporder:1186-3571-9784-4939;pass:END;sub:END;*/

Shader "Shader Forge/Emissive Glow" {
    Properties {
        ___EdgeColor ("__Edge Color", Color) = (1,0,0,1)
        ___FresnelPower ("__Fresnel Power", Range(0, 1)) = 0.5641026
        ___InnerGlow ("__Inner Glow", Range(-2, 2)) = 1.076923
        ___CenterColor ("__Center Color", Color) = (0.8665187,1,0,1)
    }
    SubShader {
        Tags {
            "RenderType"="Opaque"
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
            #define _GLOSSYENV 1
            #include "UnityCG.cginc"
            #include "UnityPBSLighting.cginc"
            #include "UnityStandardBRDF.cginc"
            #pragma multi_compile_fwdbase_fullshadows
            #pragma multi_compile_fog
            #pragma only_renderers d3d9 d3d11 glcore gles 
            #pragma target 3.0
            uniform float4 ___EdgeColor;
            uniform float ___FresnelPower;
            uniform float ___InnerGlow;
            uniform float4 ___CenterColor;
            struct VertexInput {
                float4 vertex : POSITION;
                float3 normal : NORMAL;
            };
            struct VertexOutput {
                float4 pos : SV_POSITION;
                float4 posWorld : TEXCOORD0;
                float3 normalDir : TEXCOORD1;
                UNITY_FOG_COORDS(2)
            };
            VertexOutput vert (VertexInput v) {
                VertexOutput o = (VertexOutput)0;
                o.normalDir = UnityObjectToWorldNormal(v.normal);
                o.posWorld = mul(unity_ObjectToWorld, v.vertex);
                o.pos = UnityObjectToClipPos( v.vertex );
                UNITY_TRANSFER_FOG(o,o.pos);
                return o;
            }
            float4 frag(VertexOutput i) : COLOR {
                i.normalDir = normalize(i.normalDir);
                float3 viewDirection = normalize(_WorldSpaceCameraPos.xyz - i.posWorld.xyz);
                float3 normalDirection = i.normalDir;
                float3 viewReflectDirection = reflect( -viewDirection, normalDirection );
////// Lighting:
////// Emissive:
                float node_8460 = pow(1.0-max(0,dot(normalDirection, viewDirection)),___FresnelPower);
                float node_5783 = (1.0 - node_8460);
                float3 node_2168 = (___CenterColor.rgb*node_5783);
                float3 emissive = lerp(___EdgeColor.rgb,(___InnerGlow*___CenterColor.rgb),node_2168);
                float3 finalColor = emissive;
                fixed4 finalRGBA = fixed4(finalColor,1);
                UNITY_APPLY_FOG(i.fogCoord, finalRGBA);
                return finalRGBA;
            }
            ENDCG
        }
        Pass {
            Name "Meta"
            Tags {
                "LightMode"="Meta"
            }
            Cull Off
            
            CGPROGRAM
            #pragma vertex vert
            #pragma fragment frag
            #define UNITY_PASS_META 1
            #define _GLOSSYENV 1
            #include "UnityCG.cginc"
            #include "UnityPBSLighting.cginc"
            #include "UnityStandardBRDF.cginc"
            #include "UnityMetaPass.cginc"
            #pragma fragmentoption ARB_precision_hint_fastest
            #pragma multi_compile_shadowcaster
            #pragma multi_compile_fog
            #pragma only_renderers d3d9 d3d11 glcore gles 
            #pragma target 3.0
            uniform float4 ___EdgeColor;
            uniform float ___FresnelPower;
            uniform float ___InnerGlow;
            uniform float4 ___CenterColor;
            struct VertexInput {
                float4 vertex : POSITION;
                float3 normal : NORMAL;
                float2 texcoord1 : TEXCOORD1;
                float2 texcoord2 : TEXCOORD2;
            };
            struct VertexOutput {
                float4 pos : SV_POSITION;
                float4 posWorld : TEXCOORD0;
                float3 normalDir : TEXCOORD1;
            };
            VertexOutput vert (VertexInput v) {
                VertexOutput o = (VertexOutput)0;
                o.normalDir = UnityObjectToWorldNormal(v.normal);
                o.posWorld = mul(unity_ObjectToWorld, v.vertex);
                o.pos = UnityMetaVertexPosition(v.vertex, v.texcoord1.xy, v.texcoord2.xy, unity_LightmapST, unity_DynamicLightmapST );
                return o;
            }
            float4 frag(VertexOutput i) : SV_Target {
                i.normalDir = normalize(i.normalDir);
                float3 viewDirection = normalize(_WorldSpaceCameraPos.xyz - i.posWorld.xyz);
                float3 normalDirection = i.normalDir;
                UnityMetaInput o;
                UNITY_INITIALIZE_OUTPUT( UnityMetaInput, o );
                
                float node_8460 = pow(1.0-max(0,dot(normalDirection, viewDirection)),___FresnelPower);
                float node_5783 = (1.0 - node_8460);
                float3 node_2168 = (___CenterColor.rgb*node_5783);
                o.Emission = lerp(___EdgeColor.rgb,(___InnerGlow*___CenterColor.rgb),node_2168);
                
                float3 diffColor = float3(0,0,0);
                float specularMonochrome;
                float3 specColor;
                diffColor = DiffuseAndSpecularFromMetallic( diffColor, 0, specColor, specularMonochrome );
                o.Albedo = diffColor;
                
                return UnityMetaFragment( o );
            }
            ENDCG
        }
    }
    FallBack "Diffuse"
    CustomEditor "ShaderForgeMaterialInspector"
}
