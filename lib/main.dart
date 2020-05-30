import 'package:flutter/material.dart';
import 'package:salvetempo/screens/chooseMedic.dart';
import 'package:salvetempo/screens/chooseTime.dart';
import 'package:salvetempo/screens/userpanel.dart';
import 'screens/anamnese.dart';
import 'screens/homepage.dart';
import 'screens/signup.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Salve Tempo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      routes: {
        "/": (context) => HomePage(),
        "/signup": (context) => SignUp(),
        "/userpanel": (context) => UserPanel(),
        "/anamnese": (context) => Anamnese(),
        //"/chooseMedic": (context) => ChooseMedic(),
      },
    );
  }
}
