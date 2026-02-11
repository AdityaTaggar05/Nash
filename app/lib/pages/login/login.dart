import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '/config/theme.dart';
import '/controllers/auth.dart';
import '/utils/validators.dart';
import '/widgets/creation_button.dart';
import '/widgets/normal_text_field.dart';
import '/widgets/password_text_field.dart';
import '/widgets/snackbar.dart';

class LoginPage extends ConsumerStatefulWidget {
  const LoginPage({super.key});

  @override
  ConsumerState<LoginPage> createState() => _LoginPageConsumerState();
}

class _LoginPageConsumerState extends ConsumerState<LoginPage> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  Future<void> onSubmit() async {
    final emailError = emailValidator(emailController.text);

    if (emailError != null) {
      showSnackBar(context, emailError);
      return;
    }

    if (passwordController.text.isEmpty) {
      showSnackBar(context, "Please enter a password");
      return;
    }

    try {
      await ref
          .read(authControllerProvider.notifier)
          .login(
            email: emailController.text,
            password: passwordController.text,
          );
    } catch (_) {
      if (context.mounted) {
        showSnackBar(context, "Login Failed");
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.scaffoldBackgroundColor,
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            final bool isLoading = ref
                .read(authControllerProvider.notifier)
                .isLoggingIn;

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
                                  validator: emailValidator,
                                ),
                                const SizedBox(height: 20.0),
                                PasswordTextField(
                                  hintText: "Password",
                                  controller: passwordController,
                                ),
                                const SizedBox(height: 32.0),
                                CreationButton(
                                  onPressed: isLoading ? null : onSubmit,
                                  title: isLoading ? "Logging in..." : "Login",
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
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    "New to the app? ",
                                    style: context.textTheme.bodyMedium!
                                        .copyWith(
                                          color: context.colorScheme.onSurface,
                                        ),
                                  ),
                                  GestureDetector(
                                    onTap: () => context.go('/auth/register'),
                                    child: Text(
                                      "Register",
                                      style: context.textTheme.bodySmall!
                                          .copyWith(
                                            color: context.colorScheme.primary,
                                            fontWeight: FontWeight.bold,
                                          ),
                                    ),
                                  ),
                                ],
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
