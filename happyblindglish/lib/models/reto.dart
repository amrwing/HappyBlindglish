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

  // Convertir Reto a un Map
  Map<String, dynamic> toMap() {
    return {
      'nombre': nombre,
      'tipo': tipo,
      'tema': tema,
      'descripcion': descripcion,
      'estatusCompletado': estatusCompletado ? 1 : 0, // Convertir bool a int
      'puntosReto': datosReto.puntosReto,
      'palabrasPorAprender': datosReto.palabrasPorAprender,
    };
  }

  // Crear Reto desde un Map
  factory Reto.fromMap(Map<String, dynamic> map) {
    return Reto(
      nombre: map['nombre'],
      tipo: map['tipo'],
      tema: map['tema'],
      descripcion: map['descripcion'],
      estatusCompletado: map['estatusCompletado'] == 1, // Convertir int a bool
      datosReto: DatosReto(
        puntosReto: map['puntosReto'],
        palabrasPorAprender: map['palabrasPorAprender'],
      ),
    );
  }

  @override
  String toString() {
    return 'Reto(nombre: $nombre, tipo: $tipo, tema: $tema, descripcion: $descripcion, estatusCompletado: $estatusCompletado, datosReto: $datosReto)';
  }
}

class DatosReto {
  int puntosReto;
  int palabrasPorAprender;

  DatosReto({
    required this.puntosReto,
    required this.palabrasPorAprender,
  });

  // Convertir DatosReto a un Map
  Map<String, dynamic> toMap() {
    return {
      'puntosReto': puntosReto,
      'palabrasPorAprender': palabrasPorAprender,
    };
  }

  // Crear DatosReto desde un Map
  factory DatosReto.fromMap(Map<String, dynamic> map) {
    return DatosReto(
      puntosReto: map['puntosReto'],
      palabrasPorAprender: map['palabrasPorAprender'],
    );
  }

  @override
  String toString() {
    return 'DatosReto(puntosReto: $puntosReto, palabrasPorAprender: $palabrasPorAprender,)';
  }
}
