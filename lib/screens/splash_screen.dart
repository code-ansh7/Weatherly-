import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:weatherly/screens/onboarding_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();

    Future.delayed(
      const Duration(seconds: 3),
      () {
        Navigator.pushReplacement(
          context,
          CupertinoPageRoute(
            builder: (context) => const OnboardingScreen(),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,

        // Weatherly Theme Gradient
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Color(0xFF061B33),
              Color(0xFF0D4773),
              Color(0xFF123E63),
            ],
          ),
        ),

        child: SafeArea(
          child: Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // Weather Icon
                Container(
                  width: 115,
                  height: 115,
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.10),
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: Colors.white.withOpacity(0.15),
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.cyanAccent.withOpacity(0.15),
                        blurRadius: 30,
                        spreadRadius: 5,
                      ),
                    ],
                  ),
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      const Icon(
                        Icons.cloud,
                        size: 70,
                        color: Colors.cyanAccent,
                      ),
                      Positioned(
                        right: 17,
                        top: 20,
                        child: Icon(
                          Icons.wb_sunny,
                          size: 32,
                          color: Colors.amber.shade400,
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 28),

                // 🌦️ App Name
                const Text(
                  "Weatherly",
                  style: TextStyle(
                    fontSize: 36,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 1,
                    color: Colors.white,
                  ),
                ),

                const SizedBox(height: 8),

                // Tagline
                const Text(
                  "More Than Weather",
                  style: TextStyle(
                    fontSize: 15,
                    letterSpacing: 1.2,
                    color: Colors.white70,
                  ),
                ),

                const SizedBox(height: 35),

                // Loading
                SizedBox(
                  width: 40,
                  height: 40,
                  child: CircularProgressIndicator(
                    strokeWidth: 2.5,
                    valueColor: const AlwaysStoppedAnimation<Color>(
                      Colors.cyanAccent,
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