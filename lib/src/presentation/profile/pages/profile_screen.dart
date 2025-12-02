import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:spotify/common/helpers/is_dark_mode.dart';
import 'package:spotify/core/configs/theme/app_colors.dart';
import 'package:spotify/main.dart';
import 'package:spotify/src/data/models/songs/song_model.dart';
import 'package:spotify/src/presentation/home/cubits/favorite_songs_cubit.dart';
import 'package:spotify/src/presentation/home/cubits/songs_cubit.dart';
import 'package:spotify/src/presentation/home/widgets/custom_bottom_navbar.dart';
import 'package:spotify/src/presentation/song/pages/song_player_screen.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> with RouteAware {
  late List<String> favoriteSongs;
  int _selectedIndex = 3;
  bool isDarkMode = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    routeObserver.subscribe(this, ModalRoute.of(context)!);
  }

  @override
  void dispose() {
    routeObserver.unsubscribe(this);
    super.dispose();
  }

  @override
  void didPopNext() {
    // Runs when a route above is popped, and this screen becomes visible
    setState(() {
      favoriteSongs = context.read<FavoriteSongsCubit>().favoriteSongs;
    });
  }

  @override
  void initState() {
    super.initState();
    favoriteSongs = context.read<FavoriteSongsCubit>().favoriteSongs;
  }

  void onPageSelected(int index) {
    setState(() {
      _selectedIndex = index;
      if (_selectedIndex != 3) {
        Navigator.pop(context, index);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    isDarkMode = context.isDarkMode;
    return Scaffold(
      body: Column(
        children: [
          _porfileCard(),
          _favoritesSongsTitle(),
          _favoiteSongs(),
        ],
      ),
      bottomNavigationBar: CustomBottomNavbar(
          selectedIndex: _selectedIndex, onPageSelected: onPageSelected),
    );
  }

  Widget _porfileCard() {
    return Container(
      // padding: EdgeInsets.only(top: MediaQuery.of(context).padding.top),
      height: 318.h + MediaQuery.of(context).padding.top - 7,
      decoration: BoxDecoration(
        color: isDarkMode ? Color(0xff2c2b2b) : Colors.white,
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(66.w),
          bottomRight: Radius.circular(66.w),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            spreadRadius: 2,
            offset: Offset(0, 4),
          ),
        ],
      ),

      child: Stack(
        children: [
          Positioned(
            // width: 50.w,
            // height: double.infinity,
            top: MediaQuery.of(context).padding.top,
            // left: 0.w,

            child: Image.asset(
              "assets/images/union_profile.png",
              fit: BoxFit.cover,
              color: AppColors.primary,
            ),
          ),
          Positioned(
            child: Padding(
              padding: EdgeInsets.only(
                top: (MediaQuery.of(context).padding.top + 10),
                right: 23.w,
                left: 23.w,
              ),
              child: Column(
                children: [
                  Row(
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
                                  ? Color(0xffffffff)
                                      .withAlpha((255 * 0.04).toInt())
                                  : Color(0xff000000)
                                      .withAlpha((255 * 0.04).toInt())),
                          child: Icon(
                            Icons.arrow_back_ios_rounded,
                            color: isDarkMode
                                ? Color(0xffDDDDDD)
                                : Color(0xff414141),
                            size: 20.r,
                          ),
                        ),
                      ),
                      Text(
                        "Profile",
                        style: TextStyle(
                            color: isDarkMode
                                ? Color(0xffE6E6E6)
                                : Color(0xff383838),
                            fontSize: 17.sp,
                            fontWeight: FontWeight.w700),
                      ),
                      Material(
                        color: Colors.transparent, // keep it visually unchanged
                        child: InkWell(
                          onTap: () {
                            // Navigator.pop(context);
                          },
                          child: SizedBox(
                            width: 32.w,
                            height: 32.h,
                            child: Icon(
                              IconData(0xf142,
                                  fontFamily: 'FontAwesome6ProRegular'),
                              size: null,
                              color: isDarkMode
                                  ? Color(0xffA68C8C)
                                  : Color(0xff7d7d7d),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 20.h),
                  CircleAvatar(
                    radius: 45,
                    backgroundImage: AssetImage("assets/images/profile.jpg"),
                  ),
                  SizedBox(height: 11.h),
                  Text(
                    FirebaseAuth.instance.currentUser!.email!,
                    style: TextStyle(
                        color:
                            isDarkMode ? Color(0xffD8D4D4) : Color(0xff222222),
                        fontSize: 12.sp,
                        fontWeight: FontWeight.w400),
                  ),
                  SizedBox(height: 8.h),
                  Text(
                    "Khezami",
                    style: TextStyle(
                        color:
                            isDarkMode ? Color(0xffFFFFFF) : Color(0xff222222),
                        fontSize: 20.sp,
                        fontWeight: FontWeight.w700),
                  ),
                  SizedBox(height: 18.h),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Column(
                        children: [
                          Text(
                            "778",
                            style: TextStyle(
                                color: AppColors.primary,
                                fontSize: 20.sp,
                                fontWeight: FontWeight.w700),
                          ),
                          Text(
                            "Followers",
                            style: TextStyle(
                                color: AppColors.primary,
                                fontSize: 15.sp,
                                fontWeight: FontWeight.w600),
                          )
                        ],
                      ),
                      Column(
                        children: [
                          Text(
                            "257",
                            style: TextStyle(
                                color: AppColors.primary,
                                fontSize: 20.sp,
                                fontWeight: FontWeight.w700),
                          ),
                          Text(
                            "Following",
                            style: TextStyle(
                                color: AppColors.primary,
                                fontSize: 15.sp,
                                fontWeight: FontWeight.w600),
                          )
                        ],
                      ),
                    ],
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget _favoritesSongsTitle() {
    return Container(
      margin: EdgeInsets.only(top: 19.h, left: 28.w),
      padding: EdgeInsets.symmetric(vertical: 0.h, horizontal: 0.w),
      width: null,
      height: null,
      alignment: Alignment.centerLeft,
      decoration: BoxDecoration(),
      child: Text(
        'Favorite Songs',
        style: TextStyle(
            color: isDarkMode ? Color(0xffD6D6D6) : Color(0xff222222),
            fontSize: 15.sp,
            fontWeight: FontWeight.w700),
      ),
    );
  }

  Widget _favoiteSongs() {
    return Expanded(
      child: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.only(top: 17.h, left: 29.w, right: 25.w),
          padding: EdgeInsets.symmetric(vertical: 0.h, horizontal: 0.w),
          width: null,
          height: null,
          alignment: Alignment.centerLeft,
          decoration: BoxDecoration(),
          child: BlocBuilder<SongsCubit, SongsState>(
            builder: (context, state) {
              if (state is FetchingSongSuccess) {
                var playlistSongs = state.songs;
                var favoriteSongsList = playlistSongs
                    .where((song) => favoriteSongs.contains(song.songId))
                    .toList();
                return Container(
                  margin: EdgeInsets.only(top: 0.h),
                  padding: EdgeInsets.symmetric(vertical: 0.h, horizontal: 0.w),
                  width: null,
                  height: null,
                  decoration: BoxDecoration(),
                  child: ListView.separated(
                    padding: EdgeInsets.zero,
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    separatorBuilder: (context, index) => SizedBox(width: 19.h),
                    scrollDirection: Axis.vertical,
                    itemCount: favoriteSongsList.length,
                    itemBuilder: (context, index) {
                      return _favoritetSong(favoriteSongsList[index]);
                    },
                  ),
                );
              } else if (state is FetchingSongs) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              } else if (state is FetchingSongsFailed) {
                return Center(
                  child: Text("Failed to load songs"),
                );
              }
              return const Center(child: Text('Something went wrong'));
            },
          ),
        ),
      ),
    );
  }

  Widget _favoritetSong(SongModel song) {
    return Padding(
      padding: EdgeInsets.only(bottom: 19.h),
      child: GestureDetector(
        onTap: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => SongPlayerScreen(song: song),
              ));
        },
        child: Container(
          color: Colors.transparent,
          child: Row(
            children: [
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(14.r),
                  // color: Color(0xffe6e6e6),
                ),
                width: 58.w,
                height: 56.h,
                child: ClipRRect(
                  borderRadius: BorderRadiusGeometry.circular(14.r),
                  child: CachedNetworkImage(
                    imageUrl: song.thumbanil!,
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
              SizedBox(
                width: 23.w,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    song.title!,
                    style: TextStyle(
                        color:    isDarkMode ? Color(0xffE3E3E3) :   Color(0xff000000),
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w700),
                  ),
                  Text(
                    song.artitst!,
                    style: TextStyle(
                        color:    isDarkMode ? Color(0xffE3E3E3) :   Color(0xff000000),
                        fontSize: 12.sp,
                        fontWeight: FontWeight.w400),
                  ),
                ],
              ),
              Spacer(),
              Text(
                song.duration!,
                style: TextStyle(
                    color:    isDarkMode ? Color(0xffE3E3E3) :   Color(0xff000000),
                    fontSize: 15.sp,
                    fontWeight: FontWeight.w400),
              ),
              SizedBox(
                width: (49 - (48 - 21) / 2).w,
              ),
              IconButton(
                  onPressed: () {},
                  icon: Icon(
                    IconData(0xf141, fontFamily: 'FontAwesome6ProSolid'),
                    size: 21.r,
                    color:    isDarkMode ? Color(0xffE4E4E4) :   Color(0xffb4b4b4),
                  ))
            ],
          ),
        ),
      ),
    );
  }
}
