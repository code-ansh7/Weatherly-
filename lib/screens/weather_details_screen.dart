import 'package:flutter/material.dart';
import 'package:weatherly/widgets/weather_info_card.dart';
import 'package:weatherly/theme/app_colors.dart';
import 'package:weatherly/models/weather_model.dart';

class WeatherDetailsScreen extends StatefulWidget {
  final WeatherModel weather;
  const WeatherDetailsScreen({super.key, required this.weather});

  @override
  State<WeatherDetailsScreen> createState() => _WeatherDetailsScreenState();
}

class _WeatherDetailsScreenState extends State<WeatherDetailsScreen> {
  IconData getWeatherIcon(String condition) {
    String weather = condition.toLowerCase();

    if (weather.contains("clear")) {
      return Icons.wb_sunny;
    }

    if (weather.contains("cloud")) {
      return Icons.cloud;
    }

    if (weather.contains("rain")) {
      return Icons.water_drop;
    }

    if (weather.contains("thunder")) {
      return Icons.thunderstorm;
    }

    if (weather.contains("snow")) {
      return Icons.ac_unit;
    }

    if (weather.contains("mist") ||
        weather.contains("fog") ||
        weather.contains("haze")) {
      return Icons.cloud;
    }

    return Icons.wb_sunny;
  }

  Color getWeatherIconColor(String condition) {
    String weather = condition.toLowerCase();

    if (weather.contains("clear")) {
      return AppColors.sunny;
    }

    if (weather.contains("cloud")) {
      return Colors.white70;
    }

    if (weather.contains("rain")) {
      return AppColors.humidity;
    }

    if (weather.contains("thunder")) {
      return Colors.amber;
    }

    if (weather.contains("snow")) {
      return Colors.lightBlueAccent;
    }

    if (weather.contains("mist") ||
        weather.contains("fog") ||
        weather.contains("haze")) {
      return Colors.blueGrey.shade200;
    }

    return AppColors.sunny;
  }

String cleanTemperature(String temperature) {
  double value = double.tryParse(temperature) ?? 0;

  return value.toStringAsFixed(0);
}

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
            colors: [
              AppColors.background,
              AppColors.gradientBlue,
              AppColors.gradientDarkBlue,
            ], // colors: [Color(0xFF548BC3), Color(0xFF163A5F)],
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
                          icon: Icon(
                            Icons.arrow_back,
                            color: AppColors.iconColor,
                          ),
                        ),
                      ),

                      Expanded(
                        child: Column(
                          children: [
                            Text(
                              widget.weather.cityName,
                              style: TextStyle(
                                fontSize: 27,
                                fontWeight: FontWeight.bold,
                                color: AppColors.primaryText,
                              ),
                            ),
                            Text(
                              "Tue 22 Sep, 4:12 AM",
                              style: TextStyle(
                                fontSize: 13,
                                color: AppColors.secondaryText,
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

                        colors: [AppColors.cardBlue, AppColors.cardDarkBlue],
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
                            getWeatherIcon(widget.weather.condition),
                            color: getWeatherIconColor(
                              widget.weather.condition,
                            ),
                            size: 100,
                          ),

                          Text(
                            "${cleanTemperature(widget.weather.temperature)}°C",
                            style: const TextStyle(
                              color: AppColors.primaryText,
                              fontSize: 52,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            widget.weather.condition,
                            style: const TextStyle(
                              color: AppColors.secondaryText,
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
                            child: WeatherInfoCard(
                              icon: Icons.water_drop,
                              title: 'Humidity',
                              value: '${widget.weather.humidity}%',
                            ),
                          ),

                          SizedBox(width: 20),

                          Expanded(
                            child: WeatherInfoCard(
                              icon: Icons.air,
                              title: 'Wind Speed',
                              value: '${widget.weather.windSpeed} m/s',
                            ),
                          ),
                        ],
                      ),

                      SizedBox(height: 20),

                      Row(
                        children: [
                          Expanded(
                            child: WeatherInfoCard(
                              icon: Icons.speed,
                              title: "Pressure",
                              value: "${widget.weather.pressure} hPa",
                            ),
                          ),
                          const SizedBox(width: 10),
                          Expanded(
                            child: WeatherInfoCard(
                              icon: Icons.visibility,
                              title: "Visibility",
                              value: "${widget.weather.visibility} km",
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
}
