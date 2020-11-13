part of 'buscar_bloc.dart';

abstract class BuscarState extends Equatable {
  const BuscarState();

  @override
  List<Object> get props => [];
}

class BuscarInitial extends BuscarState {}

class BuscarSuccessState extends BuscarState {
  final List<Noticia> noticiasList;

  BuscarSuccessState({@required this.noticiasList});
  @override
  List<Object> get props => [noticiasList];
}

class BuscarErrorState extends BuscarState {
  final String message;

  BuscarErrorState({@required this.message});
  @override
  List<Object> get props => [message];
}
