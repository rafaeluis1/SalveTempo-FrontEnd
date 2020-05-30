import 'package:flutter/material.dart';

class ChooseTime extends StatefulWidget {
  @override
  _ChooseTimeState createState() => _ChooseTimeState();
}

class _ChooseTimeState extends State<ChooseTime> {
  bool selectedSeg, selectedTer, selectedQua, selectedQui, selectedSex = false;

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
                        height: selectedSeg ? 100 : 60,
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
                          height: 60,
                          width: 400,
                          color: Colors.brown,
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
    );
  }
}
