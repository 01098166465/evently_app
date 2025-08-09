import 'package:evently/app_theme.dart';
import 'package:evently/intro/intro_screen.dart';
import 'package:evently/providers/settings_provider.dart';
import 'package:evently/widgets/default_eleveted_button.dart';
import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

class IntroFirstScreen extends StatelessWidget {
  static const String routeName = "/intro-first";

  @override
  Widget build(BuildContext context) {
    SettingsProvider settingsProvider = Provider.of<SettingsProvider>(context);
    double screenHeight = MediaQuery.sizeOf(context).height;
    TextTheme textTheme = Theme.of(context).textTheme;
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.asset("assets/images/intro.png", height: screenHeight * 0.15),
            SizedBox(height: 10),
            Image.asset("assets/images/intro1.png", height: screenHeight * 0.4),
            SizedBox(height: 10),
            Text(
              "Personalize Your Experience",
              style: textTheme.titleLarge!.copyWith(
                color: AppTheme.primary,
                fontWeight: FontWeight.bold,
              ),
            ),

            SizedBox(height: 20),
            Text(
              "Choose your preferred theme and language to get started with a comfortable, tailored experience that suits your style.",
              style: textTheme.titleMedium!.copyWith(
                color: settingsProvider.isDark
                    ? AppTheme.white
                    : AppTheme.black,
              ),
            ),
            SizedBox(height: 16),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Dark Theme",
                  style: textTheme.titleLarge!.copyWith(
                    color: AppTheme.primary,
                  ),
                ),
                Switch(
                  value: settingsProvider.isDark,

                  activeTrackColor: AppTheme.primary,
                  onChanged: (isDark) {
                    settingsProvider.changeTheme(
                      isDark ? ThemeMode.dark : ThemeMode.light,
                    );
                  },
                ),
              ],
            ),

            Spacer(),
            DefaultElevetedButton(
              label: "Let’s Start",
              onPressed: () => Navigator.of(context).pushNamed(
                IntroScreen.routeName,
                arguments: settingsProvider.isDark,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
