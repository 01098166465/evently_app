import 'package:flutter/material.dart';

class CategoryModel {
  String id;
  String name;
  IconData icon;
  String imageName;
  CategoryModel({
    required this.id,
    required this.name,
    required this.icon,
    required this.imageName,
  });

  static List<CategoryModel> category = [
    CategoryModel(
      id: "1",
      name: "sport",
      icon: Icons.sports_basketball_outlined,
      imageName: "sport",
    ),
    CategoryModel(
      id: "2",
      name: "birthdy",
      icon: Icons.cake_outlined,
      imageName: "birthdy",
    ),
    CategoryModel(
      id: "3",
      name: "meeting",
      icon: Icons.more_time,
      imageName: "meeting",
    ),
  ];
}
