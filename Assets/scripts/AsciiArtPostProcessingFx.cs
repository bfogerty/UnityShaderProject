using UnityEngine;
using System.Collections;

public class AsciiArtPostProcessingFx : MonoBehaviour
{
    Material matFx = null;

	// Use this for initialization
	void Start ()
    {
        matFx = new Material(Shader.Find("Unlit/Checkboard"));

    }

    void OnRenderImage(RenderTexture src, RenderTexture dest)
    {

        float aspectRatio = (float)(Screen.width) / Screen.height;
        matFx.SetFloat("_AspectRatio", aspectRatio);

        Graphics.Blit(src, dest, matFx);
    }
}
