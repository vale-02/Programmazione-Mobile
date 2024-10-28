import 'dart:convert';
import 'dart:io';

import 'package:brainiac/model/video.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;

class APIService {
  APIService._instatiate();

  static final APIService instance = APIService._instatiate();

  final String _baseUrl = 'www.googleapis.com';
  String _nextPageToken = '';

  Future<List<Video>> fetchVideoFromSearch(
      String searchName, int searchCfu) async {
    Map<String, String> parameters = {
      'part': 'snippet',
      'maxResults': '10',
      'pageToken': _nextPageToken,
      'q': '$searchName teoria e esercizi',
      'type': 'video',
      'key': dotenv.env['API_YT'] ?? 'API non trovata',
    };
    Uri uri = Uri.https(
      _baseUrl,
      '/youtube/v3/search',
      parameters,
    );
    Map<String, String> headers = {
      HttpHeaders.contentTypeHeader: 'application/json',
    };
    var response = await http.get(uri, headers: headers);
    if (response.statusCode == 200) {
      var data = json.decode(response.body);
      _nextPageToken = data['nextPageToken'] ?? '';
      List<dynamic> videoJson = data['items'] ?? [];
      List<Video> videos = [];
      for (var json in videoJson) {
        videos.add(Video.fromMap(json));
      }
      return videos;
    } else {
      throw json.decode(response.body)['error']['message'];
    }
  }
}
