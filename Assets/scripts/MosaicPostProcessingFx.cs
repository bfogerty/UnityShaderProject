using UnityEngine;
using System.Collections;

public class MosaicPostProcessingFx : MonoBehaviour
{
    [Range(1, 200)]
    public float Resolution = 40;

    Material matFx = null;

    // Use this for initialization
    void Start()
    {
        matFx = new Material(Shader.Find("Unlit/Mosaic"));

    }

    void OnRenderImage(RenderTexture src, RenderTexture dest)
    {

        float aspectRatio = (float)(Screen.width) / Screen.height;
        matFx.SetFloat("_AspectRatio", aspectRatio);
        matFx.SetFloat("_Resolution", Resolution);
        matFx.SetTexture("_SrcTex", src);

        Graphics.Blit(src, dest, matFx);
    }
}
