import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weather_app/bloc/weather_screen_bloc.dart';
import 'package:weather_app/model/weather_forecast_model.dart';
import 'package:weather_app/view/screens/city_weather_screen/widgets/bottom_section.dart';
import 'package:weather_app/view/screens/city_weather_screen/widgets/top_section.dart';
import 'package:weather_app/view/widgets/layout/responsive_flex.dart';
import 'package:weather_app/view/widgets/request_handler.dart';

class CityWeatherScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Material(
        child: Consumer<WeatherScreenBloc>(
      builder: (context, bloc, _) => Container(
        child: RequestHandler<List<WeatherForecast>>(
            main: Container(),
            stream: bloc.dataStream,
            onSuccess: (context, data) {
              return ResponsiveFlex(
                  axisOnBreakPoint: [
                    Axis.vertical,
                    Axis.horizontal,
                    Axis.horizontal,
                    Axis.horizontal,
                    Axis.horizontal,
                    Axis.horizontal,
                    Axis.horizontal,
                  ],
                  convertToColumnOnXSm: false,
                  direction: Axis.vertical,
                  onXSm: [1, 5, 2],
                  onSm: [0, 4, 1],
                  children: [
                    Container(),
                    WeatherScreenTopSection(
                      weather: data,
                    ),
                    WeatherScreenBottomSection(
                        weather: data as List<WeatherForecast>),
                  ]);
            }),
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
      ),
    ));
  }
}
