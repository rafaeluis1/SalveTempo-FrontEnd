import 'package:flutter/material.dart';
import 'package:salvetempo/models/sintoma.dart';
import 'package:salvetempo/widget/popup_errorAnamnese.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:salvetempo/service/sintomaService.dart';

class Anamnese extends StatefulWidget {
  @override
  _AnamneseState createState() => _AnamneseState();
}

class _AnamneseState extends State<Anamnese> {
  var sintomaService = SintomaService();

  Future<Sintoma> showSintoma() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String key = sharedPreferences.get("token");
    List<String> sintomas = sharedPreferences.getStringList("sintomas");

    /*
    print("Sintomas: " +
        sharedPreferences.getStringList("sintomas").length.toString());
    for (String s in sharedPreferences.getStringList("sintomas")) {
      print(s);
    }*/

    futureSintoma = sintomaService.showSintoma(key, sintomas);
    return futureSintoma;
  }

  Future<int> answerSintoma(String resposta) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String key = sharedPreferences.get("token");
    List<String> sintomas = sharedPreferences.getStringList("sintomas");

    sintomas.add(sintoma + ';' + resposta);
    print(sintomas);
    sharedPreferences.setStringList("sintomas", sintomas);

    futureResult = sintomaService.answerSintoma(key, sintoma, resposta);
    return futureResult;
  }

  Future<bool> _onWillPop() async {
    return showDialog<bool>(
        context: context,
        barrierDismissible: false,
        builder: (context) => AlertDialog(
              title: Text("Você deseja abortar sua consulta?"),
              actions: <Widget>[
                RaisedButton(
                  child: Text("Sim"),
                  onPressed: () {
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
  Future<int> futureResult;
  String sintoma;

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _onWillPop,
      child: Scaffold(
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
                                showDialog(
                                  context: context,
                                  builder: (BuildContext context) =>
                                      PopupErrorAn(),
                                );
                                //futureResult = answerSintoma("1");

                                futureResult.then((result) {
                                  if (result == 0) {
                                    setState(() {});
                                  } else {
                                    print('Algo deu errado');
                                  }
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
                                futureResult = answerSintoma("0");

                                futureResult.then((result) {
                                  if (result == 0) {
                                    setState(() {});
                                  } else {
                                    print('Algo deu errado');
                                  }
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
                                futureResult = answerSintoma("-1");

                                futureResult.then((result) {
                                  if (result == 0) {
                                    setState(() {});
                                  } else {
                                    print('Algo deu errado');
                                  }
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
                      sintoma = snapshot.data.nomecsv;
                      return Text(
                        snapshot.data.nome + '?',
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
