import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fire/Features/Posts/Data/DataSource/local_data.dart';
import 'package:fire/Features/Posts/Data/DataSource/remote_data.dart';
import 'package:fire/Features/Posts/Data/Reposatories/post_repo.dart';
import 'package:fire/Features/Posts/Domain/Reposatories/post_repo.dart';
import 'package:fire/Features/Posts/Domain/UseCase/addPosts.dart';
import 'package:fire/Features/Posts/Domain/UseCase/deletPosts.dart';
import 'package:fire/Features/Posts/Domain/UseCase/getAllPosts.dart';
import 'package:fire/Features/Posts/Presentation/bloc/AddDelete/add_del_bloc.dart';
import 'package:fire/Features/Posts/Presentation/bloc/post/post_bloc.dart';
import 'package:fire/global/network_info.dart';
import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http; // Import the HTTP client
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:shared_preferences/shared_preferences.dart';

final sl = GetIt.instance;

Future<void> init() async {
  // Global
  sl.registerLazySingleton<NetworkInfo>(
          () => NetworkInfoImpl(connectionChecker: sl()));

  // External
  final sharedPreferences = await SharedPreferences.getInstance();
  sl.registerLazySingleton(() => sharedPreferences);
  sl.registerLazySingleton(() => FirebaseFirestore.instance);
  sl.registerLazySingleton(() => InternetConnectionChecker());
  sl.registerLazySingleton(() => http.Client()); // Register the HTTP client

  // Feature: Post
  // Bloc
  sl.registerFactory(() => PostBloc(sl()));
  sl.registerFactory(() => AddDelBloc(sl(), sl()));

  // Use Cases
  sl.registerLazySingleton(() => addPostUseCase(repo: sl()));
  sl.registerLazySingleton(() => deletPostUseCase(repo: sl()));
  sl.registerLazySingleton(() => GetallpostsUseCase(repo: sl()));

  // Repository
  sl.registerLazySingleton<PostRepo>(() => PostRepoImpl(sl(), sl(), sl()));

  // Data Sources
  sl.registerLazySingleton<PostLocalDataSource>(
          () => PostLocalDataSourceImpl(sharedPreferencesd: sl()));
  sl.registerLazySingleton<PostsRemoteDataSource>(
          () => PostsRemoteDataSourceImpl(client: sl()));
}
