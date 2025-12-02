

import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:spotify/core/usecases/abstract_usecase.dart';
import 'package:spotify/injection_container.dart';
import 'package:spotify/src/logic/repository/songs/songs_repository.dart';

@Singleton()
class ToggleFavoriteSongUsecase implements UseCase<Either, String> {
  @override
  Future<Either> call({String? params}) async {
    return await getIt<SongsRepository>().toggleFavoriteSong(params!) ; 
  }
}