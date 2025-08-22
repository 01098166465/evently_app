import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:evently/models/categery_model.dart';

class EventModel {
  String id;
  String userId;
  CategoryModel category;
  String title;
  String description;
  DateTime dateTime;
  double? lat;
  double? long;

  EventModel({
    required this.category,
    this.id = "",
    required this.title,
    required this.description,
    required this.dateTime,
    required this.userId,
    this.lat = 0,
    this.long = 0,
  });

  factory EventModel.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return EventModel(
      id: doc.id,
      lat: data["lat"] ?? 0,
      long: data["long"] ?? 0,
      userId: data["userId"],
      category: CategoryModel.categories.firstWhere(
        (category) => category.id == data["categoryId"],
      ),
      title: data["title"],
      description: data["description"],
      dateTime: (data["timestamp"] as Timestamp).toDate(),
    );
  }

  Map<String, dynamic> toJson() => {
    "userId": userId,
    "lat": lat,
    "long": long,
    "categoryId": category.id,
    "title": title,
    "description": description,
    "timestamp": Timestamp.fromDate(dateTime),
  };
}
