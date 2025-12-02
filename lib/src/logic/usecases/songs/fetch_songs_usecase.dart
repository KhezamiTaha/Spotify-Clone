import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:spotify/core/usecases/abstract_usecase.dart';
import 'package:spotify/injection_container.dart';
import 'package:spotify/src/data/models/songs/song_model.dart';
import 'package:spotify/src/logic/repository/songs/songs_repository.dart';



@Singleton()
class FetchsongsUsecase implements UseCase<Either, List<SongModel>> {
  @override
  Future<Either> call({params}) async {
    return await getIt<SongsRepository>().fetchSongs() ; 
  }
}