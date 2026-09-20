import 'package:flutter/material.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF061B33),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            //Icon
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(Icons.cloud, size: 60, color: Colors.cyanAccent),
                Icon(Icons.wb_sunny, size: 35, color: Colors.amber),
              ],
            ),
            SizedBox(height: 20),

            //App-name
            Text(
              "Weatherly",
              style: TextStyle(
                fontSize: 32,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            SizedBox(height: 8),

            //Tagline
            Text(
              "More Than Weather",
              style: TextStyle(fontSize: 16, color: Colors.white70),
            ),
          ],
        ),
      ),
    );
  }
}