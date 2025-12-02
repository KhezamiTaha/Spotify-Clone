import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';
import 'package:spotify/injection_container.config.dart';
// import 'package:spotify/src/data/api/auth/auth_api.dart';
// import 'package:spotify/src/data/api/songs/songs_api.dart';
// import 'package:spotify/src/data/repository/auth/auth_repository_imp.dart';
// import 'package:spotify/src/data/repository/songs/songs_repository_imp.dart';
// import 'package:spotify/src/logic/repository/auth/auth_repository.dart';
// import 'package:spotify/src/logic/repository/songs/songs_repository.dart';
// import 'package:spotify/src/logic/usecases/auth/register_usecase.dart';
// import 'package:spotify/src/logic/usecases/auth/signin_usecase.dart';
// import 'package:spotify/src/logic/usecases/songs/fetch_songs_usecase.dart';

final getIt = GetIt.instance;

@InjectableInit(
  initializerName: 'init', // default
  preferRelativeImports: true,
  asExtension: true,
)
void configureDependencies(String environement)  {
   getIt.init(environment: environement);
}


  // // authentication
  // getIt.registerSingleton<AuthApi>(AuthApiImp());

  // getIt.registerSingleton<AuthRepository>(AuthRepositoryImp());

  // getIt.registerSingleton<RegisterUsecase>(RegisterUsecase());

  // getIt.registerSingleton<SignInUsecase>(SignInUsecase());

  // // fetching Songs
  // getIt.registerSingleton<SongsApi>(SongsApiImp());
  // getIt.registerSingleton<SongsRepository>(SongsRepositoryImp());
  // getIt.registerSingleton<FetchsongsUsecase>(FetchsongsUsecase());
