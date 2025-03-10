import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:mini_app/data/data_source/remote_data_source.dart';
import 'package:mini_app/data/network/services/api_service.dart';
import 'package:mini_app/data/repository_impl/repository_impl.dart';
import 'package:mini_app/domain/repository/repository.dart';
import 'package:mini_app/persentation/cart_view/view_model/cart_view_model.dart';

final getIt = GetIt.instance;

void setupServiceLocator() {
  getIt.registerLazySingleton (() => Dio());
  getIt.registerLazySingleton<ApiService>(() => ApiService(getIt<Dio>()));
  getIt.registerLazySingleton<RemoteDataSource>(() => RemoteDataSourceImpl(apiService: getIt<ApiService>()));
  getIt.registerLazySingleton<Repository>(() => RepositoryImpl(remoteDataSource: getIt<RemoteDataSource>()));
  // 7teet el view model blkhs feha user akhtarha fa ana lw kol mara 3mlt init llpage list htrg3 fadya feha lkol mara
  getIt.registerLazySingleton(() => CartViewModel());
}
