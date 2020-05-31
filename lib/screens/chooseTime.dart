import 'package:flutter/material.dart';
import 'package:diacritic/diacritic.dart';
import 'package:salvetempo/screens/chooseMedic.dart';

class ChooseTime extends StatefulWidget {
  @override
  _ChooseTimeState createState() => _ChooseTimeState();
}

class _ChooseTimeState extends State<ChooseTime> {
  bool selectedSeg, selectedTer, selectedQua, selectedQui, selectedSex = false;

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
                  color: Colors.white,
                  borderRadius: BorderRadius.all(
                    Radius.circular(10),
                  ),
                ),
                child: ListView(
                  shrinkWrap: true, //just set this property
                  padding: const EdgeInsets.all(8.0),
                  children: <Widget>[
                    Stack(
                      children: <Widget>[
                        Container(
                          //height: selectedSeg ? 100 : 60,
                          height: 500,
                          width: 400,
                          color: Colors.amberAccent,
                        ),
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              selectedSeg = !selectedSeg;
                              print(selectedSeg);
                            });
                          },
                          child: Container(
                            height: 500,
                            width: 400,
                            color: Colors.brown,
                            child: ListView(
                                shrinkWrap: true, //just set this property
                                padding: const EdgeInsets.all(8.0),
                                children: <Widget>[
                                  timeCard(context, "Manhã"),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  timeCard(context, "Tarde"),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  timeCard(context, "Noite"),
                                  SizedBox(
                                    height: 10,
                                  ),
                                ]),
                          ),
                        ),
                      ],
                    ),
                    Container(
                      height: 100,
                      width: 100,
                      color: Colors.black,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget timeCard(BuildContext context, String desc) {
    return GestureDetector(
      onTap: () {
        String jsonTimeKey = removeDiacritics(desc.toLowerCase());
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => ChooseMedic(jsonTimeKey)));
      },
      child: Container(
        height: 125,
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
              top: 40,
              right: 180,
              child: Text(
                desc,
                style: TextStyle(
                  fontSize: 30,
                  color: Colors.white,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
