import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:spotify/core/usecases/abstract_usecase.dart';
import 'package:spotify/injection_container.dart';
import 'package:spotify/src/logic/repository/songs/songs_repository.dart';

@Singleton()
class FetchFavoriteSongsUsecase implements UseCase<Either, NoParams> {
  @override
  Future<Either> call({NoParams? params}) async {
    return await getIt<SongsRepository>().fetchFavoriteSongs();
  }
}
