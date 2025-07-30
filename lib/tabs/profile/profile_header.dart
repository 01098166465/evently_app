import 'package:evently/app_theme.dart';
import 'package:flutter/material.dart';

class ProfileHeader extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;
    Size screenSize = MediaQuery.sizeOf(context);
    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppTheme.primary,
        borderRadius: BorderRadius.only(bottomLeft: Radius.circular(64)),
      ),

      child: SafeArea(
        child: Row(
          children: [
            Image.asset(
              "assets/images/route_logo.png",
              height: screenSize.height * 0.12,
              fit: BoxFit.fill,
            ),
            SizedBox(width: 16),

            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,

                children: [
                  Text("Mahmoud khaled", style: textTheme.headlineSmall),
                  SizedBox(height: 10),
                  Text(
                    "mahmoudkhaled@gmail.com",
                    style: textTheme.titleMedium!.copyWith(
                      color: AppTheme.white,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
