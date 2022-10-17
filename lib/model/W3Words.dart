// To parse this JSON data, do
//
//     final w3WordsModel = w3WordsModelFromJson(jsonString);

import 'dart:convert';

W3WordsModel w3WordsModelFromJson(String str) =>
    W3WordsModel.fromJson(json.decode(str));

String w3WordsModelToJson(W3WordsModel data) => json.encode(data.toJson());

class W3WordsModel {
  W3WordsModel({
    this.suggestions,
  });

  List<Suggestion>? suggestions;

  factory W3WordsModel.fromJson(Map<String, dynamic> json) => W3WordsModel(
        suggestions: json["suggestions"] == null
            ? null
            : List<Suggestion>.from(
                json["suggestions"].map((x) => Suggestion.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "suggestions": suggestions == null
            ? null
            : List<dynamic>.from(suggestions!.map((x) => x.toJson())),
      };
}

class Suggestion {
  Suggestion({
    this.country,
    this.nearestPlace,
    this.words,
    this.rank,
    this.language,
  });

  String? country;
  String? nearestPlace;
  String? words;
  int? rank;
  String? language;

  factory Suggestion.fromJson(Map<String, dynamic> json) => Suggestion(
        country: json["country"] == null ? null : json["country"],
        nearestPlace:
            json["nearestPlace"] == null ? null : json["nearestPlace"],
        words: json["words"] == null ? null : json["words"],
        rank: json["rank"] == null ? null : json["rank"],
        language: json["language"] == null ? null : json["language"],
      );

  Map<String, dynamic> toJson() => {
        "country": country == null ? null : country,
        "nearestPlace": nearestPlace == null ? null : nearestPlace,
        "words": words == null ? null : words,
        "rank": rank == null ? null : rank,
        "language": language == null ? null : language,
      };
}
