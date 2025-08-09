import 'package:evently/app_theme.dart';
import 'package:evently/auth/register_screen.dart';
import 'package:evently/firebase_service.dart';

import 'package:evently/home_screen.dart';
import 'package:evently/l10n/app_localizations.dart';
import 'package:evently/providers/settings_provider.dart';
import 'package:evently/providers/user_provider.dart';

import 'package:evently/widgets/default_eleveted_button.dart';
import 'package:evently/widgets/default_text_form_field.dart';
import 'package:evently/widgets/ui_utils.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatefulWidget {
  static const String routeName = '/login-screen';

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  GlobalKey<FormState> formkey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    SettingsProvider settingsProvider = Provider.of<SettingsProvider>(context);
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
              DefaultElevetedButton(
                label: AppLocalizations.of(context)!.login,
                onPressed: login,
              ),
              SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Don’t Have Account ?", style: textTheme.titleMedium),

                  TextButton(
                    onPressed: () => Navigator.of(
                      context,
                    ).pushReplacementNamed(RegisterScreen.routeName),
                    child: Text(AppLocalizations.of(context)!.createAccount),
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
                color: settingsProvider.isDark
                    ? AppTheme.backgroundDark
                    : AppTheme.backgroundLight,
                onPressed: loginWithGoogle,
              ),
              SizedBox(height: 24),
              Image.asset("assets/images/language.png"),
            ],
          ),
        ),
      ),
    );
  }

  void login() {
    if (formkey.currentState!.validate()) {
      FirebaseService.login(
            email: emailController.text.trim(),
            password: passwordController.text.trim(),
          )
          .then((user) {
            Provider.of<UserProvider>(
              context,
              listen: false,
            ).updateCurrentUser(user);
            Navigator.of(context).pushReplacementNamed(HomeScreen.routeName);
          })
          .catchError((error) {
            String errorMessage = 'Unexpected error occurred';

            if (error is FirebaseAuthException) {
              switch (error.code) {
                case 'user-not-found':
                  errorMessage = 'Account not found';
                  break;
                case 'wrong-password':
                  errorMessage = 'Incorrect password';
                  break;
                case 'invalid-email':
                  errorMessage = 'Invalid email';
                  break;
                default:
                  errorMessage = 'Error: ${error.message}';
              }
            } else {
              print('Non-Firebase error: $error');
            }
            print(error);
            UiUtils.showErrorMessage(errorMessage);
          });
    }
  }

  void loginWithGoogle() async {
    try {
      final user = await FirebaseService.signInWithGoogle();

      Provider.of<UserProvider>(context, listen: false).updateCurrentUser(user);

      Navigator.of(context).pushReplacementNamed(HomeScreen.routeName);
    } catch (error) {
      String errorMessage = 'حدث خطأ أثناء تسجيل الدخول بجوجل';

      if (error is FirebaseAuthException) {
        switch (error.code) {
          case 'sign-in-cancelled':
            errorMessage = 'تم إلغاء تسجيل الدخول بجوجل.';
            break;
          default:
            errorMessage = 'خطأ: ${error.message}';
        }
      }

      print(error);
      UiUtils.showErrorMessage(errorMessage);
    }
  }
}
