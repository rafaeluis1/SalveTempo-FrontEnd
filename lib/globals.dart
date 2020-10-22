library my_prj.globals;

import 'package:flutter/material.dart';

String apiURL = 'http://192.168.1.21:8000/';

void errorDialog(BuildContext context, String msg) {
  showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(title: Text("Erro"), content: Text(msg));
      });
}
