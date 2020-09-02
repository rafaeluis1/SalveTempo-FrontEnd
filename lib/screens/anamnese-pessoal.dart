import 'package:flutter/material.dart';
import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:salvetempo/screens/anamnese-clinica.dart';
import 'package:salvetempo/screens/anamnese.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:salvetempo/service/pacienteService.dart';
import 'package:salvetempo/models/paciente.dart';

class AnamnesePessoal extends StatefulWidget {
  @override
  _AnamnesePessoalState createState() => _AnamnesePessoalState();
}

class _AnamnesePessoalState extends State<AnamnesePessoal> {
  bool fuma = false;
  bool bebe = false;
  bool praticaAtividadesFisicas = false;
  bool utilizaAnticoncepcionais = false;
  bool realizouGestacoes = false;

  int freqBebeDiasSemana;
  int freqAtivFisicaDiasSemana;

  //Crtl
  var pesoCrtl = TextEditingController();
  var alturaCrtl = TextEditingController();
  var qtdCigarrosCrtl = TextEditingController();
  var ativFisicaCrtl = TextEditingController();
  var anticoncepcionaisCrtl = TextEditingController();
  var ultGestacaoCrtl = TextEditingController();

  var QLD_ALIM_ING_AGUA = {1: 'Boa', 2: 'Regular', 3: 'Ruim'};
  int habitosAlimAgua;

  var pacienteService = PacienteService();

  Future<Paciente> futurePaciente;

  void saveAnamnesePessoal() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();

    var anamnesePessoal = {
      'peso': pesoCrtl.text,
      'altura': alturaCrtl.text,
      'fuma': fuma.toString(),
      'qtdCigarrosDia': qtdCigarrosCrtl.text,
      'bebe': bebe.toString(),
      'freqBebeDiasSemana':
          freqBebeDiasSemana == null ? '0' : freqBebeDiasSemana.toString(),
      'qualidadeAlimentacaoIngestaoAgua': habitosAlimAgua.toString(),
      'praticaAtividadeFisica': praticaAtividadesFisicas.toString(),
      'tipoAtividadeFisica': ativFisicaCrtl.text,
      'freqAtividadeFisicaDiasSemana': freqAtivFisicaDiasSemana == null
          ? '0'
          : freqAtivFisicaDiasSemana.toString(),
      'utilizaAnticoncepcional': utilizaAnticoncepcionais.toString(),
      'anticoncepcionaisUtilizados': anticoncepcionaisCrtl.text,
      'realizouGestacoes': realizouGestacoes.toString(),
      'ultimaGestacaoTempoMeses': ultGestacaoCrtl.text
    };

    setState(() {
      sharedPreferences.setString(
          'anamnese-pessoal', jsonEncode(anamnesePessoal));
    });

    Navigator.push(
        context, MaterialPageRoute(builder: (context) => AnamneseClinica()));
  }

  Future<String> getSexoPaciente() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String id = sharedPreferences.getString("id");
    String pacienteSexo;

    futurePaciente = pacienteService.getPacienteById(id);

    await futurePaciente.then((paciente) {
      pacienteSexo = paciente.sexo;
    });

    return pacienteSexo;
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
                    Navigator.of(context).popUntil((route) => route.isFirst);
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
            title: Text("Anamnese - Informações Pessoais",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                ))),
        body: Center(
          child: ListView(
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
                            labelText: "Peso (kg)",
                            alignLabelWithHint: true,
                          ),
                          keyboardType: TextInputType.number,
                          controller: pesoCrtl,
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
                            labelText: "Altura (m)",
                            alignLabelWithHint: true,
                          ),
                          keyboardType: TextInputType.number,
                          controller: alturaCrtl,
                        ),
                      )
                    ],
                  ),
                ),
              ),
              Center(
                child: Padding(
                  padding: EdgeInsets.only(top: 30, right: 230),
                  child: Wrap(
                    spacing: 20,
                    runSpacing: -20,
                    children: <Widget>[
                      Transform.scale(
                        scale: 1.65,
                        child: Checkbox(
                            value: fuma,
                            onChanged: (bool resp) {
                              setState(() {
                                fuma = resp;
                                if (!fuma) {
                                  qtdCigarrosCrtl.text = '0';
                                }
                              });
                            }),
                      ),
                      Container(
                        padding: EdgeInsets.only(top: 10),
                        child: Text(
                          "Fuma?",
                          style: TextStyle(
                              fontSize: 22, fontWeight: FontWeight.w700),
                        ),
                      )
                    ],
                  ),
                ),
              ),
              Center(
                  child: fuma
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
                                    labelText: "Quantidade de cigarros (dia)",
                                    alignLabelWithHint: true,
                                  ),
                                  keyboardType: TextInputType.number,
                                  controller: qtdCigarrosCrtl,
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
                  padding: EdgeInsets.only(top: 30, right: 14),
                  child: Wrap(
                    spacing: 20,
                    runSpacing: -20,
                    children: <Widget>[
                      Transform.scale(
                        scale: 1.65,
                        child: Checkbox(
                            value: bebe,
                            onChanged: (bool resp) {
                              setState(() {
                                bebe = resp;
                                if (!bebe) {
                                  freqBebeDiasSemana = null;
                                }
                              });
                            }),
                      ),
                      Container(
                        padding: EdgeInsets.only(top: 10),
                        child: Text(
                          "Ingere bebidas alcoólicas?",
                          style: TextStyle(
                              fontSize: 22, fontWeight: FontWeight.w700),
                        ),
                      )
                    ],
                  ),
                ),
              ),
              Center(
                  child: bebe
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
                                        labelText:
                                            'Frequência (dias da semana)',
                                        border: OutlineInputBorder(),
                                        alignLabelWithHint: true,
                                      ),
                                      child: DropdownButtonHideUnderline(
                                        child: DropdownButton<int>(
                                          value: freqBebeDiasSemana,
                                          isDense: true,
                                          hint: Text("Selecione"),
                                          items: <int>[1, 2, 3, 4, 5, 6, 7]
                                              .map((int value) {
                                            return new DropdownMenuItem<int>(
                                              value: value,
                                              child: new Text(value.toString()),
                                            );
                                          }).toList(),
                                          onChanged: (value) {
                                            setState(() {
                                              freqBebeDiasSemana = value;
                                            });
                                          },
                                        ),
                                      ),
                                    );
                                  },
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
                                labelText: 'Alimentação e ingestão de água',
                                border: OutlineInputBorder(),
                                alignLabelWithHint: true,
                              ),
                              child: DropdownButtonHideUnderline(
                                child: DropdownButton<int>(
                                  value: habitosAlimAgua,
                                  isDense: true,
                                  hint: Text("Selecione"),
                                  items: <int>[1, 2, 3].map((int value) {
                                    return new DropdownMenuItem<int>(
                                      value: value,
                                      child: new Text(QLD_ALIM_ING_AGUA[value]),
                                    );
                                  }).toList(),
                                  onChanged: (value) {
                                    setState(() {
                                      habitosAlimAgua = value;
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
                ),
              ),
              Center(
                child: Padding(
                  padding: EdgeInsets.only(top: 30, right: 14),
                  child: Wrap(
                    spacing: 20,
                    runSpacing: -20,
                    children: <Widget>[
                      Transform.scale(
                        scale: 1.65,
                        child: Checkbox(
                            value: praticaAtividadesFisicas,
                            onChanged: (bool resp) {
                              setState(() {
                                praticaAtividadesFisicas = resp;
                                if (!praticaAtividadesFisicas) {
                                  freqAtivFisicaDiasSemana = null;
                                  ativFisicaCrtl.text = '';
                                }
                              });
                            }),
                      ),
                      Container(
                        padding: EdgeInsets.only(top: 10),
                        child: Text(
                          "Pratica atividades físicas?",
                          style: TextStyle(
                              fontSize: 22, fontWeight: FontWeight.w700),
                        ),
                      )
                    ],
                  ),
                ),
              ),
              Center(
                  child: praticaAtividadesFisicas
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
                                    labelText: "Atividades físicas",
                                    alignLabelWithHint: true,
                                  ),
                                  keyboardType: TextInputType.multiline,
                                  maxLines: 8,
                                  controller: ativFisicaCrtl,
                                ),
                              )
                            ],
                          ),
                        )
                      : Padding(
                          padding: EdgeInsets.only(),
                        )),
              Center(
                  child: praticaAtividadesFisicas
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
                                        labelText:
                                            'Frequência (dias da semana)',
                                        border: OutlineInputBorder(),
                                        alignLabelWithHint: true,
                                      ),
                                      child: DropdownButtonHideUnderline(
                                        child: DropdownButton<int>(
                                          value: freqAtivFisicaDiasSemana,
                                          isDense: true,
                                          hint: Text("Selecione"),
                                          items: <int>[1, 2, 3, 4, 5, 6, 7]
                                              .map((int value) {
                                            return new DropdownMenuItem<int>(
                                              value: value,
                                              child: new Text(value.toString()),
                                            );
                                          }).toList(),
                                          onChanged: (value) {
                                            setState(() {
                                              freqAtivFisicaDiasSemana = value;
                                              print(freqAtivFisicaDiasSemana);
                                            });
                                          },
                                        ),
                                      ),
                                    );
                                  },
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
                  padding: EdgeInsets.only(top: 30, right: 14),
                  child: Wrap(
                    spacing: 20,
                    runSpacing: -20,
                    children: <Widget>[
                      Transform.scale(
                        scale: 1.65,
                        child: Checkbox(
                            value: utilizaAnticoncepcionais,
                            onChanged: (bool resp) {
                              setState(() {
                                utilizaAnticoncepcionais = resp;
                                if (!utilizaAnticoncepcionais) {
                                  anticoncepcionaisCrtl.text = '';
                                }
                              });
                            }),
                      ),
                      Container(
                        padding: EdgeInsets.only(top: 10),
                        child: Text(
                          "Utiliza anticoncepcionais?",
                          style: TextStyle(
                              fontSize: 22, fontWeight: FontWeight.w700),
                        ),
                      )
                    ],
                  ),
                ),
              ),
              Center(
                  child: utilizaAnticoncepcionais
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
                                    labelText: "Anticoncepcionais utilizados",
                                    alignLabelWithHint: true,
                                  ),
                                  keyboardType: TextInputType.multiline,
                                  maxLines: 8,
                                  //controller: estadoCrtl,
                                ),
                              )
                            ],
                          ),
                        )
                      : Padding(
                          padding: EdgeInsets.only(),
                        )),
              FutureBuilder(
                  future: getSexoPaciente(),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      return Center(
                        child: snapshot.data == 'F'
                            ? Padding(
                                padding: EdgeInsets.only(top: 30, right: 115),
                                child: Wrap(
                                  spacing: 20,
                                  runSpacing: -20,
                                  children: <Widget>[
                                    Transform.scale(
                                      scale: 1.65,
                                      child: Checkbox(
                                          value: realizouGestacoes,
                                          onChanged: (bool resp) {
                                            setState(() {
                                              realizouGestacoes = resp;
                                              if (!realizouGestacoes) {
                                                ultGestacaoCrtl.text = '0';
                                              }
                                            });
                                          }),
                                    ),
                                    Container(
                                      padding: EdgeInsets.only(top: 10),
                                      child: Text(
                                        "Teve gestações?",
                                        style: TextStyle(
                                            fontSize: 22,
                                            fontWeight: FontWeight.w700),
                                      ),
                                    )
                                  ],
                                ),
                              )
                            : Padding(
                                padding: EdgeInsets.only(),
                              ),
                      );
                    } else {
                      return Center(
                        child: Padding(
                          padding: EdgeInsets.only(),
                        ),
                      );
                    }
                  }),
              Center(
                child: realizouGestacoes
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
                                  labelText: "Tempo da última gestação (meses)",
                                  alignLabelWithHint: true,
                                ),
                                keyboardType: TextInputType.number,
                                controller: ultGestacaoCrtl,
                              ),
                            )
                          ],
                        ),
                      )
                    : Padding(padding: EdgeInsets.only(top: 30)),
              ),
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
                        saveAnamnesePessoal();
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
