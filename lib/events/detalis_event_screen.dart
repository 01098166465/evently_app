import 'package:evently/app_theme.dart';

import 'package:evently/events/edit_event_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class EventDetalisScreen extends StatelessWidget {
  static const String routeName = "/event-detalis";

  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;
    Size screenSize = MediaQuery.sizeOf(context);
    return Scaffold(
      appBar: AppBar(
        title: Text("Event Details"),
        actions: [
          IconButton(
            onPressed: () =>
                Navigator.of(context).pushNamed(EditEventScreen.routeName),
            icon: SvgPicture.asset("assets/icons/edit.svg"),
            color: AppTheme.primary,
          ),

          IconButton(
            onPressed: () {},
            icon: SvgPicture.asset("assets/icons/delete.svg"),
            color: AppTheme.red,
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 16),
              ClipRRect(
                borderRadius: BorderRadiusGeometry.circular(16),
                child: Image.asset(
                  "assets/images/sport.png",

                  height: screenSize.height * 0.25,
                  width: double.infinity,
                  fit: BoxFit.fill,
                ),
              ),

              SizedBox(height: 16),
              Text(
                "We Are Going To Play Football",
                style: textTheme.headlineSmall!.copyWith(
                  color: AppTheme.primary,
                ),
              ),
              SizedBox(height: 16),
              Container(
                padding: EdgeInsets.all(8),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: AppTheme.primary),
                ),
                child: Row(
                  children: [
                    Container(
                      padding: EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: AppTheme.primary,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: SvgPicture.asset(
                        "assets/icons/date.svg",
                        color: AppTheme.white,
                      ),
                    ),
                    SizedBox(width: 8),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "21 November 2024 ",
                          style: textTheme.titleMedium!.copyWith(
                            color: AppTheme.primary,
                          ),
                        ),
                        Text("12:12PM ", style: textTheme.titleMedium),
                      ],
                    ),
                  ],
                ),
              ),
              SizedBox(height: 16),
              Container(
                padding: EdgeInsets.all(8),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: AppTheme.primary),
                ),
                child: Row(
                  children: [
                    Container(
                      padding: EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: AppTheme.primary,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: SvgPicture.asset(
                        "assets/icons/location.svg",
                        color: AppTheme.white,
                      ),
                    ),
                    SizedBox(width: 8),
                    Expanded(
                      child: Row(
                        children: [
                          Text(
                            "Cairo , Egypt ",
                            style: textTheme.titleMedium!.copyWith(
                              color: AppTheme.primary,
                            ),
                          ),
                          Spacer(),
                          IconButton(
                            onPressed: () {},
                            icon: Icon(
                              Icons.arrow_forward_ios_outlined,
                              color: AppTheme.primary,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 16),
              Container(child: Image.asset("assets/images/location.png")),
              SizedBox(height: 16),
              Text("Description", style: textTheme.titleMedium),
              SizedBox(height: 8),
              Text(
                "Lorem ipsum dolor sit amet consectetur. Vulputate eleifend suscipit eget neque senectus a. Nulla at non malesuada odio duis lectus amet nisi sit. Risus hac enim maecenas auctor et. At cras massa diam porta facilisi lacus purus. Iaculis eget quis ut amet. Sit ac malesuada nisi quis  feugiat.",
                style: textTheme.titleMedium,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
