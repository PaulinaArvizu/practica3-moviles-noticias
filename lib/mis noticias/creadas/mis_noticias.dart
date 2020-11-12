import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:noticias/mis%20noticias/bloc/mis_noticias_bloc.dart';
import 'package:noticias/noticias/item_noticia.dart';

class MisNoticias extends StatelessWidget {
  const MisNoticias({Key key}) : super(key: key);
  //DONE: mostrar noticias guradadas en firebase
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Mis noticias'),
      ),
      body: BlocProvider(
        create: (context) => MisNoticiasBloc()..add(LeerNoticiasEvent()),
        child: BlocConsumer<MisNoticiasBloc, MisNoticiasState>(
          listener: (context, state) {
            //
          },
          builder: (context, state) {
            if (state is NoticiasDescargadasState) {
              return Scaffold(
                body: ListView.builder(
                  itemCount: state.noticiasList.length,
                  itemBuilder: (BuildContext context, int index) {
                    return ItemNoticia(noticia: state.noticiasList[index]);
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
