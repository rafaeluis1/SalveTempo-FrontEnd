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
