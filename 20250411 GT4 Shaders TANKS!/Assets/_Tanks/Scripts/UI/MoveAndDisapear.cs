using UnityEngine;

public class MoveAndDisappear : MonoBehaviour
{
    public float speed = 1f;  // Vitesse de déplacement vers le bas
    public float targetY = -1f;  // Position Y où l'objet disparaît

    void Update()
    {
        // Déplace l'objet vers le bas à chaque frame
        transform.position += Vector3.down * speed * Time.deltaTime;

        // Si l'objet atteint la position Y cible (ou descend en dessous)
        if (transform.position.y <= targetY)
        {
            // Désactive l'objet pour le faire disparaître
            gameObject.SetActive(false);
        }
    }
}