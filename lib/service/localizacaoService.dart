import 'dart:convert';

import 'package:http/http.dart' as http;

import 'package:salvetempo/models/localizacaoModels.dart';
import 'package:salvetempo/globals.dart' as globals;

class LocalizacaoService {
  Future getEstados() {
    var url = globals.apiURL + 'estados/';
    return http.get(url);
  }

  Future getCidadesById(String id) {
    var url = globals.apiURL + 'cidades/?search=' + id;
    return http.get(url);
  }
}
