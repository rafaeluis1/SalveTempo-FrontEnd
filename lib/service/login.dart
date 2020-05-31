import 'dart:convert';

import 'package:http/http.dart' as http;

class Token {
  String key;

  Token({this.key});

  Token.fromJson(Map<String, dynamic> json) {
    key = json['key'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['key'] = this.key;
    return data;
  }
}

class LoginService {
  Future<Token> login(String email, String password) async {
    var url = 'http://192.168.1.21:8000/rest-auth/login/';
    var data = {"username": email, "password": password};

    final response = await http.post(url, body: data);

    if (validationResponse(response.statusCode)) {
      return Token.fromJson(json.decode(response.body));
    } else {
      return null;
    }
  }

  Future<int> logout(String key) async {
    var url = 'http://192.168.1.21:8000/rest-auth/logout/';
    var data = {};
    var headers = {"Authorization": "Token " + key};

    final response = await http.post(url, body: data, headers: headers);

    if (validationResponse(response.statusCode)) {
      return 0;
    } else {
      return -1;
    }
  }

  bool validationResponse(int code) {
    if (code >= 200 && code <= 299) {
      return true;
    } else {
      return false;
    }
  }
}
