import 'package:dartz/dartz.dart';

abstract class SongsRepository {
  Future<Either> fetchSongs();
  Future<Either> toggleFavoriteSong(String songId);
  Future<Either> fetchFavoriteSongs();
}
