import 'package:evently/app_theme.dart';
import 'package:flutter/material.dart';

class EventItem extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;
    Size screenSize = MediaQuery.sizeOf(context);
    return Stack(
      children: [
        ClipRRect(
          borderRadius: BorderRadiusGeometry.circular(16),
          child: Image.asset(
            "assets/images/meeting.png",

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
                "21",
                style: textTheme.titleLarge!.copyWith(
                  color: AppTheme.primary,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                "nov",
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
                    "Meeting for Updating TheDevelopment Method ",
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
                  onTap: () {},
                  child: Icon(
                    Icons.favorite_outlined,
                    size: 24,
                    color: AppTheme.primary,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
