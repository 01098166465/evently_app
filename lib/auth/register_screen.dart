import 'package:evently/auth/login_screen.dart';
import 'package:evently/firebase_service.dart';
import 'package:evently/home_screen.dart';
import 'package:evently/widgets/default_eleveted_button.dart';
import 'package:evently/widgets/default_text_form_field.dart';

import 'package:flutter/material.dart';

class RegisterScreen extends StatefulWidget {
  static const String routeName = '/register';

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              "assets/images/Logo.png",
              height: MediaQuery.sizeOf(context).height * 0.2,
              fit: BoxFit.fill,
            ),
            SizedBox(height: 24),
            DefaultTextFormField(
              hintText: "Name",
              controller: nameController,
              prefixIconImageName: "name",
            ),
            SizedBox(height: 16.0),
            DefaultTextFormField(
              hintText: "Email",
              controller: emailController,
              prefixIconImageName: "email",
            ),
            SizedBox(height: 16.0),
            DefaultTextFormField(
              hintText: "Password",
              controller: passwordController,
              prefixIconImageName: "password",
            ),
            SizedBox(height: 24),
            DefaultElevetedButton(label: "Create Account", onPressed: register),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Don’t Have Account ?",
                  style: TextTheme.of(context).titleMedium,
                ),

                TextButton(
                  onPressed: () => Navigator.of(
                    context,
                  ).pushReplacementNamed(LoginScreen.routeName),
                  child: Text(" Login"),
                ),
              ],
            ),
            SizedBox(height: 24),
            Image.asset("assets/images/language.png"),
          ],
        ),
      ),
    );
  }

  void register() {
    FirebaseService.register(
      name: nameController.text,
      email: emailController.text,
      password: passwordController.text,
    ).then((user) {
      Navigator.of(context).pushReplacementNamed(HomeScreen.routeName);
    });
  }
}
