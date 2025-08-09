import 'package:evently/app_theme.dart';
import 'package:evently/events/create_event_screen.dart';
import 'package:evently/nav_bar_icon.dart';
import 'package:evently/providers/settings_provider.dart';

import 'package:evently/tabs/home/home_tab.dart';
import 'package:evently/tabs/love/love_tab.dart';
import 'package:evently/tabs/map/map_tab.dart';
import 'package:evently/tabs/profile/profile_tab.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  static const String routeName = '/home';

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int currentIndex = 0;
  List<Widget> tabs = [HomeTab(), MapTab(), LoveTab(), ProfileTab()];

  @override
  Widget build(BuildContext context) {
    SettingsProvider settingsProvider = Provider.of<SettingsProvider>(context);
    return Scaffold(
      body: tabs[currentIndex],
      bottomNavigationBar: BottomAppBar(
        padding: EdgeInsets.zero,
        color: settingsProvider.isDark
            ? AppTheme.backgroundDark
            : AppTheme.primary,
        shape: CircularNotchedRectangle(),
        notchMargin: 5,
        clipBehavior: Clip.antiAlias,

        child: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          elevation: 0,
          currentIndex: currentIndex,
          onTap: (index) {
            if (currentIndex == index) return;
            currentIndex = index;
            setState(() {});
          },

          items: [
            BottomNavigationBarItem(
              icon: NavBarIcon(imageName: "home"),
              activeIcon: NavBarIcon(imageName: "home active"),
              label: "Home",
            ),
            BottomNavigationBarItem(
              icon: NavBarIcon(imageName: "map"),
              activeIcon: NavBarIcon(imageName: "map active"),
              label: "Map",
            ),
            BottomNavigationBarItem(
              icon: NavBarIcon(imageName: "love"),
              activeIcon: NavBarIcon(imageName: "love active"),
              label: "Love",
            ),
            BottomNavigationBarItem(
              icon: NavBarIcon(imageName: "profile"),
              activeIcon: NavBarIcon(imageName: "profile active"),
              label: "Profile",
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () =>
            Navigator.of(context).pushNamed(CreateEventScreen.routeName),
        child: Icon(Icons.add, size: 30),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}
