import 'package:flutter/material.dart';
import 'package:salvetempo/screens/homepage.dart';
import 'package:salvetempo/service/login.dart';

class ResetPassword extends StatefulWidget {
  @override
  _ResetPasswordState createState() => _ResetPasswordState();
}

class _ResetPasswordState extends State<ResetPassword> {
  var emailCrtl = TextEditingController();
  var loginService = LoginService();

  void sendEmailResetPassword() {
    loginService.resetPassword(emailCrtl.text).then((isOk) {
      if (!isOk) {
        print("Algo deu errado.");
        emailCrtl.clear();
      } else {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => HomePage()));
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Recuperar senha"),
      ),
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
                  spacing: 20,
                  runSpacing: -20,
                  children: <Widget>[
                    SizedBox(
                      width: 250.0,
                      height: 250.0,
                      child: TextFormField(
                        keyboardType: TextInputType.emailAddress,
                        controller: emailCrtl,
                        style: TextStyle(
                          color: Colors.white,
                        ),
                        decoration: InputDecoration(
                          labelText: "E-mail",
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
                  bottom: 20,
                ),
                child: FlatButton(
                  onPressed: sendEmailResetPassword,
                  child: Container(
                    height: 55,
                    width: 260,
                    decoration: BoxDecoration(
                      color: Colors.deepPurpleAccent,
                      borderRadius: BorderRadius.all(
                        Radius.circular(10),
                      ),
                    ),
                    child: Center(
                      child: Text(
                        "Enviar",
                        style: TextStyle(
                          color: Colors.white,
                        ),
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
