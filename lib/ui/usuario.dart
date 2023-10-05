class Usuario {
  int? id; // O ID será gerado automaticamente no banco de dados.
  String nome;
  String senha;
  int idade;
  String email;

  Usuario({
    required this.nome,
    required this.senha,
    required this.idade,
    required this.email,
  });

  // Um construtor factory para criar um objeto de usuário a partir de um mapa.
  factory Usuario.fromMap(Map<String, dynamic> map) {
    return Usuario(
      nome: map['nome'],
      senha: map['senha'],
      idade: map['idade'],
      email: map['email'],
    );
  }

  // Um método para converter o objeto de usuário em um mapa.
  Map<String, dynamic> toMap() {
    return {
      'nome': nome,
      'senha': senha,
      'idade': idade,
      'email': email,
    };
  }
}
