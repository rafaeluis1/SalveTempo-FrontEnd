import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:salvetempo/globals.dart' as globals;

class UnidadeSaudeService {
  Future getUnidadesSaudeByCidadeId(String cidadeId) {
    var url = globals.apiURL + 'unidades_saude/?search=' + cidadeId;
    return http.get(url);
  }

  Future getMedicosByUnidadeSaudeId(String key, String unidadeSaudeId) {
    var url = globals.apiURL +
        'medicos_unidades_saude_admin/?search=' +
        unidadeSaudeId;

    var headers = {"Authorization": "Token " + key};

    return http.get(url, headers: headers);
  }
}
