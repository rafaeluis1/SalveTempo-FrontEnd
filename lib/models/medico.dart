//Map<String, bool> diaPeriodoTrabalho;
import 'package:salvetempo/models/paciente.dart';
import 'package:salvetempo/models/unidadeSaudeModels.dart';

class Especializacao {
  int id;
  String nome;

  Especializacao({this.id, this.nome});

  Especializacao.fromJson(Map<String, dynamic> json) {
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

class Medico {
  int id;
  Usuario usuario;
  Especializacao especializacao;
  String nome;
  String sexo;
  String dataNasc;
  String crm;

  Medico(
      {this.id,
      this.usuario,
      this.especializacao,
      this.nome,
      this.sexo,
      this.dataNasc,
      this.crm});

  Medico.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    usuario = Usuario.fromJson(json['usuario']);
    especializacao = Especializacao.fromJson(json['especializacao']);
    nome = json['nome'];
    sexo = json['sexo'];
    dataNasc = json['dataNasc'];
    crm = json['crm'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();

    data['id'] = this.id;
    data['usuario'] = this.usuario.toJson();
    data['especializacao'] = this.especializacao.toJson();
    data['nome'] = this.nome;
    data['sexo'] = this.sexo;
    data['dataNasc'] = this.dataNasc;
    data['crm'] = this.crm;

    return data;
  }
}

class OpcaoConsulta {
  Medico medico;
  UnidadeSaude unidadeSaude;
  DateTime dataConsulta;

  OpcaoConsulta({this.medico, this.unidadeSaude, this.dataConsulta});
}
