import 'package:flutter/material.dart';

class EndConsulta extends StatefulWidget {
  final String endingTxt;

  EndConsulta(this.endingTxt);

  @override
  _EndConsultaState createState() => _EndConsultaState(this.endingTxt);
}

class _EndConsultaState extends State<EndConsulta> {
  String endingTxt;

  _EndConsultaState(this.endingTxt);

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
                  child: Stack(
                    children: <Widget>[
                      Positioned(
                        top: 15,
                        left: 10,
                        width: 300,
                        child: Text(
                          endingTxt,
                          style: TextStyle(
                            fontSize: 20,
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      Positioned(
                        top: 150,
                        left: 12,
                        child: MaterialButton(
                          minWidth: 95,
                          height: 80,
                          color: Colors.amber,
                          child: Text(
                            "Voltar ao menu principal".toUpperCase(),
                            style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                            ),
                          ),
                          onPressed: () {
                            Navigator.of(context)
                                .popUntil((route) => route.isFirst);
                          },
                        ),
                      )
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
}
