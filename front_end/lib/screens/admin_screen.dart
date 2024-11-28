import 'package:flutter/material.dart';
import '../api/api_service.dart';

class AdminScreen extends StatefulWidget {
  const AdminScreen({super.key});

  @override
  State<AdminScreen> createState() => _AdminScreenState();
}

class _AdminScreenState extends State<AdminScreen> {
  final ApiService _apiService = ApiService();
  final _formKey = GlobalKey<FormState>();
  final Map<String, dynamic> _movieData = {
    'titulo': '',
    'anio': '',
    'director': '',
    'genero': '',
    'sinopsis': '',
    'imagen_url': '',
  };

  Future<void> _addMovie() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();

      try {
        await _apiService.addMovie(_movieData);

        if (!mounted) return; // Verifica si el widget sigue montado
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Película agregada exitosamente')),
        );
        Navigator.pop(context);
      } catch (e) {
        if (!mounted) return; // Verifica nuevamente antes de usar BuildContext
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Error al agregar película')),
        );
      }
    }
  }

  Future<void> _deleteMovie(String id) async {
    try {
      await _apiService.deleteMovie(int.parse(id));

      if (!mounted) return; // Verifica si el widget sigue montado
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Película eliminada exitosamente')),
      );
      setState(() {});
    } catch (e) {
      if (!mounted) return; // Verifica nuevamente antes de usar BuildContext
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Error al eliminar película')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Administrar Catálogo")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            ElevatedButton(
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (context) {
                    return AlertDialog(
                      title: const Text("Agregar Película"),
                      content: Form(
                        key: _formKey,
                        child: SingleChildScrollView(
                          child: Column(
                            children: [
                              TextFormField(
                                decoration: const InputDecoration(labelText: 'Título'),
                                onSaved: (value) => _movieData['titulo'] = value,
                                validator: (value) =>
                                    value == null || value.isEmpty ? 'Campo requerido' : null,
                              ),
                              TextFormField(
                                decoration: const InputDecoration(labelText: 'Año'),
                                keyboardType: TextInputType.number,
                                onSaved: (value) => _movieData['anio'] = int.tryParse(value!),
                                validator: (value) =>
                                    value == null || value.isEmpty ? 'Campo requerido' : null,
                              ),
                              TextFormField(
                                decoration: const InputDecoration(labelText: 'Director'),
                                onSaved: (value) => _movieData['director'] = value,
                                validator: (value) =>
                                    value == null || value.isEmpty ? 'Campo requerido' : null,
                              ),
                              TextFormField(
                                decoration: const InputDecoration(labelText: 'Género'),
                                onSaved: (value) => _movieData['genero'] = value,
                                validator: (value) =>
                                    value == null || value.isEmpty ? 'Campo requerido' : null,
                              ),
                              TextFormField(
                                decoration: const InputDecoration(labelText: 'Sinopsis'),
                                onSaved: (value) => _movieData['sinopsis'] = value,
                                validator: (value) =>
                                    value == null || value.isEmpty ? 'Campo requerido' : null,
                              ),
                              TextFormField(
                                decoration: const InputDecoration(labelText: 'URL de la Imagen'),
                                onSaved: (value) => _movieData['imagen_url'] = value,
                                validator: (value) =>
                                    value == null || value.isEmpty ? 'Campo requerido' : null,
                              ),
                            ],
                          ),
                        ),
                      ),
                      actions: [
                        TextButton(
                          onPressed: () => Navigator.pop(context),
                          child: const Text("Cancelar"),
                        ),
                        ElevatedButton(
                          onPressed: _addMovie,
                          child: const Text("Agregar"),
                        ),
                      ],
                    );
                  },
                );
              },
              child: const Text("Agregar Película"),
            ),
            Expanded(
              child: FutureBuilder<List<Map<String, dynamic>>>(
                future: _apiService.getMovies(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (snapshot.hasError) {
                    return Center(child: Text("Error: ${snapshot.error}"));
                  } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                    return const Center(child: Text("No hay películas disponibles"));
                  } else {
                    final movies = snapshot.data!;
                    return ListView.builder(
                      itemCount: movies.length,
                      itemBuilder: (context, index) {
                        final movie = movies[index];
                        return ListTile(
                          title: Text(movie['titulo']),
                          trailing: IconButton(
                            icon: const Icon(Icons.delete, color: Colors.red),
                            onPressed: () => _deleteMovie(movie['id'].toString()),
                          ),
                        );
                      },
                    );
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
