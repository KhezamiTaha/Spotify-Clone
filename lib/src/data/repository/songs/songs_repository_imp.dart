import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:spotify/common/errors/failure.dart';
import 'package:spotify/injection_container.dart';
import 'package:spotify/src/data/api/songs/songs_api.dart';
import 'package:spotify/src/data/models/songs/song_model.dart';
import 'package:spotify/src/logic/repository/songs/songs_repository.dart';

@Singleton(as: SongsRepository)
class SongsRepositoryImp implements SongsRepository {
  @override
  Future<Either<Failure, List<SongModel>>> fetchSongs() async {
    try {
      final songsData = await getIt<SongsApi>().fetchSongs();

      final songs = songsData.map((song) => SongModel.fromJson(song)).toList();

      return Right(songs);
    } on FirebaseException catch (e) {
      return Left(Failure(message: "Firestore error", code: e.code));
    } catch (e) {
      return Left(Failure(message: "Unexpected Error $e"));
    }
  }

  @override
  Future<Either<Failure, bool>> toggleFavoriteSong(String songId) async {
    try {
      await getIt<SongsApi>().toggleFavoriteSong(songId);
      return Right(true);
    } on FirebaseException catch (e) {
      return Left(Failure(message: "Firestore error", code: e.code));
    } catch (e) {
      return Left(Failure(message: "Unexpected Error $e"));
    }
  }

  @override
  Future<Either<Failure, List<String>>> fetchFavoriteSongs() async {
    try {
      final favoriteSongs = await getIt<SongsApi>().fetchFavoriteSongs();
      return Right(favoriteSongs);
    } on FirebaseException catch (e) {
      return Left(Failure(message: "Firestore error", code: e.code));
    } catch (e) {
      return Left(Failure(message: "Unexpected Error $e"));
    }
  }
}
