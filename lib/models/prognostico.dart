class Prognostico {
  int id;
  String doenca;
  double porcentagem;

  Prognostico({this.id, this.doenca, this.porcentagem});

  Prognostico.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    doenca = json['doenca'];
    porcentagem = json['porcentagem'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();

    data['id'] = this.id;
    data['doenca'] = this.doenca;
    data['porcentagem'] = this.porcentagem;

    return data;
  }
}
