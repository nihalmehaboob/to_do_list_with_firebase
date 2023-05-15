// To parse this JSON data, do
//
//     final item = itemFromJson(jsonString);

import 'dart:convert';

List<Item> itemFromJson(String str) =>
    List<Item>.from(json.decode(str).map((x) => Item.fromJson(x)));

String itemToJson(List<Item> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Item {
  String id;
  String todo;
  String date;
  String time;
  String ap;

  Item({
    required this.id,
    required this.todo,
    required this.date,
    required this.time,
    required this.ap,
  });

  factory Item.fromJson(Map<String, dynamic> json) => Item(
        id: json["id"],
        todo: json["todo"],
        date: json["date"],
        time: json["time"],
        ap: json["ap"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "todo": todo,
        "date": date,
        "time": time,
        "ap": ap,
      };
}
