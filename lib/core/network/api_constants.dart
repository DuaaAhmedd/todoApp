class ApiConstants {
  static const String baseUrl =
      'https://ntitodo-production-1fa0.up.railway.app/api';
  
  // Auth endpoints
  static const String register = '/register';
  static const String login = '/login';
  
  // Home endpoints
  static const String myTasks = '/my_tasks';
  static const String user = '/user';
  
  // Timeouts
  static const Duration connectTimeout = Duration(seconds: 5);
  static const Duration receiveTimeout = Duration(seconds: 5);
  static const Duration sendTimeout = Duration(seconds: 5);
}
