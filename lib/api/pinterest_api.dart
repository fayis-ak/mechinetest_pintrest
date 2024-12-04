import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;

 
  
class ApiService {
  final String baseurl =
      "https://api.unsplash.com/photos/?client_id=Uv0YoXq-_CRT4Ymt0r_L148-2ia3nBmDSZrp8Zi6TZA";

  Future<List<dynamic>> fetchData() async {
    try {
      final response = await http.get(Uri.parse(baseurl));
      if (response.statusCode == 200) {
        return jsonDecode(response.body);
      } else {
        throw Exception('Failed to load data: ${response.statusCode}');
      }
    } on SocketException {
      throw Exception('No Internet connection');
    } catch (e) {
      throw Exception('Unexpected error: $e');
    }
  }
}

