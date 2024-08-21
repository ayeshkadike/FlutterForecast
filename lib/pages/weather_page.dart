import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:weatherapp/services/weather_service.dart';
import '../models/weather_model.dart'; // Import the Weather model if it's not already imported

class WeatherPage extends StatefulWidget {
  const WeatherPage({super.key}); // Added semicolon

  @override
  State<WeatherPage> createState() => _WeatherPageState();
}

class _WeatherPageState extends State<WeatherPage> {
  final _weatherService = WeatherService('271fdce6c47409e4ed140488b27618c2');
  Weather? _weather;

  _fetchWeather() async {
    String cityName = await _weatherService.getCurrentCity();

    try {
      final weather = await _weatherService.getWeather(cityName);
      setState(() {
        _weather = weather;
      });
    } catch (e) {
      print(e);
    }
  }

  String getWeatherAnimation(String? mainCondition) {
    if (mainCondition == null) return 'assets/sun.json';

    switch (mainCondition.toLowerCase()) {
      case 'clouds':
        return 'assets/clouds.json';
      case 'mist':
        return 'assets/clouds.json';
      case 'smoke':
        return 'assets/fog.json';
      case 'haze':
        return 'assets/fog.json';
      case 'dust':
        return 'assets/fog.json';
      case 'fog':
        return 'assets/fog.json';
      case 'rain':
        return 'assets/rain.json';
      case 'drizzle':
        return 'assets/rain.json';
      case 'shower rain':
        return 'assets/rain.json';
      case 'thunderstorm':
        return 'assets/thunderstorm.json';
      case 'clear':
        return 'assets/sun.json';
      default:
        return 'assets/sun.json';
    }
  }

  @override
  void initState() {
    super.initState();
    _fetchWeather();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[800], // Fixed the background color
      body: Center(
        child: _weather == null
            ? const CircularProgressIndicator() // Display a loading indicator while fetching data
            : Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    _weather?.cityName ?? "Loading City...",
                    style: const TextStyle(color: Colors.white, fontSize: 24),
                  ),
                  Lottie.asset(getWeatherAnimation(_weather?.mainCondition)),
                  Text(
                    '${_weather?.temperature.round()}°C',
                    style: const TextStyle(color: Colors.white, fontSize: 48),
                  ),
                  Text(
                    _weather?.mainCondition ?? "",
                    style: const TextStyle(color: Colors.white, fontSize: 24),
                  ),
                ],
              ),
      ),
    );
  }
}
