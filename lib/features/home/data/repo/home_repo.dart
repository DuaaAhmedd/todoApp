import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '/features/home/data/models/get_tasks_response_model.dart';
import '/features/home/data/models/tassk_model.dart';
import '/features/home/data/models/get_user_response_model.dart';
import 'package:todo/features/auth/data/models/user_model.dart';

/// Repository for home/tasks operations following Clean Architecture principles
/// Handles API calls with authentication
class HomeRepo {
  // Singleton pattern for repository
  static final HomeRepo _instance = HomeRepo._internal();
  factory HomeRepo() => _instance;
  HomeRepo._internal();

  // API Configuration
  static const String _baseUrl =
      'https://ntitodo-production-1fa0.up.railway.app/api';
  static const String _tasksEndpoint = '/my_tasks';
  static const String _userEndpoint = '/user';

  // Dio client with configuration
  final Dio _dio = Dio(
    BaseOptions(
      baseUrl: _baseUrl,
      connectTimeout: const Duration(seconds: 5),
      receiveTimeout: const Duration(seconds: 5),
      sendTimeout: const Duration(seconds: 5),
    ),
  );

  /// Get user's tasks with authentication
  Future<Either<String, List<TaskModel>>> getTasks() async {
    try {
      final token = await _getAccessToken();
      final response = await _dio.get(
        _tasksEndpoint,
        options: Options(
          headers: {'Authorization': 'Bearer $token'},
        ),
      );

      final getTasksModel = GetTasksReponseModel.fromJson(
        response.data as Map<String, dynamic>,
      );

      return right(getTasksModel.tasks ?? []);
    } on DioException catch (e) {
      return left(_handleDioError(e));
    } catch (e) {
      return left('An unexpected error occurred');
    }
  }

  /// Get user information with authentication
  Future<Either<String, UserModel>> getusers() async {
    try {
      final token = await _getAccessToken();
      final response = await _dio.get(
        _userEndpoint,
        options: Options(
          headers: {'Authorization': 'Bearer $token'},
        ),
      );

      final user = GetUserResponseModel.fromJson(
        response.data as Map<String, dynamic>,
      );

      if (user.users != null) {
        return right(user.users!);
      } else {
        return left('User data not found');
      }
    } on DioException catch (e) {
      return left(_handleDioError(e));
    } catch (e) {
      return left('An unexpected error occurred');
    }
  }

  /// Get stored access token
  Future<String?> _getAccessToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('access_token');
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
      case DioExceptionType.badResponse:
        if (e.response?.statusCode == 401) {
          return 'Authentication failed. Please login again';
        }
        return 'Server error occurred';
      default:
        return 'Network error occurred';
    }
  }
}
