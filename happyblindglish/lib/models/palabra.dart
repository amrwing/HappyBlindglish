class Palabra {
  final String palabraEspanol;
  final String palabraIngles;
  final String tipo;
  final int nivel;
  final bool aprendido;

  Palabra({
    required this.palabraEspanol,
    required this.palabraIngles,
    required this.tipo,
    required this.nivel,
    this.aprendido = false,
  });

  // Convertir Palabra a un Map
  Map<String, dynamic> toMap() {
    return {
      'palabraEspanol': palabraEspanol,
      'palabraIngles': palabraIngles,
      'tipo': tipo,
      'nivel': nivel,
      'aprendido': aprendido ? 1 : 0, // Convertir bool a int
    };
  }

  // Crear Palabra desde un Map
  factory Palabra.fromMap(Map<String, dynamic> map) {
    return Palabra(
      palabraEspanol: map['palabraEspanol'],
      palabraIngles: map['palabraIngles'],
      tipo: map['tipo'],
      nivel: map['nivel'],
      aprendido: map['aprendido'] == 1, // Convertir int a bool
    );
  }

  @override
  String toString() {
    return 'Palabra( palabraEspanol: $palabraEspanol, palabraIngles: $palabraIngles, tipo: $tipo, nivel: $nivel, aprendido: $aprendido)';
  }
}
