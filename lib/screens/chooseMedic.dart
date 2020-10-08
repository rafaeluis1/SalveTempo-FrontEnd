import 'dart:convert';
import 'package:date_format/date_format.dart';
import 'package:flutter/material.dart';
import 'package:salvetempo/models/medico.dart';
import 'package:salvetempo/models/prognostico.dart';
import 'package:salvetempo/models/unidadeSaudeModels.dart';
import 'package:salvetempo/screens/end_consulta.dart';
import 'package:salvetempo/service/consultaService.dart';
import 'package:salvetempo/service/unidadeSaudeService.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ChooseMedic extends StatefulWidget {
  final String timeKey;

  ChooseMedic(this.timeKey);

  @override
  _ChooseMedicState createState() => _ChooseMedicState(this.timeKey);
}

class _ChooseMedicState extends State<ChooseMedic> {
  String timeKey;

  var unidadeSaudeService = UnidadeSaudeService();
  var consultaService = ConsultaService();

  //var opcoesConsulta = new List<OpcaoConsulta>();

  _ChooseMedicState(this.timeKey);

  Future defineOpcoesConsulta() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();

    var opcoesConsulta = new List<OpcaoConsulta>();

    var unidadesSaude = new List<UnidadeSaude>();
    var medicosUnidadesSaude = new List<MedicoUnidadeSaude>();

    var especializacoesValidas;

    var progs = json
        .decode(json.decode(sharedPreferences.getString('prognosticos')))
        .toList();

    await consultaService
        .especializacoesValidas(sharedPreferences.getString("key"), progs)
        .then((response) {
      especializacoesValidas = json.decode(response.body)['ids'].toList();
    });

    await unidadeSaudeService
        .getUnidadesSaudeByCidadeId(sharedPreferences.getString("cidade"))
        .then((response) async {
      Iterable list = json.decode(response.body);
      unidadesSaude = list.map((item) => UnidadeSaude.fromJson(item)).toList();

      for (UnidadeSaude u in unidadesSaude) {
        await unidadeSaudeService
            .getMedicosByUnidadeSaudeId(
                sharedPreferences.getString("key"), u.id.toString())
            .then((response) {
          Iterable list = json.decode(response.body);
          medicosUnidadesSaude =
              list.map((item) => MedicoUnidadeSaude.fromJson(item)).toList();

          if (medicosUnidadesSaude.length > 0) {
            for (MedicoUnidadeSaude medico in medicosUnidadesSaude) {
              if (medico.status == 'A' &&
                  medico.diaPeriodoTrabalho.indexOf(timeKey) >= 0 &&
                  especializacoesValidas
                      .contains(medico.medico.especializacao.id)) {
                var diasSemana = medico.diaPeriodoTrabalho.split('|');
                diasSemana.removeAt(diasSemana.length - 1);

                for (String item in diasSemana) {
                  var weekday = item.split(':')[0];
                  var periodos = item.split(':')[1];

                  var today = new DateTime.now();
                  for (var i = 0; i < 7; i++) {
                    var day = today.add(new Duration(days: i));

                    if ((weekday == day.weekday.toString()) &&
                        (periodos.indexOf(timeKey) >= 0)) {
                      var op = new OpcaoConsulta(
                          medico: medico.medico,
                          unidadeSaude: medico.unidadeSaude,
                          dataConsulta: day);
                      opcoesConsulta.add(op);
                    }
                  }
                }
              }
            }
          }
        });
      }
    });

    return opcoesConsulta;
  }

  Future salvaPrognosticos(
      String key, List<String> sintomas, String consultaId) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();

    bool isOk = true;
    //var prognosticos = new List<Prognostico>();

    var progs = json
        .decode(json.decode(sharedPreferences.getString('prognosticos')))
        .toList();

    for (var prog in progs) {
      await consultaService
          .insereConsultaPrognostico(key, consultaId, prog['id'].toString(),
              prog['porcentagem'].toString())
          .then((response) {
        if (response.statusCode >= 200 && response.statusCode <= 299 && isOk) {
          print("Salvou Prognóstico");
        } else {
          print("Algo deu errado ao salvar o Prognóstico");
          isOk = false;
        }
      });
    }

    return isOk;
  }

  void saveInfoConsulta(UnidadeSaude unidadeSaude, Medico medico,
      DateTime dataConsulta, String timeKey, String finalizacaoStr) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();

    var canContinue = true;
    String key = sharedPreferences.getString("key");
    String anamnesePessoal = sharedPreferences.getString('anamnese-pessoal');
    String anamneseClinica = sharedPreferences.getString('anamnese-clinica');

    await consultaService
        .cadastroAnamnese(key, anamnesePessoal, anamneseClinica)
        .then((response) async {
      var resp = json.decode(response.body);

      if (response.statusCode >= 200 &&
          response.statusCode <= 299 &&
          canContinue) {
        await consultaService
            .cadastroConsulta(
                key,
                sharedPreferences.getString("id"),
                unidadeSaude.id.toString(),
                resp['id'].toString(),
                medico.id.toString(),
                dataConsulta,
                timeKey.substring(0, 1).toUpperCase(),
                sharedPreferences.getString("observacao"))
            .then((response) async {
          if (response.statusCode >= 200 &&
              response.statusCode <= 299 &&
              canContinue) {
            var consultaId = jsonDecode(response.body)['id'].toString();

            for (String s in sharedPreferences.getStringList("sintomas")) {
              var div = s.split(';');
              await consultaService
                  .insereConsultaSintoma(key, consultaId, div[0], div[2])
                  .then((response) {
                if (response.statusCode >= 200 &&
                    response.statusCode <= 299 &&
                    canContinue) {
                  print("Salvou Sintoma");
                } else {
                  print("Ocorreu algo errado ao inserir os sintomas.");
                  canContinue = false;
                }
              });
            }

            await salvaPrognosticos(key,
                    sharedPreferences.getStringList("sintomas"), consultaId)
                .then((result) {
              if (result == true) {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => EndConsulta(finalizacaoStr)));
              } else {
                print("Algo deu errado ao finalizar");
              }
            });
          } else {
            print("Ocorreu algo errado ao salvar a consulta");
            canContinue = false;
          }
        });
      } else {
        print("Ocorreu algo errado ao salvar a anamnese");
        canContinue = false;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    //defineOpcoesConsulta(); - Usar o FutureBuilder

    return Scaffold(
        appBar: AppBar(
          title: Text("Selecione o Médico"),
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
                        future: defineOpcoesConsulta(),
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
                                  return doctorCard(
                                      context,
                                      snapshot.data[index].medico,
                                      snapshot.data[index].unidadeSaude,
                                      snapshot.data[index].dataConsulta,
                                      this.timeKey);
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
                                      "Não foi possível encontrar nenhum médico disponível para consulta.",
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
        ));
  }

  Widget doctorCard(BuildContext context, Medico medico,
      UnidadeSaude unidadeSaude, DateTime dataConsulta, String timeKey) {
    var strDataConsulta = formatDate(dataConsulta, [dd, '/', mm, '/', yyyy]);
    return Container(
      padding: const EdgeInsets.all(8.0),
      child: Stack(
        children: <Widget>[
          GestureDetector(
            onTap: () {
              String nomenclatura = medico.sexo == 'M' ? 'o Dr.' : 'a Dra.';
              String periodo = timeKey == "manha" ? 'manhã' : timeKey;
              String finalizacao = 'Consulta marcada com ' +
                  nomenclatura +
                  ' ' +
                  medico.nome +
                  ' no dia ' +
                  strDataConsulta +
                  ', no período da ' +
                  periodo +
                  '.';

              saveInfoConsulta(
                  unidadeSaude, medico, dataConsulta, timeKey, finalizacao);
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
