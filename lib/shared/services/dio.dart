import 'package:dio/dio.dart';
import 'package:zamzam/shared/constants.dart';

class Request {
  static Dio dio = Dio(
    BaseOptions(
      baseUrl: "${Constants.baseUrl}/api/",
      headers: {"Accept": "application/json", "Content-Type": "application/json"},
    ),
  );

  static Future get(String endpoint, {String? token}) async {
    try {
      final options = Options(headers: {
        'Authorization': 'Bearer $token',
      });
      final response = await dio.get(endpoint, options: options);
      return response;
    } on DioException catch (e) {
      return e.response;
    }
  }

  static Future post(String endpoint, data, {String? token}) async {
    try {
      final options = Options(headers: {
        'Authorization': 'Bearer $token',
      });
      final response = await dio.post(endpoint, data: data, options: options);
      return response;
    } on DioException catch (e) {
      return e.response;
    }
  }

  static Future put(String endpoint, data, {String? token}) async {
    try {
      final options = Options(headers: {
        'Authorization': 'Bearer $token',
      });
      final response = await dio.put(endpoint, data: data, options: options);
      return response;
    } on DioException catch (e) {
      return e.response;
    }
  }

  static Future delete(String endpoint, {String? token}) async {
    try {
      final options = Options(headers: {
        'Authorization': 'Bearer $token',
      });
      final response = await dio.delete(endpoint, options: options);
      return response;
    } on DioException catch (e) {
      return e.response;
    }
  }
}
