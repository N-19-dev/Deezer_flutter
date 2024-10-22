import 'package:deezer_dashboard/Bar_Chart/bar_chart.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:fl_chart/fl_chart.dart';

void main() => runApp(MusicComparisonApp());

class MusicComparisonApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Music Comparison Dashboard',
      home: MusicComparisonScreen(),
    );
  }
}

class MusicComparisonScreen extends StatefulWidget {
  @override
  _MusicComparisonScreenState createState() => _MusicComparisonScreenState();
}

class _MusicComparisonScreenState extends State<MusicComparisonScreen> {
  final TextEditingController _trackController1 = TextEditingController();
  final TextEditingController _trackController2 = TextEditingController();

  Map<String, dynamic>? _track1Data;
  Map<String, dynamic>? _track2Data;

  Future<void> fetchTrackData(String track, int trackNumber) async {
    final response = await http.get(Uri.parse('https://api.deezer.com/search?q=$track'));

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      if (trackNumber == 1) {
        setState(() {
          _track1Data = data['data'][0];
        });
      } else {
        setState(() {
          _track2Data = data['data'][0];
        });
      }
    } else {
      throw Exception('Failed to load track data');
    }
  }

  String determineBetterTrack() {
    if (_track1Data != null && _track2Data != null) {
      int popularity1 = _track1Data!['rank'];
      int popularity2 = _track2Data!['rank'];
      return popularity1 > popularity2 ? 'Track 1 is better' : 'Track 2 is better';
    }
    return '';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Compare Two Songs')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _trackController1,
              decoration: InputDecoration(
                hintText: 'Enter the first track',
              ),
            ),
            SizedBox(height: 10),
            TextField(
              controller: _trackController2,
              decoration: InputDecoration(
                hintText: 'Enter the second track',
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                fetchTrackData(_trackController1.text, 1);
                fetchTrackData(_trackController2.text, 2);
              },
              child: Text('Compare Tracks'),
            ),
            SizedBox(height: 20),
            _track1Data != null && _track2Data != null
                ? Expanded(
                    child: Column(
                      children: [
                        _buildTrackCard(_track1Data!),
                        _buildTrackCard(_track2Data!),
                        SizedBox(height: 20),
                        Text(determineBetterTrack()),
                        MyBarChart(),
                      ],
                    ),
                  )
                : Text('Enter two tracks to compare'),
          ],
        ),
      ),
    );
  }

  Widget _buildTrackCard(Map<String, dynamic> trackData) {
    return Card(
      child: Column(
        children: [
          Image.network(trackData['album']['cover']),
          Text('Title: ${trackData['title']}'),
          Text('Artist: ${trackData['artist']['name']}'),
          Text('Duration: ${trackData['duration']} sec'),
          Text('Popularity: ${trackData['rank']}'),
        ],
      ),
    );
  }


}