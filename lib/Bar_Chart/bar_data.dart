import 'package:deezer_dashboard/Bar_Chart/individual_bar.dart';

class BarData {
  final int popularity1;
  final int popularity2;

  BarData({required this.popularity1, required this.popularity2});

  List<IndividualBar> barData = [];

  void initializeBarData() {
    barData = [
      IndividualBar(x: 0, y: popularity1),
      IndividualBar(x: 0, y: popularity2)
    ];
  }
}