import 'package:flutter/material.dart';
import 'package:weatherly/theme/app_colors.dart';

class SettingsScreen extends StatefulWidget {
  final VoidCallback onBack;

  const SettingsScreen({
    super.key,
    required this.onBack,
  });

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: double.infinity,
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            AppColors.background,
            AppColors.gradientBlue,
            AppColors.gradientDarkBlue,
          ],
        ),
      ),
      child: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 20,
              vertical: 15,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [

                // Header
                Row(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(14),
                        color: Colors.white.withOpacity(0.12),
                      ),
                      child: IconButton(
                        onPressed: widget.onBack,
                        icon: const Icon(
                          Icons.arrow_back,
                          color: AppColors.iconColor,
                        ),
                      ),
                    ),

                    const SizedBox(width: 15),

                    const Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Settings",
                          style: TextStyle(
                            fontSize: 27,
                            fontWeight: FontWeight.bold,
                            color: AppColors.primaryText,
                          ),
                        ),

                        Text(
                          "Customize your Weatherly Experience !",
                          style: TextStyle(
                            fontSize: 13,
                            color: AppColors.secondaryText,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),

                const SizedBox(height: 35),

                // About App Heading
                const Row(
                  children: [
                    Icon(
                      Icons.info_outline,
                      color: AppColors.cyan,
                      size: 21,
                    ),

                    SizedBox(width: 8),

                    Text(
                      "About App",
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                        color: AppColors.primaryText,
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 12),

                // About Weatherly Card
                InkWell(
                  borderRadius: BorderRadius.circular(18),
                  onTap: () {
                    showDialog(
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                          backgroundColor: AppColors.cardDarkBlue,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                          title: const Text(
                            "Weatherly",
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          content: const Text(
                            "More Than Weather\n\n"
                            "A simple weather app built with Flutter.\n\n"
                            "Version 1.0.0\n\n\n"
                            "Made By ANSH RASTOGI",
                            style: TextStyle(
                              color: Colors.white70,
                              height: 1.5,
                            ),
                          ),
                          actions: [
                            TextButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              child: const Text(
                                "Close",
                                style: TextStyle(
                                  color: AppColors.cyan,
                                ),
                              ),
                            ),
                          ],
                        );
                      },
                    );
                  },
                  child: Container(
                    width: double.infinity,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 18,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.10),
                      borderRadius: BorderRadius.circular(18),
                      border: Border.all(
                        color: Colors.white.withOpacity(0.12),
                      ),
                    ),
                    child: const Row(
                      children: [
                        CircleAvatar(
                          radius: 25,
                          backgroundColor: AppColors.circleAvatar,
                          child: Icon(
                            Icons.cloud_outlined,
                            color: AppColors.cyan,
                            size: 25,
                          ),
                        ),

                        SizedBox(width: 15),

                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Weatherly",
                                style: TextStyle(
                                  color: AppColors.primaryText,
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),

                              SizedBox(height: 4),

                              Text(
                                "More Than Weather",
                                style: TextStyle(
                                  color: AppColors.secondaryText,
                                  fontSize: 13,
                                ),
                              ),
                            ],
                          ),
                        ),

                        Icon(
                          Icons.arrow_forward_ios,
                          color: AppColors.primaryText,
                          size: 16,
                        ),
                      ],
                    ),
                  ),
                ),

                const SizedBox(height: 25),

                // App Version Heading
                const Row(
                  children: [
                    Icon(
                      Icons.phone_android_outlined,
                      color: AppColors.cyan,
                      size: 21,
                    ),

                    SizedBox(width: 8),

                    Text(
                      "App Version",
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                        color: AppColors.primaryText,
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 12),

                // App Version Card
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 18,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.10),
                    borderRadius: BorderRadius.circular(18),
                    border: Border.all(
                      color: Colors.white.withOpacity(0.12),
                    ),
                  ),
                  child: const Row(
                    children: [
                      CircleAvatar(
                        radius: 25,
                        backgroundColor: AppColors.circleAvatar,
                        child: Icon(
                          Icons.update,
                          color: AppColors.cyan,
                          size: 24,
                        ),
                      ),

                      SizedBox(width: 15),

                      Expanded(
                        child: Text(
                          "Weatherly",
                          style: TextStyle(
                            color: AppColors.primaryText,
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),

                      Text(
                        "v1.0.0",
                        style: TextStyle(
                          color: AppColors.secondaryText,
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 30),

                // Footer
                const Center(
                  child: Column(
                    children: [
                      Text(
                        "Weatherly",
                        style: TextStyle(
                          color: Colors.white54,
                          fontSize: 13,
                          fontWeight: FontWeight.bold,
                        ),
                      ),

                      SizedBox(height: 4),

                      Text(
                        "More Than Weather",
                        style: TextStyle(
                          color: Colors.white38,
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}