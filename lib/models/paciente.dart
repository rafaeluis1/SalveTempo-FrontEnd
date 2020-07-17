class Usuario {
  int id;
  String email;
  String username;

  Usuario({this.id, this.email, this.username});

  Usuario.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    email = json['email'];
    username = json['username'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['email'] = this.email;
    data['username'] = this.username;
    return data;
  }
}

class Paciente {
  int id;
  int usuario_id;
  String nome;
  String sexo;
  String dataNasc;
  Usuario usuario;

  Paciente(
      {this.usuario_id, this.nome, this.sexo, this.dataNasc, this.usuario});

  Paciente.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    usuario = Usuario.fromJson(json['usuario']);
    nome = json['nome'];
    sexo = json['sexo'];
    dataNasc = json['dataNasc'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    //data['usuario_id'] = this.usuario_id;
    data['usuario'] = this.usuario.toJson();
    data['nome'] = this.nome;
    data['sexo'] = this.sexo;
    data['dataNasc'] = this.dataNasc;
    return data;
  }
}

/*class Paciente {
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
}*/
