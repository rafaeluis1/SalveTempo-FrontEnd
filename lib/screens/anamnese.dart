import 'package:flutter/material.dart';
import 'package:salvetempo/models/sintoma.dart';
import 'package:salvetempo/screens/chooseTime.dart';
import 'package:salvetempo/screens/observacao.dart';
import 'package:salvetempo/service/consultaService.dart';
import 'package:salvetempo/widget/popup_errorAnamnese.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:salvetempo/service/sintomaService.dart';
import 'dart:convert';

class Anamnese extends StatefulWidget {
  @override
  _AnamneseState createState() => _AnamneseState();
}

class _AnamneseState extends State<Anamnese> {
  var sintomaService = SintomaService();
  var consultaService = ConsultaService();

  Future<Sintoma> showSintoma() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String key = sharedPreferences.get("key");
    List<String> sintomas = sharedPreferences.getStringList("sintomas");

    futureSintoma = sintomaService.showSintoma(key, sintomas);
    return futureSintoma;
  }

  Future<SintomaAnswer> answerSintoma(String resposta) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String key = sharedPreferences.get("key");
    List<String> sintomas = sharedPreferences.getStringList("sintomas");

    sintomas.add(sintomaId + ';' + sintoma + ';' + resposta);
    sharedPreferences.setStringList("sintomas", sintomas);

    futureSintomaAnswer = sintomaService.answerSintoma(key, sintomas);
    return futureSintomaAnswer;
  }

  Future destroySintomaList() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    List<String> sintomas = [];

    sharedPreferences.setStringList("sintomas", sintomas);
  }

  Future<bool> savePrognosticos() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String key = sharedPreferences.get("key");
    List<String> sintomas = sharedPreferences.getStringList("sintomas");
    var result;

    await consultaService.receivePrognosticos(key, sintomas).then((response) {
      if (response.statusCode >= 200 && response.statusCode <= 299) {
        setState(() {
          sharedPreferences.setString(
              'prognosticos', jsonEncode(response.body));
        });

        result = true;
      } else {
        print('Algo ocorreu errado ao receber os prognósticos.');
        result = false;
      }
    });
    return result;
  }

  void redirectPage(SintomaAnswer result) {
    if (!(result == null)) {
      if (result.valido == true) {
        if (result.counter_doencas > 3) {
          setState(() {});
        } else {
          savePrognosticos().then((result) {
            if (result) {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => Observacao()));
            }
          });
        }
      } else {
        showDialog(
          context: context,
          builder: (BuildContext context) => PopupErrorAn(),
        );
      }
    } else {
      print('Algo deu errado');
    }
  }

  Future<bool> _onWillPop() async {
    return showDialog<bool>(
        context: context,
        barrierDismissible: false,
        builder: (context) => AlertDialog(
              title: Text("Você deseja abortar o apontamento de sintomas?"),
              actions: <Widget>[
                RaisedButton(
                  child: Text("Sim"),
                  onPressed: () {
                    destroySintomaList();
                    Navigator.pop(context, true);
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

  Future<Sintoma> futureSintoma;
  Future<SintomaAnswer> futureSintomaAnswer;
  String sintoma;
  String sintomaId;

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _onWillPop,
      child: Scaffold(
        appBar: AppBar(
          title: Text("Apontamento de Sintomas"),
        ),
        body: Container(
          width: double.maxFinite,
          height: double.maxFinite,
          child: Stack(
            children: <Widget>[
              Container(
                color: Colors.lightBlueAccent,
              ),
              Center(
                child: Stack(
                  children: <Widget>[
                    Container(
                      height: 265,
                      width: 350,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(10),
                            topRight: Radius.circular(10),
                            bottomLeft: Radius.circular(10),
                            bottomRight: Radius.circular(10)),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.5),
                            spreadRadius: 5,
                            blurRadius: 7,
                            offset: Offset(0, 3), // changes position of shadow
                          ),
                        ],
                      ),
                      child: Align(
                        alignment: Alignment.bottomLeft,
                        child: ButtonBar(
                          buttonMinWidth: 100,
                          alignment: MainAxisAlignment.center,
                          children: <Widget>[
                            MaterialButton(
                              minWidth: 95,
                              height: 80,
                              color: Colors.amber,
                              child: Text(
                                "Sim".toUpperCase(),
                                style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18,
                                ),
                              ),
                              onPressed: () {
                                futureSintomaAnswer = answerSintoma("1");

                                futureSintomaAnswer.then((result) {
                                  redirectPage(result);
                                });
                              },
                            ),
                            SizedBox(
                              width: 5,
                            ),
                            MaterialButton(
                              minWidth: 95,
                              height: 80,
                              color: Colors.amber,
                              child: Text(
                                "Não".toUpperCase(),
                                style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18,
                                ),
                              ),
                              onPressed: () {
                                futureSintomaAnswer = answerSintoma("0");

                                futureSintomaAnswer.then((result) {
                                  redirectPage(result);
                                });
                              },
                            ),
                            SizedBox(
                              width: 5,
                            ),
                            MaterialButton(
                              minWidth: 95,
                              height: 80,
                              color: Colors.amber,
                              child: Text(
                                "Não Sei".toUpperCase(),
                                style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18,
                                ),
                              ),
                              onPressed: () {
                                futureSintomaAnswer = answerSintoma("-1");

                                futureSintomaAnswer.then((result) {
                                  redirectPage(result);
                                });
                              },
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Positioned(
                top: 280,
                right: 90,
                child: Text(
                  "Você possui:".toUpperCase(),
                  style: TextStyle(
                    color: Colors.black54,
                    fontWeight: FontWeight.w500,
                    fontSize: 30,
                  ),
                ),
              ),
              Center(
                child: FutureBuilder<Sintoma>(
                  future: futureSintoma = showSintoma(),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      sintomaId = snapshot.data.id.toString();
                      sintoma = snapshot.data.nomecsv;
                      return Text(
                        utf8.decode(snapshot.data.nome.runes.toList()) + '?',
                        style: TextStyle(
                          color: Colors.black54,
                          fontWeight: FontWeight.w300,
                          fontSize: 30,
                        ),
                      );
                    } else {
                      return Text('');
                    }
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
