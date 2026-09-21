import 'package:flutter/material.dart';
import 'package:worldnews/core/constants/app_colors.dart';
import 'package:worldnews/core/widgets/app_auth_buttons.dart';
import 'package:worldnews/core/widgets/app_text_field.dart';
import 'package:worldnews/features/auth/presentaion/pages/widgets/auth_footer_link.dart';
import 'package:worldnews/features/auth/presentaion/pages/widgets/auth_header.dart';
import 'package:worldnews/features/auth/presentaion/pages/widgets/auth_social_button.dart';
import 'package:worldnews/features/auth/presentaion/pages/widgets/or_divider.dart';
import 'package:worldnews/main.dart';

class RegisterPage extends StatelessWidget {
  const RegisterPage({super.key});
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.only(left: 24, right: 24, top: 24, bottom: 32),
          child: Column(
            children: [
              AuthHeader(
                title: 'Create account',
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
                      hint: 'At least 8 characters',
                      icon: Icons.lock_outline_rounded,
                      isPassword: true,
                      textInputAction: TextInputAction.next,
                    ),
                    const SizedBox(height: 18),
                    const AppTextField(
                      label: 'Confirm password',
                      hint: 'Re-enter your password',
                      icon: Icons.lock_outline_rounded,
                      isPassword: true,
                      textInputAction: TextInputAction.done,
                    ),
                    const SizedBox(height: 20),
                    AuthPrimaryButton(
                      label: 'Create account',
                      onPressed: () => Navigator.of(context).pushAndRemoveUntil(
                        MaterialPageRoute(
                          builder: (_) => const MainNavigationPage(),
                        ),
                        (route) => false,
                      ),
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
  }
}
