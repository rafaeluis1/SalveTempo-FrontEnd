import 'package:salvetempo/models/medico.dart';

class MedicoService {
  List<Medico> createMedicos() {
    List<Medico> medicos = new List<Medico>();

    Medico medico1 = new Medico(
        id: 1,
        nome: 'Diego Thomas Luís Teixeira',
        sexo: 'M',
        dataNasc: '06/02/1982',
        unidadeSaude: 'Hospital Teste',
        diaPeriodoTrabalho: {"manha": true, "tarde": true, "noite": false},
        especializacao: 'Clínico Geral');
    medicos.add(medico1);

    Medico medico2 = new Medico(
        id: 2,
        nome: 'Tereza Adriana Vera da Rosa',
        sexo: 'F',
        dataNasc: '11/09/1975',
        unidadeSaude: 'Hospital Teste',
        diaPeriodoTrabalho: {"manha": false, "tarde": true, "noite": true},
        especializacao: 'Clínico Geral');
    medicos.add(medico2);

    Medico medico3 = new Medico(
        id: 3,
        nome: 'Guilherme José Barbosa',
        sexo: 'M',
        dataNasc: '27/07/1991',
        unidadeSaude: 'Hospital Teste',
        diaPeriodoTrabalho: {"manha": true, "tarde": false, "noite": true},
        especializacao: 'Clínico Geral');
    medicos.add(medico3);

    return medicos;
  }
}
