import 'package:hello_flutter/repository/the_cocktail_db_provider.dart';
import 'package:hello_flutter/models/cocktail_db/drink.dart';

class CocktailRepository {
  final TheCocktailDbProvider provider;
  List<Drink> rawData = [];

  CocktailRepository(this.provider);

  Future<List<Drink>> searchData(String searchText) async {
    rawData = await provider.searchData((searchText));
    return rawData;
  }

  List<Drink> filter(String? filter) {
    if (filter == null) {
      return rawData;
    }
    return rawData.where((e) => e.strCategory == filter).toList();
  }
}