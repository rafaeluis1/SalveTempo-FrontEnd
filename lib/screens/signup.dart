import 'package:flutter/material.dart';
import 'package:date_format/date_format.dart';
import 'package:salvetempo/screens/userpanel.dart';
import 'package:salvetempo/service/pacienteService.dart';
import 'package:salvetempo/models/paciente.dart';

import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;

class SignUp extends StatefulWidget {
  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  var nomeCrtl = TextEditingController();
  var datanascCrtl = TextEditingController();
  var emailCrtl = TextEditingController();
  var passCrtl = TextEditingController();
  var confirmPassCrtl = TextEditingController();
  var sexoCrtl = TextEditingController();
  var emailuserCrtl = TextEditingController();
  var pacienteService = PacienteService();

  DateTime _dateInfo = DateTime.now();

  String dateText = "Data de Nascimento";

  String sexoSelected;
  Future<Usuario> futureUsuario;
  Future<Usuario> futureUsuarioGet;
  Future<Paciente> futurePaciente;

  void add() async {
    String email = emailCrtl.text;
    String nome = nomeCrtl.text;
    String sexo = sexoCrtl.text;
    String dataNasc = datanascCrtl.text;

    futureUsuario = pacienteService.cadastroUsuario(
        email, nome, passCrtl.text, confirmPassCrtl.text);

    futureUsuario.then((result) {
      if (result == null) {
        print("Algum campo é inválido");
      } else {
        futureUsuarioGet = pacienteService.getUsuarioByEmail(email);

        futureUsuarioGet.then((user) {
          if (user == null) {
            print("Usuário inválido.");
          } else {
            futurePaciente = pacienteService.cadastroPaciente(
                user.id, user.username, sexo, dataNasc);

            futurePaciente.then((paciente) {
              if (user == null) {
                print("Paciente inválido.");
              } else {
                print(paciente.toJson());
              }
            });
          }
        });
      }
    });

    nomeCrtl.clear();
    sexoCrtl.clear();
    datanascCrtl.clear();
    emailCrtl.clear();
    passCrtl.clear();
    confirmPassCrtl.clear();
    Navigator.pushReplacement(
        context,
        MaterialPageRoute(
            builder: (context) =>
                UserPanel())); // Mudar essa linha pra dentro da validação
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Form(
          child: ListView(
            children: <Widget>[
              SizedBox(
                height: 20,
              ),
              Wrap(
                direction: Axis.horizontal,
                spacing: 135,
                children: <Widget>[
                  GestureDetector(
                      child: SizedBox(
                        height: 10,
                        width: 10,
                        child: Icon(Icons.arrow_back_ios),
                      ),
                      onTap: () {
                        Navigator.pop(context);
                      }),
                  Text(
                    "CADASTRO",
                    style: TextStyle(
                      color: Colors.blueAccent,
                      fontWeight: FontWeight.w500,
                      fontSize: 20,
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 50,
              ),
              TextFormField(
                textInputAction: TextInputAction.next,
                controller: nomeCrtl,
                onTap: () =>
                    SystemChannels.textInput.invokeMethod('TextInput.hide'),
                onFieldSubmitted: (_) => FocusScope.of(context).nextFocus(),
                decoration: InputDecoration(
                  prefixIcon: Icon(Icons.face),
                  labelText: "Nome",
                ),
              ),
              SizedBox(
                height: 10,
              ),
              ButtonBar(
                alignment: MainAxisAlignment.center,
                children: <Widget>[
                  new DropdownButton<String>(
                    value: sexoSelected,
                    hint: new Text("Sexo"),
                    items: <String>['M', 'F'].map((String value) {
                      return new DropdownMenuItem<String>(
                        value: value,
                        child: new Text(value),
                      );
                    }).toList(),
                    onChanged: (value) {
                      sexoSelected = value;
                      sexoCrtl.text = value;
                    },
                  ),
                  SizedBox(
                    height: 25,
                  ),
                  new FlatButton(
                    child: new Row(
                      children: <Widget>[
                        new Text(
                          '${dateText}',
                          style: TextStyle(fontSize: 15),
                        ),
                        new Icon(Icons.date_range)
                      ],
                    ),
                    onPressed: () async {
                      final dtPick = await showDatePicker(
                          context: context,
                          initialDate: DateTime.now(),
                          firstDate: DateTime(1970),
                          lastDate: DateTime.now().add(Duration(hours: 1)));
                      if (dtPick != null && dtPick != _dateInfo) {
                        setState(() {
                          _dateInfo = dtPick;
                          dateText =
                              formatDate(_dateInfo, [yyyy, '-', mm, '-', dd]);
                          datanascCrtl.text = dateText;
                        });
                      }
                    },
                  ),
                ],
              ),
              SizedBox(
                height: 10,
              ),
              TextFormField(
                textInputAction: TextInputAction.next,
                controller: emailCrtl,
                onFieldSubmitted: (_) => FocusScope.of(context).nextFocus(),
                keyboardType: TextInputType.emailAddress,
                decoration: InputDecoration(
                  prefixIcon: Icon(Icons.alternate_email),
                  labelText: "Email",
                ),
              ),
              SizedBox(
                height: 10,
              ),
              TextFormField(
                textInputAction: TextInputAction.go,
                controller: passCrtl,
                onFieldSubmitted: (_) => FocusScope.of(context).unfocus(),
                keyboardType: TextInputType.text,
                obscureText: true,
                decoration: InputDecoration(
                  prefixIcon: Icon(Icons.vpn_key),
                  labelText: "Senha",
                ),
              ),
              SizedBox(
                height: 10,
              ),
              TextFormField(
                textInputAction: TextInputAction.go,
                controller: confirmPassCrtl,
                onFieldSubmitted: (_) => FocusScope.of(context).unfocus(),
                keyboardType: TextInputType.text,
                obscureText: true,
                decoration: InputDecoration(
                  prefixIcon: Icon(Icons.vpn_key),
                  labelText: "Confirmar Senha",
                ),
              ),
              SizedBox(
                height: 30,
              ),
              FlatButton(
                onPressed: add,
                child: Container(
                  height: 50,
                  width: double.maxFinite - 25,
                  decoration: BoxDecoration(
                    color: Colors.deepPurpleAccent,
                    borderRadius: BorderRadius.all(
                      Radius.circular(25),
                    ),
                  ),
                  child: Center(
                    child: Text(
                      "Cadastrar",
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
