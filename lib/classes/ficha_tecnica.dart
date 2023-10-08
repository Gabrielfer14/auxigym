class FichaTecnica {
  int? id;
  double altura;
  double peso;
  String objetivoUsuario;
  int idUsuario;

  FichaTecnica({
    this.id,
    required this.altura,
    required this.peso,
    required this.objetivoUsuario,
    required this.idUsuario,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'altura': altura,
      'peso': peso,
      'objetivo_usuario': objetivoUsuario,
      'id_usuario': idUsuario,
    };
  }

  factory FichaTecnica.fromMap(Map<String, dynamic> map) {
    return FichaTecnica(
      id: map['id'],
      altura: map['altura'],
      peso: map['peso'],
      objetivoUsuario: map['objetivo_usuario'],
      idUsuario: map['id_usuario'],
    );
  }
}
