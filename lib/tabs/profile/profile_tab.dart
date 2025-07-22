import 'package:evently/app_theme.dart';
import 'package:evently/tabs/profile/profile_header.dart';
import 'package:flutter/material.dart';

class ProfileTab extends StatelessWidget {
  List<Language> language = [
    Language(code: "en", name: "English"),
    Language(code: "ar", name: "العربية"),
  ];
  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ProfileHeader(),
        SizedBox(height: 24),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Language",
                    style: textTheme.titleLarge!.copyWith(
                      color: AppTheme.black,
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 16),
                    decoration: BoxDecoration(
                      border: Border.all(color: AppTheme.primary),
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: DropdownButton(
                      borderRadius: BorderRadius.circular(16),
                      underline: SizedBox(),
                      iconEnabledColor: AppTheme.primary,

                      value: "en",
                      style: textTheme.titleLarge!.copyWith(
                        color: AppTheme.primary,
                      ),
                      items: language
                          .map(
                            (language) => DropdownMenuItem(
                              value: language.code,
                              child: Text(language.name),
                            ),
                          )
                          .toList(),
                      onChanged: (value) {},
                    ),
                  ),
                ],
              ),

              SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Dark Theme",
                    style: textTheme.titleLarge!.copyWith(
                      color: AppTheme.black,
                    ),
                  ),
                  Switch(
                    value: true,
                    activeColor: AppTheme.primary,
                    onChanged: (value) {},
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class Language {
  String code;
  String name;
  Language({required this.code, required this.name});
}
