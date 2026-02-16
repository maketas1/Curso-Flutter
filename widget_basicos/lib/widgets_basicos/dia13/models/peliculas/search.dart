import 'dart:convert';

class Search {
  String? title;
  String? year;
  String? imdbId;
  String? type;
  String? poster;

  Search({this.title, this.year, this.imdbId, this.type, this.poster});

  @override
  String toString() {
    return 'Search(title: $title, year: $year, imdbId: $imdbId, type: $type, poster: $poster)';
  }

  factory Search.fromMap(Map<String, dynamic> data) => Search(
    title: data['Title'] as String?,
    year: data['Year'] as String?,
    imdbId: data['imdbID'] as String?,
    type: data['Type'] as String?,
    poster: data['Poster'] as String?,
  );

  Map<String, dynamic> toMap() => {
    'Title': title,
    'Year': year,
    'imdbID': imdbId,
    'Type': type,
    'Poster': poster,
  };

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [Search].
  factory Search.fromJson(String data) {
    return Search.fromMap(json.decode(data) as Map<String, dynamic>);
  }

  /// `dart:convert`
  ///
  /// Converts [Search] to a JSON string.
  String toJson() => json.encode(toMap());
}
