import 'dart:convert';
import 'dart:io';

import 'package:brainiac/model/playlist.dart';
import 'package:brainiac/model/video.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;

class APIService {
  APIService._instatiate();

  static final APIService instance = APIService._instatiate();

  final String _baseUrl = 'www.googleapis.com';
  String _nextPageToken = '';
  String _nextPagePlaylist = '';

  Future<List<Video>> fetchVideoFromPlaylist(String id,
      {bool loadMore = false}) async {
    if (loadMore && _nextPagePlaylist == '') {
      return [];
    }

    Map<String, String> parameters = {
      'part': 'snippet',
      'playlistId': id,
      'maxResults': '10',
      'pageToken': loadMore ? _nextPagePlaylist : '',
      'key': dotenv.env['API_YT'] ?? 'API non trovata',
    };
    Uri uri = Uri.https(
      _baseUrl,
      'youtube/v3/playlistItems',
      parameters,
    );
    Map<String, String> headers = {
      HttpHeaders.contentTypeHeader: 'application/json',
    };

    List<Video> video = [];
    var response = await http.get(uri, headers: headers);
    if (response.statusCode == 200) {
      var data = json.decode(response.body);
      _nextPageToken = data['nextPageToken'] ?? '';
      List<dynamic> items = data['items'] ?? [];
      video = items.map((item) {
        return Video.fromMap(item as Map<String, dynamic>);
      }).toList();
      return video;
    } else {
      throw json.decode(response.body)['error']['message'];
    }
  }

  Future<List<dynamic>> fetchVideoFromSearch(String searchName,
      {bool loadMore = false}) async {
    if (loadMore && _nextPageToken == '') {
      return [];
    }

    Map<String, String> parameters = {
      'part': 'snippet',
      'maxResults': '10',
      'pageToken': loadMore ? _nextPageToken : '',
      'q': '$searchName teoria e esercizi',
      'type': 'video,playlist',
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

    List<dynamic> item = [];

    var response = await http.get(uri, headers: headers);
    if (response.statusCode == 200) {
      var data = json.decode(response.body);
      _nextPageToken = data['nextPageToken'] ?? '';
      List<dynamic> videoJson = data['items'] ?? [];

      for (var json in videoJson) {
        if (json['id']['kind'] == 'youtube#video') {
          item.add(Video.fromMap(json));
        } else if (json['id']['kind'] == 'youtube#playlist') {
          item.add(Playlist.fromMap(json));
        }
      }
      return item;
    } else {
      throw json.decode(response.body)['error']['message'];
    }
  }
}
