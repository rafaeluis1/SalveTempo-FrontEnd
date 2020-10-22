import 'dart:convert';

import 'package:date_format/date_format.dart';
import 'package:flutter/material.dart';
import 'package:salvetempo/models/medico.dart';
import 'package:salvetempo/models/unidadeSaudeModels.dart';
import 'package:salvetempo/screens/consulta_anterior_detail.dart';
import 'package:salvetempo/service/consultaService.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ConsultasAnteriores extends StatefulWidget {
  @override
  _ConsultasAnterioresState createState() => _ConsultasAnterioresState();
}

class _ConsultasAnterioresState extends State<ConsultasAnteriores> {
  var consultaService = ConsultaService();

  Future getConsultasAnteriores() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();

    var opcoesConsulta = new List<OpcaoConsulta>();

    await consultaService
        .getConsultasByPacienteId(sharedPreferences.getString("key"),
            sharedPreferences.getString("id"), "F")
        .then((response) {
      if (response.statusCode >= 200 && response.statusCode <= 299) {
        var consultas = json.decode(response.body).toList();

        for (var consulta in consultas) {
          var op = new OpcaoConsulta(
              medico: Medico.fromJson(consulta['medico']),
              unidadeSaude: UnidadeSaude.fromJson(consulta['unidadeSaude']),
              dataConsulta: DateTime.parse(consulta['data']));
          op.id = consulta['id'];
          opcoesConsulta.add(op);
        }
      } else {
        print("Algo deu errado ao buscar consultas.");
      }
    });

    opcoesConsulta.sort((a, b) {
      return a.dataConsulta.compareTo(b.dataConsulta);
    });

    return opcoesConsulta;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Consultas Anteriores"),
      ),
      body: Container(
        width: double.maxFinite,
        height: double.maxFinite,
        child: Container(
          color: Colors.lightBlueAccent,
          child: Center(
            child: Container(
              height: 650,
              width: 350,
              decoration: BoxDecoration(
                color: Colors.amber,
                borderRadius: BorderRadius.all(
                  Radius.circular(10),
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(1),
                    spreadRadius: 5,
                    blurRadius: 7,
                    offset: Offset(0, 3), // changes position of shadow
                  ),
                ],
              ),
              child: Center(
                child: Container(
                  height: 625,
                  width: 325,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.all(
                      Radius.circular(10),
                    ),
                  ),
                  child: FutureBuilder(
                      future: getConsultasAnteriores(),
                      builder: (context, snapshot) {
                        if (!snapshot.hasData) {
                          return Center(
                            child: CircularProgressIndicator(),
                          );
                        } else {
                          if (snapshot.data.length > 0) {
                            return ListView.builder(
                              shrinkWrap: true,
                              itemCount: snapshot.data.length,
                              itemBuilder: (context, index) {
                                return consultaCard(
                                    context,
                                    snapshot.data[index].id,
                                    snapshot.data[index].medico,
                                    snapshot.data[index].unidadeSaude,
                                    snapshot.data[index].dataConsulta);
                              },
                            );
                          } else {
                            return Stack(
                              children: <Widget>[
                                Positioned(
                                  top: 150,
                                  left: 25,
                                  width: 280,
                                  child: Text(
                                    "Não foi realizada nenhuma consulta ainda.",
                                    style: TextStyle(
                                      color: Colors.black54,
                                      fontWeight: FontWeight.w500,
                                      fontSize: 30,
                                    ),
                                  ),
                                ),
                                Positioned(
                                    top: 400,
                                    left: 62.5,
                                    child: MaterialButton(
                                      minWidth: 200,
                                      height: 90,
                                      color: Colors.amber,
                                      child: Text(
                                        "Voltar".toUpperCase(),
                                        style: TextStyle(
                                          color: Colors.black,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 18,
                                        ),
                                      ),
                                      onPressed: () {
                                        Navigator.pop(context, false);
                                      },
                                    )),
                              ],
                            );
                          }
                        }
                      }),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget consultaCard(BuildContext context, int id, Medico medico,
      UnidadeSaude unidadeSaude, DateTime dataConsulta) {
    var strDataConsulta = formatDate(dataConsulta, [dd, '/', mm, '/', yyyy]);
    return Container(
      padding: const EdgeInsets.all(8.0),
      child: Stack(
        children: <Widget>[
          GestureDetector(
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) =>
                          ConsultaAnteriorDetail(id.toString())));
            },
            child: Container(
              height: 150,
              width: double.maxFinite,
              decoration: BoxDecoration(
                color: Colors.amber,
                borderRadius: BorderRadius.all(
                  Radius.circular(5),
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.3),
                    spreadRadius: 2,
                    blurRadius: 5,
                    offset: Offset(2, 3), // changes position of shadow
                  ),
                ],
              ),
              child: Stack(
                children: <Widget>[
                  Positioned(
                    top: 15,
                    left: 10,
                    child: Text(
                      medico.nome,
                      style: TextStyle(
                        fontSize: 20,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Positioned(
                    top: 45,
                    left: 10,
                    child: Text(
                      medico.especializacao.nome,
                      style: TextStyle(
                        fontSize: 15,
                        color: Colors.white,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                  Positioned(
                    top: 80,
                    left: 10,
                    child: Text(
                      utf8.decode(unidadeSaude.nome.runes.toList()),
                      style: TextStyle(
                        fontSize: 18,
                        color: Colors.lightBlue,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  Positioned(
                    top: 110,
                    left: 10,
                    child: Text(
                      strDataConsulta,
                      style: TextStyle(
                        fontSize: 18,
                        color: Colors.lightBlue,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(
            height: 10,
          )
        ],
      ),
    );
  }
}
