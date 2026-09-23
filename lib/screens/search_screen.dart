import 'package:flutter/material.dart';
import 'package:weatherly/theme/app_colors.dart';

class SearchScreen extends StatefulWidget {
  final VoidCallback onBack;

  const SearchScreen({super.key, required this.onBack});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
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
                // Header
                Row(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.12),
                        borderRadius: BorderRadius.circular(14),
                      ),

                      child: IconButton(
                        onPressed: widget.onBack,
                        icon: const Icon(Icons.arrow_back, color: AppColors.iconColor),
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
                            color: Colors.white,
                          ),
                        ),
                        Text(
                          "Find weather for any city",
                          style: TextStyle(fontSize: 13, color: Colors.white70),
                        ),
                      ],
                    ),
                  ],
                ),

                const SizedBox(height: 28),

                // Search Box
                TextField(
                  decoration: InputDecoration(
                    hintText: "Search city (e.g. Tilhar)",
                    hintStyle: const TextStyle(color: Colors.white60),

                    prefixIcon: const Icon(
                      Icons.search,
                      color: AppColors.cyan,
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

                const SizedBox(height: 30),

                // Location Heading
                const Text(
                  "Popular Cities",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 19,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                const SizedBox(height: 15),

                // City Cards
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
        print("$cityName Pressed!");
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
            //Location Icon
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

            // City Information 
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  cityName,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 17,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                const SizedBox(height: 4),

                Text(
                  state,
                  style: const TextStyle(color: Colors.white70, fontSize: 13),
                ),
              ],
            ),

            const Spacer(),

            const Icon(
              Icons.arrow_forward_ios,
              color: Colors.white38,
              size: 16,
            ),
          ],
        ),
      ),
    );
  }
}
