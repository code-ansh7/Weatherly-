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
    // TODO: implement initState
    super.initState();

    Future.delayed(
      const Duration(seconds: 2),
      (){
        Navigator.pushReplacement(
          context, 
          CupertinoPageRoute(
            builder: (context) => const OnboardingScreen()
          ),
        );
      }
    );
  }

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

            SizedBox(height: 40,),
            CircularProgressIndicator(
              color: Colors.white,
              backgroundColor: Colors.cyan,
            )
          ],
        ),
      ),
    );
  }
}
