// lib/widgets/cards/artist_card.dart
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart'; // Assurez-vous d'importer url_launcher

class ArtistCard extends StatelessWidget {
  final String artistName;
  final String artistImageUrl; // Propriété pour l'URL de l'image
  final String artistLink; // Propriété pour le lien Deezer
  final int artistFans; // Propriété pour le nombre de fans
  final Color borderColor;

  const ArtistCard({
    Key? key,
    required this.artistName,
    required this.artistImageUrl, // Ajouter l'argument pour l'URL
    required this.artistLink, // Ajouter l'argument pour le lien
    int? artistFans, // Le rendre nullable
    required this.borderColor,
  })  : artistFans = artistFans ?? 0, // Valeur par défaut si null
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Afficher l'image de l'artiste, taille augmentée
          Center(
            child: Container(
              width: 250, // Ajustez la largeur si nécessaire
              height: 250, // Ajustez la hauteur si nécessaire
              decoration: BoxDecoration(
                shape: BoxShape.circle, // Pour garder la forme ovale
                border: Border.all(color: borderColor, width: 3), // Couleur et largeur de la bordure
              ),
              child: ClipOval(
                child: Image.network(
                  artistImageUrl,
                  fit: BoxFit.cover, // Pour garder les proportions
                ),
              ),
            ),
          ),
          SizedBox(height: 10),
          // Afficher le nom de l'artiste en noir
          Center(
            child: Text(
              artistName,
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.black), // Couleur noire
            ),
          ),
          SizedBox(height: 5),
          // Afficher le nombre de fans
          Center(
            child: Text(
              '$artistFans fans', // Affichage du nombre de fans
              style: TextStyle(color: Colors.black54, fontSize: 14), // Style pour le texte
            ),
          ),
          SizedBox(height: 5),
          // Lien vers la page Deezer de l'artiste
          GestureDetector(
            onTap: () => _launchURL(artistLink), // Ouvrir le lien lorsque l'utilisateur clique
            child: Text(
              'Voir sur Deezer',
              style: TextStyle(color: Colors.blue, fontSize: 14, decoration: TextDecoration.underline), // Style du lien
            ),
          ),
        ],
      ),
    );
  }

  // Méthode pour ouvrir le lien
  void _launchURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }
}
