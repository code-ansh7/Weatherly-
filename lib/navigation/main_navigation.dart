import 'package:flutter/material.dart';
import 'package:weatherly/screens/home_screen.dart';
import 'package:weatherly/screens/search_screen.dart';
import 'package:weatherly/screens/setting_screen.dart';

class MainNavigation extends StatefulWidget {
  const MainNavigation({super.key});

  @override
  State<MainNavigation> createState() => _MainNavigationState();
}

class _MainNavigationState extends State<MainNavigation> {
  int index = 0;

  @override
  Widget build(BuildContext context) {
    final List<Widget> screens = [
      const HomeScreen(),
      SearchScreen(
        onBack: () {
          setState(() {
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

    // PopScope phone k back button use hone pr,
    // app ko crash nhi hone deta, aur phone ka
    // back button handle jrta hai
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
            selectedItemColor: Colors.cyanAccent,
            unselectedItemColor: Colors.white54,
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
