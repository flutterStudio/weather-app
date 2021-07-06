import 'package:weather_app/common/settings.dart';

class WeatherForecast {
  DateTime? date;
  double? tempreature;
  double? minTempreature;
  double? maxTempreature;
  int? pressure;
  int? humidity;
  int? seaLevel;
  double? windSpeed;
  WeatherStatus? weather;
  String? description;

  WeatherForecast(
      {this.date,
      this.humidity,
      this.pressure,
      this.tempreature,
      this.maxTempreature,
      this.seaLevel,
      this.weather,
      this.windSpeed,
      this.minTempreature,
      this.description});

  WeatherForecast.fromJson(Map<String, dynamic> json) {
    this.date = DateTime.parse(json["dt_txt"]);
    this.tempreature = double.tryParse(json["main"]["temp"].toString());
    this.pressure = json["main"]["pressure"];
    this.humidity = json["main"]["humidity"];
    this.windSpeed = double.tryParse((json["wind"]["speed"].toString()));
    var weatherData = (json["weather"] as List)[0];
    this.description = weatherData["description"];
    this.maxTempreature = double.tryParse(json["main"]["temp_max"].toString());
    this.minTempreature = double.tryParse(json["main"]["temp_min"].toString());
    this.seaLevel = int.tryParse(json["main"]["sea_level"].toString());
    this.weather = _getWeather(weatherData["main"]);
  }

  WeatherStatus? _getWeather(String status) {
    // var elementValue = WeatherStatus.values[0].toString().split('.')[1];
    WeatherStatus? value;
    WeatherStatus.values.forEach((element) {
      if (element.toString().split('.')[1] == status) {
        value = element;
      }
    });

    return value;
  }
}
