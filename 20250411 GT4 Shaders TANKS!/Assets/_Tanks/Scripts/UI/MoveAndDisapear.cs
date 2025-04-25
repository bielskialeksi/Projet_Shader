using UnityEngine;

public class MoveAndDisappear : MonoBehaviour
{
    public float speed = 1f;  // Vitesse de d�placement vers le bas
    public float targetY = -1f;  // Position Y o� l'objet dispara�t

    void Update()
    {
        // D�place l'objet vers le bas � chaque frame
        transform.position += Vector3.down * speed * Time.deltaTime;

        // Si l'objet atteint la position Y cible (ou descend en dessous)
        if (transform.position.y <= targetY)
        {
            // D�sactive l'objet pour le faire dispara�tre
            gameObject.SetActive(false);
        }
    }
}