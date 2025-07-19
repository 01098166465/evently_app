import 'package:flutter/material.dart';
import '../../app_theme.dart';

class IntroPageItem extends StatelessWidget {
  final Map<String, String> pageData;
  final TextTheme textTheme;

  const IntroPageItem({required this.pageData, required this.textTheme});

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.sizeOf(context).height;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Image.asset("assets/images/intro.png", height: screenHeight * 0.1),
          SizedBox(height: 10),
          Image.asset(pageData["image"]!, height: screenHeight * 0.4),
          SizedBox(height: 20),
          Align(
            alignment: Alignment.centerLeft,
            child: Text(
              pageData["title"]!,
              style: textTheme.titleLarge!.copyWith(color: AppTheme.primary),
            ),
          ),
          SizedBox(height: 30),
          Align(
            alignment: Alignment.centerLeft,
            child: Text(
              pageData["desc"]!,
              style: textTheme.titleMedium!.copyWith(color: AppTheme.black),
            ),
          ),
        ],
      ),
    );
  }
}
