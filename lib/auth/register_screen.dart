import 'package:evently/auth/login_screen.dart';
import 'package:evently/firebase_service.dart';
import 'package:evently/home_screen.dart';
import 'package:evently/providers/user_provider.dart';
import 'package:evently/widgets/default_eleveted_button.dart';
import 'package:evently/widgets/default_text_form_field.dart';
import 'package:evently/widgets/ui_utils.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class RegisterScreen extends StatefulWidget {
  static const String routeName = '/register';

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  GlobalKey<FormState> formkey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
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
                hintText: "Name",
                controller: nameController,
                prefixIconImageName: "name",
                validator: (value) {
                  if (value == null || value.length < 3) {
                    return "Invalid name";
                  }
                  return null;
                },
              ),
              SizedBox(height: 16.0),
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
              DefaultElevetedButton(
                label: "Create Account",
                onPressed: register,
              ),
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
      ),
    );
  }

  void register() {
    if (formkey.currentState!.validate()) {
      FirebaseService.register(
            name: nameController.text,
            email: emailController.text,
            password: passwordController.text,
          )
          .then((user) {
            Provider.of<UserProvider>(
              context,
              listen: false,
            ).updateCurrentUser(user);
            Navigator.of(context).pushReplacementNamed(HomeScreen.routeName);
          })
          .catchError((error) {
            String? errorMessage;
            if (error is FirebaseAuthException) {
              errorMessage = error.message;
            }
            UiUtils.showErrorMessage(errorMessage);
          });
      ;
    }
  }
}
