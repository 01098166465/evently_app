import 'package:evently/app_theme.dart';
import 'package:evently/auth/register_screen.dart';
import 'package:evently/firebase_service.dart';

import 'package:evently/home_screen.dart';

import 'package:evently/widgets/default_eleveted_button.dart';
import 'package:evently/widgets/default_text_form_field.dart';
import 'package:evently/widgets/ui_utils.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  static const String routeName = '/login';

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  GlobalKey<FormState> formkey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Form(
          key: formkey,
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
                validator: (value) {
                  if (value == null || value.length < 5) {
                    return "Invalid email";
                  }
                  return null;
                },
              ),
              SizedBox(height: 16.0),
              DefaultTextFormField(
                hintText: "Password",
                controller: passwordController,
                prefixIconImageName: "password",
                isPassword: true,
                validator: (value) {
                  if (value == null || value.length < 8) {
                    return "password must be at least 8 characters";
                  }
                  return null;
                },
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
              SizedBox(height: 24),
              Row(
                children: [
                  Expanded(child: Divider(color: AppTheme.primary)),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Text(
                      "Or",
                      style: textTheme.titleMedium!.copyWith(
                        color: AppTheme.primary,
                      ),
                    ),
                  ),

                  Expanded(child: Divider(color: AppTheme.primary)),
                ],
              ),
              SizedBox(height: 24),

              DefaultElevetedButton(
                svgIcon: "assets/icons/google.svg",
                label: "Login With Google",
                borderColor: AppTheme.primary,
                textColor: AppTheme.primary,
                color: AppTheme.backgroundLight,
                onPressed: () {},
              ),
            ],
          ),
        ),
      ),
    );
  }

  void login() {
    if (formkey.currentState!.validate()) {
      FirebaseService.login(
            email: emailController.text,
            password: passwordController.text,
          )
          .then((user) {
            Navigator.of(context).pushReplacementNamed(HomeScreen.routeName);
          })
          .catchError((error) {
            String? errorMessage;
            if (error is FirebaseAuthException) {
              errorMessage = error.message;
            }
            UiUtils.showErrorMessage(errorMessage);
          });
    }
  }
}
