// lib/widgets/cards/dashboard_card.dart
import 'package:flutter/material.dart';
import 'artist_card.dart';
import '../charts/pie_chart.dart';
import '../charts/bar_chart.dart';
import '../charts/line_chart.dart';


class DashboardCard extends StatelessWidget {
  final Map<String, dynamic>? track1Data;
  final Map<String, dynamic>? track2Data;
  final Map<String, dynamic>? artist1Data;
  final Map<String, dynamic>? artist2Data;
  final Map<String, dynamic>? album1Data;
  final Map<String, dynamic>? album2Data;
  final bool areBothTracksSelected;

  const DashboardCard({
    Key? key,
    required this.track1Data,
    required this.track2Data,
    required this.artist1Data,
    required this.artist2Data,
    required this.album1Data,
    required this.album2Data,
    required this.areBothTracksSelected,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.grey[900],
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          children: [
            Expanded(
              flex: 1,
              child: Card(
                color: Colors.white, // Couleur de fond de la carte
                child: Padding(
                  padding: const EdgeInsets.all(16.0), // Padding pour l'intérieur de la carte
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      if (areBothTracksSelected) ...[
                        ArtistCard(
                          artistName: artist1Data?['name'] ?? track1Data!['artist']['name'],
                          artistImageUrl: artist1Data?['picture_medium'] ?? track1Data!['artist']['picture_medium'],
                          artistLink: artist1Data?['link'] ?? track1Data!['artist']['link'],
                          artistFans: artist1Data?['nb_fan'] ?? track1Data!['artist']['nb_fan'],
                          borderColor: Colors.teal,
                        ),
                        SizedBox(height: 20),
                        Divider(
                          color: Colors.grey[900],
                          thickness: 1.0,
                          indent: MediaQuery.of(context).size.width * 0.1,
                          endIndent: MediaQuery.of(context).size.width * 0.1,
                        ),
                        SizedBox(height: 20),
                        ArtistCard(
                          artistName: artist2Data?['name'] ?? track2Data!['artist']['name'],
                          artistImageUrl: artist2Data?['picture_medium'] ?? track2Data!['artist']['picture_medium'],
                          artistLink: artist2Data?['link'] ?? track2Data!['artist']['link'],
                          artistFans: artist2Data?['nb_fan'] ?? track2Data!['artist']['nb_fan'],
                          borderColor: Colors.deepOrange,
                        ),
                      ],
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(width: 20),
            Expanded(
              flex: 2,
              child: Column(
                children: [
                  // Section Musique
                  SizedBox(
                    width: 900,
                    height: 350,
                    child: Card(
                      color: Colors.white,
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'Musique',
                              style: TextStyle(color: Colors.black, fontSize: 20, fontWeight: FontWeight.bold),
                            ),
                            const SizedBox(height: 10),
                            if (areBothTracksSelected)
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SizedBox(
                                    width: 275, // Ajustez la largeur en fonction de vos besoins
                                    height: 200,
                                    child: BarChartWidget(
                                      values: [track1Data!['rank'], track2Data!['rank']],
                                      labels: ['Track 1', 'Track 2'],
                                      title: 'Rang des morceaux',
                                    ),
                                  ),
                                  const SizedBox(width: 50),
                                  SizedBox(
                                    width: 150, // Ajustez la largeur et hauteur en fonction des dimensions souhaitées
                                    height: 200,
                                    child: PieChartWidget(
                                      value1: track1Data!['available_countries'].length * 100 / 330,
                                      value2: track2Data!['available_countries'].length * 100 / 330,
                                      title: 'Pays disponibles',
                                    ),
                                  ),
                                  const SizedBox(width: 50),
                                  SizedBox(
                                    width: 275, // Ajustez la largeur et hauteur en fonction de vos besoins
                                    height: 200,
                                    child: BarChartWidget(
                                      values: [track1Data!['duration'], track2Data!['duration']],
                                      labels: ['Track 1', 'Track 2'],
                                      title: 'Durée des morceaux',
                                    ),
                                  ),
                                ],
                              ),
                          ],
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(height: 20),

                  // Section Album
                  SizedBox(
                    width: 900,
                    height: 350,
                    child: Card(
                      color: Colors.white,
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'Album',
                              style: TextStyle(color: Colors.black, fontSize: 20, fontWeight: FontWeight.bold),
                            ),
                            const SizedBox(height: 10),
                            if (areBothTracksSelected)
                              Row(
                                children: [
                                  SizedBox(
                                    width: 300, // Ajustez la largeur si nécessaire
                                    height: 200, // Ajustez la hauteur si nécessaire
                                    child: BarChartWidget(
                                      values: [double.parse((album1Data!['duration'] / 60).toStringAsFixed(1)), double.parse((album2Data!['duration'] / 60).toStringAsFixed(1))],
                                      labels: ['Album 1', 'Album 2'],
                                      title: 'Durée des albums (min)',
                                    ),
                                  ),
                                  SizedBox(
                                    width: 500,
                                    height: 200,
                                    child: LineChartWidget(
                                      track1Durations: [210, 180, 200, 240], // Durée des morceaux de la première musique
                                      track2Durations: [220, 190, 210, 230], // Durée des morceaux de la deuxième musique
                                      title: 'Durées des morceaux',
                                    ),
                                  ),
                                ],
                              ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
