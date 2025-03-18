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
}
