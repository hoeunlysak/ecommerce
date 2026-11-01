import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiService {
  ApiService._();

  // Use 10.0.2.2 for Android Emulator to connect to localhost on your PC
  static const String baseUrl = 'http://10.0.2.2:5000/api';

  static const Map<String, String> _jsonHeaders = {
    'Content-Type': 'application/json',
  };

  static Uri _uri(String path) => Uri.parse('$baseUrl/$path');

  /// Fetches the product list from the ASP.NET Core API.
  /// Returns an empty list if the request fails.
  static Future<List<dynamic>> fetchProducts() async {
    try {
      final response = await http.get(_uri('products'));
      if (response.statusCode != 200) {
        throw Exception('Failed to load products');
      }
      return json.decode(response.body);
    } catch (e) {
      print('API Error: $e');
      return [];
    }
  }

  /// Logs the user in. Returns true on success, false otherwise.
  static Future<bool> loginUser(String email, String password) async {
    try {
      final response = await http.post(
        _uri('auth/login'),
        headers: _jsonHeaders,
        body: json.encode({'email': email, 'password': password}),
      );
      return response.statusCode == 200;
    } catch (e) {
      print('Login Error: $e');
      return false;
    }
  }
}