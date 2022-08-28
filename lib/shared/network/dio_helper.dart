import 'package:dio/dio.dart';

class DioHelper {

  static late Dio dio;

  static init() {
    dio = Dio(
        BaseOptions(
            baseUrl: 'https://www.themealdb.com/api/json/v1/1/',
            receiveDataWhenStatusError: true
        ),
    );
    print('base url is : ${dio.options.baseUrl}');
  }

  static Future<Response> getData({
    required String url,
    query
  })async
  {
    return await dio.get(url,queryParameters: query);
  }
}