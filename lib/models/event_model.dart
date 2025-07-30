import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:evently/models/categery_model.dart';

class EventModel {
  String id;
  CategoryModel category;
  String title;
  String description;
  DateTime dateTime;
  EventModel({
    required this.category,
    this.id = "",
    required this.title,
    required this.description,
    required this.dateTime,
  });
  EventModel.formJson(Map<String, dynamic> json)
    : this(
        id: json["id"],
        category: CategoryModel.categories.firstWhere(
          (Category) => Category.id == json["categoryId"],
        ),
        title: json["title"],
        dateTime: (json["timestamp"] as Timestamp).toDate(),
        description: json["description"],
      );

  Map<String, dynamic> toJson() => {
    "id": id,
    "categoryId": category.id,
    "title": title,
    "description": description,
    "timestamp": Timestamp.fromDate(dateTime),
  };
}
