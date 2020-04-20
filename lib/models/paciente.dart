class Paciente {
  String nome;
  String sexo;
  String dataNasc;
  String email;
  String senha;

  Paciente({this.nome, this.sexo, this.dataNasc, this.email, this.senha});

  Paciente.fromJson(Map<String, dynamic> json) {
    nome = json['nome'];
    sexo = json['sexo'];
    dataNasc = json['dataNasc'];
    email = json['email'];
    senha = json['senha'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['nome'] = this.nome;
    data['sexo'] = this.sexo;
    data['dataNasc'] = this.dataNasc;
    data['email'] = this.email;
    data['senha'] = this.senha;
    return data;
  }
}
