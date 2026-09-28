import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:weatherly/screens/weather_details_screen.dart';
import 'package:weatherly/theme/app_colors.dart';
import 'package:weatherly/widgets/weather_stat.dart';
import 'package:weatherly/models/weather_model.dart';
import 'package:weatherly/services/weather_service.dart';

class HomeScreen extends StatefulWidget {
  final WeatherModel? selectedWeather;
  final VoidCallback onSearchTap;

  const HomeScreen({
    super.key,
    this.selectedWeather,
    required this.onSearchTap,
  });

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final TextEditingController cityController = TextEditingController();

  final WeatherService weatherService = WeatherService();

  WeatherModel? weather;

  bool isLoading = true;
  String? errorMessage;
  String currentCity = "Tilhar";

  @override
  void initState() {
    super.initState();

    if (widget.selectedWeather != null) {
      weather = widget.selectedWeather;
      currentCity = widget.selectedWeather!.cityName;
      isLoading = false;
    } else {
      loadWeather("Tilhar");
    }
  }

  @override
  void didUpdateWidget(covariant HomeScreen oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (widget.selectedWeather != null &&
        widget.selectedWeather != oldWidget.selectedWeather) {
      setState(() {
        weather = widget.selectedWeather;
        currentCity = widget.selectedWeather!.cityName;
        isLoading = false;
        errorMessage = null;
      });
    }
  }

  Future<void> loadWeather(String city) async {
    try {
      currentCity = city;

      setState(() {
        isLoading = true;
        errorMessage = null;
      });

      final result = await weatherService.getWeather(city);

      if (!mounted) {
        return;
      }

      setState(() {
        weather = result;
        isLoading = false;
      });
    } catch (e) {
      if (!mounted) {
        return;
      }

      setState(() {
        isLoading = false;
        errorMessage = e.toString();
      });
    }
  }

  String cleanTemperature(String temperature) {
    double value = double.parse(temperature);

    return value.toStringAsFixed(0);
  }

  String cleanWind(String windSpeed) {
    double value = double.parse(windSpeed);

    return value.toStringAsFixed(1);
  }

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

  String getCurrentDate() {
    DateTime now = DateTime.now();

    List<String> days = ["Mon", "Tue", "Wed", "Thu", "Fri", "Sat", "Sun"];

    List<String> months = [
      "Jan",
      "Feb",
      "Mar",
      "Apr",
      "May",
      "Jun",
      "Jul",
      "Aug",
      "Sep",
      "Oct",
      "Nov",
      "Dec",
    ];

    String day = days[now.weekday - 1];
    String month = months[now.month - 1];

    return "$day, ${now.day} $month";
  }

  String getWeatherCondition(String condition) {
    if (condition == "Clear") {
      return "Clear Sky";
    }

    if (condition == "Clouds") {
      return "Cloudy";
    }

    if (condition == "Rain") {
      return "Rainy";
    }

    if (condition == "Drizzle") {
      return "Light Drizzle";
    }

    if (condition == "Thunderstorm") {
      return "Thunderstorm";
    }

    if (condition == "Snow") {
      return "Snowy";
    }

    if (condition == "Mist") {
      return "Misty";
    }

    if (condition == "Fog") {
      return "Foggy";
    }

    if (condition == "Haze") {
      return "Hazy";
    }

    return condition;
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
            child: getWeatherUI(),
          ),
        ),
      ),
    );
  }

  Widget getWeatherUI() {
    if (isLoading) {
      return SizedBox(
        height: 700,
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: const [
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
      return _buildErrorState();
    }

    return buildWeatherUI();
  }

  Widget buildWeatherUI() {
    return Column(
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

        GestureDetector(
          onTap: widget.onSearchTap,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 15),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.12),
              borderRadius: BorderRadius.circular(15),
            ),
            child: const Row(
              children: [
                Icon(Icons.search, color: Colors.cyanAccent),
                SizedBox(width: 12),
                Text(
                  "Search city...",
                  style: TextStyle(color: Colors.white70, fontSize: 16),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 22),

        GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => WeatherDetailsScreen(
                  weather: weather!,
                ),
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
                            weather!.cityName,
                            style: const TextStyle(
                              fontSize: 25,
                              fontWeight: FontWeight.bold,
                              color: AppColors.primaryText,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            getCurrentDate(),
                            style: const TextStyle(
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
                                  WeatherDetailsScreen(
                                    weather: weather!,
                                  ),
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
                            "${cleanTemperature(weather!.temperature)}°C",
                            style: const TextStyle(
                              fontSize: 52,
                              fontWeight: FontWeight.bold,
                              color: AppColors.primaryText,
                            ),
                          ),
                        ],
                      ),
                      Text(
                        getWeatherCondition(weather!.condition),
                        textAlign: TextAlign.left,
                        style: const TextStyle(
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
          onTap: () {
            loadWeather(currentCity);
          },
          child: Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: [AppColors.cardDarkBlue, AppColors.cardBlue],
                begin: Alignment.topRight,
                end: Alignment.bottomLeft,
              ),
              borderRadius: BorderRadius.circular(20),
            ),
            child: const Center(
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
            onPressed: () {
              loadWeather(currentCity);
            },
            icon: const Icon(Icons.refresh),
            label: const Text("Try Again"),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    cityController.dispose();
    super.dispose();
  }
}

/*
====================================================================
🏠 WEATHERLY — HOME SCREEN ARCHITECTURE
====================================================================

HomeScreen ka main kaam:
→ Weather data ko screen par display karna.
→ Loading state dikhana.
→ Error state dikhana.
→ Current city ka weather refresh karna.


--------------------------------------------------------------------
🌤️ 1. APP FIRST TIME HOME PAR AATA HAI
--------------------------------------------------------------------

MainNavigation
      ↓
HomeScreen
      ↓
initState()
      ↓
Kya SearchScreen se koi weather mila?
      ↓
   ┌───────────────┐
   │               │
  NO              YES
   │               │
   ↓               ↓
Tilhar ka       received weather
weather API     ko use karo
se lao
   │               │
   └───────┬───────┘
           ↓
      WeatherModel
           ↓
      Home UI


Agar selectedWeather null hai:
→ Home khud "Tilhar" ka weather API se fetch karta hai.


Agar selectedWeather available hai:
→ Home API ko dobara call nahi karta.
→ SearchScreen se mila weather directly show karta hai.


--------------------------------------------------------------------
🌐 2. HOME WEATHER API FLOW
--------------------------------------------------------------------

loadWeather("Tilhar")
        ↓
WeatherService
        ↓
OpenWeather API
        ↓
JSON Response
        ↓
WeatherModel
        ↓
weather = result
        ↓
isLoading = false
        ↓
Home Weather UI


HomeScreen khud API ka complicated kaam nahi karta.

WeatherService:
→ API call karta hai.

WeatherModel:
→ API data ko ek object mein rakhta hai.

HomeScreen:
→ Data ko screen par display karta hai.


--------------------------------------------------------------------
🔄 3. SEARCHSCREEN SE WEATHER AANE PAR
--------------------------------------------------------------------

SearchScreen
      ↓
User "Mumbai" search karta hai
      ↓
API call
      ↓
Mumbai ka WeatherModel
      ↓
MainNavigation
      ↓
selectedWeather
      ↓
HomeScreen
      ↓
didUpdateWidget()
      ↓
weather = selectedWeather
      ↓
Home UI Mumbai ka weather show karta hai.


Important:

HomeScreen SearchScreen ko directly call nahi karta.

HomeScreen ko sirf MainNavigation ke through
selectedWeather milta hai.


--------------------------------------------------------------------
🔄 4. REFRESH WEATHER
--------------------------------------------------------------------

User "Refresh Weather" press karta hai
             ↓
loadWeather(currentCity)
             ↓
WeatherService
             ↓
API
             ↓
Fresh WeatherModel
             ↓
weather update
             ↓
UI update


--------------------------------------------------------------------
🎨 5. HOME UI STATES
--------------------------------------------------------------------

HomeScreen ke paas mainly 3 states hain:


1️⃣ LOADING

isLoading == true

        ↓

"CircularProgressIndicator"
"Fetching weather..."


2️⃣ ERROR

errorMessage != null

        ↓

"Unable to load weather"
"Try Again"


3️⃣ SUCCESS

Loading false
AND
errorMessage null

        ↓

Real Weather UI


--------------------------------------------------------------------
📦 IMPORTANT VARIABLES
--------------------------------------------------------------------

weather

→ HomeScreen par currently displayed weather.


selectedWeather

→ MainNavigation se HomeScreen ko mila weather.


weatherService

→ API se weather data fetch karne wala service.


currentCity

→ Abhi Home par jis city ka weather loaded hai.


isLoading

→ API request chal rahi hai ya nahi.


errorMessage

→ API request fail hone par error store karta hai.


--------------------------------------------------------------------
🧠 HOME SCREEN KA SIMPLE RULE
--------------------------------------------------------------------

HomeScreen ka kaam:

"Weather lana + Weather dikhana"

API ka main kaam:
→ WeatherService

Data ka container:
→ WeatherModel

Screens ke beech data bhejna:
→ MainNavigation


====================================================================
*/
