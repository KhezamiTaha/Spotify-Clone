import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:spotify/common/helpers/is_dark_mode.dart';
import 'package:spotify/core/configs/theme/app_colors.dart';
import 'package:spotify/src/data/models/songs/song_model.dart';
import 'package:spotify/src/presentation/home/cubits/favorite_songs_cubit.dart';
import 'package:spotify/src/presentation/song/cubits/song_player_cubit.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SongPlayerScreen extends StatefulWidget {
  const SongPlayerScreen({super.key, required this.song});

  final SongModel song;

  @override
  State<SongPlayerScreen> createState() => _SongPlayerState();
}

class _SongPlayerState extends State<SongPlayerScreen> with RouteAware {
  double? _dragValue;
  bool isFavorite = false;
  bool isDarkMode = false;

  @override
  void initState() {
    super.initState();
    // context.read<FavoriteSongsCubit>().fetchFavoriteSongs();
    isFavorite = context
        .read<FavoriteSongsCubit>()
        .favoriteSongs
        .contains(widget.song.songId);
    // print("💖💖💖  hello again ==========  ${isFavorite} 👍👍👍");
  }

  @override
  Widget build(BuildContext context) {
    isDarkMode = context.isDarkMode;
    return BlocProvider(
      create: (context) => SongPlayerCubit()..loadSong(widget.song.songAudio!),
      child: Scaffold(
        body: SafeArea(
            child: PopScope(
          canPop: true,
          onPopInvokedWithResult: (didPop, result) {
            if (!didPop && mounted) {
              context.read<SongPlayerCubit>().close();
            }
          },
          child: Padding(
            padding: EdgeInsets.only(top: 16.h, bottom: 10.h),
            child: Column(
              children: [
                _appBar(),
                _artistImage(),
                _songInfoAndFavorit(),
                _songSliderAndPlayer(context),
                Spacer(),
                _lyrics(),
              ],
            ),
          ),
        )),
      ),
    );
  }

  Widget _appBar() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 28.w),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          GestureDetector(
            onTap: () {
              Navigator.pop(context);
            },
            child: Container(
              width: 32.w,
              height: 32.h,
              decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: isDarkMode
                      ? Color(0xffffffff).withAlpha((255 * 0.04).toInt())
                      : Color(0xff000000).withAlpha((255 * 0.04).toInt())),
              child: Icon(
                Icons.arrow_back_ios_rounded,
                color: isDarkMode ? Color(0xffDDDDDD) : Color(0xff414141),
                size: 20.r,
              ),
            ),
          ),
          Text(
            "Now Playing",
            style: TextStyle(
                color: isDarkMode ? Color(0xffDDDDDD) : Color(0xff000000),
                fontSize: 18.sp,
                fontWeight: FontWeight.w700),
          ),
          GestureDetector(
            onTap: () {
              // Navigator.pop(context);
            },
            child: Container(
              width: 32.w,
              height: 32.h,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
              ),
              child: Icon(
                IconData(0xf142, fontFamily: 'FontAwesome6ProRegular'),
                size: null,
                color: isDarkMode ? Color(0xffDDDDDD) : Color(0xff7d7d7d),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _artistImage() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 28.w),
      child: Container(
        margin: EdgeInsets.only(top: 29.h, left: 0.w),
        padding: EdgeInsets.symmetric(vertical: 0.h, horizontal: 0.w),
        width: double.infinity,
        height: MediaQuery.of(context).size.height > 850 ? 370.h : 340.h,
        alignment: Alignment.centerLeft,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(30.r),
          child: CachedNetworkImage(
            imageUrl: widget.song.thumbanil!,
            fadeInDuration: Duration(seconds: 0),
            fit: BoxFit.cover,
            width: double.infinity,
            height: double.infinity,
            placeholder: (context, url) => Container(
              color: Colors.grey[300], // or CircularProgressIndicator()
            ),
            errorWidget: (context, url, error) => Icon(Icons.error),
          ),
        ),
      ),
    );
  }

  Widget _songInfoAndFavorit() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 28.w),
      child: Container(
        margin: EdgeInsets.only(top: 17.h, left: 0.w),
        padding: EdgeInsets.symmetric(vertical: 0.h, horizontal: 0.w),
        width: null,
        height: null,
        alignment: Alignment.centerLeft,
        decoration: BoxDecoration(),
        child: Row(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.song.title!,
                  style: TextStyle(
                      color: isDarkMode ? Color(0xffDFDFDF) : Color(0xff000000),
                      fontSize: 20.sp,
                      fontWeight: FontWeight.w700),
                ),
                SizedBox(height: 7.h),
                Text(
                  widget.song.artitst!,
                  style: TextStyle(
                      color: isDarkMode ? Color(0xffBABABA) : Color(0xff404040),
                      fontSize: 20.sp,
                      fontWeight: FontWeight.w400),
                )
              ],
            ),
            Spacer(),
            IconButton(
                onPressed: () async {
                  setState(() {
                    isFavorite = !isFavorite;
                  });
                  await context
                      .read<FavoriteSongsCubit>()
                      .toggleFavoriteSong(widget.song.songId!);
                  context.read<FavoriteSongsCubit>().fetchFavoriteSongs();
                },
                icon: Icon(
                  IconData(0xf004,
                      fontFamily: (isFavorite
                          ? 'FontAwesome6ProSolid'
                          : 'FontAwesome6ProLight')),
                  size: 24.r,
                  color: isDarkMode ? Color(0xff6C6C6C) : Color(0xff6c6c6c),
                )),
          ],
        ),
      ),
    );
  }

  Widget _songSliderAndPlayer(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 6.w),
      child: BlocBuilder<SongPlayerCubit, SongPlayerState>(
        builder: (context, state) {
          if (state is SongPlayerLoading) CircularProgressIndicator.adaptive();
          if (state is SongPlayerLoaded) {
            return Container(
              margin: EdgeInsets.only(top: 30.h, left: 0.w),
              padding: EdgeInsets.symmetric(vertical: 0.h, horizontal: 0.w),
              width: null,
              height: null,
              alignment: Alignment.centerLeft,
              decoration: BoxDecoration(),
              child: Column(
                children: [
                  SizedBox(
                    width: double.infinity,
                    child: Slider.adaptive(
                      allowedInteraction: SliderInteraction.tapAndSlide,
                      value: _dragValue ??
                          context
                              .read<SongPlayerCubit>()
                              .songPosition
                              .inSeconds
                              .toDouble(),
                      min: 0,
                      max: context
                          .read<SongPlayerCubit>()
                          .songDuration
                          .inSeconds
                          .toDouble(),
                      onChanged: (value) {
                        setState(() {
                          _dragValue = value; // update UI while dragging
                        });
                      },
                      onChangeEnd: (value) {
                        context
                            .read<SongPlayerCubit>()
                            .audioPlayer
                            .seek(Duration(seconds: value.toInt()));
                        _dragValue = null;
                      },
                      activeColor:
                          isDarkMode ? Color(0xffB7B7B7) : Color(0xff5c5c5c),
                      inactiveColor: isDarkMode
                          ? Color(0xff888888).withAlpha((255 * 0.3).toInt())
                          : Color(0xff000000).withAlpha((255 * 0.3).toInt()),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 22.w),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          formatDuration(
                            _dragValue != null
                                ? Duration(seconds: _dragValue!.toInt())
                                : context.read<SongPlayerCubit>().songPosition,
                          ),
                          style: TextStyle(
                              color: isDarkMode
                                  ? Color(0xff878787)
                                  : Color(0xff404040),
                              fontSize: 12.sp,
                              fontWeight: FontWeight.w500),
                        ),
                        Text(
                          formatDuration(
                              context.read<SongPlayerCubit>().songDuration),
                          style: TextStyle(
                              color: isDarkMode
                                  ? Color(0xff878787)
                                  : Color(0xff404040),
                              fontSize: 12.sp,
                              fontWeight: FontWeight.w500),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 15.h),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      IconButton(
                        onPressed: () {},
                        icon: Icon(
                          IconData(0xf363, fontFamily: 'FontAwesome6ProSolid'),
                          size: 23.r,
                          color: isDarkMode
                              ? Color(0xff6D6D6D)
                              : Color.fromARGB(255, 143, 143, 143),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 5.w),
                        child: IconButton(
                          onPressed: () {},
                          icon: Icon(
                            IconData(0xf048,
                                fontFamily: 'FontAwesome6ProSolid'),
                            size: 23.r,
                            color: isDarkMode
                                ? Color(0xffA7A7A7)
                                : Color(0xff363636),
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          context.read<SongPlayerCubit>().playPauseSong();
                        },
                        child: Padding(
                          padding: EdgeInsets.symmetric(horizontal: 5.w),
                          child: Container(
                            width: 72.w,
                            height: 72.h,
                            decoration: BoxDecoration(
                              color: AppColors.primary,
                              shape: BoxShape.circle,
                            ),
                            child: Icon(
                              context
                                      .read<SongPlayerCubit>()
                                      .audioPlayer
                                      .playing
                                  ? Icons.pause
                                  : Icons.play_arrow_rounded,
                              color: Colors.white,
                              size: 36.r,
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 5.w),
                        child: IconButton(
                          onPressed: () {},
                          icon: Icon(
                            IconData(0xf051,
                                fontFamily: 'FontAwesome6ProSolid'),
                            size: 23.r,
                            color: isDarkMode
                                ? Color(0xffA7A7A7)
                                : Color(0xff363636),
                          ),
                        ),
                      ),
                      IconButton(
                        onPressed: () {},
                        icon: Icon(
                          IconData(0xf074,
                              fontFamily: 'FontAwesome6ProRegular'),
                          size: 23.r,
                          color: isDarkMode
                              ? Color(0xff6D6D6D)
                              : Color(0xff7e7e7e),
                        ),
                      ),
                    ],
                  )
                ],
              ),
            );
          }
          return Container();
        },
      ),
    );
  }

  String formatDuration(Duration duration) {
    final minutes = duration.inMinutes.remainder(60);
    final seconds = duration.inSeconds.remainder(60);

    final minuteStr =
        minutes < 10 ? '$minutes' : minutes.toString().padLeft(2, '0');
    final secondStr = seconds.toString().padLeft(2, '0');

    return '$minuteStr:$secondStr';
  }

  Widget _lyrics() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        ClipRRect(
          borderRadius: BorderRadiusGeometry.circular(10.r),
          child: InkWell(
            onTap: () {},
            child: Column(
              children: [
                Icon(
                  IconData(0xf106, fontFamily: 'FontAwesome6ProSolid'),
                  size: null,
                  color: isDarkMode ? Color(0xff8C8989) : Color(0xff414141),
                ),
                Text(
                  "Lyrics",
                  style: TextStyle(
                      color: isDarkMode ? Color(0xffB9B9B9) : Color(0xff404040),
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w500),
                )
              ],
            ),
          ),
        )
      ],
    );
  }
}
