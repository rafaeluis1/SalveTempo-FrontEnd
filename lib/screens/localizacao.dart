import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:salvetempo/models/localizacaoModels.dart';
import 'package:salvetempo/screens/chooseTime.dart';
import 'package:salvetempo/service/localizacaoService.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Localizacao extends StatefulWidget {
  @override
  _LocalizacaoState createState() => _LocalizacaoState();
}

class _LocalizacaoState extends State<Localizacao> {
  var localizacaoService = LocalizacaoService();

  var estadoCrtl = TextEditingController();
  var cidadeCrtl = TextEditingController();

  var selectedEstado;
  var selectedCidade;

  void chooseEstado() {
    var estados = new List<Estado>();

    localizacaoService.getEstados().then((response) {
      Iterable list = json.decode(response.body);
      estados = list.map((item) => Estado.fromJson(item)).toList();

      showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text("Selecione o estado"),
              content: Container(
                width: double.maxFinite,
                child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: estados.length,
                    itemBuilder: (BuildContext context, int index) {
                      return RadioListTile(
                        title: Text(
                            utf8.decode(estados[index].nome.runes.toList()) +
                                ' (' +
                                estados[index].sigla +
                                ')'),
                        value: estados[index].id,
                        groupValue: selectedEstado,
                        onChanged: (value) {
                          selectedEstado = value;
                          estadoCrtl.text =
                              utf8.decode(estados[index].nome.runes.toList()) +
                                  ' (' +
                                  estados[index].sigla +
                                  ')';
                          cidadeCrtl.clear();
                          Navigator.pop(context, false);
                        },
                      );
                    }),
              ),
            );
          });
    });
  }

  void chooseCidade() {
    var cidades = new List<Cidade>();

    if (selectedEstado == null) {
      showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text("Nenhum estado selecionado"),
            );
          });
    } else {
      localizacaoService
          .getCidadesById(selectedEstado.toString())
          .then((response) {
        Iterable list = json.decode(response.body);
        cidades = list.map((item) => Cidade.fromJson(item)).toList();

        showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: Text("Selecione a cidade"),
                content: Container(
                  width: double.maxFinite,
                  child: ListView.builder(
                      shrinkWrap: true,
                      itemCount: cidades.length,
                      itemBuilder: (BuildContext context, int index) {
                        return RadioListTile(
                          title: Text(
                              utf8.decode(cidades[index].nome.runes.toList())),
                          value: cidades[index].id,
                          groupValue: selectedCidade,
                          onChanged: (value) {
                            selectedCidade = value;
                            cidadeCrtl.text =
                                utf8.decode(cidades[index].nome.runes.toList());
                            Navigator.pop(context, false);
                          },
                        );
                      }),
                ),
              );
            });
      });
    }
  }

  void saveLocalizacao() async {
    if (!(selectedEstado == null) && !(selectedCidade == null)) {
      SharedPreferences sharedPreferences =
          await SharedPreferences.getInstance();

      setState(() {
        sharedPreferences.setString("estado", selectedEstado.toString());
        sharedPreferences.setString("cidade", selectedCidade.toString());
      });

      Navigator.push(
          context, MaterialPageRoute(builder: (context) => ChooseTime()));
    } else {
      print("Selecione estado e cidade.");
    }
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Localização"),
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
                      borderRadius: const BorderRadius.all(Radius.circular(10)),
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
                              saveLocalizacao();
                            },
                          ),
                          SizedBox(
                            height: 125,
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Center(
              child: Padding(
                padding: EdgeInsets.only(bottom: 280),
                child: Wrap(
                  spacing: 20,
                  runSpacing: -20,
                  children: <Widget>[
                    SizedBox(
                      width: 360,
                      child: TextField(
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: "Estado",
                          alignLabelWithHint: true,
                        ),
                        readOnly: true,
                        onTap: () {
                          chooseEstado();
                        },
                        controller: estadoCrtl,
                      ),
                    )
                  ],
                ),
              ),
            ),
            Center(
              child: Padding(
                padding: EdgeInsets.only(bottom: 50),
                child: Wrap(
                  spacing: 20,
                  runSpacing: -20,
                  children: <Widget>[
                    SizedBox(
                      width: 360,
                      child: TextField(
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: "Cidade",
                          alignLabelWithHint: true,
                        ),
                        readOnly: true,
                        onTap: () {
                          chooseCidade();
                        },
                        controller: cidadeCrtl,
                      ),
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
