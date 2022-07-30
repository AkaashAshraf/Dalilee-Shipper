// To parse this JSON data, do
//
//     final complainTypeListModel = complainTypeListModelFromJson(jsonString);
// To parse this JSON data, do
//
//     final ticketTypeModel = ticketTypeModelFromJson(jsonString);

import 'dart:convert';

TicketTypeModel ticketTypeModelFromJson(String str) => TicketTypeModel.fromJson(json.decode(str));

String ticketTypeModelToJson(TicketTypeModel data) => json.encode(data.toJson());

class TicketTypeModel {
    TicketTypeModel({
        this.categories,
    });

    List<Category>? categories;

    factory TicketTypeModel.fromJson(Map<String, dynamic> json) => TicketTypeModel(
        categories: List<Category>.from(json["categories"].map((x) => Category.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "categories": List<dynamic>.from(categories!.map((x) => x.toJson())),
    };
}

class Category {
    Category({
        this.id,
        this.name,
        
     
    });

    dynamic id;
    dynamic name;
   
    factory Category.fromJson(Map<String, dynamic> json) => Category(
        id: json["id"],
        name: json["name"],
       
       
      
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
      
        
    };
}
