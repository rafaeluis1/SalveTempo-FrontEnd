import 'package:flutter/material.dart';
import 'package:salvetempo/screens/anamnese-clinica.dart';
import 'package:salvetempo/screens/anamnese-pessoal.dart';
import 'package:salvetempo/screens/chooseTime.dart';
import 'package:salvetempo/screens/localizacao.dart';
import 'package:salvetempo/screens/userpanel.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

class Observacao extends StatefulWidget {
  @override
  _ObservacaoState createState() => _ObservacaoState();
}

class _ObservacaoState extends State<Observacao> {
  var observacaoCrtl = TextEditingController();

  void saveObservacao() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();

    setState(() {
      sharedPreferences.setString("observacao", observacaoCrtl.text);
    });

    Navigator.push(
        context, MaterialPageRoute(builder: (context) => Localizacao()));
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
                    //Navigator.of(context).popUntil((route) => route.isFirst);
                    Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                            builder: (context) => AnamneseClinica()));
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

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _onWillPop,
      child: Scaffold(
        appBar: AppBar(
          title: Text("Observação"),
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
                      height: 400,
                      width: 380,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius:
                            const BorderRadius.all(Radius.circular(10)),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.5),
                            spreadRadius: 5,
                            blurRadius: 7,
                            offset: Offset(0, 3),
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
                              minWidth: 150,
                              height: 70,
                              color: Colors.amber,
                              child: Text(
                                "Próximo".toUpperCase(),
                                style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18,
                                ),
                              ),
                              onPressed: () {
                                saveObservacao();
                              },
                            ),
                            SizedBox(
                              height: 125,
                            )
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ),
              Center(
                child: Padding(
                  padding: EdgeInsets.only(bottom: 160),
                  child: Wrap(
                    spacing: 20,
                    runSpacing: -20,
                    children: <Widget>[
                      SizedBox(
                        width: 360,
                        child: TextField(
                          keyboardType: TextInputType.multiline,
                          maxLines: 8,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: "Observação",
                            alignLabelWithHint: true,
                          ),
                          controller: observacaoCrtl,
                        ),
                      )
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
