import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:salvetempo/models/sintoma.dart';
import 'package:salvetempo/globals.dart' as globals;

class SintomaService {
  Future<int> startConsulta(String key) async {
    var url = globals.apiURL + 'startconsulta/';
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
    var url = globals.apiURL + 'showsintoma/';

    Map<String, String> body = Map.fromIterable(sintomas,
        key: (k) => k.toString().split(';')[1],
        value: (v) => v.toString().split(';')[2]);

    var headers = {"Authorization": "Token " + key};

    http.Response response = await http.post(url, body: body, headers: headers);

    if (response.statusCode >= 200 && response.statusCode <= 299) {
      List<dynamic> sintomaJson = jsonDecode(response.body);
      return Sintoma.fromJson(sintomaJson[0]);
    } else {
      return null;
    }
  }

  Future<SintomaAnswer> answerSintoma(String key, List<String> sintomas) async {
    var url = globals.apiURL + 'answersintoma/';

    Map<String, String> body = Map.fromIterable(sintomas,
        key: (k) => k.toString().split(';')[1],
        value: (v) => v.toString().split(';')[2]);

    var headers = {"Authorization": "Token " + key};

    final response = await http.post(url, body: body, headers: headers);
    print(response.body);

    if (response.statusCode >= 200 && response.statusCode <= 299) {
      List<dynamic> sintomaAnswerJson = jsonDecode(response.body);
      return SintomaAnswer.fromJson(sintomaAnswerJson[0]);
    } else {
      return null;
    }
  }
}
