import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weather_app/bloc/weather_screen_bloc.dart';
import 'package:weather_app/model/weather_forecast_model.dart';
import 'package:weather_app/utils/date_time_utils.dart';
import 'package:weather_app/view/screens/day_weather_screen.dart/widgets/weather_property.dart';

class CityDailyWeather extends StatelessWidget {
  final WeatherForecast _weatherForecast;
  CityDailyWeather({required WeatherForecast weatherForecast})
      : _weatherForecast = weatherForecast;

  @override
  Widget build(BuildContext context) {
    return Consumer<WeatherScreenBloc>(
      builder: (context, bloc, _) => Scaffold(
          appBar: AppBar(
            backgroundColor: Color(0xFF001a31),
            title: Text(
              "Dubai, ${DateTimeUtils.formatDate(_weatherForecast.date ?? DateTime.now())}",
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                  fontWeight: FontWeight.w500),
            ),
          ),
          body: Container(
              padding: EdgeInsets.symmetric(horizontal: 24, vertical: 30),
              decoration: BoxDecoration(
                  gradient: LinearGradient(
                      colors: [
                        Color(0xFF009575),
                        Color(0xFF01414d),
                        Color(0xFF001a31)
                      ],
                      begin: Alignment.bottomCenter,
                      end: Alignment.topCenter,
                      stops: [0, 0.3, 1])),
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    WeatherProperty(
                      property: "Humidity",
                      value: _weatherForecast.humidity.toString(),
                    ),
                    WeatherProperty(
                      property: "Maximum Tempreature",
                      value: _weatherForecast.maxTempreature.toString(),
                    ),
                    WeatherProperty(
                      property: "Minimum Tempreature",
                      value: _weatherForecast.minTempreature.toString(),
                    ),
                    WeatherProperty(
                      property: "Wind Speed",
                      value: _weatherForecast.windSpeed.toString(),
                    ),
                    WeatherProperty(
                      property: "pressure",
                      value: _weatherForecast.pressure.toString(),
                    ),
                    WeatherProperty(
                      property: "Sea Level",
                      value: _weatherForecast.seaLevel.toString(),
                    )
                  ]))),
    );
  }
}
