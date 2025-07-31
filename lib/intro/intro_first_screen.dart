import 'package:evently/app_theme.dart';
import 'package:flutter/material.dart';

class IntroFirstScreen extends StatelessWidget {
  static const String routeName = "/intro-first";

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.sizeOf(context).height;
    TextTheme textTheme = Theme.of(context).textTheme;
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.asset("assets/images/intro.png", height: screenHeight * 0.2),
            SizedBox(height: 10),
            Image.asset("assets/images/intro1.png", height: screenHeight * 0.4),
            SizedBox(height: 10),
            Text(
              "Personalize Your Experience",
              style: textTheme.titleLarge!.copyWith(color: AppTheme.primary),
            ),

            SizedBox(height: 20),
            Text(
              "Choose your preferred theme and language to get started with a comfortable, tailored experience that suits your style.",
              style: textTheme.titleMedium!.copyWith(color: AppTheme.black),
            ),
            Row(),
          ],
        ),
      ),
    );
  }
}
