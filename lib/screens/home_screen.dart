import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:weatherly/screens/weather_details_screen.dart';
import 'package:weatherly/theme/app_colors.dart';
import 'package:weatherly/widgets/weather_stat.dart';
import 'package:weatherly/models/weather_model.dart';
import 'package:weatherly/services/weather_service.dart';

// HomeScreen open
//        ↓
// isLoading = true
//        ↓
// ⏳ Loading UI
//        ↓
// API request
//        ↓
// Response received
//        ↓
// weather = result
//        ↓
// isLoading = false
//        ↓
// 🌤️ Real weather UI

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final WeatherService weatherService =
      WeatherService(); // Weather Service ka object banaya

  WeatherModel? weather; // Model initialize kiya

  bool isLoading = true;
  String? errorMessage;

  @override
  void initState() {
    super.initState();
    //homescreen khulte hi phle ye kaam kro
    loadWeather(); // Real Weather Data Function
  }

  Future<void> loadWeather() async {
    try {
      setState(() {
        // Abhi request gayi nhi hai tb tk isLoading = true
        isLoading = true;
        errorMessage = null;
      });

      //API calling
      final result = await weatherService.getWeather('Tilhar');

      //suppose user requested to weather and during request user switch the other screen
      //so this screen will destroy
      if (!mounted)
        return; //Agr screen exist nhi krti to function yhi destroy kr do

      setState(() {
        // After Response
        weather = result;
        isLoading = false;
      });

      //await ke baad agar setState() karna hai -> mounted check karna safe practice hai.
    } catch (e) {
      if (!mounted) return;

      setState(() {
        isLoading = false;
        errorMessage = e.toString();
      });
    }
  }

  // Remove decimal points in temp
  String cleanTemperature(String temperature) {
    double value = double.parse(temperature);

    return value.toStringAsFixed(0);
  }

  // For Cleaning wind Speed
  String cleanWind(String windSpeed) {
    double value = double.parse(windSpeed);

    return value.toStringAsFixed(1);
  }

  //For Real Icon
  IconData getWeatherIcon(String condition) {
    if (condition == "Clear") {
      return Icons.wb_sunny;
    }

    if (condition == "Clouds") {
      return Icons.cloud;
    }

    if (condition == "Rain") {
      return Icons.water_drop;
    }

    if (condition == "Drizzle") {
      return Icons.grain;
    }

    if (condition == "Thunderstorm") {
      return Icons.thunderstorm;
    }

    if (condition == "Snow") {
      return Icons.ac_unit;
    }

    if (condition == "Mist" || condition == "Fog" || condition == "Haze") {
      return Icons.cloud;
    }

    return Icons.cloud;
  }

  //For icon color
  Color getWeatherIconColor(String condition) {
    if (condition == "Clear") {
      return AppColors.sunny;
    }

    if (condition == "Clouds") {
      return Colors.grey.shade300;
    }

    if (condition == "Rain") {
      return Colors.lightBlueAccent;
    }

    if (condition == "Drizzle") {
      return Colors.cyanAccent;
    }

    if (condition == "Thunderstorm") {
      return Colors.deepPurpleAccent;
    }

    if (condition == "Snow") {
      return Colors.white;
    }

    if (condition == "Mist" || condition == "Fog" || condition == "Haze") {
      return Colors.blueGrey.shade200;
    }

    return Colors.white70;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: AppColors.appBar,
        leading: IconButton(
          onPressed: () {},
          icon: const Icon(Icons.menu, color: AppColors.iconColor, size: 24),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 20),
            child: CircleAvatar(
              radius: 20,
              backgroundColor: AppColors.circleAvatar,
              child: const Icon(Icons.person, color: AppColors.iconColor),
            ),
          ),
        ],
      ),
      body: homeBody(),
    );
  }

  Widget homeBody() {
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
            padding: const EdgeInsets.all(20),

            child: getWeatherUI(), // Decide What we will render
          ),
        ),
      ),
    );
  }

  //Control UI
  Widget getWeatherUI() {
    if (isLoading) {
      return SizedBox(
        height: 500,
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              CircularProgressIndicator(color: AppColors.cyan),
              SizedBox(height: 16),
              Text(
                "Fetching weather...",
                style: TextStyle(color: Colors.white70, fontSize: 15),
              ),
            ],
          ),
        ),
      );
    }

    if (errorMessage != null) {
      // Agr eoor aaye to
      return _buildErrorState();
    }

    return buildWeatherUI();
  }

  //Success UI
  Widget buildWeatherUI() {
    return Column(
      // Agr loading false hai to ye
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Good Morning,\nAnsh! 👋",
              style: TextStyle(
                fontSize: 34,
                fontWeight: FontWeight.bold,
                color: AppColors.primaryText,
                height: 1.2,
              ),
            ),
            SizedBox(height: 4),
            Text(
              "Check the weather around you...",
              style: TextStyle(fontSize: 14, color: AppColors.secondaryText),
            ),
          ],
        ),

        const SizedBox(height: 20),

        TextField(
          decoration: InputDecoration(
            hintText: "Search city (e.g. Tilhar)",
            hintStyle: const TextStyle(color: AppColors.secondaryText),
            prefixIcon: const Icon(Icons.search, color: AppColors.primaryText),
            filled: true,
            fillColor: Colors.white.withOpacity(0.12),
            contentPadding: const EdgeInsets.symmetric(vertical: 17),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(18),
              borderSide: BorderSide.none,
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(18),
              borderSide: BorderSide(color: Colors.white.withOpacity(0.15)),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(18),
              borderSide: const BorderSide(color: AppColors.cyan, width: 1.5),
            ),
          ),
        ),

        const SizedBox(height: 22),

        GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const WeatherDetailsScreen(),
              ),
            );
          },
          child: Container(
            width: double.infinity,
            height: 350,
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [AppColors.cardBlue, AppColors.cardDarkBlue],
              ),
              borderRadius: BorderRadius.circular(24),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.25),
                  blurRadius: 20,
                  offset: const Offset(0, 10),
                ),
              ],
            ),
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            // Real City
                            weather!.cityName,
                            style: TextStyle(
                              fontSize: 25,
                              fontWeight: FontWeight.bold,
                              color: AppColors.primaryText,
                            ),
                          ),
                          SizedBox(height: 4),
                          Text(
                            "Sun, 20 Sep",
                            style: TextStyle(
                              fontSize: 18,
                              color: AppColors.secondaryText,
                            ),
                          ),
                        ],
                      ),
                      const Spacer(),
                      IconButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            CupertinoPageRoute(
                              builder: (context) =>
                                  const WeatherDetailsScreen(),
                            ),
                          );
                        },
                        icon: const Icon(
                          Icons.more_horiz_rounded,
                          color: AppColors.primaryText,
                          size: 24,
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 10),

                  Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            getWeatherIcon(weather!.condition),
                            size: 65,
                            color: getWeatherIconColor(weather!.condition),
                          ),
                          const SizedBox(width: 20),

                          Text(
                            // Real Temprature after cleaning
                            "${cleanTemperature(weather!.temperature)}°C",

                            style: TextStyle(
                              fontSize: 52,
                              fontWeight: FontWeight.bold,
                              color: AppColors.primaryText,
                            ),
                          ),
                        ],
                      ),

                      Text(
                        weather!.condition, // Real Condition
                        textAlign: TextAlign.left,
                        style: TextStyle(
                          fontSize: 25,
                          color: AppColors.secondaryText,
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 10),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      WeatherStat(
                        icon: Icons.water_drop,
                        title: "Humidity",
                        value: "${weather!.humidity}%",
                        iconColor: AppColors.cyan,
                      ),

                      WeatherStat(
                        icon: Icons.air,
                        title: "Wind",
                        value: "${cleanWind(weather!.windSpeed)} m/s",
                        iconColor: AppColors.cyan,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),

        const SizedBox(height: 20),

        InkWell(
          onTap: loadWeather,
          child: Container(
            width: double.infinity,
            padding: EdgeInsets.symmetric(horizontal: 14, vertical: 10),
            decoration: BoxDecoration(
              // color: AppColors.cyan,
              gradient: LinearGradient(
                colors: [AppColors.cardDarkBlue, AppColors.cardBlue],
                begin: Alignment.topRight,
                end: Alignment.bottomLeft,
              ),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Center(
              child: Text(
                "Refresh Weather",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w700,
                  color: AppColors.background,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  //Error UI
  Widget _buildErrorState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(Icons.cloud_off_rounded, color: Colors.white70, size: 60),

          const SizedBox(height: 16),

          const Text(
            "Unable to load weather",
            style: TextStyle(
              color: Colors.white,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),

          const SizedBox(height: 8),

          Text(
            errorMessage ?? "Something went wrong",
            textAlign: TextAlign.center,
            style: const TextStyle(color: Colors.white70, fontSize: 14),
          ),

          const SizedBox(height: 20),

          ElevatedButton.icon(
            onPressed: loadWeather,
            icon: const Icon(Icons.refresh),
            label: const Text("Try Again"),
          ),
        ],
      ),
    );
  }
}

//     HomeScreen
//          │
//          ▼
//    initState()
//          │
//          ▼
//    loadWeather()
//          │
//          ▼
// isLoading = true
//          │
//          ▼
// WeatherService
//          │
//          ▼
//   OpenWeather API
//          │
//          ▼
//    JSON Response
//          │
//          ▼
//    WeatherModel
//          │
//          ▼
// weather = result
//          │
//          ▼
// isLoading = false
//          │
//          ▼
// ┌─────────────────┐
// │   REAL WEATHER  │
// │                 │
// │ Tilhar          │
// │ 32°C            │
// │ Clear            │
// │ 45%              │
// │ 5.2 m/s          │
// └─────────────────┘

//            loadWeather()
//                 │
//       ┌─────────┴─────────┐
//       │                   │
//       ▼                   ▼
//  isLoading=true       API request
//       │                   │
//       ▼                   ▼
//  ⏳ Loading          Response?
//                           │
//                ┌──────────┴──────────┐
//                │                     │
//             Success                Error
//                │                     │
//                ▼                     ▼
//       weather = result       errorMessage
//       isLoading=false        isLoading=false
//                │                     │
//                ▼                     ▼
//            🌤️ Weather            ❌ Error
//                                     │
//                                     ▼
//                                 🔄 Retry

// _HomeScreenState
// │
// ├── weatherService
// ├── weather
// ├── isLoading
// ├── errorMessage
// │
// ├── initState()
// │
// ├── loadWeather()
// │
// ├── getWeatherUI()
// │
// ├── buildWeatherUI()
// │
// ├── cleanTemperature()
// ├── cleanWind()
// │
// ├── getWeatherIcon()       ← 🆕
// ├── getWeatherIconColor()  ← 🆕
// │
// └── _buildErrorState()
