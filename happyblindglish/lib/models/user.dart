class Usuario {
  int? id; // ID del usuario (puede ser nulo si no está en la base de datos)
  String nombre; // Nombre del usuario
  int edad; // Edad del usuario
  int puntos; // Puntos acumulados por el usuario
  int nivel; // Nivel del usuario

  // Constructor
  Usuario({
    this.id,
    required this.nombre,
    required this.edad,
    required this.puntos,
    required this.nivel,
  });

  // Método para convertir un Usuario a un Map (útil para insertar en la base de datos)
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'nombre': nombre,
      'edad': edad,
      'puntos': puntos,
      'nivel': nivel,
    };
  }

  // Método para crear un Usuario desde un Map (útil para recuperar de la base de datos)
  factory Usuario.fromMap(Map<String, dynamic> map) {
    return Usuario(
      id: map['id'],
      nombre: map['nombre'],
      edad: map['edad'],
      puntos: map['puntos'],
      nivel: map['nivel'],
    );
  }

  // Método toString para imprimir la información del usuario
  @override
  String toString() {
    return 'Usuario(id: $id, nombre: $nombre, edad: $edad, puntos: $puntos, nivel: $nivel)';
  }
}