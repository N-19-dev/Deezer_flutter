// lib/widgets/charts/pie_chart.dart
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class PieChartWidget extends StatelessWidget {
  final double value1; // The value1 of the portion
  final double value2; // The value2 of the portion
  final String title; // The title for the chart (e.g., "Duration", "Countries")

  const PieChartWidget({
    Key? key,
    required this.value1,
    required this.value2,
    required this.title,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          title,
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.black),
        ),
        SizedBox(height: 10),
        AspectRatio(
          aspectRatio: 1,
          child: PieChart(
            PieChartData(
              sectionsSpace: 2,
              centerSpaceRadius: 40,
              sections: _buildPieChartSections(),
            ),
          ),
        ),
      ],
    );
  }

  List<PieChartSectionData> _buildPieChartSections() {
    return [
      PieChartSectionData(
        color: Colors.teal,
        value: value1,
        title: '${value1.toStringAsFixed(1)}%',
        radius: 50,
        titleStyle: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white),
      ),
      PieChartSectionData(
        color: Colors.deepOrange,
        value: value2,
        title: '${value2.toStringAsFixed(1)}%',
        radius: 40,
      ),
    ];
  }
}
