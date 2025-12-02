import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:injectable/injectable.dart';

abstract class SongsApi {
  Future<List<Map<String, dynamic>>> fetchSongs();
  Future<void> toggleFavoriteSong(String songId);
  Future<List<String>> fetchFavoriteSongs();
}

@LazySingleton(as: SongsApi)
class SongsApiImp implements SongsApi {
  @override
  Future<List<Map<String, dynamic>>> fetchSongs() async {
    final snapshot = await FirebaseFirestore.instance
        .collection("Songs")
        .orderBy(
          "order",
          descending: false,
        )
        .get();
    final songs = snapshot.docs.map((doc) => doc.data()).toList();
    return songs;
  }

  @override
  Future<void> toggleFavoriteSong(String songId) async {
    final doc = await FirebaseFirestore.instance
        .collection("Users")
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .get();

    // print("💖💖💖  favoriteSongs ==========  ${doc.data()} 👍👍👍");
    final List favoriteSongs = doc.data()!["favoriteSongs"];

    if (favoriteSongs.contains(songId)) {
      await doc.reference.update({
        "favoriteSongs": FieldValue.arrayRemove([songId])
      });
    } else {
      await doc.reference.update({
        "favoriteSongs": FieldValue.arrayUnion([songId])
      });
    }
  }

  @override
  Future<List<String>> fetchFavoriteSongs() async {
    final doc = await FirebaseFirestore.instance
        .collection("Users")
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .get();
    final List<String> favoriteSongs =
        List<String>.from(doc.data()!["favoriteSongs"]);
    // print("💖💖💖  fetch songs in api ==========  ${doc.data()} 👍👍👍");
    return favoriteSongs;
  }
}
