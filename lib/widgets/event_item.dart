import 'package:evently/app_theme.dart';

import 'package:evently/events/detalis_event_screen.dart';
import 'package:evently/models/event_model.dart';
import 'package:evently/providers/events_provider.dart';
import 'package:evently/providers/user_provider.dart';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class EventItem extends StatelessWidget {
  EventModel event;
  EventItem(this.event);
  @override
  Widget build(BuildContext context) {
    UserProvider userProvider = Provider.of<UserProvider>(context);
    bool isFavorite = userProvider.checkIsFavouriteEvent(event.id);
    TextTheme textTheme = Theme.of(context).textTheme;
    Size screenSize = MediaQuery.sizeOf(context);
    return InkWell(
      onTap: () {
        Navigator.of(context).pushNamed(EventDetalisScreen.routeName);
      },
      child: Stack(
        children: [
          ClipRRect(
            borderRadius: BorderRadiusGeometry.circular(16),
            child: Image.asset(
              "assets/images/${event.category.imageName}.png",

              height: screenSize.height * 0.25,
              width: double.infinity,
              fit: BoxFit.fill,
            ),
          ),
          Container(
            padding: EdgeInsets.all(8),
            margin: EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: AppTheme.backgroundLight,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Column(
              children: [
                Text(
                  "${event.dateTime.day}",
                  style: textTheme.titleLarge!.copyWith(
                    color: AppTheme.primary,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  DateFormat("MMM").format(event.dateTime),
                  style: textTheme.titleSmall!.copyWith(
                    color: AppTheme.primary,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            bottom: 8,
            width: screenSize.width - 32,
            child: Container(
              padding: EdgeInsets.all(8),
              margin: EdgeInsets.symmetric(horizontal: 4),
              decoration: BoxDecoration(
                color: AppTheme.backgroundLight,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Text(
                      event.title,
                      style: textTheme.titleSmall!.copyWith(
                        color: AppTheme.black,
                        fontWeight: FontWeight.bold,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  SizedBox(width: 8),
                  InkWell(
                    onTap: () {
                      if (isFavorite) {
                        userProvider.removeEventToFavorites(event.id);
                        Provider.of<EventsProvider>(
                          context,
                          listen: false,
                        ).fliterFavouriteEvents(
                          userProvider.currentUser!.favouriteEventsIds,
                        );
                      } else {
                        userProvider.addEventToFavorites(event.id);
                      }
                    },
                    child: Icon(
                      isFavorite
                          ? Icons.favorite
                          : Icons.favorite_border_outlined,
                      size: 24,
                      color: AppTheme.primary,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
