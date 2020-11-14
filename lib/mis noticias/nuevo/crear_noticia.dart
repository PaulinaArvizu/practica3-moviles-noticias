import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:noticias/mis%20noticias/bloc/mis_noticias_bloc.dart';

class CrearNoticia extends StatefulWidget {
  CrearNoticia({Key key}) : super(key: key);

  @override
  _CrearNoticiaState createState() => _CrearNoticiaState();
}

//DONE: formulario para crear noticias
//DONE: tomar fotos de camara o cargar de la galeria
//DONE: tomar fecha actual

class _CrearNoticiaState extends State<CrearNoticia> {
  TextEditingController _authorController = TextEditingController();
  TextEditingController _titleController = TextEditingController();
  TextEditingController _descriptionController = TextEditingController();
  File _chosenImage;
  MisNoticiasBloc _bloc;
  var _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: Text("Crear noticia"),
      ),
      body: BlocProvider(
        create: (context) {
          _bloc = MisNoticiasBloc();
          return _bloc..add(LeerNoticiasEvent());
        },
        child: BlocConsumer<MisNoticiasBloc, MisNoticiasState>(
          listener: (context, state) {
            if (state is NoticiasErrorState) {
              //DONE: dialogo o snackbar de error
              _scaffoldKey.currentState.showSnackBar(
                SnackBar(
                  content: Text("Se presentó un error"),
                ),
              );
            } else if (state is NoticiasCreadaState) {
              //DONE: dialogo o snackbar de success
              _scaffoldKey.currentState.showSnackBar(
                SnackBar(
                  content: Text("Success: noticia creada"),
                ),
              );
            } else if (state is ImagenCargadaState) {
              _chosenImage = state.imagen;
            }
          },
          builder: (context, state) {
            if (state is NoticiasCreadaState) {
              _clearForm();
              return _formularioCrearNoticia();
            }
            return _formularioCrearNoticia();
          },
        ),
      ),
    );
  }

  Widget _formularioCrearNoticia() {
    return Padding(
      padding: EdgeInsets.all(12),
      child: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            _chosenImage != null
                ? Image.file(
                    _chosenImage,
                    width: 150,
                    height: 150,
                  )
                : Container(
                    height: 150,
                    width: 150,
                    child: Placeholder(
                      fallbackHeight: 150,
                      fallbackWidth: 150,
                    ),
                  ),
            SizedBox(height: 48),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                  icon: Icon(Icons.add_a_photo),
                  onPressed: () {
                    _bloc.add(CargarImagenEvent(takePictureFromCamera: true));
                    // widget.noticiasBloc.add(ChooseImageEvent());
                  },
                ),
                IconButton(
                  icon: Icon(Icons.add_photo_alternate_outlined),
                  onPressed: () {
                    _bloc.add(CargarImagenEvent(takePictureFromCamera: false));
                    // widget.noticiasBloc.add(ChooseImageEvent());
                  },
                ),
              ],
            ),
            SizedBox(height: 48),
            TextField(
              controller: _titleController,
              decoration: InputDecoration(
                hintText: "Título",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
            SizedBox(height: 12),
            TextField(
              controller: _authorController,
              decoration: InputDecoration(
                hintText: "Autor",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
            SizedBox(height: 12),
            TextField(
              controller: _descriptionController,
              maxLines: 5,
              decoration: InputDecoration(
                hintText: "Descripción",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
            SizedBox(height: 24),
            RaisedButton(
              child: Text("Guardar"),
              onPressed: () {
                print("Enter onPressed");
                _bloc.add(
                  CrearNoticiaEvent(
                    titulo: _titleController.text,
                    descripcion: _descriptionController.text,
                    autor: _authorController.text,
                    fuente: "Mi nombre",
                  ),
                );
                print("Exit onPressed");
              },
            ),
          ],
        ),
      ),
    );
  }

  _clearForm() {
    //borrar el formulario
    _authorController.clear();
    _titleController.clear();
    _descriptionController.clear();
    _chosenImage = null;
  }
}
