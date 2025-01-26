import 'package:dio/dio.dart';
import 'package:flutter_with_bloc/constants/string.dart';

class CharactersApi {
  late Dio dio;

  CharactersApi() {
    BaseOptions options = BaseOptions(
      baseUrl: baseUrl,
      receiveDataWhenStatusError: true,
      connectTimeout: Duration(seconds: 30), // 30 seconds
      receiveTimeout: Duration(seconds: 30), // 30 seconds
    );
    dio = Dio(options);
  }

  Future<List<dynamic>> getCharacters() async {
    try {
      Response response = await dio.get('character');
      return response.data['results'];
    } catch (error, stacktrace) {
      print("Exception occured: $error stackTrace: $stacktrace");
      return [];
    }
  }
}
