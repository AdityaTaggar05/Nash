import 'package:app/config/theme.dart';
import 'package:app/widgets/creation_button.dart';
import 'package:app/widgets/normal_text_field.dart';
import 'package:app/widgets/password_text_field.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.scaffoldBackgroundColor,
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            return SingleChildScrollView(
              child: ConstrainedBox(
                constraints: BoxConstraints(minHeight: constraints.maxHeight),
                child: IntrinsicHeight(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 28.0,
                      vertical: 36.0,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        const SizedBox(height: 40),
                        Text(
                          "Nash",
                          textAlign: TextAlign.center,
                          style: context.textTheme.displayLarge!.copyWith(
                            fontSize: 90,
                            color: context.colorScheme.primary,
                          ),
                        ),
                        const SizedBox(height: 40),
                        Container(
                          decoration: BoxDecoration(
                            color: context.colorScheme.surface,
                            borderRadius: BorderRadius.circular(25.0),
                          ),
                          child: Padding(
                            padding: EdgeInsets.symmetric(
                              vertical: 24.0,
                              horizontal: 16.0,
                            ),
                            child: Column(
                              children: [
                                Text(
                                  "Welcome Back!",
                                  style: context.textTheme.displayLarge!
                                      .copyWith(
                                        color: context.colorScheme.onSurface,
                                        fontSize: 24,
                                        fontWeight: FontWeight.bold,
                                      ),
                                ),
                                SizedBox(height: 28),
                                CustomTextField(
                                  hintText: "E-mail",
                                  controller: emailController,
                                ),
                                const SizedBox(height: 20.0),
                                PasswordTextField(
                                  hintText: "Password",
                                  controller: passwordController,
                                ),
                                const SizedBox(height: 32.0),
                                CreationButton(onPressed: () {
                                  return null;
                                },
                                title: "Login"
                                ),
                              ],
                            ),
                          ),
                        ),
                        Spacer(),
                        Center(
                          child: Container(
                            decoration: BoxDecoration(
                              color: context.colorScheme.surface,
                              borderRadius: BorderRadius.circular(48.0),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 28.0,
                                vertical: 12.0,
                              ),
                              child: RichText(
                                text: TextSpan(
                                  style: context.textTheme.bodyMedium!.copyWith(
                                    color: context.colorScheme.onSurface,
                                  ),
                                  children: <TextSpan>[
                                    TextSpan(text: "New to the app? "),
                                    TextSpan(
                                      text: 'Register',
                                      style: context.textTheme.bodySmall!
                                          .copyWith(
                                            color: context.colorScheme.primary,
                                            fontWeight: FontWeight.bold,
                                          ),
                                      recognizer: TapGestureRecognizer()
                                        ..onTap = () {
                                          context.push('/register');
                                        },
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}