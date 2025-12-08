import 'package:dio/dio.dart';
import '/core/network/api_constants.dart';
import '/core/network/dio_client.dart';
import '/features/auth/data/models/basic_response_model.dart';
import '/features/auth/data/models/login_response_model.dart';
import '/features/auth/data/models/user_model.dart';

abstract class AuthRemoteDataSource {
  Future<String> register({
    required String username,
    required String password,
  });

  Future<UserModel> login({
    required String username,
    required String password,
  });
}

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  final DioClient dioClient;

  AuthRemoteDataSourceImpl(this.dioClient);

  @override
  Future<String> register({
    required String username,
    required String password,
  }) async {
    try {
      final response = await dioClient.dio.post(
        ApiConstants.register,
        data: FormData.fromMap({
          'username': username,
          'password': password,
        }),
      );

      final basicResponseModel = BasicResponseModel.fromJson(
        response.data as Map<String, dynamic>,
      );

      if (basicResponseModel.status == true) {
        return basicResponseModel.message ?? 'Registration successful';
      } else {
        throw DioException(
          requestOptions: response.requestOptions,
          response: response,
          error: basicResponseModel.message ?? 'Registration failed',
        );
      }
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<UserModel> login({
    required String username,
    required String password,
  }) async {
    try {
      final response = await dioClient.dio.post(
        ApiConstants.login,
        data: FormData.fromMap({
          'username': username,
          'password': password,
        }),
      );

      final loginModel = LoginResponseModel.fromJson(
        response.data as Map<String, dynamic>,
      );

      if (loginModel.status == true && loginModel.user != null) {
        // Save tokens (will be handled by local data source)
        return loginModel.user!;
      } else {
        throw DioException(
          requestOptions: response.requestOptions,
          response: response,
          error: 'Login failed',
        );
      }
    } catch (e) {
      rethrow;
    }
  }
}
