import 'package:get_it/get_it.dart';
import 'package:mobil_dersi_projesi/core/repository/user_repository.dart';
import 'package:mobil_dersi_projesi/core/services/fake_auth_service.dart';
import 'package:mobil_dersi_projesi/core/services/firebase_auth_service.dart';
import 'package:mobil_dersi_projesi/core/services/firebase_storage_service.dart';
import 'package:mobil_dersi_projesi/core/services/firestore_db_service.dart';

GetIt locator = GetIt.instance;

void setupLocator(){
  locator.registerLazySingleton(() => FirebaseAuthService());
  locator.registerLazySingleton(() => FakeAuthenticationService());
  locator.registerLazySingleton(() => FirestoreDBService());
  locator.registerLazySingleton(() => FirebaseStorageService());
  locator.registerLazySingleton(() => UserRepository());
}