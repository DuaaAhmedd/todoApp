import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '/features/auth/data/models/basic_response_model.dart';
import '/features/auth/data/models/login_response_model.dart';
import '/features/auth/data/models/user_model.dart';

class AuthRepo {
  Dio dio = Dio(
    BaseOptions(
      connectTimeout: Duration(seconds: 5),
      receiveTimeout: Duration(seconds: 5),
      sendTimeout: Duration(seconds: 5),
    ),
  );
  Future<Either<String, String>> register({
    required String username,
    required String password,
  }) async {
    try {
      var response = await dio.post(
        'https://ntitodo-production-1fa0.up.railway.app/api/register',
        data: FormData.fromMap({'username': username, 'password': password}),
      );

      var basicResponseModel = BasicResponseModel.fromJson(
        response.data as Map<String, dynamic>,
      );
      if (basicResponseModel.status == true) {
        return right(basicResponseModel.message ?? '');
      } else {
        return left(basicResponseModel.message ?? '');
      }
    } on DioException catch (e) {
      if (e.response?.data != null) {
        return left(e.response!.data['message'] ?? '');
      } else {
        return left('something went wrong'); // TODO: Handle this case.
      }
    } catch (e) {
      return left('something went wrong');
    }
  }

  Future<Either<String, UserModel>> login({
    required String username,
    required String password,
  }) async {
    try {
      var response = await dio.post(
        'https://ntitodo-production-1fa0.up.railway.app/api/login',
        data: FormData.fromMap({'username': username, 'password': password}),
      );
      var loginModel = LoginResponseModel.fromJson(
        response.data as Map<String, dynamic>,
      );
      if (loginModel.status == true &&
          loginModel.user != null &&
          loginModel.accessToken != null) {
        final prefs = await SharedPreferences.getInstance();
        await prefs.setString('access_token', loginModel.accessToken!);
        if (loginModel.refreshToken != null) {
          await prefs.setString('refresh_token', loginModel.refreshToken!);
        }
        return right(loginModel.user!);
      } else {
        throw Exception;
      }
    } on DioException catch (e) {
      if (e.response?.data != null) {
        return left(e.response!.data['message'] ?? '');
      } else {
        return left('something went wrong'); // TODO: Handle this case.
      }
    } catch (e) {
      return left('something went wrong');
    }
  }
}
