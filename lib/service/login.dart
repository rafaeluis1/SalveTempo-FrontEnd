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
  var url = 'http://192.168.1.21:8000/rest-auth/login/';

  Future<Token> login(String email, String password) async {
    var data = {
      "username": email,
      "password": password
    };

    final response = await http.post(
      url,
      body: data
    );

    if (response.statusCode >= 200 && response.statusCode <= 299){
      return Token.fromJson(json.decode(response.body));
    } else {
      return null;
    }
  }
}
