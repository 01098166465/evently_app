import 'package:evently/firebase_service.dart';
import 'package:evently/models/categery_model.dart';
import 'package:evently/models/event_model.dart';
import 'package:evently/tabs/home/home_header.dart';
import 'package:evently/widgets/event_item.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class HomeTab extends StatefulWidget {
  @override
  State<HomeTab> createState() => _HomeTabState();
}

class _HomeTabState extends State<HomeTab> {
  List<EventModel> allEvents = [];
  List<EventModel> displayedEvents = [];
  @override
  void initState() {
    super.initState();
    getEvents();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        HomeHeader(filterEvents: filterEvents),
        SizedBox(height: 16),
        Expanded(
          child: ListView.separated(
            padding: EdgeInsets.symmetric(horizontal: 16),
            itemBuilder: (_, index) => EventItem(displayedEvents[index]),
            separatorBuilder: (_, __) => SizedBox(height: 16),
            itemCount: displayedEvents.length,
          ),
        ),
      ],
    );
  }

  Future<void> getEvents() async {
    allEvents = await FirebaseService.getEvents();
    displayedEvents = allEvents;
    setState(() {});
  }

  void filterEvents(CategoryModel? category) {
    if (category == null) {
      displayedEvents = allEvents;
    } else {
      displayedEvents = allEvents
          .where((event) => event.category == category)
          .toList();
    }
    setState(() {});
  }
}
