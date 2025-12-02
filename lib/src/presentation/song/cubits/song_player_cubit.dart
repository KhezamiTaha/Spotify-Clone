import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:just_audio/just_audio.dart';
import 'package:meta/meta.dart';

part 'song_player_state.dart';

class SongPlayerCubit extends Cubit<SongPlayerState> {
  AudioPlayer audioPlayer = AudioPlayer();

  late StreamSubscription _positionSub;
  late StreamSubscription _durationSub;

  Duration songDuration = Duration.zero;
  Duration songPosition = Duration.zero;
  SongPlayerCubit() : super(SongPlayerLoading()) {
    _positionSub = audioPlayer.positionStream.listen((positon) {
      songPosition = positon;
      if (isClosed) return; // prevent crash
      emit(SongPlayerLoaded());
    });

    _durationSub = audioPlayer.durationStream.listen((duration) {
      if (duration != null) {
        songDuration = duration;
      }
    });
  }

  void updateSongPlayer() {
    emit(SongPlayerLoaded());
  }

  Future<void> loadSong(String url) async {
    try {
      await audioPlayer.setUrl(url);
      if (isClosed) return;

      emit(SongPlayerLoaded());
    } catch (e) {
      if (isClosed) return;

      emit(SongPlayerFailure());
    }
  }

  Future<void> playPauseSong({String? action}) async {
    if (action == "start") {
      Future.delayed(Duration(seconds: 2));
      await audioPlayer.play();
      emit(SongPlayerLoaded());
      return;
    }

    if (audioPlayer.playing) {
      await audioPlayer.pause();
    } else if (action == null) {
      await audioPlayer.play();
    }
    if (isClosed) return;
    emit(SongPlayerLoaded());
  }

  @override
  Future<void> close() {
    _positionSub.cancel();
    _durationSub.cancel();
    audioPlayer.dispose();
    return super.close();
  }
}
