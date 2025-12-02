import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:spotify/core/configs/assets/app_vectors.dart';
import 'package:spotify/src/data/models/songs/song_model.dart';
import 'package:spotify/src/presentation/Welcome/pages/welcome_screen.dart';
import 'package:spotify/src/presentation/home/cubits/favorite_songs_cubit.dart';
import 'package:spotify/src/presentation/home/cubits/songs_cubit.dart';
import 'package:spotify/src/presentation/home/pages/homepage.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    context.read<SongsCubit>().fetchSongs();
    redirect();
  }

  Future<void> _preloadThumbnails() async {
    final List<SongModel> songs =
        await context.read<SongsThumbnailsCubit>().fetchSongsThumbnails();
    for (final song in songs) {
      if (song.thumbanil != null && song.thumbanil!.isNotEmpty) {
        await DefaultCacheManager().downloadFile(song.thumbanil!);
      }
    }
  }

  Future<void> redirect() async {
    await context.read<FavoriteSongsCubit>().fetchFavoriteSongs();
    _preloadThumbnails();
    await Future.delayed(Duration(seconds: 3));
    Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => FirebaseAuth.instance.currentUser != null
              ? Homepage()
              : WelcomeScreen(),
        ));
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    print("width in splash :  $width");
    print("height in splash :  $height");
    return Scaffold(
      body: Center(
        child: SvgPicture.asset(AppVectors.splashLogo),
      ),
    );
  }
}
