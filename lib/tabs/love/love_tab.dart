import 'package:evently/providers/events_provider.dart';
import 'package:evently/providers/user_provider.dart';
import 'package:evently/widgets/default_text_form_field.dart';
import 'package:evently/widgets/event_item.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LoveTab extends StatefulWidget {
  @override
  State<LoveTab> createState() => _LoveTabState();
}

class _LoveTabState extends State<LoveTab> {
  late EventsProvider eventsProvider;
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      eventsProvider = Provider.of<EventsProvider>(context, listen: false);
      List<String> favouriteEventsIds = Provider.of<UserProvider>(
        context,
        listen: false,
      ).currentUser!.favouriteEventsIds;
      eventsProvider.fliterFavouriteEvents(favouriteEventsIds);
    });
  }

  @override
  Widget build(BuildContext context) {
    EventsProvider eventsProvider = Provider.of<EventsProvider>(context);

    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          children: [
            DefaultTextFormField(
              hintText: "Search for Event",
              prefixIconImageName: "Search",
              onChanged: (query) {},
            ),
            SizedBox(height: 16),
            Expanded(
              child: ListView.separated(
                itemBuilder: (_, index) =>
                    EventItem(eventsProvider.favouriteEvents[index]),
                separatorBuilder: (_, __) => SizedBox(height: 16),
                itemCount: eventsProvider.favouriteEvents.length,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
