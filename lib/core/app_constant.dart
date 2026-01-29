
import 'package:first/core/app_imports.dart';

final session = UserSessionManager();
final ApiClient _apiClient = ApiClient();

class AppConstant {
  AppConstant._();

  static const String appName = "Laptop Horbour";

  static bool get isloggedIn => session.isLoggedIn;
}