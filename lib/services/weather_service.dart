import 'dart:convert';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;

class WeatherService {
  Future<Map<String, dynamic>> getWeather(String city) async {
    final apiKey = dotenv.env['OPENWEATHER_API_KEY'];

    final url = Uri.parse(
      'https://api.openweathermap.org/data/2.5/weather'
      '?q=$city'
      '&appid=$apiKey'
      '&units=metric',
    );

    final response = await http.get(url);

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else if (response.statusCode == 404) {
      throw Exception('City not found');
    } else {
      throw Exception('Something went wrong');
    }
  }
}