import 'package:evently/firebase_service.dart';
import 'package:evently/models/categery_model.dart';
import 'package:evently/models/event_model.dart';
import 'package:flutter/material.dart';

class EventsProvider with ChangeNotifier {
  List<EventModel> allEvents = [];
  List<EventModel> displayedEvents = [];
  List<EventModel> favouriteEvents = [];

  Future<void> getEvents() async {
    allEvents = await FirebaseService.getEvents();
    displayedEvents = allEvents;
    notifyListeners();
  }

  void filterEvents(CategoryModel? category) {
    if (category == null) {
      displayedEvents = allEvents;
    } else {
      displayedEvents = allEvents
          .where((event) => event.category == category)
          .toList();
    }
    notifyListeners();
  }

  void fliterFavouriteEvents(List<String> favouriteIds) {
    favouriteEvents = allEvents
        .where((event) => favouriteIds.contains(event.id))
        .toList();
    notifyListeners();
  }
}
