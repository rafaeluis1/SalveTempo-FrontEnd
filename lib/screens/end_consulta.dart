import 'package:flutter/material.dart';
import 'package:salvetempo/screens/userpanel.dart';

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
      appBar: AppBar(
        title: Text("Finalização"),
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
                            height: 90,
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
                              Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => UserPanel()));
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
            Positioned(
              top: 200,
              left: 25,
              width: 360,
              child: Text(
                endingTxt,
                style: TextStyle(
                  color: Colors.black54,
                  fontWeight: FontWeight.w500,
                  fontSize: 30,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
