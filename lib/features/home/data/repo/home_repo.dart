import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '/features/home/data/models/get_tasks_response_model.dart';
import '/features/home/data/models/tassk_model.dart';
import '/features/home/data/models/get_user_response_model.dart';
import 'package:todo/features/home/data/repo/home_repo.dart';
import 'package:todo/features/auth/data/models/user_model.dart';

class HomeRepo {
  Dio dio = Dio();
  Future<Either<String, List<TaskModel>>> getTasks() async {
    try {
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      String? accessToken = prefs.getString('accsess_token');
      var response = await dio.get(
        'https://ntitodo-production-1fa0.up.railway.app/api/my_tasks',
        options: Options(headers: {'Authorization': 'Bearer $accessToken'}),
      );
      var getTasksModel = GetTasksReponseModel.fromJson(
        response.data as Map<String, dynamic>,
      );
      print(' tasks:  ${getTasksModel.tasks}');
      return right(getTasksModel.tasks ?? []);
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

  Future<Either<String, UserModel>> getusers() async {
    try {
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      String? accessToken = prefs.getString('accsess_token');
      var response = await dio.get(
        'https://ntitodo-production-1fa0.up.railway.app/api/my_tasks',
        options: Options(headers: {'Authorization': 'Bearer $accessToken'}),
      );
      var user = getUserModel.fromJson(response.data as Map<String, dynamic>);

      return right(user.users!);
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
