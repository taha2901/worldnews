import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:worldnews/core/constants/app_colors.dart';
import 'package:worldnews/core/widgets/app_auth_buttons.dart';
import 'package:worldnews/core/widgets/app_text_field.dart';
import 'package:worldnews/features/auth/presentaion/cubit/auth_cubit.dart';
import 'package:worldnews/features/auth/presentaion/cubit/auth_state.dart';
import 'package:worldnews/features/auth/presentaion/pages/widgets/auth_footer_link.dart';
import 'package:worldnews/features/auth/presentaion/pages/widgets/auth_header.dart';
import 'package:worldnews/features/auth/presentaion/pages/widgets/auth_social_button.dart';
import 'package:worldnews/features/auth/presentaion/pages/widgets/or_divider.dart';
import 'package:worldnews/main.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  late final TextEditingController _emailController;
  late final TextEditingController _passwordController;
  late final TextEditingController _confirmPasswordController;

  @override
  void initState() {
    super.initState();
    _emailController = TextEditingController();
    _passwordController = TextEditingController();
    _confirmPasswordController = TextEditingController();
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
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
                  const AuthHeader(title: 'Create account'),
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
                          hint: 'At least 8 characters',
                          icon: Icons.lock_outline_rounded,
                          isPassword: true,
                          textInputAction: TextInputAction.next,
                        ),
                        const SizedBox(height: 18),
                        AppTextField(
                          controller: _confirmPasswordController,
                          label: 'Confirm password',
                          hint: 'Re-enter your password',
                          icon: Icons.lock_outline_rounded,
                          isPassword: true,
                          textInputAction: TextInputAction.done,
                        ),
                        const SizedBox(height: 20),
                        AuthPrimaryButton(
                          label: isLoading ? 'Creating account...' : 'Create account',
                          isLoading: isLoading,
                          onPressed: isLoading
                              ? null
                              : () {
                                  final email = _emailController.text.trim();
                                  final password = _passwordController.text.trim();
                                  final confirmPassword = _confirmPasswordController.text.trim();

                                  if (email.isEmpty || password.isEmpty || confirmPassword.isEmpty) {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(
                                        content: Text('Please fill all fields'),
                                      ),
                                    );
                                    return;
                                  }

                                  if (password != confirmPassword) {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(
                                        content: Text('Passwords do not match'),
                                      ),
                                    );
                                    return;
                                  }

                                  context.read<AuthCubit>().register(
                                    email: email,
                                    password: password,
                                  );
                                },
                        ),
                        const SizedBox(height: 22),
                        const OrDivider(),
                        const SizedBox(height: 22),
                        AuthSocialButton(
                          label: 'Sign up with Google',
                          onPressed: () {},
                        ),
                        const SizedBox(height: 24),
                        AuthFooterLink(
                          text: 'Already have an account?',
                          actionLabel: 'Log in',
                          onTap: () => Navigator.of(context).maybePop(),
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
