import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/user_model.dart';
import '../models/absen_model.dart';
import '../models/auth_response.dart';

class ApiService {
  final Dio _dio;

  ApiService()
      : _dio = Dio(
          BaseOptions(
            baseUrl: 'https://absensib1.mobileprojp.com',
            connectTimeout: const Duration(seconds: 30),
            receiveTimeout: const Duration(seconds: 30),
            headers: {'Accept': 'application/json'},
          ),
        ) {
    _dio.interceptors.add(LogInterceptor(
      request: true,
      requestBody: true,
      responseBody: true,
      error: true,
    ));
    _dio.interceptors.add(InterceptorsWrapper(
      onRequest: (options, handler) async {
        final prefs = await SharedPreferences.getInstance();
        final token = prefs.getString('auth_token');
        if (token != null) {
          options.headers['Authorization'] = 'Bearer $token';
        }
        return handler.next(options);
      },
    ));
  }

  Exception _handleError(DioException e) {
    if (e.response != null && e.response?.data != null) {
      final data = e.response?.data;
      if (data is Map && data.containsKey('message')) {
        return Exception(data['message']);
      }
    }
    return Exception(e.message ?? 'Unknown Error Occurred');
  }

  Future<AuthResponse> register({
    required String name,
    required String email,
    required String password,
  }) async {
    try {
      final response = await _dio.post('/api/register', data: {
        'name': name,
        'email': email,
        'password': password,
      });
      final data = response.data['data'];
      return AuthResponse.fromJson(data);
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  Future<AuthResponse> login({
    required String email,
    required String password,
  }) async {
    try {
      final response = await _dio.post('/api/login', data: {
        'email': email,
        'password': password,
      });
      final data = response.data['data'];
      return AuthResponse.fromJson(data);
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  Future<AbsenModel> checkIn({
    required double checkInLat,
    required double checkInLng,
    required String checkInAddress,
    required String status,
    String? alasanIzin,
  }) async {
    try {
      final response = await _dio.post('/api/absen/check-in', data: {
        'check_in_lat': checkInLat,
        'check_in_lng': checkInLng,
        'check_in_location': '$checkInLat, $checkInLng',
        'check_in_address': checkInAddress,
        'status': status,
        if (alasanIzin != null) 'alasan_izin': alasanIzin,
      });
      return AbsenModel.fromJson(response.data['data']);
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  Future<AbsenModel> checkOut({
    required double checkOutLat,
    required double checkOutLng,
    required String checkOutAddress,
  }) async {
    try {
      final response = await _dio.post('/api/absen/check-out', data: {
        'check_out_lat': checkOutLat,
        'check_out_lng': checkOutLng,
        'check_out_location': '$checkOutLat, $checkOutLng',
        'check_out_address': checkOutAddress,
      });
      return AbsenModel.fromJson(response.data['data']);
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  Future<List<AbsenModel>> getHistory({String? start, String? end}) async {
    try {
      final Map<String, dynamic> queryParams = {};
      if (start != null) queryParams['start'] = start;
      if (end != null) queryParams['end'] = end;

      final response = await _dio.get('/api/absen/history', queryParameters: queryParams);
      final List data = response.data['data'] ?? [];
      return data.map((json) => AbsenModel.fromJson(json)).toList();
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  Future<UserModel> getProfile() async {
    try {
      final response = await _dio.get('/api/profile');
      return UserModel.fromJson(response.data['data']);
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  Future<UserModel> editProfile({
    required String name,
    String? email,
  }) async {
    try {
      final data = {'name': name};
      if (email != null) data['email'] = email;

      final response = await _dio.put('/api/profile', data: data);
      return UserModel.fromJson(response.data['data']);
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  Future<AbsenModel> deleteAbsen(int id) async {
    try {
      final response = await _dio.delete('/api/absen/$id');
      return AbsenModel.fromJson(response.data['data']);
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }
}
