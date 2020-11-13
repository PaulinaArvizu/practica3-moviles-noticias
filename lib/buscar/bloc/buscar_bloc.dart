import 'dart:async';
import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:noticias/models/noticia.dart';
import 'package:noticias/secrets.dart';

part 'buscar_event.dart';
part 'buscar_state.dart';

class BuscarBloc extends Bloc<BuscarEvent, BuscarState> {
  final _sportsLink =
      "https://newsapi.org/v2/top-headlines?country=mx&category=sports&$apiKey";

  final _businessLink =
      "https://newsapi.org/v2/top-headlines?country=mx&category=business&$apiKey";

  BuscarBloc() : super(BuscarInitial());

  @override
  Stream<BuscarState> mapEventToState(
    BuscarEvent event,
  ) async* {
    if (event is GetNewsEvent) {
      //request de noticias
      try {
        List<Noticia> noticiasList = await _requestNoticias();

        //yield lista de noticias al estado
        yield BuscarSuccessState(noticiasList: noticiasList);
      } catch (e) {}
    }
  }

  Future<List<Noticia>> _requestNoticias() async {
    // request sports
    Response response = await get(_sportsLink);
    List<Noticia> _sportsNews = List();
    if (response.statusCode == 200) {
      //deserializar json -> dart
      List<dynamic> data = jsonDecode(response.body)['articles'];

      //mapear resultado a lista de noticias
      _sportsNews =
          ((data).map((element) => Noticia.fromJson(element))).toList();
    }

    // request business
    response = await get(_businessLink);
    List<Noticia> _businessNews = List();
    if (response.statusCode == 200) {
      //deserializar json -> dart
      List<dynamic> data = jsonDecode(response.body)['articles'];

      //mapear resultado a lista de noticias
      _businessNews =
          ((data).map((element) => Noticia.fromJson(element))).toList();
    }

    //juntar listas en una sola
    List<Noticia> _noticiasList = List();
    _noticiasList = _sportsNews + _businessNews;

    return _noticiasList;
  }
}
