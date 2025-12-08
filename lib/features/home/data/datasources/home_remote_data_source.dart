import 'package:dio/dio.dart';
import '/core/network/api_constants.dart';
import '/core/network/dio_client.dart';
import '/features/auth/data/models/user_model.dart';
import '/features/home/data/models/get_tasks_response_model.dart';
import '/features/home/data/models/get_user_response_model.dart';
import '/features/home/data/models/tassk_model.dart';

abstract class HomeRemoteDataSource {
  Future<List<TaskModel>> getTasks();
  Future<UserModel> getUser();
}

class HomeRemoteDataSourceImpl implements HomeRemoteDataSource {
  final DioClient dioClient;

  HomeRemoteDataSourceImpl(this.dioClient);

  @override
  Future<List<TaskModel>> getTasks() async {
    try {
      final response = await dioClient.dio.get(ApiConstants.myTasks);

      final getTasksModel = GetTasksReponseModel.fromJson(
        response.data as Map<String, dynamic>,
      );

      return getTasksModel.tasks ?? [];
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<UserModel> getUser() async {
    try {
      final response = await dioClient.dio.get(ApiConstants.user);

      final getUserModel = GetUserResponseModel.fromJson(
        response.data as Map<String, dynamic>,
      );

      if (getUserModel.users != null) {
        return getUserModel.users!;
      } else {
        throw DioException(
          requestOptions: response.requestOptions,
          response: response,
          error: 'User not found',
        );
      }
    } catch (e) {
      rethrow;
    }
  }
}
