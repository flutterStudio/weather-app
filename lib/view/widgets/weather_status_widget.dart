import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:weather_app/model/weather_forecast_model.dart';
import 'package:weather_app/utils/date_time_utils.dart';
import 'package:weather_app/view/screens/day_weather_screen.dart/day_weather_screen.dart';
import 'package:weather_app/view/widgets/layout/responsive_flex.dart';
import 'package:weather_app/view/widgets/weather_icon.dart';

class WeatherStatusWidget extends StatelessWidget {
  final Axis _direction;
  final WeatherForecast _forecast;

  const WeatherStatusWidget(
      {Key? key,
      Axis direction = Axis.horizontal,
      required WeatherForecast forecast})
      : _direction = direction,
        _forecast = forecast,
        super(key: key);
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) =>
                    CityDailyWeather(weatherForecast: _forecast)));
      },
      child: ResponsiveFlex(
        onXSm: [2, 3, 1, 1, 1, 1],
        onSm: [2, 1, 1, 1, 1, 2],
        direction: _direction,
        children: [
          WeatherIcon(
            size: 36,
            forecast: _forecast,
          ),
          Container(
            height: 20,
          ),
          Text(
            "${DateTimeUtils.abbrevDayName(_forecast.date!.day) ?? '  '} ",
            style: TextStyle(
                color: Colors.white, fontSize: 14, fontWeight: FontWeight.w200),
          ),
          Text(
            "${_forecast.maxTempreature}",
            style: TextStyle(
                color: Colors.white, fontSize: 14, fontWeight: FontWeight.w200),
          ),
          Text(
            "${_forecast.minTempreature}",
            style: TextStyle(
                color: Colors.white, fontSize: 14, fontWeight: FontWeight.w200),
          ),
          Container()
        ],
      ),
    );
  }
}
