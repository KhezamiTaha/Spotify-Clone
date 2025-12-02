// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format width=80

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:get_it/get_it.dart' as _i174;
import 'package:injectable/injectable.dart' as _i526;

import 'src/data/api/auth/auth_api.dart' as _i734;
import 'src/data/api/songs/songs_api.dart' as _i56;
import 'src/data/repository/auth/auth_repository_imp.dart' as _i413;
import 'src/data/repository/songs/songs_repository_imp.dart' as _i801;
import 'src/logic/repository/auth/auth_repository.dart' as _i438;
import 'src/logic/repository/songs/songs_repository.dart' as _i747;
import 'src/logic/usecases/auth/register_usecase.dart' as _i274;
import 'src/logic/usecases/auth/signin_usecase.dart' as _i779;
import 'src/logic/usecases/songs/fetch_favorite_songs_usecase.dart' as _i151;
import 'src/logic/usecases/songs/fetch_songs_usecase.dart' as _i292;
import 'src/logic/usecases/songs/toggle_favorite_song_usecase.dart' as _i1060;

extension GetItInjectableX on _i174.GetIt {
// initializes the registration of main-scope dependencies inside of GetIt
  _i174.GetIt init({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) {
    final gh = _i526.GetItHelper(
      this,
      environment,
      environmentFilter,
    );
    gh.singleton<_i274.RegisterUsecase>(() => _i274.RegisterUsecase());
    gh.singleton<_i779.SignInUsecase>(() => _i779.SignInUsecase());
    gh.singleton<_i151.FetchFavoriteSongsUsecase>(
        () => _i151.FetchFavoriteSongsUsecase());
    gh.singleton<_i292.FetchsongsUsecase>(() => _i292.FetchsongsUsecase());
    gh.singleton<_i1060.ToggleFavoriteSongUsecase>(
        () => _i1060.ToggleFavoriteSongUsecase());
    gh.singleton<_i438.AuthRepository>(() => _i413.AuthRepositoryImp());
    gh.singleton<_i734.AuthApi>(() => _i734.AuthApiImp());
    gh.singleton<_i747.SongsRepository>(() => _i801.SongsRepositoryImp());
    gh.lazySingleton<_i56.SongsApi>(() => _i56.SongsApiImp());
    return this;
  }
}
