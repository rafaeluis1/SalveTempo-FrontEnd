class Sintoma {
  int id;
  String nomecsv;
  String nome;

  Sintoma({this.id, this.nomecsv, this.nome});

  Sintoma.fromJson(Map<String, dynamic> json) {
    //id = json['id'];
    nomecsv = json['nomecsv'];
    nome = json['nome'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    //data['id'] = this.id;
    data['nomecsv'] = this.nomecsv;
    data['nome'] = this.nome;
    return data;
  }
}

class SintomaAnswer {
  int counter_doencas;
  bool valido;

  SintomaAnswer({this.counter_doencas, this.valido});

  SintomaAnswer.fromJson(Map<String, dynamic> json) {
    counter_doencas = json['counter_doencas'];
    valido = json['valido'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['counter_doencas'] = this.counter_doencas;
    data['valido'] = this.valido;
    return data;
  }
}
