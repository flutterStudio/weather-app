import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:weather_app/common/settings.dart';
import 'package:weather_app/model/weather_forecast_model.dart';

class WeatherIcon extends StatelessWidget {
  final WeatherForecast _forecast;
  final double size;

  const WeatherIcon(
      {Key? key, required WeatherForecast forecast, required this.size})
      : _forecast = forecast,
        super(key: key);
  @override
  Widget build(BuildContext context) {
    return Icon(
      _getIcon(),
      size: size,
      color: Colors.white,
    );
  }

  IconData? _getIcon() {
    if (_forecast.weather == null) {
      return null;
    }
    bool isDay = _forecast.date!.hour < 12 && _forecast.date!.hour > 0;

    switch (_forecast.weather) {
      case WeatherStatus.Clear:
        {
          return isDay ? Icons.wb_sunny_outlined : FontAwesomeIcons.moon;
        }
      case WeatherStatus.Clouds:
        {
          return isDay ? FontAwesomeIcons.cloudSun : FontAwesomeIcons.cloudMoon;
        }
      case WeatherStatus.Haze:
        {
          return FontAwesomeIcons.smog;
        }
      case WeatherStatus.Rain:
        {
          return isDay
              ? FontAwesomeIcons.cloudSunRain
              : FontAwesomeIcons.cloudMoonRain;
        }
      case WeatherStatus.Wind:
        {
          return FontAwesomeIcons.wind;
        }
      case WeatherStatus.Snow:
        {
          return FontAwesomeIcons.snowflake;
        }
      default:
        return FontAwesomeIcons.broadcastTower;
    }
  }
}
