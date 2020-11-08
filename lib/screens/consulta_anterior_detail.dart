import 'dart:convert';

import 'package:date_format/date_format.dart';
import 'package:flutter/material.dart';
import 'package:salvetempo/service/consultaService.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ConsultaAnteriorDetail extends StatefulWidget {
  final String consultaId;

  ConsultaAnteriorDetail(this.consultaId);

  @override
  _ConsultaAnteriorDetailState createState() =>
      _ConsultaAnteriorDetailState(this.consultaId);
}

class _ConsultaAnteriorDetailState extends State<ConsultaAnteriorDetail> {
  String consultaId;

  _ConsultaAnteriorDetailState(this.consultaId);

  var consultaService = ConsultaService();

  Future getConsulta() async {
    var consultaInfo = {};
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();

    await consultaService
        .getConsultaById(sharedPreferences.getString("key"), consultaId)
        .then((response) async {
      if (response.statusCode >= 200 && response.statusCode <= 299) {
        var consulta = json.decode(response.body);

        consultaInfo['medico'] = consulta['medico']['nome'];
        consultaInfo['unidadeSaude'] = consulta['unidadeSaude']['nome'];
        consultaInfo['data'] = DateTime.parse(consulta['data']);
        consultaInfo['observacao'] = consulta['observacao'];
        consultaInfo['diagnostico'] = consulta['diagnostico']['nome'];

        await consultaService
            .getConsultasSintomasByConsultaId(
                sharedPreferences.getString("key"), consultaId)
            .then((response) {
          if (response.statusCode >= 200 && response.statusCode <= 299) {
            var consultaSintomasInfo = [];

            var consultasSintomas = json.decode(response.body).toList();

            for (var consultaSintoma in consultasSintomas) {
              var possuiStr = "";

              switch (consultaSintoma['possui']) {
                case 1:
                  {
                    possuiStr = "Sim";
                  }
                  break;
                case 0:
                  {
                    possuiStr = "Não";
                  }
                  break;
                case -1:
                  {
                    possuiStr = "Não sabe";
                  }
                  break;
              }

              var item = {
                "sintoma": consultaSintoma['sintoma']['nome'],
                "possui": possuiStr
              };
              consultaSintomasInfo.add(item);
            }

            consultaInfo['sintomas'] = consultaSintomasInfo;
          } else {
            print("Algo errado ocorreu ao acessar os sintomas desta consulta.");
          }
        });
      } else {
        print("Algo errado ocorreu ao acessar esta consulta.");
      }
    });

    return consultaInfo;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Consulta Anterior"),
        ),
        body: Center(
          child: FutureBuilder(
            future: getConsulta(),
            builder: (context, snapshot) {
              if (!snapshot.hasData) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              } else {
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
                                  labelText: "Médico",
                                  alignLabelWithHint: true,
                                ),
                                controller: TextEditingController()
                                  ..text = snapshot.data['medico'],
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
                                  labelText: "Unidade de Saúde",
                                  alignLabelWithHint: true,
                                ),
                                controller: TextEditingController()
                                  ..text = snapshot.data['unidadeSaude'],
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
                                  labelText: "Data",
                                  alignLabelWithHint: true,
                                ),
                                controller: TextEditingController()
                                  ..text = formatDate(snapshot.data['data'],
                                      [dd, '/', mm, '/', yyyy]),
                                readOnly: true,
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                    Center(
                        child: snapshot.data['observacao'].toString().length > 0
                            ? Padding(
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
                                          labelText: "Observação",
                                          alignLabelWithHint: true,
                                        ),
                                        keyboardType: TextInputType.multiline,
                                        maxLines: 8,
                                        controller: TextEditingController()
                                          ..text = utf8.decode(snapshot
                                              .data['observacao'].runes
                                              .toList()),
                                        readOnly: true,
                                      ),
                                    )
                                  ],
                                ),
                              )
                            : Padding(
                                padding: EdgeInsets.only(),
                              )),
                    Container(
                      padding: EdgeInsets.only(top: 30, left: 25),
                      child: Text(
                        "Sintomas Apontados:",
                        style: TextStyle(
                            fontSize: 22, fontWeight: FontWeight.w700),
                      ),
                    ),
                    ListView.builder(
                      shrinkWrap: true,
                      physics: ClampingScrollPhysics(),
                      itemCount: snapshot.data['sintomas'].length,
                      itemBuilder: (context, index) {
                        return sintomaCard(
                            context,
                            snapshot.data['sintomas'][index]['sintoma'],
                            snapshot.data['sintomas'][index]['possui']);
                      },
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
                                  labelText: "Diagnóstico",
                                  alignLabelWithHint: true,
                                ),
                                controller: TextEditingController()
                                  ..text = utf8.decode(snapshot
                                      .data['diagnostico'].runes
                                      .toList()),
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

  Widget sintomaCard(BuildContext context, String sintoma, String possui) {
    return Center(
      child: Container(
        padding: const EdgeInsets.all(10.0),
        child: Stack(
          children: <Widget>[
            GestureDetector(
              onTap: () {},
              child: Container(
                height: 80,
                width: 360,
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
                        utf8.decode(sintoma.runes.toList()),
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
                        'Possui: ' + possui,
                        style: TextStyle(
                          fontSize: 18,
                          color: Colors.lightBlue,
                          fontWeight: FontWeight.w500,
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
      ),
    );
  }
}
