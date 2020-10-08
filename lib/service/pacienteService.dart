import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:salvetempo/models/paciente.dart';
import 'package:salvetempo/globals.dart' as globals;

class PacienteService {
  Future<Usuario> getUsuarioByEmail(String email) async {
    var url = globals.apiURL + 'users/?search=' + email;
    final response = await http.get(url);

    if (response.statusCode >= 200 && response.statusCode <= 299) {
      List<dynamic> usuarioJson = jsonDecode(response.body);
      return Usuario.fromJson(usuarioJson[0]);
    } else {
      return null;
    }
  }

  Future<Paciente> getPacienteByEmail(String email) async {
    var url = globals.apiURL + 'pacientes/?search=' + email;
    final response = await http.get(url);

    if (response.statusCode >= 200 && response.statusCode <= 299) {
      List<dynamic> pacienteJson = jsonDecode(response.body);
      return Paciente.fromJson(pacienteJson[0]);
    } else {
      return null;
    }
  }

  Future<Paciente> getPacienteById(String id) async {
    var url = globals.apiURL + 'pacientes/' + id;
    final response = await http.get(url);

    if (response.statusCode >= 200 && response.statusCode <= 299) {
      return Paciente.fromJson(json.decode(response.body));
    } else {
      return null;
    }
  }

  Future<int> cadastroUsuario(String email, String username, String password,
      String confirmPassword) async {
    var url = globals.apiURL + 'rest-auth/registration/';

    var data = {
      "username": username,
      "email": email,
      "password1": password,
      "password2": confirmPassword
    };

    final response = await http.post(url, body: data);

    if (response.statusCode >= 200 && response.statusCode <= 299) {
      return 0;
    } else {
      return -1;
    }
  }

  Future<Paciente> cadastroPaciente(
      int usuario_id, String nome, String sexo, String dataNasc) async {
    var url = globals.apiURL + 'pacientes/';
    var data = {
      "usuario_id": usuario_id.toString(),
      "nome": nome,
      "sexo": sexo,
      "dataNasc": dataNasc
    };

    final response = await http.post(url, body: data);

    if (response.statusCode >= 200 && response.statusCode <= 299) {
      return Paciente.fromJson(json.decode(response.body));
    } else {
      return null;
    }
  }
}
