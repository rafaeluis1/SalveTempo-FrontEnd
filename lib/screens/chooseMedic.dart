import 'package:flutter/material.dart';

class ChooseMedic extends StatefulWidget {
  @override
  _ChooseMedicState createState() => _ChooseMedicState();
}

class _ChooseMedicState extends State<ChooseMedic> {
  @override
  Widget build(BuildContext context) {
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
                  child: ListView(
                    shrinkWrap: true, //just set this property
                    padding: const EdgeInsets.all(8.0),
                    children: <Widget>[
                      doctorCard(context, "Felipe Moura", "Cardiologista",
                          "UBS - Jataí"),
                      SizedBox(
                        height: 10,
                      ),
                      doctorCard(context, "Jarbas da Costa", "Cardiologista",
                          "UBS - Jataí"),
                      SizedBox(
                        height: 10,
                      ),
                      doctorCard(context, "Luiz Santos", "Cardiologista",
                          "UBS - Pq Bela Vista"),
                      SizedBox(
                        height: 10,
                      ),
                      doctorCard(context, "Drauzio Rodrigues", "Cardiologista",
                          "UBS - Santa Rosália"),
                      SizedBox(
                        height: 10,
                      ),
                      doctorCard(context, "Marcelo Severino", "Cardiologista",
                          "UBS - ZN Sorocaba"),
                      SizedBox(
                        height: 10,
                      ),
                      doctorCard(context, "Pamela Souza", "Cardiologista",
                          "UBS - ZN Sorocaba"),
                      SizedBox(
                        height: 10,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget doctorCard(BuildContext context, String nome, String especialidade,
      String unidadeSaude) {
    return GestureDetector(
      onTap: () {},
      child: Container(
        height: 100,
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
              top: 10,
              left: 10,
              child: CircleAvatar(
                radius: 30.0,
                backgroundColor: Colors.white,
              ),
            ),
            Positioned(
              top: 15,
              left: 120,
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
              top: 40,
              left: 120,
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
              top: 70,
              left: 120,
              child: Text(
                unidadeSaude,
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
