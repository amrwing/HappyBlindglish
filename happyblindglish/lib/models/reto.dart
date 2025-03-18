class Reto {
  String? nombre;
  String tipo;
  String? tema;
  String? descripcion;
  bool estatusCompletado;
  DatosReto datosReto;

  Reto({
    this.tema,
    this.nombre,
    required this.tipo,
    this.descripcion,
    required this.estatusCompletado,
    required this.datosReto,
  });
}

class DatosReto {
  int puntosReto;
  int palabrasPorAprender;
  int palabrasAprendidas;

  DatosReto({
    required this.puntosReto,
    required this.palabrasPorAprender,
    required this.palabrasAprendidas,
  });
}
