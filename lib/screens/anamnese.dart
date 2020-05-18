import 'package:flutter/material.dart';

class Anamnese extends StatefulWidget {
  @override
  _AnamneseState createState() => _AnamneseState();
}

class _AnamneseState extends State<Anamnese> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                            onPressed: () {},
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
                            onPressed: () {},
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
                            onPressed: () {},
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
                "Você possui?".toUpperCase(),
                style: TextStyle(
                  color: Colors.black54,
                  fontWeight: FontWeight.w500,
                  fontSize: 30,
                ),
              ),
            ),
            Center(
              child: Text(
                "%sintoma%",
                style: TextStyle(
                  color: Colors.black54,
                  fontWeight: FontWeight.w300,
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
