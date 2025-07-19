import 'package:evently/auth/register_screen.dart';
import 'package:evently/home_screen.dart';
import 'package:evently/widgets/default_eleveted_button.dart';
import 'package:evently/widgets/default_text_form_field.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  static const String routeName = '/login';

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
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
            DefaultElevetedButton(label: "Login", onPressed: login),
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
                  ).pushReplacementNamed(RegisterScreen.routeName),
                  child: Text("Create Account"),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void login() {}
}
