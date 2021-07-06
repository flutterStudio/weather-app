class Settings {
  static const Map<int, String> HTTP_REQUEST_STATE_CODE = {
    200: "Ok",
    400: "Bad Request",
    401: "Unauthorized",
    403: "Forbidden",
    404: "Not Found",
    408: "Request Timeout",
    409: "Can not Delete a warehouse that has a product group.",
  };
}

enum WeatherStatus { Clouds, Clear, Haze, Rain, Wind, Snow }

enum ErrorType { network, emptyResponse, other, none }
