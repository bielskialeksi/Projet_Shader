using UnityEngine;

[ExecuteInEditMode]
[RequireComponent(typeof(Camera))]
public class CameraShakeEffect : MonoBehaviour
{
    public Material shakeMaterial;
    public float shakeIntensity = 0.005f;
    public float shakeSpeed = 40f;
    public float shakeDuration = 0.5f;
    public bool IsShake = false;
    private float shakeTimer = 0f;

    void OnRenderImage(RenderTexture src, RenderTexture dest)
    {
        Debug.Log("in OnRendererimage");
        if (shakeTimer > 0 && shakeMaterial != null)
        {
            shakeTimer -= Time.deltaTime;
            shakeMaterial.SetFloat("_ShakeIntensity", shakeIntensity);
            shakeMaterial.SetFloat("_ShakeSpeed", shakeSpeed);
            shakeMaterial.SetFloat("_Time", Time.time);
            Graphics.Blit(src, dest, shakeMaterial);
            IsShake = true;
        }
        else
        {
            IsShake=false;
            Graphics.Blit(src, dest); // Aucun effet
        }
    }

    public void TriggerShake(float intensity, float duration)
    {
        shakeIntensity = intensity;
        shakeDuration = duration;
        shakeTimer = duration;
    }
}
