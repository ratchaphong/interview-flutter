import 'dart:convert';

import 'package:collection/collection.dart';
import 'package:flutter/foundation.dart';

import 'drink.dart';

@immutable
class CocktailDb {
  final List<Drink>? drinks;

  const CocktailDb({this.drinks});

  @override
  String toString() => 'CocktailDb(drinks: $drinks)';

  factory CocktailDb.fromJsonString(Map<String, dynamic> data) => CocktailDb(
        drinks: (data['drinks'] as List<dynamic>?)
            ?.map((e) => Drink.fromJsonString(e as Map<String, dynamic>))
            .toList(),
      );

  Map<String, dynamic> toJsonString() => {
        'drinks': drinks?.map((e) => e.toJsonString()).toList(),
      };

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [CocktailDb].
  factory CocktailDb.fromJson(String data) {
    return CocktailDb.fromJsonString(json.decode(data) as Map<String, dynamic>);
  }

  /// `dart:convert`
  ///
  /// Converts [CocktailDb] to a JSON string.
  String toJson() => json.encode(toJsonString());

  CocktailDb copyWith({
    List<Drink>? drinks,
  }) {
    return CocktailDb(
      drinks: drinks ?? this.drinks,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    if (other is! CocktailDb) return false;
    final mapEquals = const DeepCollectionEquality().equals;
    return mapEquals(other.toJsonString(), toJsonString());
  }

  @override
  int get hashCode => drinks.hashCode;
}
