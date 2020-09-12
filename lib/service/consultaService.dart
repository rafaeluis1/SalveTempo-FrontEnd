import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:date_format/date_format.dart';

class ConsultaService {
  Future cadastroAnamnese(
      String key, String anamnesePessoal, String anamneseClinica) {
    var anamnesePessoalJson = jsonDecode(anamnesePessoal);
    var anamneseClinicaJson = jsonDecode(anamneseClinica);

    var url = 'http://192.168.1.21:8000/anamneses/';
    var data = {};
    data.addAll(anamnesePessoalJson);
    data.addAll(anamneseClinicaJson);

    var headers = {"Authorization": "Token " + key};

    return http.post(url, body: data, headers: headers);
  }

  Future cadastroConsulta(
      String key,
      String pacienteId,
      String unidadeSaudeId,
      String anamneseId,
      String medicoId,
      DateTime dataConsulta,
      String periodo,
      String observacao) {
    var url = 'http://192.168.1.21:8000/consultas/';

    var data = {
      "paciente_id": pacienteId,
      "unidadeSaude_id": unidadeSaudeId,
      "anamnese_id": anamneseId,
      "medico_id": medicoId,
      "diagnostico_id": "",
      "data": formatDate(dataConsulta, [yyyy, '-', mm, '-', dd]),
      "periodo": periodo,
      "percentual_assertividade_prognostico": "0",
      "observacao": observacao,
      "status": "P"
    };

    var headers = {"Authorization": "Token " + key};

    return http.post(url, body: data, headers: headers);
  }

  Future insereConsultaSintoma(
      String key, String consultaId, String sintomaId, String possui) {
    var url = 'http://192.168.1.21:8000/consultas-sintomas/';

    var data = {
      "consulta_id": consultaId,
      "sintoma_id": sintomaId,
      "possui": possui
    };

    var headers = {"Authorization": "Token " + key};

    return http.post(url, body: data, headers: headers);
  }

  Future receivePrognosticos(String key, List<String> sintomas) {
    var url = 'http://192.168.1.21:8000/returnprognosticos/';

    Map<String, String> body = Map.fromIterable(sintomas,
        key: (k) => k.toString().split(';')[1],
        value: (v) => v.toString().split(';')[2]);

    var headers = {"Authorization": "Token " + key};

    return http.post(url, body: body, headers: headers);
  }

  Future insereConsultaPrognostico(
      String key, String consultaId, String doencaId, String percentual) {
    var url = 'http://192.168.1.21:8000/consultas-prognosticos/';

    var data = {
      "consulta_id": consultaId,
      "doenca_id": doencaId,
      "percentual": percentual
    };

    var headers = {"Authorization": "Token " + key};

    return http.post(url, body: data, headers: headers);
  }

  Future especializacoesValidas(String key, dynamic progs) {
    var url = 'http://192.168.1.21:8000/valid_especializacoes_doencas/';

    Map<String, String> body = Map.fromIterable(progs,
        key: (k) => k['id'].toString(), value: (v) => v['doenca'].toString());

    var headers = {"Authorization": "Token " + key};

    return http.post(url, body: body, headers: headers);
  }
}
