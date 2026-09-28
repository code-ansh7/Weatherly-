import 'package:flutter/material.dart';
import 'package:weatherly/theme/app_colors.dart';
import 'package:weatherly/models/weather_model.dart';
import 'package:weatherly/services/weather_service.dart';

class SearchScreen extends StatefulWidget {
  final VoidCallback onBack;
  final ValueChanged<WeatherModel> onCitySelected;

  const SearchScreen({
    super.key,
    required this.onBack,
    required this.onCitySelected,
  });

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final WeatherService weatherService = WeatherService();

  final TextEditingController cityController = TextEditingController();

  WeatherModel? weather;

  bool isLoading = false;
  String? errorMessage;

  // @override
  // void initState() {
  //   super.initState();

  //   Future.delayed(const Duration(milliseconds: 300), () {
  //     FocusScope.of(context).requestFocus();
  //   });
  // }

  Future<void> searchCity(String city) async {
    if (city.trim().isEmpty) {
      return;
    }

    setState(() {
      isLoading = true;
      errorMessage = null;
    });

    try {
      final result = await weatherService.getWeather(city.trim());

      if (!mounted) {
        return;
      }

      setState(() {
        weather = result;
        isLoading = false;
      });

      widget.onCitySelected(result);
    } catch (e) {
      if (!mounted) {
        return;
      }

      String message = "Something went wrong. Please try again.";

      if (e.toString().contains("City not found")) {
        message = "City not found. Please check the city name.";
      }

      if (e.toString().contains("Invalid API key")) {
        message = "Weather service is unavailable right now.";
      }

      if (e.toString().contains("Too many requests")) {
        message = "Too many requests. Please try again later.";
      }

      if (e.toString().contains("Weather server error")) {
        message = "Weather server is unavailable. Please try again.";
      }

      setState(() {
        isLoading = false;
        errorMessage = message;
      });
    }
  }

  @override
  void dispose() {
    cityController.dispose();
    super.dispose();
  }

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
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),

            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,

              children: [
                Row(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.12),
                        borderRadius: BorderRadius.circular(14),
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
                          "Search City",

                          style: TextStyle(
                            fontSize: 27,
                            fontWeight: FontWeight.bold,
                            color: AppColors.primaryText,
                          ),
                        ),

                        Text(
                          "Find weather for any city",

                          style: TextStyle(
                            fontSize: 13,
                            color: AppColors.secondaryText,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),

                const SizedBox(height: 28),

                TextField(
                  autofocus: true,
                  controller: cityController,

                  style: const TextStyle(
                    color: AppColors.primaryText,
                    fontSize: 16,
                  ),

                  textInputAction: TextInputAction.search,

                  onSubmitted: (value) {
                    searchCity(value);
                  },

                  decoration: InputDecoration(
                    hintText: "Search city (e.g. Tilhar)",

                    hintStyle: const TextStyle(color: AppColors.secondaryText),

                    prefixIcon: const Icon(
                      Icons.search,
                      color: AppColors.primaryText,
                    ),

                    filled: true,

                    fillColor: Colors.white.withOpacity(0.12),

                    contentPadding: const EdgeInsets.symmetric(vertical: 17),

                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(18),
                      borderSide: BorderSide.none,
                    ),

                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(18),
                      borderSide: BorderSide(
                        color: Colors.white.withOpacity(0.15),
                      ),
                    ),

                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(18),
                      borderSide: const BorderSide(
                        color: AppColors.cyan,
                        width: 1.5,
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 20),

                if (isLoading)
                  const Center(
                    child: Padding(
                      padding: EdgeInsets.all(20),

                      child: CircularProgressIndicator(color: AppColors.cyan),
                    ),
                  ),

                if (errorMessage != null)
                  Container(
                    width: double.infinity,

                    padding: const EdgeInsets.all(16),

                    decoration: BoxDecoration(
                      color: Colors.red.withOpacity(0.20),

                      borderRadius: BorderRadius.circular(16),

                      border: Border.all(color: Colors.red.withOpacity(0.3)),
                    ),

                    child: Column(
                      children: [
                        const Icon(
                          Icons.location_off_outlined,
                          color: Colors.white70,
                          size: 35,
                        ),

                        const SizedBox(height: 8),

                        Text(
                          errorMessage!,
                          textAlign: TextAlign.center,

                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 14,
                          ),
                        ),

                        const SizedBox(height: 12),

                        ElevatedButton.icon(
                          onPressed: () {
                            searchCity(cityController.text);
                          },

                          icon: const Icon(Icons.refresh),

                          label: const Text("Try Again"),
                        ),
                      ],
                    ),
                  ),

                const SizedBox(height: 10),

                const Text(
                  "Popular Cities",

                  style: TextStyle(
                    color: AppColors.primaryText,
                    fontSize: 19,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                const SizedBox(height: 15),

                cityCard("Tilhar", "Shahjahanpur, Uttar Pradesh"),

                cityCard("Bareilly", "Uttar Pradesh, India"),

                cityCard("New Delhi", "Delhi, India"),

                cityCard("Mumbai", "Maharashtra, India"),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget cityCard(String cityName, String state) {
    return InkWell(
      borderRadius: BorderRadius.circular(18),

      onTap: () {
        cityController.text = cityName;

        searchCity(cityName);
      },

      child: Container(
        width: double.infinity,

        margin: const EdgeInsets.only(bottom: 12),

        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),

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
                Icons.location_on_outlined,
                color: AppColors.cyan,
                size: 24,
              ),
            ),

            const SizedBox(width: 15),

            Column(
              crossAxisAlignment: CrossAxisAlignment.start,

              children: [
                Text(
                  cityName,

                  style: const TextStyle(
                    color: AppColors.primaryText,
                    fontSize: 17,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                const SizedBox(height: 4),

                Text(
                  state,

                  style: const TextStyle(
                    color: AppColors.secondaryText,
                    fontSize: 13,
                  ),
                ),
              ],
            ),

            const Spacer(),

            const Icon(
              Icons.arrow_forward_ios,
              color: AppColors.primaryText,
              size: 16,
            ),
          ],
        ),
      ),
    );
  }
}

/*
====================================================================
🔎 WEATHERLY — SEARCH SCREEN ARCHITECTURE
====================================================================

SearchScreen ka main kaam:

→ User se city ka naam lena.
→ API se us city ka weather fetch karna.
→ Loading dikhana.
→ Error handle karna.
→ Successful WeatherModel ko MainNavigation ko dena.


--------------------------------------------------------------------
🔍 1. USER CITY SEARCH KARTA HAI
--------------------------------------------------------------------

User Search Box mein:

" Mumbai "

type karta hai.

        ↓

TextField
        ↓
searchCity("Mumbai")
        ↓
WeatherService
        ↓
OpenWeather API


--------------------------------------------------------------------
🌐 2. API RESPONSE
--------------------------------------------------------------------

OpenWeather API
        ↓
JSON Response
        ↓
WeatherService
        ↓
WeatherModel


WeatherModel ke andar example:

cityName
temperature
humidity
windSpeed
condition
description
pressure
visibility


--------------------------------------------------------------------
📦 3. RESULT SEARCHSCREEN MEIN AATA HAI
--------------------------------------------------------------------

API se result aane ke baad:

weather = result

Iska matlab:

SearchScreen ke paas ab searched city ka
WeatherModel available hai.


Example:

weather
  ↓
Mumbai
32°C
70% Humidity
4.2 m/s Wind
Clouds


--------------------------------------------------------------------
📤 4. SEARCHSCREEN WEATHER KO HOME TAK KAISE BHEJTA HAI?
--------------------------------------------------------------------

SearchScreen directly HomeScreen ko nahi jaanta.

Instead:

SearchScreen
      ↓
onCitySelected(result)
      ↓
MainNavigation


"onCitySelected" ek callback/function hai.

Simple language mein:

SearchScreen bolta hai:

"MainNavigation bhai,
mujhe Mumbai ka weather mil gaya.
Ye lo WeatherModel."


--------------------------------------------------------------------
🔄 5. MAINNAVIGATION KE PAAS WEATHER JAATA HAI
--------------------------------------------------------------------

SearchScreen
      ↓
onCitySelected(result)
      ↓
MainNavigation
      ↓
selectedWeather = result
      ↓
index = 0
      ↓
HomeScreen


index = 0 ka matlab:

Home tab open karo.


--------------------------------------------------------------------
🏠 6. HOME SCREEN PAR WEATHER KAISE PAHUNCHTA HAI?
--------------------------------------------------------------------

MainNavigation:

selectedWeather
      ↓
HomeScreen(
    selectedWeather: selectedWeather
)


HomeScreen ko selectedWeather milta hai.

HomeScreen:

weather = selectedWeather

      ↓

Home UI new city ka weather show karta hai.


--------------------------------------------------------------------
❌ 7. AGAR CITY GALAT HO
--------------------------------------------------------------------

User:

"xyz123"

        ↓

API request
        ↓
City not found
        ↓
catch()
        ↓
errorMessage
        ↓
Error UI


SearchScreen close nahi hota.

User same search box mein
new city search kar sakta hai.


--------------------------------------------------------------------
⏳ 8. LOADING STATE
--------------------------------------------------------------------

Search start:

isLoading = true

        ↓

CircularProgressIndicator


API response:

isLoading = false


        ↓

Weather UI / Error UI


--------------------------------------------------------------------
🏙️ 9. POPULAR CITY CARDS
--------------------------------------------------------------------

User:

Tilhar
Bareilly
New Delhi
Mumbai

mein se kisi city card par tap karta hai.

        ↓

cityController.text = cityName
        ↓
searchCity(cityName)
        ↓
API
        ↓
WeatherModel
        ↓
onCitySelected()
        ↓
MainNavigation
        ↓
Home


--------------------------------------------------------------------
📦 IMPORTANT VARIABLES
--------------------------------------------------------------------

cityController

→ Search box mein user kya type kar raha hai
  usko control karta hai.


weather

→ Search ki hui city ka weather temporarily rakhta hai.


isLoading

→ API request chal rahi hai ya nahi.


errorMessage

→ Search fail hone par error message rakhta hai.


onBack

→ SearchScreen se Home tab par wapas jaane ka callback.


onCitySelected

→ SearchScreen se WeatherModel ko
  MainNavigation tak bhejne ka callback.


weatherService

→ OpenWeather API se data fetch karta hai.


--------------------------------------------------------------------
🧠 SEARCH SCREEN KA SIMPLE RULE
--------------------------------------------------------------------

SearchScreen ka kaam:

"City search karo → WeatherModel banao/receive karo
→ MainNavigation ko bhejo."

SearchScreen ka kaam HomeScreen ko directly control karna nahi hai.


====================================================================
*/
