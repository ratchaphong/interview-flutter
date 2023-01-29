import 'package:bloc/bloc.dart';
import 'package:flutter/foundation.dart';
import 'package:hello_flutter/models/cocktail_db/drink.dart';
import 'package:hello_flutter/repository/cocktail_repository.dart';

part 'cocktail_event.dart';
part 'cocktail_state.dart';

class CocktailBloc extends Bloc<CocktailEvent, CocktailState> {
  final CocktailRepository repository;

  CocktailBloc(this.repository) : super(CocktailInitial()) {
    on<SearchEvent>((event, emit) async {
      // ignore: todo
      // TODO: implement event handler
      emit(CocktailLoading());
      try {
        var drinks = await repository.searchData(event.searchText);
        emit(CocktailFinish(drinks));
      } catch (e) {
        emit(CocktailError(e.toString()));
      }
    });

    on<FilterEvent>((event, emit) {
      var drinks = repository.filter(event.filterText);
      emit(CocktailFinish(drinks));
    });
  }
}
