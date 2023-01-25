import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:flutter/foundation.dart';
import 'package:hello_flutter/main.dart';
import 'package:hello_flutter/models/cocktail_db/cocktail_db.dart';
import 'package:hello_flutter/models/cocktail_db/drink.dart';
import 'package:http/http.dart' as http;

part 'cocktail_event.dart';
part 'cocktail_state.dart';

class CocktailBloc extends Bloc<CocktailEvent, CocktailState> {
  CocktailBloc() : super(CocktailInitial()) {
    on<SearchEvent>((event, emit) async {
      // ignore: todo
      // TODO: implement event handler
      emit(CocktailLoading());
      try {
        var url = Uri.https(
          'www.thecocktaildb.com',
          '/api/json/v1/1/search.php',
          {'s': event.searchText},
        );
        var r = await http.get(url);
        if (r.statusCode != 200) {
          if (kDebugMode) {
            print("Error");
          }
        }
        var drinks = CocktailDb.fromJson(r.body).drinks;
        if (drinks == null) {
          emit(CocktailError('no drinks found'));
          return;
        }
        emit(CocktailFinish(drinks));
      } catch (e) {
        if (kDebugMode) {
          print(e);
        }
        emit(CocktailError(e.toString()));
      }
    });
  }
}
