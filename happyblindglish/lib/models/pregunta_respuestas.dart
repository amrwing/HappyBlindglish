
class PreguntaRespuestas {
  String pregunta;
  List<Respuesta> respuestas;
  String tipoPalabra;

  PreguntaRespuestas({
    required this.pregunta,
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




