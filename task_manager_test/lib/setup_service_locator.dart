import 'package:get_it/get_it.dart';
import 'package:task_manager_test/data/repository/repository_impl.dart';
import 'package:task_manager_test/data/services/network_services.dart';
import 'package:task_manager_test/data/services/network_services_impl.dart';

import 'data/repository/repository.dart';

GetIt serviceLocator = GetIt.instance;

void setupServiceLocator() {
  NetworkService service = NetworkServiceImpl();
  serviceLocator.registerSingleton<NetworkService>(service);
  serviceLocator.registerSingleton<Repository>(RepositoryImpl(service));
}