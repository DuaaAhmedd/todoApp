import '/core/network/dio_client.dart';
import '/features/auth/data/datasources/auth_local_data_source.dart';
import '/features/auth/data/datasources/auth_remote_data_source.dart';
import '/features/auth/data/repo/auth_repo.dart';
import '/features/auth/domain/repositories/auth_repository.dart';
import '/features/auth/domain/usecases/login_usecase.dart';
import '/features/auth/domain/usecases/register_usecase.dart';
import '/features/home/data/datasources/home_remote_data_source.dart';
import '/features/home/data/repo/home_repo.dart';
import '/features/home/domain/repositories/home_repository.dart';
import '/features/home/domain/usecases/get_tasks_usecase.dart';
import '/features/home/domain/usecases/get_user_usecase.dart';

class ServiceLocator {
  static final ServiceLocator _instance = ServiceLocator._internal();
  factory ServiceLocator() => _instance;
  ServiceLocator._internal();

  // Core
  late DioClient _dioClient;

  // Auth
  late AuthLocalDataSource _authLocalDataSource;
  late AuthRemoteDataSource _authRemoteDataSource;
  late AuthRepository _authRepository;
  late LoginUseCase _loginUseCase;
  late RegisterUseCase _registerUseCase;

  // Home
  late HomeRemoteDataSource _homeRemoteDataSource;
  late HomeRepository _homeRepository;
  late GetTasksUseCase _getTasksUseCase;
  late GetUserUseCase _getUserUseCase;

  void init() {
    // Core
    _dioClient = DioClient();

    // Auth
    _authLocalDataSource = AuthLocalDataSourceImpl();
    _authRemoteDataSource = AuthRemoteDataSourceImpl(
      _dioClient,
      _authLocalDataSource,
    );
    _authRepository = AuthRepositoryImpl(_authRemoteDataSource);
    _loginUseCase = LoginUseCase(_authRepository);
    _registerUseCase = RegisterUseCase(_authRepository);

    // Home
    _homeRemoteDataSource = HomeRemoteDataSourceImpl(_dioClient);
    _homeRepository = HomeRepositoryImpl(_homeRemoteDataSource);
    _getTasksUseCase = GetTasksUseCase(_homeRepository);
    _getUserUseCase = GetUserUseCase(_homeRepository);
  }

  // Getters
  DioClient get dioClient => _dioClient;
  LoginUseCase get loginUseCase => _loginUseCase;
  RegisterUseCase get registerUseCase => _registerUseCase;
  GetTasksUseCase get getTasksUseCase => _getTasksUseCase;
  GetUserUseCase get getUserUseCase => _getUserUseCase;
  AuthLocalDataSource get authLocalDataSource => _authLocalDataSource;
}
