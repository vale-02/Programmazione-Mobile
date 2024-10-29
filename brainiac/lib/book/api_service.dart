import 'dart:convert';
import 'dart:io';

import 'package:brainiac/model/book.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;

class ApiService {
  ApiService._instantiate();

  static final ApiService instance = ApiService._instantiate();
  final String _baseUrl = 'www.googleapis.com';

  Future<List<Book>> fetchBookFromSearch(
    String name,
  ) async {
    Map<String, String> parameters = {
      'q': '$name per università',
      'maxResults': '40',
      'filter': 'partial',
      'printType': 'books',
      'key': dotenv.env['API_BK'] ?? 'API non trovata',
    };
    Uri uri = Uri.https(
      _baseUrl,
      '/books/v1/volumes',
      parameters,
    );
    Map<String, String> headers = {
      HttpHeaders.contentTypeHeader: 'application/json',
    };

    List<Book> book = [];
    var response = await http.get(uri, headers: headers);
    if (response.statusCode == 200) {
      var data = json.decode(response.body);
      List<dynamic> items = data['items'] ?? [];
      book = items.map((item) {
        return Book.fromMap(item as Map<String, dynamic>);
      }).toList();
      return book;
    } else {
      throw json.decode(response.body)['error']['message'];
    }
  }
}
