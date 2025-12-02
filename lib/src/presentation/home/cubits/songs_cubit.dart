// ignore_for_file: avoid_print

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:spotify/common/errors/failure.dart';
import 'package:spotify/injection_container.dart';
import 'package:spotify/src/data/models/songs/song_model.dart';
import 'package:spotify/src/logic/usecases/songs/fetch_songs_usecase.dart';

class SongsState {}

class FetchingSongs extends SongsState {}

class FetchingSongsFailed extends SongsState {
  final Failure failure;
  FetchingSongsFailed({required this.failure});
}

class FetchingSongSuccess extends SongsState {
  final List<SongModel> songs;

  FetchingSongSuccess({required this.songs});
}

class SongsCubit extends Cubit<SongsState> {
  SongsCubit() : super(FetchingSongs());

  void fetchSongs() async {
    final songsResult = await getIt<FetchsongsUsecase>().call();

    songsResult.fold(
      (failure) {
        print(failure.toString());
        emit(FetchingSongsFailed(failure: failure));
      },
      (songs) {
        emit(FetchingSongSuccess(songs: songs));
      },
    );
  }
}

class SongsThumbnailsCubit extends Cubit<List<SongModel>> {
  SongsThumbnailsCubit() : super([]);

  Future<List<SongModel>> fetchSongsThumbnails() async {
    final songsResult = await getIt<FetchsongsUsecase>().call();

    return songsResult.fold(
      (failure) {
        print(failure.toString());
        return [];
      },
      (songs) {
        return songs;
      },
    );
  }
}
