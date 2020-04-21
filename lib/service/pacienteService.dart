import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:salvetempo/models/paciente.dart';

class PacienteService {

  Future<Usuario> cadastroUsuario(String email, String username, String password, String confirmPassword) async {
    var url = 'http://192.168.1.21:8000/users/';
    var data = {
      "email": email,
      "username": username,
      "password": password,
      "confirm_password": confirmPassword
    };

    final response = await http.post(
      url,
      body: data
    );

    if (response.statusCode >= 200 && response.statusCode <= 299){
      return Usuario.fromJson(json.decode(response.body));
    } else {
      return null;
    }
  }

  Future<Usuario> getUsuarioByEmail(String email) async {
    var url = 'http://192.168.1.21:8000/users/?search=' + email;
    final response = await http.get(url);

    if (response.statusCode >= 200 && response.statusCode <= 299){
      List<dynamic> usuarioJson = jsonDecode(response.body);
      return Usuario.fromJson(usuarioJson[0]);
    } else {
      return null;
    }
  }

  Future<Paciente> cadastroPaciente(int usuario_id, String nome, String sexo, String dataNasc) async {
    var url = 'http://192.168.1.21:8000/pacientes/';
    var data = {
      "usuario_id": usuario_id.toString(),
      "nome": nome,
      "sexo": sexo,
      "dataNasc": dataNasc
    };

    final response = await http.post(
      url,
      body: data
    );

    if (response.statusCode >= 200 && response.statusCode <= 299){
      return Paciente.fromJson(json.decode(response.body));
    } else {
      return null;
    }
  }
}