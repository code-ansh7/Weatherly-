import 'package:flutter/material.dart';
import 'package:weatherly/screens/home_screen.dart';
import 'package:weatherly/screens/search_screen.dart';
import 'package:weatherly/screens/setting_screen.dart';
import 'package:weatherly/theme/app_colors.dart';
import 'package:weatherly/models/weather_model.dart';



class MainNavigation extends StatefulWidget {
  const MainNavigation({super.key});

  @override
  State<MainNavigation> createState() => _MainNavigationState();
}

class _MainNavigationState extends State<MainNavigation> {

  int index = 0;

  WeatherModel? selectedWeather;

  @override
  Widget build(BuildContext context) {
    final List<Widget> screens = [
     
      HomeScreen(
        selectedWeather: selectedWeather, //yha pr de diya

        onSearchTap: (){
          setState(() {
            index = 1;
          });
        },

        onSettingsTap: () {
          setState(() {
            index = 2;
          });
        },
      ),
      SearchScreen(
        onBack: () {
          setState(() {
            index = 0;
          });
        },

        onCitySelected: (weather) {
          setState(() {
            // SearchScreen se mila weather MainNavigation mein save karo.
            selectedWeather = weather;

            // Search successful hone ke baad Home par jao.
            index = 0;
          });
        },  
      ),

      SettingsScreen(
        onBack: () {
          setState(() {
            index = 0;
          });
        },
      ),
    ];

    return PopScope(
      canPop: index == 0,

      onPopInvokedWithResult: (didPop, result) {
        if (didPop) {
          return;
        }

        if (index != 0) {
          setState(() {
            index = 0;
          });
        }
      },

      child: Scaffold(
        body: screens[index],

        bottomNavigationBar: Container(
          decoration: BoxDecoration(
            color: const Color(0xFF2B4868),
            border: Border(
              top: BorderSide(color: Colors.white.withOpacity(0.10), width: 1),
            ),
          ),

          child: BottomNavigationBar(
            backgroundColor: Colors.transparent,
            elevation: 0,

            currentIndex: index,

            type: BottomNavigationBarType.fixed,

            selectedItemColor: AppColors.cyan,
            unselectedItemColor: AppColors.secondaryText,

            selectedFontSize: 13,
            unselectedFontSize: 11,

            selectedLabelStyle: const TextStyle(fontWeight: FontWeight.bold),

            unselectedLabelStyle: const TextStyle(
              fontWeight: FontWeight.normal,
            ),

            onTap: (selectedIndex) {
              setState(() {
                index = selectedIndex;
              });
            },

            items: const [
              BottomNavigationBarItem(
                icon: Icon(Icons.home_outlined),
                activeIcon: Icon(Icons.home),
                label: "Home",
              ),

              BottomNavigationBarItem(
                icon: Icon(Icons.search_outlined),
                activeIcon: Icon(Icons.search),
                label: "Search",
              ),

              BottomNavigationBarItem(
                icon: Icon(Icons.settings_outlined),
                activeIcon: Icon(Icons.settings),
                label: "Settings",
              ),
            ],
          ),
        ),
      ),
    );
  }
}





/*
====================================================================
🧭 WEATHERLY — MAIN NAVIGATION ARCHITECTURE
====================================================================

MainNavigation app ke main screens ko control karta hai.

Iska main kaam:

→ Home / Search / Settings ke beech switch karna.
→ Bottom Navigation control karna.
→ SearchScreen se WeatherModel receive karna.
→ Received WeatherModel ko HomeScreen tak pahunchana.
→ Phone ke back button ko handle karna.


====================================================================
📱 1. MAIN SCREENS
====================================================================

                    MainNavigation
                          │
             ┌────────────┼────────────┐
             ↓            ↓            ↓
           Home         Search      Settings
             │            │
             │            │
             │            ↓
             │       Search City
             │            │
             │            ↓
             │       WeatherModel
             │            │
             │            ↓
             └────── MainNavigation
                          │
                          ↓
                     HomeScreen


====================================================================
🔢 2. INDEX VARIABLE
====================================================================

index batata hai ki kaunsa bottom navigation tab active hai.


index = 0
→ Home


index = 1
→ Search


index = 2
→ Settings


Example:

User Search par tap karta hai:

index = 1

        ↓

SearchScreen show


User Home par tap karta hai:

index = 0

        ↓

HomeScreen show


====================================================================
📦 3. SELECTEDWEATHER
====================================================================

WeatherModel? selectedWeather;


Is variable ka main kaam:

SearchScreen se aaye weather ko temporarily
MainNavigation mein store karna.


Example:

User SearchScreen par:

"Mumbai"

search karta hai.

        ↓

SearchScreen
        ↓
API
        ↓
Mumbai WeatherModel
        ↓
onCitySelected(result)
        ↓
MainNavigation
        ↓
selectedWeather = result


Ab:

selectedWeather

ke andar Mumbai ka complete weather data hai.


====================================================================
📤 4. SEARCHSCREEN → MAINNAVIGATION
====================================================================

SearchScreen ko MainNavigation ek callback deta hai:

onCitySelected


SearchScreen successful search ke baad:

widget.onCitySelected(result);


call karta hai.


Iska simple meaning:

"MainNavigation bhai,
weather mil gaya.
Ye WeatherModel tum rakh lo."


====================================================================
🏠 5. MAINNAVIGATION → HOMESCREEN
====================================================================

MainNavigation ke paas:

selectedWeather

available hai.


Ab MainNavigation:

HomeScreen(
    selectedWeather: selectedWeather
)


ke through HomeScreen ko weather deta hai.


Flow:

SearchScreen
      ↓
WeatherModel
      ↓
MainNavigation
      ↓
selectedWeather
      ↓
HomeScreen
      ↓
weather
      ↓
Weather UI


====================================================================
🔄 6. COMPLETE SEARCH FLOW
====================================================================

User Search tab press karta hai
             ↓
        index = 1
             ↓
       SearchScreen
             ↓
     User "Mumbai" type karta hai
             ↓
        searchCity()
             ↓
      WeatherService
             ↓
      OpenWeather API
             ↓
       WeatherModel
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
             ↓
 selectedWeather Home ko mila
             ↓
       Home weather update
             ↓
       Mumbai Weather 🌦️


====================================================================
🌐 7. WEATHER SERVICE KA ROLE
====================================================================

MainNavigation API call nahi karta.

SearchScreen API ka URL handle nahi karta.

HomeScreen bhi API ka actual HTTP logic handle nahi karta.


API ka actual kaam:

WeatherService

karta hai.


Flow:

Home / Search
      ↓
WeatherService
      ↓
OpenWeather API
      ↓
JSON
      ↓
WeatherModel
      ↓
Screen


====================================================================
📦 8. WEATHERMODEL KA ROLE
====================================================================

WeatherModel weather data ka container hai.


Example:

WeatherModel
│
├── cityName
├── temperature
├── humidity
├── windSpeed
├── condition
├── description
├── pressure
└── visibility


Isse hum multiple values ko
ek single object ke form mein pass kar sakte hain.


Example:

SearchScreen
      ↓
WeatherModel
      ↓
MainNavigation
      ↓
HomeScreen


Humein temperature, humidity, wind etc.
alag-alag pass karne ki zarurat nahi.


====================================================================
🔙 9. PHONE BACK BUTTON
====================================================================

Agar user Search ya Settings tab par hai:

Phone Back
     ↓
MainNavigation
     ↓
index = 0
     ↓
Home


Agar user already Home par hai:

index = 0
     ↓
canPop = true
     ↓
Phone ka normal back behavior


====================================================================
🧠 10. MAINNAVIGATION KA SIMPLE RULE
====================================================================

MainNavigation ko app ka "manager" samjho.


Home:
→ Weather display karta hai.


Search:
→ City search karta hai.


Settings:
→ App settings handle karta hai.


MainNavigation:
→ In screens ko connect karta hai.
→ Navigation control karta hai.
→ Search se weather lekar Home ko deta hai.


====================================================================
🌦️ WEATHERLY COMPLETE ARCHITECTURE
====================================================================


                         WEATHERLY
                             │
                             ↓
                     MainNavigation
                             │
              ┌──────────────┼──────────────┐
              ↓              ↓              ↓
            HOME           SEARCH         SETTINGS
              ↑              │
              │              ↓
              │        searchCity()
              │              ↓
              │       WeatherService
              │              ↓
              │       OpenWeather API
              │              ↓
              │        WeatherModel
              │              ↓
              │      onCitySelected()
              │              ↓
              │       MainNavigation
              │              ↓
              │       selectedWeather
              │              ↓
              └──────── HomeScreen


====================================================================
🔥 ONE-LINE MEMORY
====================================================================

WeatherService
→ data laata hai

WeatherModel
→ data rakhta hai

SearchScreen
→ city search karta hai

MainNavigation
→ screens aur data ko connect karta hai

HomeScreen
→ weather display karta hai


====================================================================
*/