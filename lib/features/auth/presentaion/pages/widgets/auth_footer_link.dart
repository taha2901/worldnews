import 'package:flutter/material.dart';
import 'package:worldnews/core/constants/app_colors.dart';

class AuthFooterLink extends StatelessWidget {
  const AuthFooterLink({
    super.key,
    required this.text,
    required this.actionLabel,
    required this.onTap,
  });

  final String text;
  final String actionLabel;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          text,
          style: const TextStyle(color: AppColors.muted, fontSize: 14.5),
        ),
        TextButton(
          onPressed: onTap,
          style: TextButton.styleFrom(
            foregroundColor: AppColors.accent,
            padding: const EdgeInsets.symmetric(horizontal: 6),
            minimumSize: const Size(0, 32),
          ),
          child: Text(
            actionLabel,
            style: const TextStyle(fontSize: 14.5, fontWeight: FontWeight.w800),
          ),
        ),
      ],
    );
  }
}
