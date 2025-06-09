import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiService {
  final String baseUrl = 'http://10.0.2.2:8000'; // für Android-Emulator

  Future<String> askQuestion(String question) async {
    final url = Uri.parse('$baseUrl/ask');
    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
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
