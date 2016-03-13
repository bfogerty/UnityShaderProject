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
        Graphics.Blit(src, dest, matFx);
    }
}
