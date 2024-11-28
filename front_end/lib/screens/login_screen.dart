// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import '../api/api_service.dart';
import 'catalog_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _correoController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final ApiService _apiService = ApiService();

  void _login() async {
    final correo = _correoController.text.trim();
    final password = _passwordController.text.trim();

    // Validación de campos vacíos
    if (correo.isEmpty || password.isEmpty) {
      _showSnackbar("Por favor, completa todos los campos");
      return;
    }

    try {
      // Log de datos enviados
      // ignore: avoid_print
      print("Intentando iniciar sesión con correo: $correo");

      final response = await _apiService.login(correo, password);

      if (response['status'] == 'success') {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const CatalogScreen()),
        );
      } else {
        _showSnackbar(response['message'] ?? "Error desconocido");
      }
    } catch (e) {
      _showSnackbar("Error en la conexión con el servidor");
      // ignore: avoid_print
      print("Error al iniciar sesión: $e");
    }
  }

  void _showSnackbar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(message)));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Iniciar Sesión")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _correoController,
              decoration: const InputDecoration(labelText: "Correo Electrónico"),
              keyboardType: TextInputType.emailAddress,
            ),
            const SizedBox(height: 15),
            TextField(
              controller: _passwordController,
              decoration: const InputDecoration(labelText: "Contraseña"),
              obscureText: true,
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _login,
              child: const Text("Iniciar Sesión"),
            ),
          ],
        ),
      ),
    );
  }
}
