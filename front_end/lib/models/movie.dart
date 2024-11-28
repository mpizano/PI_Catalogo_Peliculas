class Movie {
  final int id;
  final String titulo;
  final int anio;
  final String director;
  final String genero;
  final String sinopsis;
  final String imagenUrl;

  // Constructor
  Movie({
    required this.id,
    required this.titulo,
    required this.anio,
    required this.director,
    required this.genero,
    required this.sinopsis,
    required this.imagenUrl,
  });

  // Factory para crear un objeto Movie desde un JSON
  factory Movie.fromJson(Map<String, dynamic> json) {
    return Movie(
      id: json['id'] ?? 0, // Usamos un valor predeterminado si no hay 'id'
      titulo: json['titulo'] ?? '',
      anio: json['anio'] ?? 0,
      director: json['director'] ?? '',
      genero: json['genero'] ?? '',
      sinopsis: json['sinopsis'] ?? '',
      imagenUrl: json['imagen_url'] ?? '',
    );
  }

  // Método para convertir un objeto Movie a JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'titulo': titulo,
      'anio': anio,
      'director': director,
      'genero': genero,
      'sinopsis': sinopsis,
      'imagen_url': imagenUrl,
    };
  }
}
