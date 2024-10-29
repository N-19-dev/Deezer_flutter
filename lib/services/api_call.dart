// lib/services/api_call.dart
import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiCall {
  static Future<List<dynamic>> fetchGeneralData(String track) async {
    final response = await http.get(Uri.parse('https://api.deezer.com/search?q=$track'));

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      return data['data'].isNotEmpty ? data['data'] : [];
    } else {
      throw Exception('Failed to load general data');
    }
  }

  static Future<Map<String, dynamic>> fetchTrackData(int trackId) async {
    final response = await http.get(Uri.parse('https://api.deezer.com/track/$trackId'));

    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Failed to load track data');
    }
  }

  static Future<Map<String, dynamic>> fetchArtistData(int artistId) async {
    final response = await http.get(Uri.parse('https://api.deezer.com/artist/$artistId'));

    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Failed to load artist data');
    }
  }

  static Future<Map<String, dynamic>> fetchAlbumData(int albumId) async {
    final response = await http.get(Uri.parse('https://api.deezer.com/album/$albumId'));

    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Failed to load album data');
    }
  }
}
