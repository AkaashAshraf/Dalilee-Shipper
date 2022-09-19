import 'dart:convert';

W3WordsModel w3WordsModelFromJson(String str) =>
    W3WordsModel.fromJson(json.decode(str));

String w3WordsModelToJson(W3WordsModel data) => json.encode(data.toJson());

class W3WordsModel {
  W3WordsModel({
    required this.status,
    required this.words,
  });

  String status;
  List<Word> words;

  factory W3WordsModel.fromJson(Map<String, dynamic> json) => W3WordsModel(
        status: json["status"] == null ? null : json["status"],
        words: json["words"] == null
            ? []
            : List<Word>.from(json["words"].map((x) => Word.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status == null ? "" : status,
        "words": words == null
            ? []
            : List<dynamic>.from(words.map((x) => x.toJson())),
      };
}

class Word {
  Word({
    required this.id,
    required this.shipperId,
    required this.words,
    required this.createdAt,
    required this.updatedAt,
  });

  int id;
  int shipperId;
  String words;
  String createdAt;
  String updatedAt;

  factory Word.fromJson(Map<String, dynamic> json) => Word(
        id: json["id"] == null ? 0 : json["id"],
        shipperId: json["shipper_id"] == null ? 0 : json["shipper_id"],
        words: json["words"] == null ? [] : json["words"],
        createdAt: json["created_at"] == null ? "" : json["created_at"],
        updatedAt: json["updated_at"] == null ? "" : json["updated_at"],
      );

  Map<String, dynamic> toJson() => {
        "id": id == null ? 0 : id,
        "shipper_id": shipperId == 0 ? null : shipperId,
        "words": words == null ? [] : words,
        "created_at": createdAt == null ? "" : createdAt,
        "updated_at": updatedAt == null ? "" : updatedAt,
      };
}
