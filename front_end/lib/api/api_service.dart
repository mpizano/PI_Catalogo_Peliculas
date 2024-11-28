import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiService {
  final String baseUrl = 'http://localhost/catalogo_peliculas/backend/';

  Future<Map<String, dynamic>> login(String correo, String password) async {
    final response = await http.post(
      Uri.parse('${baseUrl}login.php'),
      body: jsonEncode({'correo': correo, 'password': password}),
      headers: {'Content-Type': 'application/json'},
    );

    return jsonDecode(response.body);
  }

  Future<Map<String, dynamic>> register(String correo, String password) async {
    final response = await http.post(
      Uri.parse('${baseUrl}register.php'),
      body: jsonEncode({'correo': correo, 'password': password}),
      headers: {'Content-Type': 'application/json'},
    );

    return jsonDecode(response.body);
  }

  Future<List<Map<String, dynamic>>> getMovies() async {
    final response = await http.get(Uri.parse('${baseUrl}get_movies.php'));
    return List<Map<String, dynamic>>.from(jsonDecode(response.body));
  }

  Future<Map<String, dynamic>> addMovie(Map<String, dynamic> movie) async {
    final response = await http.post(
      Uri.parse('${baseUrl}add_movie.php'),
      body: jsonEncode(movie),
      headers: {'Content-Type': 'application/json'},
    );

    return jsonDecode(response.body);
  }

  Future<Map<String, dynamic>> deleteMovie(int id) async {
    final response = await http.post(
      Uri.parse('${baseUrl}delete_movie.php'),
      body: jsonEncode({'id': id}),
      headers: {'Content-Type': 'application/json'},
    );

    return jsonDecode(response.body);
  }
}
