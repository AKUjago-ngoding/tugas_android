import 'package:dio/dio.dart';
import 'package:flutter_application_2/features/tugas/tugas_14_API_using/models/ghibli_models.dart';
import 'package:flutter_application_2/features/tugas/tugas_14_API_using/services/dio_helper.dart';

class GhibliServices {
  final Dio _dio = createDioClient();

  Future<List<Ghibli>> fetchFilm() async {
    final response = await _dio.get('/films');
    return
      (response.data as List).map((e) => Ghibli.fromJson(e)).toList();
  }
}