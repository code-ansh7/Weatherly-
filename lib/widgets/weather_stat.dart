import 'package:flutter/material.dart';
import 'package:weatherly/theme/app_colors.dart';


class WeatherStat extends StatelessWidget {
  final IconData icon;
  final String title;
  final String value;
  final Color iconColor;

  const WeatherStat({
    super.key,
    required this.icon,
    required this.title,
    required this.value,
    required this.iconColor,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(icon, size: 40, color: iconColor),

        const SizedBox(width: 8),

        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: const TextStyle(
                fontSize: 18, 
                color: AppColors.secondaryText
              ), 
            ),
            Text(
              value,
              style: const TextStyle(
                fontSize: 25,
                fontWeight: FontWeight.bold,
                color: AppColors.primaryText,
              ),
            ),
          ],
        ),
      ],
    );
  }
}