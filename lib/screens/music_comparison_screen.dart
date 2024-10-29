// lib/screens/music_comparison_screen.dart
import 'package:flutter/material.dart';
import '../widgets/cards/track_card.dart';
import '../widgets/cards/dashboard_card.dart';
import '../widgets/cards/search_card.dart';
import '../services/api_call.dart';

class MusicComparisonScreen extends StatefulWidget {
  @override
  _MusicComparisonScreenState createState() => _MusicComparisonScreenState();
}

class _MusicComparisonScreenState extends State<MusicComparisonScreen> {
  final TextEditingController _trackController1 = TextEditingController();
  final TextEditingController _trackController2 = TextEditingController();

  List<dynamic>? _generalData1 = [];
  List<dynamic>? _generalData2 = [];

  Map<String, dynamic>? _trackData1;
  Map<String, dynamic>? _trackData2;
  Map<String, dynamic>? _artist1Data;
  Map<String, dynamic>? _artist2Data;
  Map<String, dynamic>? _album1Data;
  Map<String, dynamic>? _album2Data;

  Future<void> fetchGeneralData(String track, int trackNumber) async {
    try {
      final data = await ApiCall.fetchGeneralData(track);
      setState(() {
        if (trackNumber == 1) {
          _generalData1 = data;
        } else {
          _generalData2 = data;
        }
      });
    } catch (e) {
      print('Erreur lors de la récupération des données: $e');
    }
  }

  void selectTrack(Map<String, dynamic> generalData, int trackNumber) async {
    final trackId = generalData['id'];
    final trackData = await ApiCall.fetchTrackData(trackId); // Obtenir les données spécifiques du morceau

    final artistId = generalData['artist']['id'];
    final artistData = await ApiCall.fetchArtistData(artistId);

    final albumId = generalData['album']['id'];
    final albumData = await ApiCall.fetchAlbumData(albumId);

    if (trackNumber == 1) {
      setState(() {
        _trackData1 = trackData;
        _artist1Data = artistData;
        _album1Data = albumData;
        _generalData1 = [];
        _trackController1.text = generalData['title'];
      });
    } else {
      setState(() {
        _trackData2 = trackData;
        _artist2Data = artistData;
        _album2Data = albumData;
        _generalData2 = [];
        _trackController2.text = generalData['title'];
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Comparateur de Morceaux')),
      backgroundColor: Colors.black,
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            SearchCard(
              controller1: _trackController1,
              controller2: _trackController2,
              onChangedTrack1: (value) {
                if (value.isNotEmpty) {
                  fetchGeneralData(value, 1);
                } else {
                  setState(() {
                    _generalData1 = [];
                  });
                }
              },
              onChangedTrack2: (value) {
                if (value.isNotEmpty) {
                  fetchGeneralData(value, 2);
                } else {
                  setState(() {
                    _generalData2 = [];
                  });
                }
              },
              track1Suggestions: _generalData1,
              track2Suggestions: _generalData2,
              onSelectTrack: selectTrack,
            ),
            SizedBox(height: 20),
            if (_trackData1 != null || _trackData2 != null)
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  if (_trackData1 != null)
                    TrackCard(trackData: _trackData1!, title: _trackData1!['title']),
                  if (_trackData2 != null)
                    TrackCard(trackData: _trackData2!, title: _trackData2!['title']),
                ],
              ),
            SizedBox(height: 20),
            Divider(
              color: Colors.white,
              thickness: 1.0,
              indent: MediaQuery.of(context).size.width * 0.1,
              endIndent: MediaQuery.of(context).size.width * 0.1,
            ),
            SizedBox(height: 20),
            if (_trackData1 == null || _trackData2 == null)
              const Text(
                'Veuillez sélectionner 2 morceaux pour commencer la comparaison.',
                style: TextStyle(color: Colors.white),
                textAlign: TextAlign.center,
              ),
            if (_trackData1 != null && _trackData2 != null)
              DashboardCard(
                track1Data: _trackData1!,
                track2Data: _trackData2!,
                artist1Data: _artist1Data,
                artist2Data: _artist2Data,
                album1Data: _album1Data,
                album2Data: _album2Data,
                areBothTracksSelected: true,
              ),
          ],
        ),
      ),
    );
  }
}
