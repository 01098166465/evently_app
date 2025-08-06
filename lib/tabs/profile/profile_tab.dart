import 'package:evently/app_theme.dart';
import 'package:evently/auth/login_screen.dart';
import 'package:evently/firebase_service.dart';
import 'package:evently/l10n/app_localizations.dart';
import 'package:evently/providers/settings_provider.dart';
import 'package:evently/providers/user_provider.dart';
import 'package:evently/tabs/profile/profile_header.dart';
import 'package:evently/widgets/default_eleveted_button.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProfileTab extends StatelessWidget {
  List<Language> language = [
    Language(code: "en", name: "English"),
    Language(code: "ar", name: "العربية"),
  ];
  @override
  Widget build(BuildContext context) {
    SettingsProvider settingsProvider = Provider.of<SettingsProvider>(context);
    TextTheme textTheme = Theme.of(context).textTheme;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,

      children: [
        ProfileHeader(),
        SizedBox(height: 24),
        Expanded(
          child: Padding(
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
                        color: settingsProvider.isDark
                            ? AppTheme.white
                            : AppTheme.black,
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

                        value: settingsProvider.languageCode,
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
                        onChanged: (languageCode) {
                          if (languageCode == null) return;
                          settingsProvider.changeLanguage(languageCode);
                        },
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
                        color: settingsProvider.isDark
                            ? AppTheme.white
                            : AppTheme.black,
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
                  label: AppLocalizations.of(context)!.logout,
                  svgIcon: "assets/icons/Exit.svg",
                  color: AppTheme.red,
                  onPressed: () {
                    FirebaseService.logout().then((_) {
                      Navigator.of(
                        context,
                      ).pushReplacementNamed(LoginScreen.routeName).then((_) {
                        Provider.of<UserProvider>(
                          context,
                          listen: false,
                        ).updateCurrentUser(null);
                      });
                    });
                  },
                ),
                SizedBox(height: 30),
              ],
            ),
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
