class Contato {
  String? nome;
  int? idade;
  String? cpf;
  String? id;

  Contato({
    required this.nome,
    required this.idade,
    required this.cpf,
    required this.id,
  });

  Contato.fromMap(Map<String, dynamic> map) {
    nome = map["nome"];
    cpf = map["cpf"];
    idade = map["idade"];
    id = map["id"];
  }

  Map<String, dynamic> toMap() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['nome'] = nome;
    data['idade'] = idade;
    data['cpf'] = cpf;
    data['id'] = id;
    return data;
  }
}
