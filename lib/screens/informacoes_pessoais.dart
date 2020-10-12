import 'package:date_format/date_format.dart';
import 'package:flutter/material.dart';
import 'package:salvetempo/models/paciente.dart';
import 'package:salvetempo/service/pacienteService.dart';
import 'package:shared_preferences/shared_preferences.dart';

class InformacoesPessoais extends StatefulWidget {
  @override
  _InformacoesPessoaisState createState() => _InformacoesPessoaisState();
}

class _InformacoesPessoaisState extends State<InformacoesPessoais> {
  var pacienteService = PacienteService();

  Future<Paciente> getPaciente() async {
    Paciente pacienteRecebido;
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();

    await pacienteService
        .getPacienteById(sharedPreferences.getString("id"))
        .then((paciente) {
      pacienteRecebido = paciente;
    });

    return pacienteRecebido;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Informações Pessoais"),
        ),
        body: Center(
          child: FutureBuilder<Paciente>(
            future: getPaciente(),
            builder: (context, snapshot) {
              if (!snapshot.hasData) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              } else {
                var sexoStr = "";

                switch (snapshot.data.sexo) {
                  case "M":
                    {
                      sexoStr = "Masculino";
                    }
                    break;
                  case "F":
                    {
                      sexoStr = "Feminino";
                    }
                    break;
                }

                return ListView(
                  children: <Widget>[
                    Center(
                      child: Padding(
                        padding: EdgeInsets.only(top: 50),
                        child: Wrap(
                          spacing: 20,
                          runSpacing: -20,
                          children: <Widget>[
                            SizedBox(
                              width: 360,
                              child: TextField(
                                decoration: InputDecoration(
                                  border: OutlineInputBorder(),
                                  labelText: "Nome",
                                  alignLabelWithHint: true,
                                ),
                                controller: TextEditingController()
                                  ..text = snapshot.data.nome,
                                readOnly: true,
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                    Center(
                      child: Padding(
                        padding: EdgeInsets.only(top: 30),
                        child: Wrap(
                          spacing: 20,
                          runSpacing: -20,
                          children: <Widget>[
                            SizedBox(
                              width: 360,
                              child: TextField(
                                decoration: InputDecoration(
                                  border: OutlineInputBorder(),
                                  labelText: "E-mail",
                                  alignLabelWithHint: true,
                                ),
                                controller: TextEditingController()
                                  ..text = snapshot.data.usuario.email,
                                readOnly: true,
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                    Center(
                      child: Padding(
                        padding: EdgeInsets.only(top: 30),
                        child: Wrap(
                          spacing: 20,
                          runSpacing: -20,
                          children: <Widget>[
                            SizedBox(
                              width: 360,
                              child: TextField(
                                decoration: InputDecoration(
                                  border: OutlineInputBorder(),
                                  labelText: "Data de Nascimento",
                                  alignLabelWithHint: true,
                                ),
                                controller: TextEditingController()
                                  ..text = formatDate(
                                      DateTime.parse(snapshot.data.dataNasc),
                                      [dd, '/', mm, '/', yyyy]),
                                readOnly: true,
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                    Center(
                      child: Padding(
                        padding: EdgeInsets.only(top: 30),
                        child: Wrap(
                          spacing: 20,
                          runSpacing: -20,
                          children: <Widget>[
                            SizedBox(
                              width: 360,
                              child: TextField(
                                decoration: InputDecoration(
                                  border: OutlineInputBorder(),
                                  labelText: "Sexo",
                                  alignLabelWithHint: true,
                                ),
                                controller: TextEditingController()
                                  ..text = sexoStr,
                                readOnly: true,
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ],
                );
              }
            },
          ),
        ));
  }
}
