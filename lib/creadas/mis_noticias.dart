import 'package:flutter/material.dart';

class MisNoticias extends StatelessWidget {
  const MisNoticias({Key key}) : super(key: key);
  //TODO: mostrar noticias guradadas en firebase
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text("Mis noticias"),
      ),
    );
  }
}
