import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:task/core/utils/api_service.dart';

import '../repo/users_repo/users_repo.dart';
import '../repo/users_repo/users_repo_impl.dart';

final getIt = GetIt.instance;

void setupDependencyInjection() {
  getIt.registerSingleton<Dio>(Dio());
  getIt.registerSingleton<ApiService>(ApiService(getIt<Dio>()));

  getIt.registerSingleton<UsersRepo>(UsersRepoImpl());
}
