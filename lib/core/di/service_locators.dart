import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:mini_app/core/constants.dart';
import 'package:mini_app/core/services/stripe_service_widget.dart';
import 'package:mini_app/data/data_source/firebase_data_source.dart';
import 'package:mini_app/data/data_source/shared_preference_datasource.dart';
import 'package:mini_app/data/network/services/api_service.dart';
import 'package:mini_app/data/repository_impl/repository_impl.dart';
import 'package:mini_app/domain/repository/repository.dart';
import 'package:mini_app/persentation/cart_view/view_model/cart_view_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

final getIt = GetIt.instance;

void setupServiceLocator() {
  getIt.registerLazySingleton (() => Dio());
  getIt.registerLazySingleton<ApiService>(() => ApiService(getIt<Dio>()));

  getIt.registerSingletonAsync<SharedPreferences>(() async => await SharedPreferences.getInstance());
  getIt.registerLazySingleton<SharedPreferenceDataSource>(() => SharedPreferenceDataSource(sharedPreferences: getIt<SharedPreferences>()));
  getIt.registerLazySingleton<Constants>(() => Constants());

  getIt.registerLazySingleton<StripeService>(() => StripeService(getIt<Constants>())..init());

  getIt.registerLazySingleton<FirebaseDataSource>(() => FirebaseDataSource());
  getIt.registerLazySingleton<Repository>(() => RepositoryImpl(getIt<FirebaseDataSource>(), getIt<SharedPreferenceDataSource>(), getIt<Constants>()));
  // 7teet el view model blkhs feha user akhtarha fa ana lw kol mara 3mlt init llpage list htrg3 fadya feha lkol mara
  getIt.registerLazySingleton(() => CartViewModel());
}
