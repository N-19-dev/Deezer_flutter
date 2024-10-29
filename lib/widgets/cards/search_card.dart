// lib/widgets/search_card.dart
import 'package:flutter/material.dart';

class SearchCard extends StatelessWidget {
  final TextEditingController controller1;
  final TextEditingController controller2;
  final Function(String) onChangedTrack1;
  final Function(String) onChangedTrack2;
  final List<dynamic>? track1Suggestions;
  final List<dynamic>? track2Suggestions;
  final Function(Map<String, dynamic>, int) onSelectTrack;

  const SearchCard({
    Key? key,
    required this.controller1,
    required this.controller2,
    required this.onChangedTrack1,
    required this.onChangedTrack2,
    required this.track1Suggestions,
    required this.track2Suggestions,
    required this.onSelectTrack,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Expanded(
              child: TextField(
                controller: controller1,
                decoration: InputDecoration(
                  labelText: 'Rechercher un morceau',
                  border: OutlineInputBorder(),
                  labelStyle: TextStyle(color: Colors.grey[300]),
                ),
                style: TextStyle(color: Colors.white),
                onChanged: onChangedTrack1,
              ),
            ),
            SizedBox(width: 10),
            Expanded(
              child: TextField(
                controller: controller2,
                decoration: InputDecoration(
                  labelText: 'Rechercher un morceau',
                  border: OutlineInputBorder(),
                  labelStyle: TextStyle(color: Colors.grey[300]),
                ),
                style: TextStyle(color: Colors.white),
                onChanged: onChangedTrack2,
              ),
            ),
          ],
        ),
        SizedBox(height: 20),
        _buildSuggestionsList(track1Suggestions, 1),
        SizedBox(height: 20),
        _buildSuggestionsList(track2Suggestions, 2),
      ],
    );
  }

  Widget _buildSuggestionsList(List<dynamic>? suggestions, int trackNumber) {
    if (suggestions == null || suggestions.isEmpty) return SizedBox();

    return Container(
      height: 200,
      child: ListView.builder(
        itemCount: suggestions.length,
        itemBuilder: (context, index) {
          final track = suggestions[index];
          return ListTile(
            leading: Image.network(
              track['album']['cover_small'],
              width: 50,
              height: 50,
              fit: BoxFit.cover,
            ),
            title: Text(track['title'], style: TextStyle(color: Colors.white)),
            subtitle: Text(track['artist']['name'], style: TextStyle(color: Colors.grey)),
            onTap: () => onSelectTrack(track, trackNumber),
          );
        },
      ),
    );
  }
}
