import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:salvetempo/models/paciente.dart';
import 'package:flutter/services.dart';
import 'package:salvetempo/service/login.dart';
import 'package:http/http.dart' as http;
import 'package:salvetempo/service/pacienteService.dart';
import 'package:salvetempo/screens/signup.dart';
import 'package:salvetempo/widget/SlideCadastro.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool selected = true;
  DateTime _dateInfo = DateTime.now();
  String dateText = "Data de Nascimento";
  FocusNode loginFocus;

  var nomeCrtl = TextEditingController();
  var datanascCrtl = TextEditingController();
  var emailCrtl = TextEditingController();
  var passCrtl = TextEditingController();
  var confirmPassCrtl = TextEditingController();
  var sexoCrtl = TextEditingController();
  var emailuserCrtl = TextEditingController();
  var passuserCrtl = TextEditingController();
  var loginService = LoginService();
  var pacienteService = PacienteService();

  Future<Token> futureToken;
  Future<Usuario> futureUsuario;
  Future<Usuario> futureUsuarioGet;
  Future<Paciente> futurePaciente;

  String sexoSelected;

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
  }

  void login() async {
    futureToken = loginService.login(emailuserCrtl.text, passuserCrtl.text);

    futureToken.then((result) {
      if (result == null) {
        print("E-mail ou senha inválidos.");
      } else {
        print('key: ' + result.key);
      }
    });

    emailuserCrtl.clear();
    passuserCrtl.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.maxFinite,
        height: double.maxFinite,
        child: Stack(
          children: <Widget>[
            Container(
              color: Colors.blue,
            ),
            Center(
              child: Padding(
                padding: EdgeInsets.only(top: 10),
                child: Wrap(
                  spacing: 20, // to apply margin horizontally
                  runSpacing: -20,
                  children: <Widget>[
                    SizedBox(
                      width: 250.0,
                      height: 100.0,
                      child: TextFormField(
                        textInputAction: TextInputAction.next,
                        onFieldSubmitted: (_) =>
                            FocusScope.of(context).nextFocus(),
                        keyboardType: TextInputType.emailAddress,
                        controller: emailuserCrtl,
                        style: TextStyle(
                          color: Colors.white,
                        ),
                        decoration: InputDecoration(
                          labelText: "Email",
                          labelStyle: TextStyle(
                              color: Colors.white, fontWeight: FontWeight.bold),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.white,
                              width: 3,
                            ),
                            borderRadius:
                                const BorderRadius.all(Radius.circular(10)),
                          ),
                          errorBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.white,
                              width: 3,
                            ),
                            borderRadius:
                                const BorderRadius.all(Radius.circular(10)),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.white,
                              width: 3,
                            ),
                            borderRadius:
                                const BorderRadius.all(Radius.circular(10)),
                          ),
                          disabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.white,
                              width: 3,
                            ),
                            borderRadius:
                                const BorderRadius.all(Radius.circular(10)),
                          ),
                          border: UnderlineInputBorder(),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 250.0,
                      height: 100.0,
                      child: TextFormField(
                        textInputAction: TextInputAction.go,
                        onFieldSubmitted: (_) =>
                            FocusScope.of(context).unfocus(),
                        controller: passuserCrtl,
                        obscureText: true,
                        style: TextStyle(
                          color: Colors.white,
                        ),
                        decoration: InputDecoration(
                          labelText: "Senha",
                          labelStyle: TextStyle(
                              color: Colors.white, fontWeight: FontWeight.bold),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.white,
                              width: 3,
                            ),
                            borderRadius:
                                const BorderRadius.all(Radius.circular(10)),
                          ),
                          errorBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.white,
                              width: 3,
                            ),
                            borderRadius:
                                const BorderRadius.all(Radius.circular(10)),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.white,
                              width: 3,
                            ),
                            borderRadius:
                                const BorderRadius.all(Radius.circular(10)),
                          ),
                          disabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.white,
                              width: 3,
                            ),
                            borderRadius:
                                const BorderRadius.all(Radius.circular(10)),
                          ),
                          border: UnderlineInputBorder(),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Center(
              child: Padding(
                padding: EdgeInsets.only(
                  top: 190,
                ),
                child: FlatButton(
                  onPressed: login,
                  child: Container(
                    height: 50,
                    width: 250,
                    decoration: BoxDecoration(
                      color: Colors.deepPurpleAccent,
                      borderRadius: BorderRadius.all(
                        Radius.circular(10),
                      ),
                    ),
                    child: Center(
                      child: Text(
                        "Entrar",
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            GestureDetector(
              onTap: () {
                Navigator.push(
                    context, SlideCadastro(builder: (context) => SignUp()));
              },
              child: Align(
                alignment: Alignment.bottomCenter,
                child: Container(
                  height: 80,
                  width: 400,
                  child: Align(
                    alignment: Alignment.center,
                    child: Text("CADASTRO"),
                  ),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(55),
                      topRight: Radius.circular(55),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
