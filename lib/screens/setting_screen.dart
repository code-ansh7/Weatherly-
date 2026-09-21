import 'package:flutter/material.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  bool isCelsius = true;
  String selectedTheme = "Dark";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,

        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [Color(0xFF061B33), Color(0xFF0D4773), Color(0xFF123E63)],
          ),
        ),

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
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      icon: Icon(Icons.arrow_back, color: Colors.white),
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
                          color: Colors.white,
                        ),
                      ),

                      Text(
                        "Customize your Weatherly Experience !",
                        style: TextStyle(fontSize: 13, color: Colors.white70),
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
                    color: Colors.cyanAccent,
                    size: 21,
                  ),

                  SizedBox(width: 8),
                  Text(
                    "Temprature Unit",
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
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
                                ? Colors.cyanAccent
                                : Colors.white.withOpacity(0.12),

                            borderRadius: BorderRadius.circular(13),
                          ),

                          child: Center(
                            child: Text(
                              "°C",
                              style: TextStyle(
                                color: isCelsius
                                    ? Color(0xFF061B33)
                                    : Colors.white70,
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
                                ? Colors.cyanAccent
                                : Colors.white.withOpacity(0.12),

                            borderRadius: BorderRadius.circular(13),
                          ),

                          child: Center(
                            child: Text(
                              "°F",
                              style: TextStyle(
                                color: !isCelsius
                                    ? Color(0xFF061B33)
                                    : Colors.white70,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 30),

              //Theme Heading
              Row(
                children: [
                  const Icon(
                    Icons.palette_outlined,
                    color: Colors.cyanAccent,
                    size: 21,
                  ),

                  const SizedBox(width: 8),

                  const Text(
                    "Theme",
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 12),

              // Theme Container
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(7),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.10),
                  borderRadius: BorderRadius.circular(18),
                  border: Border.all(color: Colors.white.withOpacity(0.12)),
                ),

                child: Row(
                  children: [
                    // Light
                    Expanded(
                      child: InkWell(
                        borderRadius: BorderRadius.circular(13),
                        onTap: () {
                          setState(() {
                            selectedTheme = "Light";
                          });
                        },
                        child: Container(
                          padding: const EdgeInsets.symmetric(vertical: 13),
                          decoration: BoxDecoration(
                            color: selectedTheme == "Light"
                                ? Colors.cyanAccent
                                : Colors.white.withOpacity(0.12),
                            borderRadius: BorderRadius.circular(13),
                          ),
                          child: Center(
                            child: Text(
                              "Light",
                              style: TextStyle(
                                color: selectedTheme == "Light"
                                    ? const Color(0xFF061B33)
                                    : Colors.white70,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),

                    const SizedBox(width: 7),

                    // Dark
                    Expanded(
                      child: InkWell(
                        borderRadius: BorderRadius.circular(13),
                        onTap: () {
                          setState(() {
                            selectedTheme = "Dark";
                          });
                        },
                        child: Container(
                          padding: const EdgeInsets.symmetric(vertical: 13),
                          decoration: BoxDecoration(
                            color: selectedTheme == "Dark"
                                ? Colors.cyanAccent
                                : Colors.white.withOpacity(0.12),
                            borderRadius: BorderRadius.circular(13),
                          ),
                          child: Center(
                            child: Text(
                              "Dark",
                              style: TextStyle(
                                color: selectedTheme == "Dark"
                                    ? const Color(0xFF061B33)
                                    : Colors.white70,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),

                    const SizedBox(width: 7),

                    // 📱 System
                    Expanded(
                      child: InkWell(
                        borderRadius: BorderRadius.circular(13),
                        onTap: () {
                          setState(() {
                            selectedTheme = "System";
                          });
                        },
                        child: Container(
                          padding: const EdgeInsets.symmetric(vertical: 13),
                          decoration: BoxDecoration(
                            color: selectedTheme == "System"
                                ? Colors.cyanAccent
                                : Colors.white.withOpacity(0.12),
                            borderRadius: BorderRadius.circular(13),
                          ),
                          child: Center(
                            child: Text(
                              "System",
                              style: TextStyle(
                                color: selectedTheme == "System"
                                    ? const Color(0xFF061B33)
                                    : Colors.white70,
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

              const SizedBox(height: 30),

              // About App Heading
              Row(
                children: [
                  const Icon(
                    Icons.info_outline,
                    color: Colors.cyanAccent,
                    size: 21,
                  ),

                  const SizedBox(width: 8),

                  const Text(
                    "About App",
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
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
                          color: Colors.cyanAccent,
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
                                color: Colors.white,
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),

                            SizedBox(height: 4),

                            Text(
                              "More Than Weather",
                              style: TextStyle(
                                color: Colors.white70,
                                fontSize: 13,
                              ),
                            ),
                          ],
                        ),
                      ),

                      const Icon(
                        Icons.arrow_forward_ios,
                        color: Colors.white38,
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
    );
  }
}