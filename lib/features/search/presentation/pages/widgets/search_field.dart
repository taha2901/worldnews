import 'package:flutter/material.dart';
import 'package:worldnews/core/constants/app_colors.dart';

class SearchField extends StatelessWidget {
  const SearchField({
    super.key,
    required this.controller,
    required this.onChanged,
  });

  final TextEditingController controller;
  final ValueChanged<String> onChanged;

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      textInputAction: TextInputAction.search,
      cursorColor: AppColors.accent,
      style: const TextStyle(color: AppColors.ink, fontSize: 16),
      onChanged: onChanged,
      decoration: InputDecoration(
        hintText: 'Search topics, news, people...',
        hintStyle: const TextStyle(
          color: AppColors.muted,
          fontSize: 15,
        ),
        prefixIcon: const Icon(
          Icons.search_rounded,
          color: AppColors.muted,
        ),
        filled: true,
        fillColor: AppColors.surface,
        contentPadding: const EdgeInsets.symmetric(vertical: 16),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: const BorderSide(color: AppColors.border),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: const BorderSide(color: AppColors.border),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: const BorderSide(
            color: AppColors.accent,
            width: 1.6,
          ),
        ),
      ),
    );
  }
}
