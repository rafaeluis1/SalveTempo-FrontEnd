import 'package:flutter/material.dart';
import 'package:salvetempo/screens/anamnese-pessoal.dart';
import 'package:salvetempo/screens/anamnese.dart';
import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

class AnamneseClinica extends StatefulWidget {
  @override
  _AnamneseClinicaState createState() => _AnamneseClinicaState();
}

class _AnamneseClinicaState extends State<AnamneseClinica> {
  bool utilizaMedicamentos = false;
  bool possuiAlergias = false;
  bool alteracoesCardiacas = false;
  bool pressaoAlta = false;
  bool pressaoBaixa = false;
  bool disturbiosCirculatorios = false;
  bool disturbiosHormonais = false;
  bool diabetes = false;
  bool realizouCirurgias = false;

  //Crtl
  var medicamentoCrtl = TextEditingController();
  var alergiasCrtl = TextEditingController();
  var altCardiacaCrtl = TextEditingController();
  var distCirculatorioCrtl = TextEditingController();
  var distHormonalCrtl = TextEditingController();
  var cirurgiaCrtl = TextEditingController();

  var TP_DIABETES = {1: 'Tipo 1', 2: 'Tipo 2', 3: 'Gestacional'};
  int tipoDiabetes;

  Future<bool> returnAnamnesePessoal() async {
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => AnamnesePessoal()));
  }

  void saveAnamneseClinica() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();

    var anamneseClinica = {
      "utilizaMedicamentos": utilizaMedicamentos.toString(),
      "medicamentosUtilizados": medicamentoCrtl.text,
      "alergias": possuiAlergias.toString(),
      "alergiasDesc": alergiasCrtl.text,
      "alteracoesCardiacas": alteracoesCardiacas.toString(),
      "alteracoesCardiacasDesc": altCardiacaCrtl.text,
      "pressaoAlta": pressaoAlta.toString(),
      "pressaoBaixa": pressaoBaixa.toString(),
      "disturbioCirculatorio": disturbiosCirculatorios.toString(),
      "disturbioCirculatorioDesc": distCirculatorioCrtl.text,
      "disturbioHormonal": disturbiosHormonais.toString(),
      "disturbioHormonalDesc": distHormonalCrtl.text,
      "diabetes": diabetes.toString(),
      "tipoDiabetes": tipoDiabetes == null ? '' : tipoDiabetes.toString(),
      "fezCirurgias": realizouCirurgias.toString(),
      "cirurgiasDesc": cirurgiaCrtl.text
    };

    setState(() {
      sharedPreferences.setString(
          'anamnese-clinica', jsonEncode(anamneseClinica));
    });

    Navigator.push(
        context, MaterialPageRoute(builder: (context) => Anamnese()));
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: returnAnamnesePessoal,
      child: Scaffold(
        appBar: AppBar(
            title: Text("Anamnese - Informações Clínicas",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                ))),
        body: Center(
          child: ListView(
            children: <Widget>[
              Center(
                child: Padding(
                  padding: EdgeInsets.only(top: 50, right: 14),
                  child: Wrap(
                    spacing: 20,
                    runSpacing: -20,
                    children: <Widget>[
                      Transform.scale(
                        scale: 1.65,
                        child: Checkbox(
                            value: utilizaMedicamentos,
                            onChanged: (bool resp) {
                              setState(() {
                                utilizaMedicamentos = resp;
                                if (!utilizaMedicamentos) {
                                  medicamentoCrtl.text = '';
                                }
                              });
                            }),
                      ),
                      Container(
                        padding: EdgeInsets.only(top: 10),
                        child: Text(
                          "Utiliza algum medicamento?",
                          style: TextStyle(
                              fontSize: 22, fontWeight: FontWeight.w700),
                        ),
                      )
                    ],
                  ),
                ),
              ),
              Center(
                  child: utilizaMedicamentos
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
                                    labelText: "Medicamentos",
                                    alignLabelWithHint: true,
                                  ),
                                  keyboardType: TextInputType.multiline,
                                  maxLines: 8,
                                  controller: medicamentoCrtl,
                                ),
                              )
                            ],
                          ),
                        )
                      : Padding(
                          padding: EdgeInsets.only(),
                        )),
              Center(
                child: Padding(
                  padding: EdgeInsets.only(top: 30, right: 47),
                  child: Wrap(
                    spacing: 20,
                    runSpacing: -20,
                    children: <Widget>[
                      Transform.scale(
                        scale: 1.65,
                        child: Checkbox(
                            value: possuiAlergias,
                            onChanged: (bool resp) {
                              setState(() {
                                possuiAlergias = resp;
                                if (!possuiAlergias) {
                                  alergiasCrtl.text = '';
                                }
                              });
                            }),
                      ),
                      Container(
                        padding: EdgeInsets.only(top: 10),
                        child: Text(
                          "Possui/Possuiu alergias?",
                          style: TextStyle(
                              fontSize: 22, fontWeight: FontWeight.w700),
                        ),
                      )
                    ],
                  ),
                ),
              ),
              Center(
                  child: possuiAlergias
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
                                    labelText: "Alergias",
                                    alignLabelWithHint: true,
                                  ),
                                  keyboardType: TextInputType.multiline,
                                  maxLines: 8,
                                  controller: alergiasCrtl,
                                ),
                              )
                            ],
                          ),
                        )
                      : Padding(
                          padding: EdgeInsets.only(),
                        )),
              Center(
                child: Padding(
                  padding: EdgeInsets.only(top: 30, right: 7),
                  child: Wrap(
                    spacing: 20,
                    runSpacing: -20,
                    children: <Widget>[
                      Transform.scale(
                        scale: 1.65,
                        child: Checkbox(
                            value: alteracoesCardiacas,
                            onChanged: (bool resp) {
                              setState(() {
                                alteracoesCardiacas = resp;
                                if (!alteracoesCardiacas) {
                                  altCardiacaCrtl.text = '';
                                }
                              });
                            }),
                      ),
                      Container(
                        padding: EdgeInsets.only(top: 10),
                        child: Text(
                          "Possui alterações cardíacas?",
                          style: TextStyle(
                              fontSize: 22, fontWeight: FontWeight.w700),
                        ),
                      )
                    ],
                  ),
                ),
              ),
              Center(
                  child: alteracoesCardiacas
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
                                    labelText: "Alterações cardíacas",
                                    alignLabelWithHint: true,
                                  ),
                                  keyboardType: TextInputType.multiline,
                                  maxLines: 8,
                                  controller: altCardiacaCrtl,
                                ),
                              )
                            ],
                          ),
                        )
                      : Padding(
                          padding: EdgeInsets.only(),
                        )),
              Center(
                child: Padding(
                  padding: EdgeInsets.only(top: 30, right: 98),
                  child: Wrap(
                    spacing: 20,
                    runSpacing: -20,
                    children: <Widget>[
                      Transform.scale(
                        scale: 1.65,
                        child: Checkbox(
                            value: pressaoAlta,
                            onChanged: (bool resp) {
                              setState(() {
                                pressaoAlta = resp;
                              });
                            }),
                      ),
                      Container(
                        padding: EdgeInsets.only(top: 10),
                        child: Text(
                          "Possui pressão alta?",
                          style: TextStyle(
                              fontSize: 22, fontWeight: FontWeight.w700),
                        ),
                      )
                    ],
                  ),
                ),
              ),
              Center(
                child: Padding(
                  padding: EdgeInsets.only(top: 30, right: 80),
                  child: Wrap(
                    spacing: 20,
                    runSpacing: -20,
                    children: <Widget>[
                      Transform.scale(
                        scale: 1.65,
                        child: Checkbox(
                            value: pressaoBaixa,
                            onChanged: (bool resp) {
                              setState(() {
                                pressaoBaixa = resp;
                              });
                            }),
                      ),
                      Container(
                        padding: EdgeInsets.only(top: 10),
                        child: Text(
                          "Possui pressão baixa?",
                          style: TextStyle(
                              fontSize: 22, fontWeight: FontWeight.w700),
                        ),
                      )
                    ],
                  ),
                ),
              ),
              Center(
                child: Padding(
                  padding: EdgeInsets.only(top: 30, left: 5),
                  child: Wrap(
                    spacing: 20,
                    runSpacing: -20,
                    children: <Widget>[
                      Transform.scale(
                        scale: 1.65,
                        child: Checkbox(
                            value: disturbiosCirculatorios,
                            onChanged: (bool resp) {
                              setState(() {
                                disturbiosCirculatorios = resp;
                                if (!disturbiosCirculatorios) {
                                  distCirculatorioCrtl.text = '';
                                }
                              });
                            }),
                      ),
                      Container(
                        padding: EdgeInsets.only(top: 10),
                        child: Text(
                          "Possui distúrbios circulatórios?",
                          style: TextStyle(
                              fontSize: 21, fontWeight: FontWeight.w700),
                        ),
                      )
                    ],
                  ),
                ),
              ),
              Center(
                  child: disturbiosCirculatorios
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
                                    labelText: "Distúrbios circulatórios",
                                    alignLabelWithHint: true,
                                  ),
                                  keyboardType: TextInputType.multiline,
                                  maxLines: 8,
                                  controller: distCirculatorioCrtl,
                                ),
                              )
                            ],
                          ),
                        )
                      : Padding(
                          padding: EdgeInsets.only(),
                        )),
              Center(
                child: Padding(
                  padding: EdgeInsets.only(top: 30, left: 2),
                  child: Wrap(
                    spacing: 20,
                    runSpacing: -20,
                    children: <Widget>[
                      Transform.scale(
                        scale: 1.65,
                        child: Checkbox(
                            value: disturbiosHormonais,
                            onChanged: (bool resp) {
                              setState(() {
                                disturbiosHormonais = resp;
                                if (!disturbiosHormonais) {
                                  distHormonalCrtl.text = '';
                                }
                              });
                            }),
                      ),
                      Container(
                        padding: EdgeInsets.only(top: 10),
                        child: Text(
                          "Possui distúrbios hormonais?",
                          style: TextStyle(
                              fontSize: 22, fontWeight: FontWeight.w700),
                        ),
                      )
                    ],
                  ),
                ),
              ),
              Center(
                  child: disturbiosHormonais
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
                                    labelText: "Distúrbios hormonais",
                                    alignLabelWithHint: true,
                                  ),
                                  keyboardType: TextInputType.multiline,
                                  maxLines: 8,
                                  controller: distHormonalCrtl,
                                ),
                              )
                            ],
                          ),
                        )
                      : Padding(
                          padding: EdgeInsets.only(),
                        )),
              Center(
                child: Padding(
                  padding: EdgeInsets.only(top: 30, right: 134),
                  child: Wrap(
                    spacing: 20,
                    runSpacing: -20,
                    children: <Widget>[
                      Transform.scale(
                        scale: 1.65,
                        child: Checkbox(
                            value: diabetes,
                            onChanged: (bool resp) {
                              setState(() {
                                diabetes = resp;
                                if (!diabetes) {
                                  tipoDiabetes = null;
                                }
                              });
                            }),
                      ),
                      Container(
                        padding: EdgeInsets.only(top: 10),
                        child: Text(
                          "Possui diabetes?",
                          style: TextStyle(
                              fontSize: 22, fontWeight: FontWeight.w700),
                        ),
                      )
                    ],
                  ),
                ),
              ),
              Center(
                child: diabetes
                    ? Padding(
                        padding: EdgeInsets.only(top: 30),
                        child: Wrap(
                          spacing: 20,
                          runSpacing: -20,
                          children: <Widget>[
                            SizedBox(
                              width: 360,
                              child: FormField<int>(
                                builder: (FormFieldState<int> state) {
                                  return InputDecorator(
                                    decoration: InputDecoration(
                                      labelText: 'Tipo de diabetes',
                                      border: OutlineInputBorder(),
                                      alignLabelWithHint: true,
                                    ),
                                    child: DropdownButtonHideUnderline(
                                      child: DropdownButton<int>(
                                        value: tipoDiabetes,
                                        isDense: true,
                                        hint: Text("Selecione"),
                                        items: <int>[1, 2, 3].map((int value) {
                                          return new DropdownMenuItem<int>(
                                            value: value,
                                            child: new Text(TP_DIABETES[value]),
                                          );
                                        }).toList(),
                                        onChanged: (value) {
                                          setState(() {
                                            tipoDiabetes = value;
                                          });
                                        },
                                      ),
                                    ),
                                  );
                                },
                              ),
                            ),
                          ],
                        ),
                      )
                    : Padding(
                        padding: EdgeInsets.only(),
                      ),
              ),
              Center(
                child: Padding(
                  padding: EdgeInsets.only(top: 30, right: 111),
                  child: Wrap(
                    spacing: 20,
                    runSpacing: -20,
                    children: <Widget>[
                      Transform.scale(
                        scale: 1.65,
                        child: Checkbox(
                            value: realizouCirurgias,
                            onChanged: (bool resp) {
                              setState(() {
                                realizouCirurgias = resp;
                                if (!realizouCirurgias) {
                                  cirurgiaCrtl.text = '';
                                }
                              });
                            }),
                      ),
                      Container(
                        padding: EdgeInsets.only(top: 10),
                        child: Text(
                          "Realizou cirurgias?",
                          style: TextStyle(
                              fontSize: 22, fontWeight: FontWeight.w700),
                        ),
                      )
                    ],
                  ),
                ),
              ),
              Center(
                  child: realizouCirurgias
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
                                    labelText: "Cirurgias",
                                    alignLabelWithHint: true,
                                  ),
                                  keyboardType: TextInputType.multiline,
                                  maxLines: 8,
                                  controller: cirurgiaCrtl,
                                ),
                              )
                            ],
                          ),
                        )
                      : Padding(
                          padding: EdgeInsets.only(),
                        )),
              Align(
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
                        saveAnamneseClinica();
                      },
                    ),
                    SizedBox(
                      height: 125,
                    )
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
