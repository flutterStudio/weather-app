import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weather_app/bloc/weather_screen_bloc.dart';
import 'package:weather_app/view/screens/city_weather_screen/city_weather_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Provider<WeatherScreenBloc>(
      create: (context) => WeatherScreenBloc(),
      child: MaterialApp(
          title: 'Flutter Demo',
          theme: ThemeData(
            primarySwatch: Colors.blue,
          ),
          home: CityWeatherScreen()),
    );
  }
}
