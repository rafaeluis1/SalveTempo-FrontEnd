import 'dart:ffi';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:salvetempo/models/paciente.dart';
import 'package:salvetempo/screens/anamnese.dart';
import 'package:salvetempo/screens/homepage.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:salvetempo/service/pacienteService.dart';
import 'package:salvetempo/service/sintomaService.dart';
import 'package:salvetempo/service/login.dart';
import 'dart:convert';

class UserPanel extends StatefulWidget {
  @override
  _UserPanelState createState() => _UserPanelState();
}

class _UserPanelState extends State<UserPanel> {
  var pacienteService = PacienteService();
  var sintomaService = SintomaService();
  var loginService = LoginService();

  Future<bool> _onWillPop() async {
    return showDialog<bool>(
        context: context,
        barrierDismissible: false,
        builder: (context) => AlertDialog(
              title: Text("Deseja sair da aplicação?"),
              actions: <Widget>[
                RaisedButton(
                  child: Text("Sim"),
                  onPressed: () {
                    futureResult = logout();

                    futureResult.then((result) {
                      if (result == 0) {
                        Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(builder: (context) => HomePage()),
                            (r) => false);
                      } else {
                        print('Algo deu errado');
                      }
                    });
                  },
                ),
                RaisedButton(
                  child: Text("Não"),
                  onPressed: () {
                    Navigator.pop(context, false);
                  },
                ),
              ],
            ));
  }

  Future<Paciente> buscaPacienteById() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String id = sharedPreferences.getString("id");

    futurePaciente = pacienteService.getPacienteById(id);
    return futurePaciente;
  }

  Future<int> startConsulta() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String key = sharedPreferences.get("key");

    setState(() {
      sharedPreferences.setStringList("sintomas", []);
    });

    futureResult = sintomaService.startConsulta(key);
    return futureResult;
  }

  Future<int> logout() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String key = sharedPreferences.get("key");

    futureResult = loginService.logout(key);
    return futureResult;
  }

  Future<Paciente> futurePaciente;
  Future<int> futureResult;

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _onWillPop,
      child: Scaffold(
        appBar: AppBar(
          title: Text("Painel do Usuário"),
          leading: Transform.rotate(
            angle: 180 * pi / 180,
            child: IconButton(
              icon: Icon(Icons.exit_to_app),
              tooltip: 'Logout',
              onPressed: () {
                _onWillPop();
              },
            ),
          ),
        ),
        body: Container(
          width: double.maxFinite,
          height: double.maxFinite,
          child: Stack(
            children: <Widget>[
              Container(
                color: Colors.white,
              ),
              Positioned(
                  top: 80,
                  left: 40,
                  child: FutureBuilder<Paciente>(
                    future: futurePaciente = buscaPacienteById(),
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        return Text(
                          "Olá, " +
                              utf8.decode(snapshot.data.nome.runes.toList()),
                          style: TextStyle(
                            color: Colors.blueAccent,
                            fontWeight: FontWeight.w500,
                            fontSize: 20,
                          ),
                        );
                      } else {
                        return Text('');
                      }
                    },
                  )),
              Center(
                child: ButtonBar(
                  buttonHeight: 50,
                  buttonMinWidth: 400,
                  alignment: MainAxisAlignment.spaceBetween,
                  mainAxisSize: MainAxisSize.max,
                  children: <Widget>[
                    new MaterialButton(
                        color: Colors.redAccent,
                        child: Text(
                          "Nova Consulta",
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w500,
                            fontSize: 20,
                          ),
                        ),
                        onPressed: () {
                          futureResult = startConsulta();

                          futureResult.then((result) {
                            if (result == 0) {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => Anamnese()));
                            } else {
                              print('Algo deu errado');
                            }
                          });
                        }),
                    SizedBox(
                      height: 10,
                    ),
                    new MaterialButton(
                        color: Colors.blueAccent,
                        child: Text(
                          "Histórico de Consultas",
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w500,
                            fontSize: 20,
                          ),
                        ),
                        onPressed: () {}),
                    SizedBox(
                      height: 10,
                    ),
                    new MaterialButton(
                        color: Colors.blueAccent,
                        child: Text(
                          "Informações Pessoais",
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w500,
                            fontSize: 20,
                          ),
                        ),
                        onPressed: () {}),
                    SizedBox(
                      height: 10,
                    ),
                    new MaterialButton(
                        color: Colors.blueAccent,
                        child: Text(
                          "Ultimos Médicos Consultados",
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w500,
                            fontSize: 20,
                          ),
                        ),
                        onPressed: () {}),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
