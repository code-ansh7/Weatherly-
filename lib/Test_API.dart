import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

final API = "";
// 1. DATA MODEL
class Weather {
  final String cityName;
  final double temperature;
  final String description;
  final String iconCode;

  Weather({
    required this.cityName,
    required this.temperature,
    required this.description,
    required this.iconCode,
  });

  factory Weather.fromJson(Map<String, dynamic> json) {
    return Weather(
      cityName: json['name'] ?? 'Unknown',
      temperature: (json['main']['temp'] as num).toDouble(),
      description: json['weather'][0]['description'],
      iconCode: json['weather'][0]['icon'],
    );
  }
}

// 2. API SERVICE
class WeatherService {
  static const String _apiKey = '';

  static const String _baseUrl =
      'api.openweathermap.org';

  static Future<Weather> fetchWeather(String cityName) async {
    final uri = Uri.https(
      _baseUrl,
      '/data/2.5/weather',
      {
        'q': cityName,
        'appid': _apiKey,
        'units': 'metric',
      },
    );

    final response = await http.get(uri);

    if (response.statusCode == 200) {
      final json = jsonDecode(response.body);

      return Weather.fromJson(json);
    } else if (response.statusCode == 404) {
      throw Exception(
        'City not found. Please try again.',
      );
    } else {
      throw Exception(
        'Error fetching weather data.',
      );
    }
  }
}

// 3. MAIN APP & UI
void main() {
  runApp(const WeatherApp());
}

class WeatherApp extends StatelessWidget {
  const WeatherApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Weather',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorSchemeSeed: Colors.blue,
        useMaterial3: true,
        brightness: Brightness.light,
      ),
      home: const HomeScreen(),
    );
  }
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final TextEditingController _cityController = TextEditingController();
  Weather? _weather;
  bool _isLoading = false;
  String? _errorMessage;

  Future<void> _searchWeather() async {
    final city = _cityController.text.trim();
    if (city.isEmpty) return;

    setState(() {
      _isLoading = true;
      _errorMessage = null;
      _weather = null;
    });

    try {
      final weather = await WeatherService.fetchWeather(city);
      setState(() {
        _weather = weather;
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _errorMessage = e.toString().replaceAll('Exception: ', '');
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Weather App'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            // Search Bar
            TextField(
              controller: _cityController,
              decoration: InputDecoration(
                hintText: 'Enter city name (e.g., Tilhar)',
                prefixIcon: const Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              onSubmitted: (_) => _searchWeather(),
            ),
            const SizedBox(height: 15),
            
            // Search Button
            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                onPressed: _isLoading ? null : _searchWeather,
                icon: const Icon(Icons.cloud_outlined),
                label: const Text('Get Weather'),
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 15),
                ),
              ),
            ),
            const SizedBox(height: 30),

            // Results Area
            Expanded(
              child: _buildContent(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildContent() {
    if (_isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    if (_errorMessage != null) {
      return Center(
        child: Text(
          _errorMessage!,
          style: const TextStyle(color: Colors.red, fontSize: 16),
          textAlign: TextAlign.center,
        ),
      );
    }

    if (_weather != null) {
      return _buildWeatherCard(_weather!);
    }

    return const Center(
      child: Text(
        'Search for a city to see the weather',
        style: TextStyle(fontSize: 16, color: Colors.grey),
      ),
    );
  }

  Widget _buildWeatherCard(Weather weather) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Weather Icon (Fetched from OpenWeatherMap)
            Image.network(
              'https://openweathermap.org/img/wn/${weather.iconCode}@2x.png',
              width: 120,
              height: 120,
            ),
            const SizedBox(height: 10),
            
            // City Name
            Text(
              weather.cityName,
              style: const TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            
            // Temperature
            Text(
              '${weather.temperature.toStringAsFixed(1)}°C',
              style: const TextStyle(fontSize: 48, fontWeight: FontWeight.w300),
            ),
            const SizedBox(height: 10),
            
            // Description
            Text(
              weather.description.toUpperCase(),
              style: const TextStyle(fontSize: 18, color: Colors.grey),
            ),
          ],
        ),
      ),
    );
  }
}

