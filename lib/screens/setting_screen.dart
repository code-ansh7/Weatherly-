import 'package:flutter/material.dart';
import 'package:weatherly/theme/app_colors.dart';

class SettingsScreen extends StatefulWidget {
  final VoidCallback onBack;
  const SettingsScreen({super.key, required this.onBack});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  bool isCelsius = true;
  String selectedTheme = "Dark";

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
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
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
                        icon: Icon(
                          Icons.arrow_back,
                          color: AppColors.iconColor,
                        ),
                      ),
                    ),
                    SizedBox(width: 15),

                    Column(
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

                SizedBox(height: 30),

                Row(
                  children: [
                    Icon(
                      Icons.thermostat_outlined,
                      color: AppColors.cyan,
                      size: 21,
                    ),

                    SizedBox(width: 8),
                    Text(
                      "Temperature Unit",
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                        color: AppColors.primaryText,
                      ),
                    ),
                  ],
                ),

                SizedBox(height: 12),

                Container(
                  width: double.infinity,
                  padding: EdgeInsets.all(7),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.10),
                    borderRadius: BorderRadius.circular(18),
                    border: Border.all(color: Colors.white.withOpacity(0.12)),
                  ),

                  child: Row(
                    children: [
                      Expanded(
                        child: InkWell(
                          onTap: () {
                            setState(() {
                              isCelsius = true;
                            });
                          },
                          child: Container(
                            padding: EdgeInsets.symmetric(vertical: 13),
                            decoration: BoxDecoration(
                              color: isCelsius
                                  ? AppColors.cyan
                                  : Colors.white.withOpacity(0.12),

                              borderRadius: BorderRadius.circular(13),
                            ),

                            child: Center(
                              child: Text(
                                "°C",
                                style: TextStyle(
                                  color: isCelsius
                                      ? AppColors.background
                                      : AppColors.primaryText,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),

                      SizedBox(width: 7),

                      Expanded(
                        child: InkWell(
                          onTap: () {
                            setState(() {
                              isCelsius = false;
                            });
                          },
                          child: Container(
                            padding: EdgeInsets.symmetric(vertical: 13),
                            decoration: BoxDecoration(
                              color: !isCelsius
                                  ? AppColors.cyan
                                  : Colors.white.withOpacity(0.12),

                              borderRadius: BorderRadius.circular(13),
                            ),

                            child: Center(
                              child: Text(
                                "°F",
                                style: TextStyle(
                                  color: !isCelsius
                                      ? AppColors.background
                                      : AppColors.primaryText,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 12),

                // About App Heading
                Row(
                  children: [
                    const Icon(
                      Icons.info_outline,
                      color: AppColors.cyan,
                      size: 21,
                    ),

                    const SizedBox(width: 8),

                    const Text(
                      "About App",
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                        color: AppColors.secondaryText,
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 12),

                // About Weatherly Card
                InkWell(
                  borderRadius: BorderRadius.circular(18),
                  onTap: () {
                    print("About Weatherly Pressed!");
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
                      border: Border.all(color: Colors.white.withOpacity(0.12)),
                    ),
                    child: Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            color: Colors.cyanAccent.withOpacity(0.12),
                            shape: BoxShape.circle,
                          ),
                          child: const Icon(
                            Icons.cloud_outlined,
                            color: AppColors.cyan,
                            size: 24,
                          ),
                        ),

                        const SizedBox(width: 15),

                        const Expanded(
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

                        const Icon(
                          Icons.arrow_forward_ios,
                          color: AppColors.primaryText,
                          size: 16,
                        ),
                      ],
                    ),
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