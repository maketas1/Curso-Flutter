import 'dart:convert';

import 'search.dart';

class Peliculas {
  List<Search>? search;
  String? totalResults;
  String? response;

  Peliculas({this.search, this.totalResults, this.response});

  @override
  String toString() {
    return 'Peliculas(search: $search, totalResults: $totalResults, response: $response)';
  }

  factory Peliculas.fromMap(Map<String, dynamic> data) => Peliculas(
    search: (data['Search'] as List<dynamic>?)
        ?.map((e) => Search.fromMap(e as Map<String, dynamic>))
        .toList(),
    totalResults: data['totalResults'] as String?,
    response: data['Response'] as String?,
  );

  Map<String, dynamic> toMap() => {
    'Search': search?.map((e) => e.toMap()).toList(),
    'totalResults': totalResults,
    'Response': response,
  };

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [Peliculas].
  factory Peliculas.fromJson(String data) {
    return Peliculas.fromMap(json.decode(data) as Map<String, dynamic>);
  }

  /// `dart:convert`
  ///
  /// Converts [Pelicula] to a JSON string.
  String toJson() => json.encode(toMap());
}
