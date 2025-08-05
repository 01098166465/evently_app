import 'package:evently/firebase_service.dart';
import 'package:evently/models/user_model.dart';
import 'package:flutter/material.dart';

class UserProvider with ChangeNotifier {
  UserModel? currentUser;
  void updateCurrentUser(UserModel? user) {
    currentUser = user;
    notifyListeners();
  }

  bool checkIsFavouriteEvent(String eventId) {
    return currentUser!.favouriteEventsIds.contains(eventId);
  }

  void addEventToFavorites(String eventId) {
    FirebaseService.addEventToFavourites(eventId);
    currentUser!.favouriteEventsIds.add(eventId);
    notifyListeners();
  }

  void removeEventToFavorites(String eventId) {
    FirebaseService.removeEventToFavourites(eventId);
    currentUser!.favouriteEventsIds.remove(eventId);
    notifyListeners();
  }
}
