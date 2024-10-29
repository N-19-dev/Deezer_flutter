// lib/widgets/track_card.dart
import 'package:flutter/material.dart';

class TrackCard extends StatelessWidget {
  final Map<String, dynamic> trackData;
  final String title;

  TrackCard({required this.trackData, required this.title});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.4, // Largeur fixe pour les colonnes
      decoration: BoxDecoration(
        color: Colors.grey[900], // Fond gris sombre pour les détails
        borderRadius: BorderRadius.circular(12.0), // Arrondi léger des bords
      ),
      padding: EdgeInsets.all(16.0),
      child: Row(
        children: [
          // Image du morceau à gauche
          ClipRRect(
            borderRadius: BorderRadius.circular(8.0), // Arrondir les bords de l'image
            child: Image.network(
              trackData['album']['cover'],
              height: 100,
              width: 100, // Largeur fixe pour l'image
              fit: BoxFit.cover, // Ajustement de l'image
            ),
          ),
          SizedBox(width: 16), // Espacement entre l'image et les informations
          // Informations du morceau à droite
          Expanded( // Utilisation d'Expanded pour occuper l'espace restant
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold)),
                SizedBox(height: 8),
                Text('Artiste: ${trackData['artist']['name']}', style: TextStyle(color: Colors.white)),
                Text('Album: ${trackData['album']['title']}', style: TextStyle(color: Colors.white)), // Ajouter l'album
              ],
            ),
          ),
        ],
      ),
    );
  }
}
