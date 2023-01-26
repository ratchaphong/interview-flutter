part of 'cocktail_bloc.dart';

@immutable
abstract class CocktailState {}

class CocktailInitial extends CocktailState {}

class CocktailLoading extends CocktailState {}

class CocktailError extends CocktailState {
  final String message;

  CocktailError(this.message);
}

class CocktailFinish extends CocktailState {
  final List<Drink> drinks;

  CocktailFinish(this.drinks);
}
