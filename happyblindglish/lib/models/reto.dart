class Reto {
  String nombre;
  String tipo;
  String descripcion;
  bool estatusCompletado;
  DatosReto datosReto;

  Reto({
    required this.nombre,
    required this.tipo,
    required this.descripcion,
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
