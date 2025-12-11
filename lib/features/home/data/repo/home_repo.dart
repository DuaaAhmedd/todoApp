import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

import 'package:shared_preferences/shared_preferences.dart';
import '/features/home/data/models/get_tasks_response_model.dart';
import '/features/home/data/models/tassk_model.dart';
import '/features/home/data/models/get_user_response_model.dart';
import 'package:todo/features/auth/data/models/user_model.dart';

class HomeRepo {
  Dio dio = Dio();
  Future<Either<String, List<TaskModel>>> getTasks() async {
    try {
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      final String? accessToken = prefs.getString('access_token');

      if (accessToken == null) return left('not authorized');

      var response = await dio.get(
        'https://ntitodo-production-1fa0.up.railway.app/api/my_tasks',
        options: Options(headers: {'Authorization': 'Bearer $accessToken'}),
      );

      var getTasksModel = GetTasksReponseModel.fromJson(
        response.data as Map<String, dynamic>,
      );

      if (getTasksModel.status == true) {
        final tasks = getTasksModel.tasks ?? [];

        return right(tasks);
      } else {
        return left('something went wrong');
      }
    } on DioException catch (e) {
      if (e.response?.data != null) {
        return left(e.response!.data['message'] ?? 'something went wrong');
      } else {
        return left('network error');
      }
    } catch (e) {
      return left('something went wrong');
    }
  }

  Future<Either<String, UserModel>> getusers() async {
    try {
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      final String? accessToken = prefs.getString('access_token');
      if (accessToken == null) return left('not authorized');
      var response = await dio.get(
        'https://ntitodo-production-1fa0.up.railway.app/api/user',
        options: Options(headers: {'Authorization': 'Bearer $accessToken'}),
      );
      var user = GetUserResponseModel.fromJson(
        response.data as Map<String, dynamic>,
      );

      return right(user.users!);
    } on DioException catch (e) {
      if (e.response?.data != null) {
        return left(e.response!.data['message'] ?? 'something went wrong');
      } else {
        return left('network error');
      }
    } catch (e) {
      return left('something went wrong');
    }
  }

  Future<Either<String, bool>> deleteTask(int taskId) async {
    try {
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      final String? accessToken = prefs.getString('access_token');
      if (accessToken == null) return left('not authorized');

      var response = await dio.delete(
        'https://ntitodo-production-1fa0.up.railway.app/api/tasks/$taskId',
        options: Options(headers: {'Authorization': 'Bearer $accessToken'}),
      );

      if (response.statusCode == 200 || response.statusCode == 204) {
        return right(true);
      } else {
        return left('Failed to delete task');
      }
    } on DioException catch (e) {
      if (e.response?.data != null) {
        return left(e.response!.data['message'] ?? 'Failed to delete task');
      } else {
        return left('network error');
      }
    } catch (e) {
      return left('something went wrong');
    }
  }

  Future<Either<String, TaskModel>> editTask(
    int taskId,
    String title,
    String description,
  ) async {
    try {
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      final String? accessToken = prefs.getString('access_token');
      if (accessToken == null) return left('not authorized');

      var response = await dio.put(
        'https://ntitodo-production-1fa0.up.railway.app/api/tasks/$taskId',
        data: {'title': title, 'description': description},
        options: Options(headers: {'Authorization': 'Bearer $accessToken'}),
      );

      if (response.statusCode == 200) {
        try {
          var taskData = response.data['task'] ?? response.data;
          var updatedTask = TaskModel.fromJson(
            taskData as Map<String, dynamic>,
          );
          return right(updatedTask);
        } catch (parseError) {
          return left('Error parsing response: $parseError');
        }
      } else {
        return left('Failed to update task');
      }
    } on DioException catch (e) {
      if (e.response?.data != null) {
        return left(e.response!.data['message'] ?? 'Failed to update task');
      } else {
        return left('network error');
      }
    } catch (e) {
      return left('Error: $e');
    }
  }
}
