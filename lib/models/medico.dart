class Medico {
  int id;
  String nome;
  String sexo;
  String dataNasc;
  String unidadeSaude;
  Map<String, bool> diaPeriodoTrabalho;
  String especializacao;

  Medico(
      {this.id,
      this.nome,
      this.sexo,
      this.dataNasc,
      this.unidadeSaude,
      this.diaPeriodoTrabalho,
      this.especializacao});

  Medico.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    nome = json['nome'];
    sexo = json['sexo'];
    dataNasc = json['dataNasc'];
    unidadeSaude = json['unidadeSaude'];
    diaPeriodoTrabalho = json['diaPeriodoTrabalho'];
    especializacao = json['especializacao'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['nome'] = this.nome;
    data['sexo'] = this.sexo;
    data['dataNasc'] = this.dataNasc;
    data['unidadeSaude'] = this.unidadeSaude;
    data['diaPeriodoTrabalho'] = this.diaPeriodoTrabalho;
    data['especializacao'] = this.especializacao;

    return data;
  }
}
