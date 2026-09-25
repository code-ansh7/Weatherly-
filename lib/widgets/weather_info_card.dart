import 'package:flutter/material.dart';
import 'package:weatherly/theme/app_colors.dart';


class WeatherInfoCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final String value;

  const WeatherInfoCard({
    super.key,
    required this.icon,
    required this.title,
    required this.value,
  });
 
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(

        // color: Colors.white.withOpacity(0.10),
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,

          colors: [AppColors.cardBlue, AppColors.cardDarkBlue],
        ),
        
        borderRadius: BorderRadius.circular(18),

        border: Border.all(
          color: Colors.white.withOpacity(0.12),
        ),

      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            icon,
            color: AppColors.cyan,
            size: 40,
          ),
          const SizedBox(height: 8),
          Text(
            title,
            style: const TextStyle(
              color: AppColors.secondaryText,
              fontSize: 18,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            value,
            style: const TextStyle(
              color: AppColors.primaryText,
              fontSize: 25,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}