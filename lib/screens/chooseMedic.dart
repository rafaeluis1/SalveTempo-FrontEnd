import 'package:flutter/material.dart';
import 'package:salvetempo/models/medico.dart';
import 'package:salvetempo/screens/end_consulta.dart';
import 'package:salvetempo/service/medicoService.dart';

class ChooseMedic extends StatefulWidget {
  final String timeKey;

  ChooseMedic(this.timeKey);

  @override
  _ChooseMedicState createState() => _ChooseMedicState(this.timeKey);
}

class _ChooseMedicState extends State<ChooseMedic> {
  String timeKey;

  _ChooseMedicState(this.timeKey);

  @override
  Widget build(BuildContext context) {
    MedicoService medicoService = new MedicoService();
    List<Medico> medicos = medicoService.createMedicos();

    List<Medico> medicosDisponiveis =
        medicoService.getMedicosByPeriodo(medicos, this.timeKey);

    return Scaffold(
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
                    child: ListView.builder(
                      itemCount: medicosDisponiveis.length,
                      itemBuilder: (context, index) {
                        return ListView(
                          shrinkWrap: true, //just set this property
                          padding: const EdgeInsets.all(8.0),
                          children: <Widget>[
                            doctorCard(
                                context,
                                medicosDisponiveis[index].nome,
                                medicosDisponiveis[index].especializacao,
                                medicosDisponiveis[index].unidadeSaude,
                                medicosDisponiveis[index].sexo,
                                this.timeKey),
                            SizedBox(
                              height: 10,
                            ),
                          ],
                        );
                      },
                    )),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget doctorCard(BuildContext context, String nome, String especialidade,
      String unidadeSaude, String sexo, String timeKey) {
    return GestureDetector(
      onTap: () {
        String nomenclatura = sexo == 'M' ? 'o Dr.' : 'a Dra.';
        String periodo = timeKey == "manha" ? 'manhã' : timeKey;
        String finalizacao = 'Consulta marcada com ' +
            nomenclatura +
            ' ' +
            nome +
            ' no dia 30/05/2020, no período da ' +
            periodo +
            '.';

        Navigator.push(context,
            MaterialPageRoute(builder: (context) => EndConsulta(finalizacao)));
      },
      child: Container(
        height: 150,
        width: 100,
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
                nome,
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
                especialidade,
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
                unidadeSaude,
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
                "Data: 30/05/2020",
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
    );
  }
}
