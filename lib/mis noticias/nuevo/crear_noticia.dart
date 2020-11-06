import 'package:flutter/material.dart';

class CrearNoticia extends StatefulWidget {
  CrearNoticia({Key key}) : super(key: key);

  @override
  _CrearNoticiaState createState() => _CrearNoticiaState();
}

//TODO: formulario para crear noticias
//TODO: tomar fotos de camara o cargar de la galeria
//TODO: tomar fecha actual

class _CrearNoticiaState extends State<CrearNoticia> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text("Crear noticia"),
      ),
    );
  }
}
