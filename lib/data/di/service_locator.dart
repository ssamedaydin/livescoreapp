import 'package:get_it/get_it.dart';
import '../repositories/fixtures_repository.dart';
import '../../ui/fixturex/view_model/fixtures_bloc.dart';
import '../repositories/leauges_repository.dart';
import '../repositories/live_score_repository.dart';
import '../services/api_client.dart';

final getIt = GetIt.instance;

Future<void> setupLocator() async {
  _registerServices();

  _registerRepositories();

  _registerBlocs();
}

void _registerServices() {

  getIt.registerLazySingleton<ApiClient>(() => ApiClient());
}

void _registerRepositories() {

  getIt.registerLazySingleton<LiveScoreRepository>(
    () => LiveScoreRepositoryImpl(apiClient: getIt<ApiClient>()),
  );


  getIt.registerLazySingleton<LeagueRepository>(
    () => LeagueRepositoryImpl(apiClient: getIt<ApiClient>()),
  );


  getIt.registerLazySingleton<FixturesRepository>(
    () => FixturesRepositoryImpl(apiClient: getIt<ApiClient>()),
  );
}

void _registerBlocs() {

  getIt.registerFactory(() => FixturesBloc(repository: getIt<FixturesRepository>()));
}
