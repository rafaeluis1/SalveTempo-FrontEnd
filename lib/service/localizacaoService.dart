import 'dart:convert';

import 'package:http/http.dart' as http;

import 'package:salvetempo/models/localizacaoModels.dart';

class LocalizacaoService {
  Future getEstados() {
    var url = 'http://192.168.1.21:8000/estados/';
    return http.get(url);
  }

  Future getCidadesById(String id) {
    var url = 'http://192.168.1.21:8000/cidades/?search=' + id;
    return http.get(url);
  }
}
