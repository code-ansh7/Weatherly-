import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:weatherly/screens/search_screen.dart';
import 'package:weatherly/screens/setting_screen.dart';
import 'package:weatherly/screens/weather_details_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int index = 0;

  @override
  Widget build(BuildContext context) {
    final List<Widget> screens = [
      homeBody(),
      const SearchScreen(),
      const SettingsScreen(),
    ];

    return Scaffold(
      backgroundColor: const Color(0xFF061B33),

      // Home AppBar sirf Home tab par
      appBar: index == 0
          ? AppBar(
              elevation: 0,
              backgroundColor: const Color(0xFF2B4868),
              // shape: const RoundedRectangleBorder(
              //   borderRadius: BorderRadius.only(
              //     bottomLeft: Radius.circular(25),
              //     bottomRight: Radius.circular(25),
              //   ),
              // ),

              leading: IconButton(
                onPressed: () {},
                icon: const Icon(Icons.menu, color: Colors.white, size: 24),
              ),

              actions: [
                Padding(
                  padding: const EdgeInsets.only(right: 20),
                  child: CircleAvatar(
                    radius: 20,
                    backgroundColor: const Color(0xFF163A5F),
                    child: const Icon(Icons.person, color: Colors.white),
                  ),
                ),
              ],
            )
          : null,

      // Selected Screen
      body: screens[index],

      // Bottom Navigation
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

          selectedItemColor: Colors.cyanAccent,
          unselectedItemColor: Colors.white54,

          selectedFontSize: 12,
          unselectedFontSize: 11,

          selectedLabelStyle: const TextStyle(fontWeight: FontWeight.bold),

          unselectedLabelStyle: const TextStyle(fontWeight: FontWeight.normal),

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
          colors: [Color(0xFF061B33), Color(0xFF0D4773), Color(0xFF123E63)],
        ),
      ),

      child: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20),

            child: Column(
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
                        color: Colors.white,
                        height: 1.2,
                      ),
                    ),

                    SizedBox(height: 4),

                    Text(
                      "Check the weather around you...",
                      style: TextStyle(fontSize: 14, color: Colors.white70),
                    ),
                  ],
                ),

                const SizedBox(height: 20),

                // Search Box
                TextField(
                  decoration: InputDecoration(
                    hintText: "Search city (e.g. Tilhar)",
                    hintStyle: const TextStyle(color: Colors.white60),

                    prefixIcon: const Icon(
                      Icons.search,
                      color: Colors.cyanAccent,
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
                        color: Colors.cyanAccent,
                        width: 1.5,
                      ),
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
                    height: 300,

                    decoration: BoxDecoration(
                      gradient: const LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,

                        colors: [Color(0xFF548BC3), Color(0xFF163A5F)],
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
                              const Column(
                                crossAxisAlignment: CrossAxisAlignment.start,

                                children: [
                                  Text(
                                    "Tilhar",
                                    style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                    ),
                                  ),

                                  SizedBox(height: 4),

                                  Text(
                                    "Sun, 20 Sep",
                                    style: TextStyle(
                                      fontSize: 13,
                                      color: Colors.white70,
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
                                          WeatherDetailsScreen(),
                                    ),
                                  );
                                },

                                icon: const Icon(
                                  Icons.more_horiz_rounded,
                                  color: Colors.white70,
                                  size: 24,
                                ),
                              ),
                            ],
                          ),

                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,

                            children: [
                              const Icon(
                                Icons.wb_sunny,
                                size: 65,
                                color: Color(0xFFFFC107),
                              ),

                              const SizedBox(width: 20),

                              Text(
                                "32°C",
                                style: TextStyle(
                                  fontSize: 52,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                            ],
                          ),

                          Text(
                            "Sunny",
                            textAlign: TextAlign.left,
                            style: TextStyle(fontSize: 25, color: Colors.white),
                          ),

                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,

                            children: [
                              // HUMIDITY
                              Row(
                                children: [
                                  const Icon(
                                    Icons.water_drop,
                                    size: 22,
                                    color: Color(0xFF29B6F6),
                                  ),

                                  const SizedBox(width: 8),

                                  const Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,

                                    children: [
                                      Text(
                                        "Humidity",
                                        style: TextStyle(
                                          fontSize: 11,
                                          color: Colors.white70,
                                        ),
                                      ),

                                      Text(
                                        "45%",
                                        style: TextStyle(
                                          fontSize: 15,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),

                              // WIND
                              Row(
                                children: [
                                  const Icon(
                                    Icons.air,
                                    size: 22,
                                    color: Color(0xFF00E5FF),
                                  ),

                                  const SizedBox(width: 8),

                                  const Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,

                                    children: [
                                      Text(
                                        "Wind",
                                        style: TextStyle(
                                          fontSize: 11,
                                          color: Colors.white70,
                                        ),
                                      ),

                                      Text(
                                        "12 km/h",
                                        style: TextStyle(
                                          fontSize: 15,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ],
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

                const SizedBox(height: 20),

                //For Future...
              ],
            ),
          ),
        ),
      ),
    );
  }
}
