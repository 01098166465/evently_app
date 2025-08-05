import 'package:evently/app_theme.dart';
import 'package:evently/auth/login_screen.dart';
import 'package:evently/auth/register_screen.dart';
import 'package:evently/events/create_event_screen.dart';
import 'package:evently/events/edit_event_screen.dart';
import 'package:evently/events/detalis_event_screen.dart';
import 'package:evently/home_screen.dart';
import 'package:evently/intro/intro_first_screen.dart';
import 'package:evently/intro/intro_screen.dart';
import 'package:evently/providers/events_provider.dart';
import 'package:evently/providers/user_provider.dart';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => UserProvider()),
        ChangeNotifierProvider(create: (_) => EventsProvider()..getEvents()),
      ],
      child: EventlyApp(),
    ),
  );
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

      initialRoute: LoginScreen.routeName,

      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: ThemeMode.light,
    );
  }
}
