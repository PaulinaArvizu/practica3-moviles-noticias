import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:noticias/buscar/bloc/buscar_bloc.dart';
import 'package:noticias/models/noticia.dart';
import 'package:noticias/noticias/item_noticia.dart';

class Buscar extends StatefulWidget {
  Buscar({Key key}) : super(key: key);

  @override
  _BuscarState createState() => _BuscarState();
}

class _BuscarState extends State<Buscar> {
  List<Noticia> _listOfNews;
  List<Noticia> _filteredListOfNews;
  var _searchTextController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _filteredListOfNews = List();
    _listOfNews = List();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Busqueda"),
      ),
      body: BlocProvider(
        create: (context) => BuscarBloc()..add(GetNewsEvent()),
        child: BlocConsumer<BuscarBloc, BuscarState>(
          listener: (context, state) {
            //
          },
          builder: (context, state) {
            if (state is BuscarSuccessState) {
              _listOfNews = state.noticiasList;
              return Padding(
                padding: const EdgeInsets.all(24.0),
                child: Column(
                  children: [
                    TextField(
                      controller: _searchTextController,
                      decoration: InputDecoration(
                        labelText: "Buscar noticia por título",
                        prefixIcon: Icon(Icons.search),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(20)),
                        ),
                      ),
                      onChanged: (value) {
                        _filterByTitle();
                      },
                    ),
                    SizedBox(height: 20),
                    Expanded(
                      child: ListView.separated(
                        itemCount: _filteredListOfNews.length,
                        separatorBuilder: (context, index) => Divider(),
                        itemBuilder: (context, index) =>
                            ItemNoticia(noticia: _filteredListOfNews[index]),
                      ),
                    ),
                  ],
                ),
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

  _filterByTitle() {
    setState(() {
      if (_searchTextController.text == "") {
        _filteredListOfNews = List();
        return;
      }
      _filteredListOfNews = _listOfNews.where((noticia) {
        return noticia.title
            .toLowerCase()
            .contains(_searchTextController.text.toLowerCase());
      }).toList();
    });
  }
}
