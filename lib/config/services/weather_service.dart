// static import 'package:dio/dio.dart';

// Future<Standing> getStanding(String code) async {
//     final dio = Dio();
//     DateTime now = DateTime.now();
//     int currentYear = now.year;

//     try {
//       final response = await dio.get(
//           'https://api-footballdata-goldenfutbol-production.up.railway.app/competition/standing/${code}');

//       return Standing.fromMap((response.data));
//     } catch (e) {
//       throw Exception(e);
//     }
//   }