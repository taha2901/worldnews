import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:worldnews/core/constants/app_colors.dart';
import 'package:worldnews/core/widgets/app_auth_buttons.dart';
import 'package:worldnews/core/widgets/app_text_field.dart';
import 'package:worldnews/features/auth/presentaion/cubit/auth_cubit.dart';
import 'package:worldnews/features/auth/presentaion/cubit/auth_state.dart';
import 'package:worldnews/features/auth/presentaion/pages/register_page.dart';
import 'package:worldnews/features/auth/presentaion/pages/widgets/auth_footer_link.dart';
import 'package:worldnews/features/auth/presentaion/pages/widgets/auth_header.dart';
import 'package:worldnews/features/auth/presentaion/pages/widgets/auth_social_button.dart';
import 'package:worldnews/features/auth/presentaion/pages/widgets/or_divider.dart';
import 'package:worldnews/main.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  late final TextEditingController _emailController;
  late final TextEditingController _passwordController;

  @override
  void initState() {
    super.initState();
    _emailController = TextEditingController();
    _passwordController = TextEditingController();
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthCubit, AuthState>(
      listener: (context, state) {
        if (state is AuthAuthenticated) {
          Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(builder: (_) => const MainNavigationPage()),
            (route) => false,
          );
        }

        if (state is AuthFailure) {
          ScaffoldMessenger.of(context)
            ..clearSnackBars()
            ..showSnackBar(
              SnackBar(
                content: Text(state.message),
                behavior: SnackBarBehavior.floating,
                backgroundColor: AppColors.ink,
                margin: const EdgeInsets.all(16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(14),
                ),
              ),
            );
        }
      },
      builder: (context, state) {
        final isLoading = state is AuthLoading;

        return Scaffold(
          backgroundColor: AppColors.background,
          body: SafeArea(
            child: SingleChildScrollView(
              padding: const EdgeInsets.only(left: 24, right: 24, top: 24, bottom: 32),
              child: Column(
                children: [
                  const AuthHeader(title: 'Welcome back'),
                  const SizedBox(height: 12),
                  Container(
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(24),
                      border: Border.all(color: AppColors.border),
                    ),
                    child: Column(
                      children: [
                        AppTextField(
                          controller: _emailController,
                          label: 'Email',
                          hint: 'you@example.com',
                          icon: Icons.mail_outline_rounded,
                          keyboardType: TextInputType.emailAddress,
                          textInputAction: TextInputAction.next,
                        ),
                        const SizedBox(height: 18),
                        AppTextField(
                          controller: _passwordController,
                          label: 'Password',
                          hint: 'Enter your password',
                          icon: Icons.lock_outline_rounded,
                          isPassword: true,
                          textInputAction: TextInputAction.done,
                        ),
                        Align(
                          alignment: Alignment.centerRight,
                          child: TextButton(
                            onPressed: () {},
                            style: TextButton.styleFrom(
                              foregroundColor: AppColors.ink,
                            ),
                            child: const Text(
                              'Forgot password?',
                              style: TextStyle(fontWeight: FontWeight.w700),
                            ),
                          ),
                        ),
                        const SizedBox(height: 8),
                        AuthPrimaryButton(
                          label: isLoading ? 'Logging in...' : 'Log in',
                          isLoading: isLoading,
                          onPressed: isLoading
                              ? null
                              : () {
                                  final email = _emailController.text.trim();
                                  final password = _passwordController.text.trim();

                                  if (email.isEmpty || password.isEmpty) {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(
                                        content: Text('Please enter email and password'),
                                      ),
                                    );
                                    return;
                                  }

                                  context.read<AuthCubit>().login(
                                    email: email,
                                    password: password,
                                  );
                                },
                        ),
                        const SizedBox(height: 22),
                        const OrDivider(),
                        const SizedBox(height: 22),
                        AuthSocialButton(
                          label: 'Continue with Google',
                          onPressed: isLoading
                              ? null
                              : () => context.read<AuthCubit>().signInWithGoogle(),
                        ),
                        const SizedBox(height: 24),
                        AuthFooterLink(
                          text: "Don't have an account?",
                          actionLabel: 'Sign up',
                          onTap: () => Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (_) => const RegisterPage(),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
