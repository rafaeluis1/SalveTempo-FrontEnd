import 'package:flutter/material.dart';
import 'package:salvetempo/screens/anamnese.dart';

class UserPanel extends StatefulWidget {
  @override
  _UserPanelState createState() => _UserPanelState();
}

class _UserPanelState extends State<UserPanel> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Painel do Usuário")),
      body: Container(
        width: double.maxFinite,
        height: double.maxFinite,
        child: Stack(
          children: <Widget>[
            Container(
              color: Colors.white,
            ),
            Positioned(
              top: 80,
              left: 110,
              child: Text(
                "Olá, %username%",
                style: TextStyle(
                  color: Colors.blueAccent,
                  fontWeight: FontWeight.w500,
                  fontSize: 20,
                ),
              ),
            ),
            Center(
              child: ButtonBar(
                buttonHeight: 50,
                buttonMinWidth: 400,
                alignment: MainAxisAlignment.spaceBetween,
                mainAxisSize: MainAxisSize.max,
                children: <Widget>[
                  new MaterialButton(
                      color: Colors.redAccent,
                      child: Text(
                        "Nova Consulta",
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w500,
                          fontSize: 20,
                        ),
                      ),
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => Anamnese()));
                      }),
                  SizedBox(
                    height: 10,
                  ),
                  new MaterialButton(
                      color: Colors.blueAccent,
                      child: Text(
                        "Histórico de Consultas",
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w500,
                          fontSize: 20,
                        ),
                      ),
                      onPressed: () {}),
                  SizedBox(
                    height: 10,
                  ),
                  new MaterialButton(
                      color: Colors.blueAccent,
                      child: Text(
                        "Informações Pessoais",
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w500,
                          fontSize: 20,
                        ),
                      ),
                      onPressed: () {}),
                  SizedBox(
                    height: 10,
                  ),
                  new MaterialButton(
                      color: Colors.blueAccent,
                      child: Text(
                        "Ultimos Médicos Consultados",
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w500,
                          fontSize: 20,
                        ),
                      ),
                      onPressed: () {}),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
