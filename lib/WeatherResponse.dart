class WeatherResponse {
  String main, description;
  double temperature;

  WeatherResponse({this.main, this.description, this.temperature});

  factory WeatherResponse.fromJSON(Map<String, dynamic> json) {
    return WeatherResponse(
      main: json['weather'][0]['main'],
      description: json['weather'][0]['description'],
      temperature: json['main']['temp'] - 273,
    );
  }
}
