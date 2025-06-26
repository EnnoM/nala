import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class ApiService {
  final String baseUrl = 'http://10.0.2.2:8000'; // für Android Emulator

  // SPEICHERN DES TOKENS
  Future<void> _saveToken(String token) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('jwt_token', token);
  }

  // LADEN DES TOKENS
  Future<String?> getToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('jwt_token');
  }

  // LOGIN
  Future<bool> login(String username, String password) async {
    final url = Uri.parse('$baseUrl/login');
    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'username': username, 'password': password}),
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      final token = data['token'];
      await _saveToken(token);
      return true;
    } else {
      return false;
    }
  }

  // REGISTRIERUNG
  Future<bool> register(String username, String password) async {
    final url = Uri.parse('$baseUrl/register');
    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'username': username, 'password': password}),
    );

    return response.statusCode == 200;
  }

  // FRAGE STELLEN
  Future<String> askQuestion(String question) async {
    final url = Uri.parse('$baseUrl/ask');
    final token = await getToken();

    final response = await http.post(
      url,
      headers: {
        'Content-Type': 'application/json',
        if (token != null) 'Authorization': 'Bearer $token',
      },
      body: jsonEncode({'question': question}),
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return data['answer'] ?? 'Keine Antwort erhalten.';
    } else {
      throw Exception('Fehler vom Server: ${response.statusCode}');
    }
  }
}
