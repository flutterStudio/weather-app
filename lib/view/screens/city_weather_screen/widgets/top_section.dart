import 'package:flutter/material.dart';
import 'package:weather_app/model/weather_forecast_model.dart';
import 'package:weather_app/utils/date_time_utils.dart';
import 'package:weather_app/view/widgets/layout/responsive_flex.dart';
import 'package:weather_app/view/widgets/weather_icon.dart';

class WeatherScreenTopSection extends StatelessWidget {
  final List<WeatherForecast> _weather;
  WeatherScreenTopSection({required weather}) : _weather = weather;

  @override
  Widget build(BuildContext context) {
    return ResponsiveFlex(
      onXSm: [1, 1, 1, 4, 1, 4],
      direction: Axis.vertical,
      convertToColumnOnXSm: false,
      children: [
        Text(
          "${DateTimeUtils.formatDate(_weather.elementAt(0).date ?? DateTime.now())}",
          style: TextStyle(
              color: Colors.white, fontSize: 24, fontWeight: FontWeight.w300),
        ),
        Text(
          "Dubai",
          style: TextStyle(
              color: Colors.white, fontSize: 24, fontWeight: FontWeight.w500),
        ),
        Container(),
        WeatherIcon(
          forecast: _weather[0],
          size: 50,
        ),
        Text(
          "${_weather[0].description}",
          style: TextStyle(
              color: Colors.white, fontSize: 18, fontWeight: FontWeight.w200),
        ),
        Text(
          "27",
          style: TextStyle(
              color: Colors.white, fontSize: 80, fontWeight: FontWeight.w400),
        ),
      ],
    );
  }
}
