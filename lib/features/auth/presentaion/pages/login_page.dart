import 'package:flutter/material.dart';
import 'package:worldnews/core/constants/app_colors.dart';
import 'package:worldnews/core/widgets/app_auth_buttons.dart';
import 'package:worldnews/core/widgets/app_text_field.dart';
import 'package:worldnews/features/auth/presentaion/pages/register_page.dart';
import 'package:worldnews/features/auth/presentaion/pages/widgets/auth_footer_link.dart';
import 'package:worldnews/features/auth/presentaion/pages/widgets/auth_header.dart';
import 'package:worldnews/features/auth/presentaion/pages/widgets/auth_social_button.dart';
import 'package:worldnews/features/auth/presentaion/pages/widgets/or_divider.dart';
import 'package:worldnews/main.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.only(left: 24, right: 24, top: 24, bottom: 32),
          child: Column(
            children: [
              const AuthHeader(
                title: 'Welcome back',
              ),
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
                    const AppTextField(
                      label: 'Email',
                      hint: 'you@example.com',
                      icon: Icons.mail_outline_rounded,
                      keyboardType: TextInputType.emailAddress,
                      textInputAction: TextInputAction.next,
                    ),
                    const SizedBox(height: 18),
                    const AppTextField(
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
                      label: 'Log in',
                      onPressed: () => Navigator.of(context).pushReplacement(
                        MaterialPageRoute(
                          builder: (_) => const MainNavigationPage(),
                        ),
                      ),
                    ),
                    const SizedBox(height: 22),
                    const OrDivider(),
                    const SizedBox(height: 22),
                    AuthSocialButton(
                      label: 'Continue with Google',
                      onPressed: () {},
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
  }
}
