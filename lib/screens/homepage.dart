import 'package:date_format/date_format.dart';
import 'package:flutter/material.dart';
import 'package:salvetempo/models/paciente.dart';
import 'package:flutter/services.dart';
import 'package:salvetempo/service/login.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool selected = true;
  DateTime _dateInfo = DateTime.now();
  String dateText = "Data de Nascimento";
  FocusNode loginFocus;

  var nomeCrtl = TextEditingController();
  var datanascCrtl = TextEditingController();
  var emailCrtl = TextEditingController();
  var passCrtl = TextEditingController();
  var sexoCrtl = TextEditingController();
  var emailuserCrtl = TextEditingController();
  var passuserCrtl = TextEditingController();
  String sexoSelected;

  void add() {
    setState(() {
      Paciente cadPasc = new Paciente(
          nome: nomeCrtl.text,
          sexo: sexoCrtl.text,
          dataNasc: datanascCrtl.text,
          email: emailCrtl.text,
          senha: passCrtl.text);
      String sexLimpo;
      String dateLimpo = "Data de Nascimento";
      dateText = dateLimpo;
      sexoSelected = sexLimpo;

      Paciente.fromJson(cadPasc.toJson());

      print(cadPasc.toJson());
    });

    nomeCrtl.clear();
    sexoCrtl.clear();
    datanascCrtl.clear();
    emailCrtl.clear();
    passCrtl.clear();
  }

  void login() {
    setState(() {
      Login login =
          new Login(emailuser: emailuserCrtl.text, password: passuserCrtl.text);
      Login.fromJson(login.toJson());
      print(login.toJson());
    });
    emailuserCrtl.clear();
    passuserCrtl.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.maxFinite,
        height: double.maxFinite,
        child: Stack(
          children: <Widget>[
            Container(
              color: Colors.blue,
            ),
            Center(
              child: Padding(
                padding: EdgeInsets.only(top: 10),
                child: Wrap(
                  spacing: 20, // to apply margin horizontally
                  runSpacing: -20,
                  children: <Widget>[
                    SizedBox(
                      width: 250.0,
                      height: 100.0,
                      child: TextFormField(
                        textInputAction: TextInputAction.next,
                        onFieldSubmitted: (_) =>
                            FocusScope.of(context).nextFocus(),
                        keyboardType: TextInputType.emailAddress,
                        controller: emailuserCrtl,
                        style: TextStyle(
                          color: Colors.white,
                        ),
                        decoration: InputDecoration(
                          labelText: "Email",
                          labelStyle: TextStyle(
                              color: Colors.white, fontWeight: FontWeight.bold),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.white,
                              width: 3,
                            ),
                            borderRadius:
                                const BorderRadius.all(Radius.circular(10)),
                          ),
                          errorBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.white,
                              width: 3,
                            ),
                            borderRadius:
                                const BorderRadius.all(Radius.circular(10)),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.white,
                              width: 3,
                            ),
                            borderRadius:
                                const BorderRadius.all(Radius.circular(10)),
                          ),
                          disabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.white,
                              width: 3,
                            ),
                            borderRadius:
                                const BorderRadius.all(Radius.circular(10)),
                          ),
                          border: UnderlineInputBorder(),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 250.0,
                      height: 100.0,
                      child: TextFormField(
                        textInputAction: TextInputAction.go,
                        onFieldSubmitted: (_) =>
                            FocusScope.of(context).unfocus(),
                        controller: passuserCrtl,
                        obscureText: true,
                        style: TextStyle(
                          color: Colors.white,
                        ),
                        decoration: InputDecoration(
                          labelText: "Senha",
                          labelStyle: TextStyle(
                              color: Colors.white, fontWeight: FontWeight.bold),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.white,
                              width: 3,
                            ),
                            borderRadius:
                                const BorderRadius.all(Radius.circular(10)),
                          ),
                          errorBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.white,
                              width: 3,
                            ),
                            borderRadius:
                                const BorderRadius.all(Radius.circular(10)),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.white,
                              width: 3,
                            ),
                            borderRadius:
                                const BorderRadius.all(Radius.circular(10)),
                          ),
                          disabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.white,
                              width: 3,
                            ),
                            borderRadius:
                                const BorderRadius.all(Radius.circular(10)),
                          ),
                          border: UnderlineInputBorder(),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Center(
              child: Padding(
                padding: EdgeInsets.only(
                  top: 190,
                ),
                child: FlatButton(
                  onPressed: login,
                  child: Container(
                    height: 50,
                    width: 250,
                    decoration: BoxDecoration(
                      color: Colors.deepPurpleAccent,
                      borderRadius: BorderRadius.all(
                        Radius.circular(10),
                      ),
                    ),
                    child: Center(
                      child: Text(
                        "Entrar",
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            Positioned(
              bottom: -1,
              child: GestureDetector(
                onTap: () {
                  setState(() {
                    selected = !selected;
                  });
                },
                child: AnimatedContainer(
                  duration: Duration(seconds: 1),
                  padding: EdgeInsets.all(45),
                  width: MediaQuery.of(context).size.width,
                  height:
                      selected ? 110 : MediaQuery.of(context).size.height - 100,
                  curve: Curves.fastOutSlowIn,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(55),
                      topRight: Radius.circular(55),
                    ),
                  ),
                  child: Center(
                    child: SingleChildScrollView(
                      child: Column(
                        children: <Widget>[
                          Column(
                            mainAxisSize: MainAxisSize.min,
                            children: <Widget>[
                              Text(
                                "CADASTRO",
                                style: TextStyle(
                                  color: Colors.blueAccent,
                                  fontWeight: FontWeight.w500,
                                  fontSize: 20,
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.only(top: 16),
                                child: TextFormField(
                                  textInputAction: TextInputAction.next,
                                  controller: nomeCrtl,
                                  onTap: () => SystemChannels.textInput
                                      .invokeMethod('TextInput.hide'),
                                  onFieldSubmitted: (_) =>
                                      FocusScope.of(context).nextFocus(),
                                  decoration: InputDecoration(
                                    prefixIcon: Icon(Icons.face),
                                    labelText: "Nome",
                                  ),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.only(top: 16),
                                child: ButtonBar(
                                  alignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    new DropdownButton<String>(
                                      value: sexoSelected,
                                      hint: new Text("Sexo"),
                                      items: <String>['M', 'F']
                                          .map((String value) {
                                        return new DropdownMenuItem<String>(
                                          value: value,
                                          child: new Text(value),
                                        );
                                      }).toList(),
                                      onChanged: (value) {
                                        sexoSelected = value;
                                        sexoCrtl.text = value;
                                      },
                                    ),
                                    new FlatButton(
                                      child: new Row(
                                        children: <Widget>[
                                          new Text(
                                            '${dateText}',
                                            style: TextStyle(fontSize: 15),
                                          ),
                                          new Icon(Icons.date_range)
                                        ],
                                      ),
                                      onPressed: () async {
                                        final dtPick = await showDatePicker(
                                            context: context,
                                            initialDate: DateTime.now(),
                                            firstDate: DateTime(1970),
                                            lastDate: DateTime.now()
                                                .add(Duration(hours: 1)));
                                        if (dtPick != null &&
                                            dtPick != _dateInfo) {
                                          setState(() {
                                            _dateInfo = dtPick;
                                            dateText = formatDate(_dateInfo,
                                                [dd, '/', mm, '/', yyyy]);
                                            datanascCrtl.text = dateText;
                                          });
                                        }
                                      },
                                    ),
                                  ],
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.only(top: 16),
                                child: TextFormField(
                                  textInputAction: TextInputAction.next,
                                  controller: emailCrtl,
                                  onFieldSubmitted: (_) =>
                                      FocusScope.of(context).nextFocus(),
                                  keyboardType: TextInputType.emailAddress,
                                  decoration: InputDecoration(
                                    prefixIcon: Icon(Icons.alternate_email),
                                    labelText: "Email",
                                  ),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.only(top: 16),
                                child: TextFormField(
                                  textInputAction: TextInputAction.go,
                                  controller: passCrtl,
                                  onFieldSubmitted: (_) =>
                                      FocusScope.of(context).unfocus(),
                                  keyboardType: TextInputType.text,
                                  obscureText: true,
                                  decoration: InputDecoration(
                                    prefixIcon: Icon(Icons.vpn_key),
                                    labelText: "Senha",
                                  ),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.only(
                                  top: 20,
                                ),
                                child: FlatButton(
                                  onPressed: add,
                                  child: Container(
                                    height: 50,
                                    width: double.maxFinite - 25,
                                    decoration: BoxDecoration(
                                      color: Colors.deepPurpleAccent,
                                      borderRadius: BorderRadius.all(
                                        Radius.circular(25),
                                      ),
                                    ),
                                    child: Center(
                                      child: Text(
                                        "Cadastrar",
                                        style: TextStyle(
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}