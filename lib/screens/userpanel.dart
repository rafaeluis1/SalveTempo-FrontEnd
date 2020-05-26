import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:salvetempo/models/paciente.dart';
import 'package:salvetempo/screens/anamnese.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:salvetempo/service/pacienteService.dart';
import 'package:salvetempo/service/sintomaService.dart';

class UserPanel extends StatefulWidget {
  @override
  _UserPanelState createState() => _UserPanelState();
}

class _UserPanelState extends State<UserPanel> {
  var pacienteService = PacienteService();
  var sintomaService = SintomaService();

  Future<Paciente> buscaPacienteByEmail() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String email = sharedPreferences.getString("email");

    futurePaciente = pacienteService.getPacienteByEmail(email);
    return futurePaciente;
  }

  Future<int> startConsulta() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String key = sharedPreferences.get("token");

    setState(() {
      sharedPreferences.setStringList("sintomas", []);
    });

    futureResult = sintomaService.startConsulta(key);
    return futureResult;
  }

  Future<Paciente> futurePaciente;
  Future<int> futureResult;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Painel do Usuário")),
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
                  future: futurePaciente = buscaPacienteByEmail(),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      return Text(
                        "Olá, " + snapshot.data.nome,
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
    );
  }
}
