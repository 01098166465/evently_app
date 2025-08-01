import 'package:evently/app_theme.dart';
import 'package:evently/auth/login_screen.dart';
import 'package:evently/auth/register_screen.dart';
import 'package:evently/events/create_event_screen.dart';
import 'package:evently/events/edit_event_screen.dart';
import 'package:evently/events/detalis_event_screen.dart';
import 'package:evently/home_screen.dart';
import 'package:evently/intro/intro_first_screen.dart';
import 'package:evently/intro/intro_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(EventlyApp());
}

class EventlyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      routes: {
        IntroFirstScreen.routeName: (_) => IntroFirstScreen(),
        HomeScreen.routeName: (_) => HomeScreen(),
        LoginScreen.routeName: (_) => LoginScreen(),
        RegisterScreen.routeName: (_) => RegisterScreen(),
        IntroScreen.routeName: (_) => IntroScreen(),
        CreateEventScreen.routeName: (_) => CreateEventScreen(),
        EventDetalisScreen.routeName: (_) => EventDetalisScreen(),
        EditEventScreen.routeName: (_) => EditEventScreen(),
      },

      initialRoute: HomeScreen.routeName,

      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: ThemeMode.light,
    );
  }
}
