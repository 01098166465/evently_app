import 'package:evently/app_theme.dart';
import 'package:evently/events/edit_event_screen.dart';
import 'package:evently/firebase_service.dart';
import 'package:evently/models/event_model.dart';
import 'package:evently/providers/events_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class EventDetalisScreen extends StatelessWidget {
  static const String routeName = "/event-detalis";

  @override
  Widget build(BuildContext context) {
    final event = ModalRoute.of(context)!.settings.arguments as EventModel;
    TextTheme textTheme = Theme.of(context).textTheme;
    Size screenSize = MediaQuery.sizeOf(context);

    return Scaffold(
      appBar: AppBar(
        title: Text("Event Details"),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.of(
                context,
              ).pushNamed(EditEventScreen.routeName, arguments: event);
            },
            icon: SvgPicture.asset("assets/icons/edit.svg"),
            color: AppTheme.primary,
          ),
          IconButton(
            onPressed: () async {
              bool confirm = await showDialog(
                context: context,
                builder: (_) => AlertDialog(
                  title: Text(
                    "Delete Event",
                    style: TextStyle(color: AppTheme.primary), // لون العنوان
                  ),
                  content: Text("Are you sure you want to delete this event?"),
                  actions: [
                    TextButton(
                      onPressed: () => Navigator.of(context).pop(false),
                      child: Text("Cancel"),
                    ),
                    TextButton(
                      onPressed: () => Navigator.of(context).pop(true),
                      child: Text(
                        "Delete",
                        style: TextStyle(color: AppTheme.red),
                      ),
                    ),
                  ],
                ),
              );

              if (confirm) {
                try {
                  await FirebaseService.deleteEvent(event.id);

                  final provider = Provider.of<EventsProvider>(
                    context,
                    listen: false,
                  );
                  await provider.getEvents();

                  // ✅ SnackBar باللون الأخضر
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(
                        "Event deleted successfully",
                        style: TextStyle(color: Colors.white),
                      ),
                      backgroundColor: Colors.green,
                      behavior: SnackBarBehavior.floating,
                      margin: EdgeInsets.all(16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      duration: Duration(seconds: 3),
                    ),
                  );

                  Navigator.of(context).pop();
                } catch (e) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text("Failed to delete event")),
                  );
                }
              }
            },
            icon: SvgPicture.asset("assets/icons/delete.svg"),
            color: AppTheme.red,
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 16),

            ClipRRect(
              borderRadius: BorderRadius.circular(16),
              child: Image.asset(
                "assets/images/${event.category.imageName}.png",
                height: screenSize.height * 0.25,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            ),

            SizedBox(height: 16),

            Text(
              event.title,
              style: textTheme.headlineSmall!.copyWith(color: AppTheme.primary),
            ),

            SizedBox(height: 16),

            Container(
              padding: EdgeInsets.all(12),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: AppTheme.primary),
              ),
              child: Row(
                children: [
                  Container(
                    padding: EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: AppTheme.primary,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: SvgPicture.asset(
                      "assets/icons/date.svg",
                      color: AppTheme.white,
                      height: 24,
                      width: 24,
                    ),
                  ),
                  SizedBox(width: 12),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        DateFormat('d MMMM yyyy').format(event.dateTime),
                        style: textTheme.titleMedium!.copyWith(
                          color: AppTheme.primary,
                        ),
                      ),
                      Text(
                        DateFormat(
                          'h:mma',
                        ).format(event.dateTime).toUpperCase(),
                        style: textTheme.titleMedium,
                      ),
                    ],
                  ),
                ],
              ),
            ),

            SizedBox(height: 16),

            Container(
              padding: EdgeInsets.all(12),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: AppTheme.primary),
              ),
              child: Row(
                children: [
                  Container(
                    padding: EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: AppTheme.primary,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: SvgPicture.asset(
                      "assets/icons/location.svg",
                      color: AppTheme.white,
                      height: 24,
                      width: 24,
                    ),
                  ),
                  SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      "Cairo, Egypt",
                      style: textTheme.titleMedium!.copyWith(
                        color: AppTheme.primary,
                      ),
                    ),
                  ),
                  Icon(
                    Icons.arrow_forward_ios_outlined,
                    size: 18,
                    color: AppTheme.primary,
                  ),
                ],
              ),
            ),

            SizedBox(height: 16),

            ClipRRect(
              borderRadius: BorderRadius.circular(16),
              child: Image.asset("assets/images/location.png"),
            ),

            SizedBox(height: 24),

            Text(
              "Description",
              style: textTheme.titleLarge!.copyWith(
                color: AppTheme.primary,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 8),
            Text(
              event.description,
              style: textTheme.bodyLarge,
              textAlign: TextAlign.justify,
            ),
          ],
        ),
      ),
    );
  }
}
