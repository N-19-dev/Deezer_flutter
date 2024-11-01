import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class LineChartWidget extends StatelessWidget {
  final List<double> track1Durations;
  final List<double> track2Durations;
  final String title;

  const LineChartWidget({
    Key? key,
    required this.track1Durations,
    required this.track2Durations,
    required this.title, // Ajout du titre
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Calculer la longueur maximale des listes pour définir les limites de l'axe X
    final int maxLength = [track1Durations.length, track2Durations.length].reduce((a, b) => a > b ? a : b);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Center(
          child: Text(
            title, // Affichage du titre
            style: const TextStyle(
              color: Colors.black,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        const SizedBox(height: 10), // Espacement entre le titre et le graphique
        AspectRatio(
          aspectRatio: 2,
          child: LineChart(
            LineChartData(
              gridData: FlGridData(show: false), // Masquer la grille
              titlesData: FlTitlesData(
                bottomTitles: AxisTitles(
                  sideTitles: SideTitles(
                    showTitles: true, // Afficher seulement l’axe x en noir
                    interval: 1,
                    getTitlesWidget: (value, meta) {
                      int index = value.toInt() + 1;
                      return SideTitleWidget(
                        axisSide: meta.axisSide,
                        space: 4,
                        child: Text(
                          index.toString(),
                          style: const TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: 10,
                          ),
                        ),
                      );
                    },
                  ),
                ),
                leftTitles: AxisTitles(
                  sideTitles: SideTitles(
                    showTitles: true, // Afficher seulement l’axe y en noir
                    reservedSize: 40,
                    getTitlesWidget: (value, meta) {
                      return SideTitleWidget(
                        axisSide: meta.axisSide,
                        space: 4,
                        child: Text(
                          value.toString(),
                          style: const TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: 10,
                          ),
                        ),
                      );
                    },
                  ),
                ),
                topTitles: AxisTitles(
                  sideTitles: SideTitles(showTitles: false), // Masquer les titres supérieurs
                ),
                rightTitles: AxisTitles(
                  sideTitles: SideTitles(showTitles: false), // Masquer les titres à droite
                ),
              ),
              borderData: FlBorderData(
                show: true,
                border: Border.all(color: const Color(0xff37434d), width: 1),
              ),
              minX: 0,
              maxX: maxLength.toDouble(),
              lineBarsData: [
                LineChartBarData(
                  spots: _createSpots(track1Durations),
                  isCurved: false,
                  color: Colors.teal,
                  dotData: FlDotData(show: true),
                  belowBarData: BarAreaData(show: false),
                ),
                LineChartBarData(
                  spots: _createSpots(track2Durations),
                  isCurved: false,
                  color: Colors.deepOrange,
                  dotData: FlDotData(show: true),
                  belowBarData: BarAreaData(show: false),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  List<FlSpot> _createSpots(List<double> durations) {
    return List.generate(durations.length, (index) {
      return FlSpot(index.toDouble(), durations[index]);
    });
  }
}
