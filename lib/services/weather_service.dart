import 'dart:convert';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;

import 'package:weatherly/models/weather_model.dart';

class WeatherService {
  Future<WeatherModel> getWeather(String city) async {
    final apiKey = dotenv.env['OPENWEATHER_API_KEY'];

    final url = Uri.parse(
      'https://api.openweathermap.org/data/2.5/weather'
      '?q=$city'
      '&appid=$apiKey'
      '&units=metric',
    );

    try {
      final response = await http.get(url); // Get request to server

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body); // weather data assigning

        String cityName = data['name'];//City Name

        double temp = data['main']['temp'];
        String temperature = temp.toString();//Temprature

        String humidity = data['main']['humidity'].toString();//Humidity

        double wind = data['wind']['speed'];
        String windSpeed = wind.toString();//Wind Speed

        String condition = data['weather'][0]['main'];//Condition

        String description = data['weather'][0]['description'];//Description

        String pressure = data['main']['pressure'].toString();//Pressure

        double visibilityValue = data['visibility'] / 1000;
        String visibility = visibilityValue.toString();//Visibility

        return WeatherModel(
          cityName: cityName,
          temperature: temperature,
          humidity: humidity,
          windSpeed: windSpeed,
          condition: condition,
          description: description,
          pressure: pressure,
          visibility: visibility,
        );
      }

      if (response.statusCode == 404) {
        throw Exception('City not found');
      }

      if (response.statusCode == 401) {
        throw Exception('Invalid API key');
      }

      if (response.statusCode == 429) {
        throw Exception('Too many requests');
      }

      if (response.statusCode == 500) {
        throw Exception('Weather server error');
      }

      throw Exception('Unable to fetch weather');
    } catch (e) {
      rethrow;
    }
  }
}



// Complete flow of (Weatherly -> Server -> Weatherly)

// OpenWeather API
//       ↓
// response.body
//       ↓
// jsonDecode()
//       ↓
// data
//       ↓
// data['main']['temp']
// data['main']['humidity']
// data['wind']['speed']
// ...
//       ↓
// Variables
//       ↓
// WeatherModel object
//       ↓
// return