class LeccionPregunta {
  final String preguntaEspanol;
  final String preguntaIngles;
  final bool completada;
  final List<Respuesta> respuestas;
  final String tipoPalabra;

  LeccionPregunta(
    this.preguntaEspanol,
    this.preguntaIngles,
    this.completada, {
    required this.respuestas,
    required this.tipoPalabra,
  });
}

class Respuesta {
  String respuesta;
  bool correcta;

  Respuesta({
    required this.respuesta,
    required this.correcta,
  });
}
