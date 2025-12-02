import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:spotify/injection_container.dart';
import 'package:spotify/src/logic/usecases/songs/fetch_favorite_songs_usecase.dart';
import 'package:spotify/src/logic/usecases/songs/toggle_favorite_song_usecase.dart';

class FavoriteSongsCubit extends Cubit<List<String>> {
  FavoriteSongsCubit() : super([]);

  List<String> favoriteSongs = [];

  Future<List<String>> fetchFavoriteSongs() async {
    final favoritSongsResult = await getIt<FetchFavoriteSongsUsecase>().call();

    return favoritSongsResult.fold(
      (failure) {
        print(
            "🚑🚑🚑 fetch song failure  ==========  ${failure.toString()} 🚀🚀🚀");
        return [];
      },
      (favoritSongs) {
        print("💖💖💖  array fetched in cubit from api ==========  ${favoritSongs} 👍👍👍");
        favoriteSongs = favoritSongs;
        return favoritSongs;
      },
    );
  }

  Future<void> toggleFavoriteSong(String songId) async {
    final toggleFavoriteSongResult =
        await getIt<ToggleFavoriteSongUsecase>().call(params: songId);

    return toggleFavoriteSongResult.fold(
      (failure) {
        print(failure.toString());
      },
      (favoritSongs) {},
    );
  }
}
