class Pais {
  int id;
  String nome;

  Pais({this.id, this.nome});

  Pais.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    nome = json['nome'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();

    data['id'] = this.id;
    data['nome'] = this.nome;

    return data;
  }
}

class Estado {
  int id;
  Pais pais;
  String sigla;
  String nome;

  Estado({this.id, this.pais, this.sigla, this.nome});

  Estado.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    pais = Pais.fromJson(json['pais']);
    sigla = json['sigla'];
    nome = json['nome'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();

    data['id'] = this.id;
    data['pais'] = this.pais.toJson();
    data['sigla'] = this.sigla;
    data['nome'] = this.nome;

    return data;
  }
}

class Cidade {
  int id;
  Estado estado;
  String nome;
  double latitude;
  double longitude;

  Cidade({this.id, this.estado, this.nome, this.latitude, this.longitude});

  Cidade.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    estado = Estado.fromJson(json['estado']);
    nome = json['nome'];
    latitude = json['latitude'];
    longitude = json['longitude'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();

    data['id'] = this.id;
    data['estado'] = this.estado.toJson();
    data['nome'] = this.nome;
    data['latitude'] = this.latitude;
    data['longitude'] = this.longitude;

    return data;
  }
}

class Endereco {
  int id;
  Cidade cidade;
  String bairro;
  String logradouro;
  String numero;
  String complemento;

  Endereco(
      {this.id,
      this.cidade,
      this.bairro,
      this.logradouro,
      this.numero,
      this.complemento});

  Endereco.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    cidade = Cidade.fromJson(json['cidade']);
    bairro = json['bairro'];
    logradouro = json['logradouro'];
    numero = json['numero'];
    complemento = json['complemento'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();

    data['id'] = this.id;
    data['cidade'] = this.cidade.toJson();
    data['bairro'] = this.bairro;
    data['logradouro'] = this.logradouro;
    data['numero'] = this.numero;
    data['complemento'] = this.complemento;

    return data;
  }
}
