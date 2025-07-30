import 'package:evently/app_theme.dart';
import 'package:evently/models/categery_model.dart';
import 'package:evently/tabs/home/tab_item.dart';

import 'package:flutter/material.dart';

class HomeHeader extends StatefulWidget {
  @override
  State<HomeHeader> createState() => _HomeHeaderState();
}

class _HomeHeaderState extends State<HomeHeader> {
  int currentIndex = 0;
  @override
  Widget build(BuildContext context) {
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
              Text("Welcome Back ✨", style: textTheme.titleSmall),
              Text("Mahmoud Khaled", style: textTheme.headlineSmall),
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
