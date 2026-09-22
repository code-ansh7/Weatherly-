import 'package:flutter/material.dart';

class WeatherDetailsScreen extends StatefulWidget {
  const new({super.key});

  @override
  State<WeatherDetailsScreen> createState() => _WeatherDetailsScreenState();
}

class _WeatherDetailsScreenState extends State<WeatherDetailsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [Color(0xFF061B33), Color(0xFF0D4773), Color(0xFF123E63)],
            // colors: [Color(0xFF548BC3), Color(0xFF163A5F)],
          ),
        ),
        child: SafeArea(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  //Header
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

                      Expanded(
                        child: Column(
                          children: [
                            Text(
                              "Tilhar",
                              style: TextStyle(
                                fontSize: 27,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                            Text(
                              "Tue 22 Sep, 4:12 AM",
                              style: TextStyle(
                                fontSize: 13,
                                color: Colors.white70,
                              ),
                            ),
                          ],
                        ),
                      ),

                      SizedBox(width: 35),
                    ],
                  ),
                  SizedBox(height: 30),

                  Container(
                    padding: EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(25),

                      // color: Colors.white.withOpacity(0.10),
                      gradient: const LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,

                        colors: [Color(0xFF548BC3), Color(0xFF163A5F)],
                      ),

                      border: Border.all(color: Colors.white.withOpacity(0.15)),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.cyanAccent.withOpacity(0.15),
                          blurRadius: 30,
                          spreadRadius: 5,
                        ),
                      ],
                    ),
                    child: Center(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            Icons.cloud,
                            color: const Color.fromARGB(255, 167, 232, 232),
                            size: 100,
                          ),
                          Text(
                            "28°C",
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 52,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            "Light Rain",
                            style: const TextStyle(
                              color: Colors.white70,
                              fontSize: 17,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: 30),

                  Column(
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: infoContainer(
                              Icons.water_drop,
                              "Humidity",
                              "45%",
                            ),
                          ),
                          SizedBox(width: 20),
                          Expanded(
                            child: infoContainer(
                              Icons.air,
                              "Wind Speed",
                              "12 Km/h",
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 20),

                      Row(
                        children: [
                          Expanded(
                            child: infoContainer(
                              Icons.thermostat,
                              "Pressure",
                              "1012 hPa",
                            ),
                          ),
                          SizedBox(width: 20),
                          Expanded(
                            child: infoContainer(
                              Icons.visibility,
                              "Visibility",
                              "10 Km",
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget infoContainer(IconData icon, String description, String value) {
    return Container(
      padding: EdgeInsets.all(20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(25),

        // color: Colors.white.withOpacity(0.10),
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,

          colors: [Color(0xFF548BC3), Color(0xFF163A5F)],
        ),

        border: Border.all(color: Colors.white.withOpacity(0.15)),
        boxShadow: [
          BoxShadow(
            color: Colors.cyanAccent.withOpacity(0.15),
            blurRadius: 30,
            spreadRadius: 5,
          ),
        ],
      ),

      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Icon(icon, color: Colors.cyanAccent, size: 40),
          SizedBox(height: 10),
          Text(
            description,
            style: TextStyle(color: Colors.white70, fontSize: 18),
          ),

          Text(
            value,
            style: TextStyle(
              color: Colors.white,
              fontSize: 25,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
