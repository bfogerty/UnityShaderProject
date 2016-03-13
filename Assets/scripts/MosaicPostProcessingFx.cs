using UnityEngine;
using System.Collections;

public class MosaicPostProcessingFx : MonoBehaviour
{
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
        matFx.SetTexture("_SrcTex", src);

        Graphics.Blit(src, dest, matFx);
    }
}
