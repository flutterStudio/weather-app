import 'package:http/http.dart';
import 'dart:convert';
import 'package:weather_app/common/settings.dart' as appSettings;
import 'package:weather_app/utils/exception.dart';
import 'package:weather_app/utils/extensions.dart';

enum RequestType { GET, POST, DELETE }

class ApiService {
  static final ApiService _instance = ApiService._internal();
  final String baseUrl = "https://api.openweathermap.org/data/2.5/";

  factory ApiService() => _instance;

  ApiService._internal();

  final Client _client = Client();

  Future<String> request(
      {required RequestType requestType,
      required String endPoint,
      Map<String, dynamic>? parameters}) async {
    String urlString = baseUrl +
        endPoint +
        (parameters.isNullOrEmpty() ? "" : _generateOptionsString(parameters));
    Uri url = Uri.parse(urlString);
    switch (requestType) {
      case RequestType.GET:
        return await _processResponse(await _client.get(url));
      case RequestType.POST:
        return await _processResponse(await _client.post(url,
            headers: {
              "Content-Type": "application/json",
              "Access-Control-Allow-Origin": "*",
              "Access-Control-Allow-Methods": "POST, OPTIONS, GET",
            },
            body: json.encode(parameters)));
      case RequestType.DELETE:
        return await _processResponse(await _client.delete(url));
    }
  }

  /// Converts [options] map into a string.
  String _generateOptionsString(Map<String, dynamic>? options) {
    String optionsString = "?";
    options?.forEach((option, value) {
      optionsString += value != null ? "$option=${value.toString()}&" : " ";
    });
    return optionsString.substring(0, optionsString.length - 1);
  }

  Future<String> _processResponse(Response response) async {
    print(response.body);
    switch (response.statusCode) {
      case 200:
        {
          return response.body;
        }
      case 400:
        {
          List errors = json.decode(response.body);
          String message = errors[errors.length - 1];

          throw NetworkException(
              message: message,
              logMessage: appSettings.Settings.HTTP_REQUEST_STATE_CODE[400]);
        }
      case 401:
        {
          throw NetworkException(
            message: appSettings.Settings.HTTP_REQUEST_STATE_CODE[401] ?? "",
          );
        }
      case 403:
        {
          throw NetworkException(
              message: appSettings.Settings.HTTP_REQUEST_STATE_CODE[403] ?? "");
        }
      case 404:
        {
          throw NetworkException(
              message: appSettings.Settings.HTTP_REQUEST_STATE_CODE[404] ?? "");
        }
      case 408:
        {
          throw NetworkException(
              message: appSettings.Settings.HTTP_REQUEST_STATE_CODE[408] ?? "");
        }
      case 409:
        {
          throw DatabaseException(
              message: appSettings.Settings.HTTP_REQUEST_STATE_CODE[409] ?? "");
        }
      default:
        {
          throw NetworkException(message: "Unknown Error");
        }
    }
  }
}
