// Amplify Bloom - Advanced Bloom Post-Effect for Unity
// Copyright (c) Amplify Creations, Lda <info@amplify.pt>

using UnityEngine;
using AmplifyBloom;

[ExecuteInEditMode]
[RequireComponent( typeof( Camera ) )]
public class RenderColorMask : MonoBehaviour
{
	public Camera maskCamera;
	public LayerMask layerMask;

	public bool invertMask;
	public bool debug;

	private const string RenderTypeStr = "RenderType";

	private int m_width, m_height;
	private RenderTexture m_maskTexture;
	private Shader m_colorMaskShader;
	private Shader m_colorMaskShaderAlpha;

	private Camera m_camera;
	private AmplifyBloomEffect m_bloomEffect;
	private int m_colormaskId;

	void Start()
	{
		m_colorMaskShader = Shader.Find( "Hidden/ColorMaskShader" );
		m_colorMaskShaderAlpha = Shader.Find( "Hidden/ColorMaskShaderAlpha" );
		m_camera = GetComponent<Camera>();
		m_bloomEffect = GetComponent<AmplifyBloomEffect>();

		m_colormaskId = Shader.PropertyToID( "_COLORMASK_Color" );
		UpdateRenderTextures();
		UpdateCameraProperties();
	}

	void Update()
	{
		UpdateRenderTextures();
		UpdateCameraProperties();
	}

	void UpdateRenderTextures()
	{
		int w = ( int ) ( m_camera.pixelWidth + 0.5f );
		int h = ( int ) ( m_camera.pixelHeight + 0.5f );

		if ( m_width != w || m_height != h )
		{
			m_width = w;
			m_height = h;

			if ( m_maskTexture != null )
				DestroyImmediate( m_maskTexture );

			m_maskTexture = new RenderTexture( m_width, m_height, 24, RenderTextureFormat.Default, RenderTextureReadWrite.Linear ) { hideFlags = HideFlags.HideAndDontSave, name = "MaskTexture" };
			m_maskTexture.antiAliasing = ( QualitySettings.antiAliasing > 0 ) ? QualitySettings.antiAliasing : 1;
			m_maskTexture.Create();
		}

		m_bloomEffect.MaskTexture = m_maskTexture;
	}

	void UpdateCameraProperties()
	{
		maskCamera.CopyFrom( m_camera );
		maskCamera.targetTexture = m_maskTexture;
		maskCamera.clearFlags = CameraClearFlags.Nothing;
		maskCamera.renderingPath = RenderingPath.VertexLit;
		maskCamera.pixelRect = new Rect( 0, 0, m_width, m_height );
		maskCamera.depthTextureMode = DepthTextureMode.None;
		maskCamera.allowHDR = false;
		maskCamera.enabled = false;
	}

	void Render( Shader shader )
	{
		// Render all objects, except ColorMask layer
		Shader.SetGlobalColor( m_colormaskId , invertMask ? Color.black : Color.white );
		maskCamera.cullingMask = ~layerMask;
		maskCamera.RenderWithShader( shader, RenderTypeStr );

		// Render only ColorMask layer
		Shader.SetGlobalColor( m_colormaskId, invertMask ? Color.white : Color.black );
		maskCamera.cullingMask = layerMask;
		maskCamera.RenderWithShader( shader, RenderTypeStr );
	}

	void OnPreRender()
	{
		RenderBuffer prevColor = Graphics.activeColorBuffer;
		RenderBuffer prevDepth = Graphics.activeDepthBuffer;

		Graphics.SetRenderTarget( m_maskTexture );
		GL.Clear( true, true, invertMask ? Color.black : Color.white );

		// Render Opaque objects
		Render( m_colorMaskShader );

		// Render Transparent objects
		Render( m_colorMaskShaderAlpha );

		Graphics.SetRenderTarget( prevColor, prevDepth );
	}

	void OnGUI()
	{
		if ( debug )
			GUI.DrawTexture( new Rect( 0, 0, Screen.width, Screen.height ), m_maskTexture );
	}
}
