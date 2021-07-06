import 'package:rxdart/rxdart.dart';
import 'package:weather_app/bloc/bloc.dart';
import 'package:weather_app/model/data.dart';
import 'package:weather_app/model/weather_forecast_model.dart';
import 'package:weather_app/repository/main_repo.dart';

class WeatherScreenBloc implements BLOC {
  final PublishSubject<Data<List<WeatherForecast>>> _dataStreamController =
      PublishSubject();
  final int dubaiCityId = 292223;

  Data<List<WeatherForecast>>? _weatherForecast;

  WeatherScreenBloc() {
    getWeatherData();
  }
  Stream<Data<List<WeatherForecast>>> get dataStream =>
      _dataStreamController.stream;

  Future<void> getWeatherData() async {
    _dataStreamController.sink.add(Data.inProgress());

    Data<List<WeatherForecast>> forecast =
        await MainRepository.instance().getCityWeather(dubaiCityId);
    if (forecast.hasData && forecast.status == DataStatus.succeed) {
      _weatherForecast = forecast;
    }

    _dataStreamController.sink.add(_weatherForecast ?? Data.empty());
  }

  @override
  void dispose() {
    _dataStreamController.close();
  }
}
