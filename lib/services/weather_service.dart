import 'dart:convert';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:weatherly/models/weather_model.dart';

class WeatherService {
  Future<WeatherModel> getWeather(String city) async {
    final apiKey = dotenv.env['OPENWEATHER_API_KEY'];

    final url = Uri.parse(
      // Convert URL in URI
      'https://api.openweathermap.org/data/2.5/weather'
      '?q=$city'
      '&appid=$apiKey'
      '&units=metric',
    );

    final response = await http.get(url); // GET Request to server

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);

      return WeatherModel.fromJson(data);
    } else if (response.statusCode == 404) {
      throw Exception('City not found');
    } else if (response.statusCode == 401) {
      throw Exception('Invalid API Key');
    } else if (response.statusCode == 429) {
      throw Exception('Too many requests! Please try again later!');
    } else if (response.statusCode == 500) {
      throw Exception('Internet Server Error');
    } else {
      throw Exception('Unable to fetch weather');
    }
  }
}
