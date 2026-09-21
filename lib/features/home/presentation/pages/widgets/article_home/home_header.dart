import 'package:flutter/material.dart';
import 'package:worldnews/core/constants/app_colors.dart';
import 'notification_button.dart';

class HomeHeader extends StatelessWidget {
  const HomeHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 20, top: 16, right: 20, bottom: 4),
      child: Row(
        children: [
          const Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Good morning',
                  style: TextStyle(color: AppColors.muted, fontSize: 14),
                ),
                SizedBox(height: 2),
                Text(
                  'Top stories',
                  style: TextStyle(
                    color: AppColors.ink,
                    fontSize: 28,
                    fontWeight: FontWeight.w800,
                    letterSpacing: -0.5,
                  ),
                ),
              ],
            ),
          ),
          const NotificationButton(),
        ],
      ),
    );
  }
}
