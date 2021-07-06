import 'dart:convert';
import 'dart:developer';

import 'package:flutter/foundation.dart';
import 'package:weather_app/model/data.dart';
import 'package:weather_app/model/weather_forecast_model.dart';
import 'package:weather_app/services/api_service.dart';
import 'package:weather_app/utils/exception.dart';

class MainRepository {
  static MainRepository _istance = MainRepository._internal();

  MainRepository._internal();

  factory MainRepository.instance() => _istance;

  List<WeatherForecast> _weatherForecast = [];
  Future<Data<List<WeatherForecast>>> getCityWeather(int id) async {
    try {
      String response = await ApiService().request(
          requestType: RequestType.GET,
          endPoint: 'forecast',
          parameters: {"id": id, "appid": "3db8f2ad11423f578f1411921ef90de0"});
      var responseList = jsonDecode(response)["list"] as List;
      if (responseList.length == 0) {
        return Data.empty(initialData: _weatherForecast);
      }
      List<WeatherForecast> projects =
          await compute<List<dynamic>, List<WeatherForecast>>(
              _parseWeatherData, responseList);

      _weatherForecast = projects;
      return Data.succeed(data: _weatherForecast);
    } on NetworkException catch (e) {
      return Data.faild(message: e.info, previousData: _weatherForecast);
    } catch (e) {
      log(e.toString());
      return Data.faild(
          message: "Error occured.", previousData: _weatherForecast);
    }
  }

  static List<WeatherForecast> _parseWeatherData(List<dynamic> response) {
    return response.map((e) => WeatherForecast.fromJson(e)).toList();
  }
}
