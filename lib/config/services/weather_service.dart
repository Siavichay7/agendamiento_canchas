import 'package:dio/dio.dart';

Future<dynamic> getWeather(String date) async {
  final dio = Dio();
  DateTime now = DateTime.now();
  int currentYear = now.year;

  try {
    final response = await dio.get(
        'https://api.weatherapi.com/v1/forecast.json?q=Samborondon&days=1&dt=2024-03-20&key=1d84e781e9bc4d26afc33716242203');
    var cloud = response.data['current']['cloud'].toString();
    return cloud;
  } catch (e) {
    throw Exception(e);
  }
}
