import 'dart:convert';

import 'package:http/http.dart' as http;

class UnidadeSaudeService {
  Future getUnidadesSaudeByCidadeId(String cidadeId) {
    var url = 'http://192.168.1.21:8000/unidades_saude/?search=' + cidadeId;
    return http.get(url);
  }

  Future getMedicosByUnidadeSaudeId(String key, String unidadeSaudeId) {
    var url = 'http://192.168.1.21:8000/medicos_unidades_saude_admin/?search=' +
        unidadeSaudeId;

    var headers = {"Authorization": "Token " + key};

    return http.get(url, headers: headers);
  }
}
