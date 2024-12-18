import 'package:dio/dio.dart';

import 'endpoints.dart';

class ApiService {
  final Dio _dio = Dio();

  Future fetchHotels() async {
    try {
      final response = await _dio.get(AppEndpoints.hotelList);
      return response.data['properties'];
    } catch (e) {
      throw Exception('Failed to fetch hotels');
    }
  }
}
