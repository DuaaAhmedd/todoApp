import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '/features/auth/data/models/basic_response_model.dart';
import '/features/auth/data/models/login_response_model.dart';
import '/features/auth/data/models/user_model.dart';

/// Repository for authentication operations following Clean Architecture principles
/// Handles API calls and token management
class AuthRepo {
  // Singleton pattern for repository
  static final AuthRepo _instance = AuthRepo._internal();
  factory AuthRepo() => _instance;
  AuthRepo._internal();

  // API Configuration
  static const String _baseUrl =
      'https://ntitodo-production-1fa0.up.railway.app/api';
  static const String _registerEndpoint = '/register';
  static const String _loginEndpoint = '/login';

  // Dio client with configuration
  final Dio _dio = Dio(
    BaseOptions(
      baseUrl: _baseUrl,
      connectTimeout: const Duration(seconds: 5),
      receiveTimeout: const Duration(seconds: 5),
      sendTimeout: const Duration(seconds: 5),
    ),
  );

  /// Register a new user
  Future<Either<String, String>> register({
    required String username,
    required String password,
  }) async {
    try {
      final response = await _dio.post(
        _registerEndpoint,
        data: FormData.fromMap({
          'username': username,
          'password': password,
        }),
      );

      final basicResponseModel = BasicResponseModel.fromJson(
        response.data as Map<String, dynamic>,
      );

      if (basicResponseModel.status == true) {
        return right(basicResponseModel.message ?? 'Registration successful');
      } else {
        return left(basicResponseModel.message ?? 'Registration failed');
      }
    } on DioException catch (e) {
      return left(_handleDioError(e));
    } catch (e) {
      return left('An unexpected error occurred');
    }
  }

  /// Login user and save authentication tokens
  Future<Either<String, UserModel>> login({
    required String username,
    required String password,
  }) async {
    try {
      final response = await _dio.post(
        _loginEndpoint,
        data: FormData.fromMap({
          'username': username,
          'password': password,
        }),
      );

      final loginModel = LoginResponseModel.fromJson(
        response.data as Map<String, dynamic>,
      );

      if (loginModel.status == true && loginModel.user != null) {
        // Save authentication tokens
        await _saveTokens(
          accessToken: loginModel.accessToken,
          refreshToken: loginModel.refreshToken,
        );
        return right(loginModel.user!);
      } else {
        return left('Login failed');
      }
    } on DioException catch (e) {
      return left(_handleDioError(e));
    } catch (e) {
      return left('An unexpected error occurred');
    }
  }

  /// Save authentication tokens to local storage
  Future<void> _saveTokens({
    String? accessToken,
    String? refreshToken,
  }) async {
    if (accessToken != null && refreshToken != null) {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('access_token', accessToken);
      await prefs.setString('refresh_token', refreshToken);
    }
  }

  /// Get stored access token
  Future<String?> getAccessToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('access_token');
  }

  /// Clear authentication tokens
  Future<void> clearTokens() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('access_token');
    await prefs.remove('refresh_token');
  }

  /// Handle Dio errors and return user-friendly messages
  String _handleDioError(DioException e) {
    if (e.response?.data != null && e.response!.data is Map) {
      return e.response!.data['message'] ?? 'Network error occurred';
    }
    
    switch (e.type) {
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.sendTimeout:
      case DioExceptionType.receiveTimeout:
        return 'Connection timeout. Please try again';
      case DioExceptionType.connectionError:
        return 'No internet connection';
      default:
        return 'Network error occurred';
    }
  }
}
