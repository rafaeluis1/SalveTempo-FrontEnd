import 'package:salvetempo/models/localizacaoModels.dart';
import 'package:salvetempo/models/medico.dart';

class UnidadeSaude {
  int id;
  Endereco endereco;
  String nome;
  String tipo;
  List<Medico> medicos;

  UnidadeSaude({this.id, this.endereco, this.nome, this.tipo});

  UnidadeSaude.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    endereco = Endereco.fromJson(json['endereco']);
    nome = json['nome'];
    tipo = json['tipo'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();

    data['id'] = this.id;
    data['endereco'] = this.endereco.toJson();
    data['nome'] = this.nome;
    data['tipo'] = this.tipo;

    return data;
  }
}

class MedicoUnidadeSaude {
  int id;
  Medico medico;
  UnidadeSaude unidadeSaude;
  String diaPeriodoTrabalho;
  String status;

  MedicoUnidadeSaude(
      {this.id,
      this.medico,
      this.unidadeSaude,
      this.diaPeriodoTrabalho,
      this.status});

  MedicoUnidadeSaude.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    medico = Medico.fromJson(json['medico']);
    unidadeSaude = UnidadeSaude.fromJson(json['unidadeSaude']);
    diaPeriodoTrabalho = json['diaPeriodoTrabalho'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();

    data['id'] = this.id;
    data['medico'] = this.medico;
    data['unidadeSaude'] = this.unidadeSaude;
    data['diaPeriodoTrabalho'] = this.diaPeriodoTrabalho;
    data['status'] = this.status;

    return data;
  }
}
