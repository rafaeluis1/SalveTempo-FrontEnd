import 'dart:convert';

import 'package:http/http.dart' as http;

import 'package:salvetempo/globals.dart' as globals;

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
    var url = globals.apiURL + 'rest-auth/login/';
    var data = {"username": email, "email": email, "password": password};

    final response = await http.post(url, body: data);

    if (validationResponse(response.statusCode)) {
      return Token.fromJson(json.decode(response.body));
    } else {
      return null;
    }
  }

  Future<int> logout(String key) async {
    var url = globals.apiURL + 'rest-auth/logout/';
    var data = {};
    var headers = {"Authorization": "Token " + key};

    final response = await http.post(url, body: data, headers: headers);

    if (validationResponse(response.statusCode)) {
      return 0;
    } else {
      return -1;
    }
  }

  Future<bool> resetPassword(String email) async {
    var url = globals.apiURL + 'rest-auth/password/reset/';

    var data = {"email": email};

    final response = await http.post(url, body: data);

    if (validationResponse(response.statusCode)) {
      return true;
    } else {
      return false;
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
