import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:noticias/mis%20noticias/bloc/mis_noticias_bloc.dart';
import 'package:noticias/noticias/item_noticia.dart';

class MisNoticias extends StatelessWidget {
  MisNoticias({Key key}) : super(key: key);
  //DONE: mostrar noticias guradadas en firebase
  MisNoticiasBloc _bloc = MisNoticiasBloc();
  var _scaffoldKey = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: Text('Mis noticias'),
      ),
      body: BlocProvider(
        create: (context) {
          return _bloc..add(LeerNoticiasEvent());
        },
        child: BlocConsumer<MisNoticiasBloc, MisNoticiasState>(
          listener: (context, state) {
            //DONE: dialogo o snackbar de error
            _scaffoldKey.currentState.showSnackBar(
                SnackBar(content: Text("Error al solicitar noticias")));
          },
          builder: (context, state) {
            if (state is NoticiasDescargadasState) {
              return Scaffold(
                body: RefreshIndicator(
                  child: ListView.builder(
                    itemCount: state.noticiasList.length,
                    itemBuilder: (BuildContext context, int index) {
                      return ItemNoticia(noticia: state.noticiasList[index]);
                    },
                  ),
                  onRefresh: () async {
                    _bloc..add(LeerNoticiasEvent());
                    return Future.delayed(Duration(seconds: 1));
                  },
                ),
              );
            } else if (state is NoticiasErrorState) {
              return Center(
                child: Text(state.errorMessage),
              );
            }
            return Center(
              child: Text('No hay noticias disponibles'),
            );
          },
        ),
      ),
    );
  }
}
