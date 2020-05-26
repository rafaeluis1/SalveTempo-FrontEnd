import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:salvetempo/models/sintoma.dart';

class SintomaService {
  Future<int> startConsulta(String key) async {
    var url = 'http://192.168.1.21:8000/startconsulta/';
    var data = {};
    var headers = {"Authorization": "Token " + key};

    final response = await http.post(url, body: data, headers: headers);

    if (response.statusCode >= 200 && response.statusCode <= 299) {
      return 0;
    } else {
      return -1;
    }
  }

  Future<Sintoma> showSintoma(String key, List<String> sintomas) async {
    var url = 'http://192.168.1.21:8000/showsintoma/';

    Map<String, String> body = Map.fromIterable(sintomas,
        key: (k) => k.toString().split(';')[0],
        value: (v) => v.toString().split(';')[1]);

    var headers = {"Authorization": "Token " + key};

    http.Response response = await http.post(url, body: body, headers: headers);

    if (response.statusCode >= 200 && response.statusCode <= 299) {
      List<dynamic> sintomaJson = jsonDecode(response.body);
      return Sintoma.fromJson(sintomaJson[0]);
    } else {
      return null;
    }
  }

  Future<int> answerSintoma(String key, String sintoma, String resposta) async {
    var url = 'http://192.168.1.21:8000/answersintoma/';
    var data = {"sintoma": sintoma, "resposta": resposta.toString()};
    var headers = {"Authorization": "Token " + key};

    final response = await http.post(url, body: data, headers: headers);

    if (response.statusCode >= 200 && response.statusCode <= 299) {
      return 0;
    } else {
      return -1;
    }
  }
}
