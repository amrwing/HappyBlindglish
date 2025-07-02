class Leccion {
  String nombre; // Nombre de la lección, por ejemplo: "Lección 1: Animales"
  String tema; // Tema de la lección, como "Animales", "Colores", etc.
  String? descripcion; // Descripción opcional de la lección
  int?
      dificultad; // Dificultad de la lección (opcional, puede ser un valor de 1 a 5)

  Leccion({
    required this.nombre,
    required this.tema,
    this.descripcion,
    this.dificultad,
  });

  // Convertir Leccion a un Map
  Map<String, dynamic> toMap() {
    return {
      'nombre': nombre,
      'tema': tema,
      'descripcion': descripcion,
      'dificultad': dificultad,
    };
  }

  // Crear Leccion desde un Map
  factory Leccion.fromMap(Map<String, dynamic> map) {
    return Leccion(
      nombre: map['nombre'],
      tema: map['tema'],
      descripcion: map['descripcion'],
      dificultad: map['dificultad'],
    );
  }

  @override
  String toString() {
    return 'Leccion(nombre: $nombre, tema: $tema, descripcion: $descripcion, dificultad: $dificultad)';
  }
}
