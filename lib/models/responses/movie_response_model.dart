import 'dart:convert';

class MovieResponseModel {
  List<Search> search;
  String totalResults;
  String response;

  MovieResponseModel({
    required this.search,
    required this.totalResults,
    required this.response,
  });

  factory MovieResponseModel.fromJson(String str) =>
      MovieResponseModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory MovieResponseModel.fromMap(Map<String, dynamic> json) =>
      MovieResponseModel(
        search: List<Search>.from(json["Search"].map((x) => Search.fromMap(x))),
        totalResults: json["totalResults"],
        response: json["Response"],
      );

  Map<String, dynamic> toMap() => {
        "Search": List<dynamic>.from(search.map((x) => x.toMap())),
        "totalResults": totalResults,
        "Response": response,
      };
}

class Search {
  String title;
  String year;
  String imdbId;
  String type;
  String poster;

  Search({
    required this.title,
    required this.year,
    required this.imdbId,
    required this.type,
    required this.poster,
  });

  factory Search.fromJson(String str) => Search.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Search.fromMap(Map<String, dynamic> json) => Search(
        title: json["Title"],
        year: json["Year"],
        imdbId: json["imdbID"],
        // type: typeValues.map[json["Type"]]!,
        type: json["Type"],
        poster: json["Poster"],
      );

  Map<String, dynamic> toMap() => {
        "Title": title,
        "Year": year,
        "imdbID": imdbId,
        // "Type": typeValues.reverse[type],
        "Type": type,
        "Poster": poster,
      };
}

// enum Type { MOVIE }

// final typeValues = EnumValues({"movie": Type.MOVIE});

// class EnumValues<T> {
//   Map<String, T> map;
//   late Map<T, String> reverseMap;

//   EnumValues(this.map);

//   Map<T, String> get reverse {
//     reverseMap = map.map((k, v) => MapEntry(v, k));
//     return reverseMap;
//   }
// }
