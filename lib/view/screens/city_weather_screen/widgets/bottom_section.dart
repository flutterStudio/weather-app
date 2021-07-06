import 'package:flutter/material.dart';
import 'package:weather_app/model/weather_forecast_model.dart';
import 'package:weather_app/view/widgets/weather_status_widget.dart';

class WeatherScreenBottomSection extends StatelessWidget {
  WeatherScreenBottomSection({required weather}) : _weather = weather;
  final List<WeatherForecast> _weather;
  @override
  Widget build(BuildContext context) {
    return OrientationBuilder(
      builder: (context, orientation) => ListView.builder(
        scrollDirection: orientation == Orientation.landscape
            ? Axis.horizontal
            : Axis.vertical,
        itemExtent: MediaQuery.of(context).size.width * 0.2,
        itemBuilder: (context, index) => Padding(
          padding: EdgeInsets.symmetric(
            horizontal: 10,
          ),
          child: WeatherStatusWidget(
            forecast: _weather[index],
            direction: Axis.vertical,
          ),
        ),
        itemCount: _weather.length,
      ),
    );
  }
}
