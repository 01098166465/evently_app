import 'package:evently/app_theme.dart';
import 'package:evently/models/categery_model.dart';
import 'package:evently/providers/events_provider.dart';
import 'package:evently/providers/user_provider.dart';
import 'package:evently/tabs/home/tab_item.dart';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';

class HomeHeader extends StatefulWidget {
  @override
  State<HomeHeader> createState() => _HomeHeaderState();
}

class _HomeHeaderState extends State<HomeHeader> {
  int currentIndex = 0;
  @override
  Widget build(BuildContext context) {
    EventsProvider eventsProvider = Provider.of<EventsProvider>(context);
    TextTheme textTheme = Theme.of(context).textTheme;
    return Container(
      padding: EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: AppTheme.primary,
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(24),
          bottomRight: Radius.circular(24),
        ),
      ),

      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 8),
              Text("Welcome Back ✨", style: textTheme.titleSmall),
              SizedBox(height: 8),
              Text(
                Provider.of<UserProvider>(context).currentUser!.name,
                style: textTheme.headlineSmall,
              ),
              SizedBox(height: 8),
              Row(
                children: [
                  SvgPicture.asset(
                    "assets/icons/map.svg",
                    height: 24,
                    width: 24,
                  ),
                  Text("Cairo , Egypt", style: textTheme.titleSmall),
                ],
              ),
              SizedBox(height: 16),
              DefaultTabController(
                length: CategoryModel.categories.length + 1,
                child: TabBar(
                  isScrollable: true,
                  indicatorColor: Colors.transparent,
                  dividerColor: Colors.transparent,
                  tabAlignment: TabAlignment.start,
                  labelPadding: EdgeInsets.only(right: 10),
                  onTap: (index) {
                    if (currentIndex == index) return;
                    currentIndex = index;
                    CategoryModel? selectedCategory = currentIndex == 0
                        ? null
                        : CategoryModel.categories[currentIndex - 1];
                    eventsProvider.filterEvents(selectedCategory);

                    setState(() {});
                  },
                  tabs: [
                    TabItem(
                      label: "All",
                      icon: Icons.ac_unit_outlined,
                      isSelected: currentIndex == 0,
                      selectedForegroundColor: AppTheme.primary,
                      selectedBackgroundColor: AppTheme.white,
                      unselectedForegroundColor: AppTheme.white,
                    ),
                    ...CategoryModel.categories.map(
                      (category) => TabItem(
                        label: category.name,
                        icon: category.icon,
                        isSelected:
                            currentIndex ==
                            CategoryModel.categories.indexOf(category) + 1,
                        selectedForegroundColor: AppTheme.primary,
                        selectedBackgroundColor: AppTheme.white,
                        unselectedForegroundColor: AppTheme.white,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
