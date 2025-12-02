import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:spotify/common/helpers/is_dark_mode.dart';
import 'package:spotify/core/configs/assets/app_vectors.dart';
import 'package:spotify/core/configs/theme/app_colors.dart';
import 'package:spotify/main.dart';
import 'package:spotify/src/data/models/songs/song_model.dart';
import 'package:spotify/src/presentation/chose_mode/cubits/theme_cubit.dart';
import 'package:spotify/src/presentation/chose_mode/pages/chose_mode_screen.dart';
import 'package:spotify/src/presentation/home/cubits/favorite_songs_cubit.dart';
import 'package:spotify/src/presentation/home/cubits/songs_cubit.dart';
import 'package:spotify/src/presentation/home/widgets/container_box_decoration.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:spotify/src/presentation/home/widgets/custom_bottom_navbar.dart';
import 'package:spotify/src/presentation/profile/pages/profile_screen.dart';
import 'package:spotify/src/presentation/song/pages/song_player_screen.dart';

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage>
    with SingleTickerProviderStateMixin, RouteAware {
  late TabController _tabController;

  late List<String> favoriteSongs;
  int _selectedIndex = 0;

  bool isNavigationEnabled = false;
  bool isSmall = false;

  bool isDarkMode = false;

  @override
  void initState() {
    super.initState();
    context.read<SongsCubit>().fetchSongs();
    _tabController = TabController(length: 4, vsync: this);

    favoriteSongs = context.read<FavoriteSongsCubit>().favoriteSongs;
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    routeObserver.subscribe(this, ModalRoute.of(context)!);
  }

  @override
  void dispose() {
    _tabController.dispose();
    routeObserver.unsubscribe(this);
    super.dispose();
  }

  @override
  void didPopNext() {}

  void onPageSelected(int index) async {
    if (index == 3) {
      final indexPassed = await Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ProfileScreen(),
          ));
      setState(() {
        _selectedIndex = indexPassed;
      });
    } else {
      setState(() {
        _selectedIndex = index;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    isDarkMode = context.isDarkMode;
    double bottonPadding = MediaQuery.of(context).padding.bottom;
    isNavigationEnabled = bottonPadding > 27;
    isSmall = MediaQuery.of(context).size.height < 750;

    // print(" width in the homepage:   ${MediaQuery.of(context).size.width}");
    // print(" height in the homepage:   ${MediaQuery.of(context).size.height}");
    // print(
    //     " bottom padding in the homepage:   ${MediaQuery.of(context).padding.bottom}");
    return Scaffold(
      // backgroundColor: Colors.redAccent,
      body: Padding(
        padding: EdgeInsets.only(top: 29.h),
        child: Column(
          children: [
            _hero(),
            Expanded(
              child: SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: Column(
                  children: [
                    _tabbar(),
                    _tabview(),
                    // SizedBox(height: (242 + 26).h, child: _tabview()),
                    _playlist(),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
      bottomNavigationBar: CustomBottomNavbar(
          selectedIndex: _selectedIndex, onPageSelected: onPageSelected),
    );
  }

  Widget _hero() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 28.w),
      child: SizedBox(
        height: !isNavigationEnabled ? 204.h : 193.h,
        child: Stack(
          children: [
            Positioned(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  InkWell(
                    onTap: () {
                      FirebaseAuth.instance.signOut();
                      Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ChoseModeScreen(),
                          ),
                          (route) => false);
                    },
                    child: SizedBox(
                      width: 48.w,
                      height: 48.h,
                      child: Padding(
                        padding: EdgeInsets.only(right: 9.w, bottom: 13.h),
                        child: Icon(
                          IconData(0xe65f,
                              fontFamily: 'FontAwesome6ProRegular'),
                          size: 25.r,
                          color: isDarkMode
                              ? Color(0xffcfcfcf)
                              : Color(0xff2d264b),
                        ),
                      ),
                    ),
                  ),
                  // SizedBox(width: 66.w),
                  SvgPicture.asset(
                    AppVectors.splashLogo,
                    width: 108.w,
                  ),
                  // SizedBox(width: 99.w),
                  ClipRRect(
                    borderRadius: BorderRadiusGeometry.circular(20.r),
                    child: InkWell(
                      splashColor: Colors.transparent,
                      borderRadius: BorderRadius.circular(40.r),
                      onTap: () {
                        if (isDarkMode) {
                          context
                              .read<ThemeCubit>()
                              .updateAppTheme(ThemeMode.light);
                        } else {
                          context
                              .read<ThemeCubit>()
                              .updateAppTheme(ThemeMode.dark);
                        }
                        setState(() {});
                      },
                      child: SizedBox(
                        width: 48.w,
                        height: 48.h,
                        child: Padding(
                          padding: EdgeInsets.only(bottom: 9.h, left: 19.w),
                          child: Icon(
                            IconData(!isDarkMode ? 0xf186 : 0xe0c9,
                                fontFamily: 'FontAwesome6ProSolid'),
                            size: null,
                            color: isDarkMode
                                ? Color(0xffcfcfcf)
                                : Color.fromARGB(255, 87, 87, 87),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            // putting the card,
            Positioned(
              top: 57.h,
              right: 0,
              left: 0,
              child: Card(
                // elevation: 2,
                color: AppColors.primary,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30.r),
                ),
                child: Padding(
                  padding:
                      EdgeInsets.symmetric(horizontal: 19.w, vertical: 14.h),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "New Album",
                        style: TextStyle(
                            color: Color(0xfffbfbfb),
                            fontSize: 10.sp,
                            fontWeight: FontWeight.w500),
                      ),
                      Text(
                        "Happier Than\nEver",
                        style: TextStyle(
                            color: Color(0xfffbfbfb),
                            fontSize: 19.sp,
                            fontWeight: FontWeight.w700),
                      ),
                      Text(
                        "Hamza Namira",
                        style: TextStyle(
                            color: Color(0xfffbfbfb),
                            fontSize: 13.sp,
                            fontWeight: FontWeight.w500),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            // shpae image,
            Positioned(
              top: 67.h,
              right: 10.w,
              child: Image.asset(
                "assets/images/union_top.png",
                width: 100.w,
              ),
            ),
            // image of singer,
            Positioned(
                top: 17.h,
                right: 30.w,
                child: Image.asset(
                  "assets/images/hamza_homepage.png",
                  width: 210.w,
                ))
          ],
        ),
      ),
    );
  }

  Widget _tabbar() {
    return Container(
      margin: EdgeInsets.only(top: 3.h, left: 34.w),
      padding: EdgeInsets.symmetric(vertical: 0, horizontal: 0),
      width: null,
      height: null,
      alignment: Alignment.centerLeft,
      decoration: ContainerBoxDecoration(),
      child: TabBar(
        controller: _tabController,
        dividerColor: Colors.transparent,
        indicatorColor: AppColors.primary,
        indicatorSize: TabBarIndicatorSize.label,
        indicatorPadding: EdgeInsets.symmetric(horizontal: 6.w, vertical: 8.h),
        isScrollable: true,
        tabAlignment: TabAlignment.start,
        labelPadding:
            EdgeInsets.only(left: 2.w, right: 44.w, top: 0, bottom: 0),
        labelStyle: TextStyle(
            color: isDarkMode ? Color(0xffdbdbdb) : Color(0xff000000),
            fontSize: 20.sp,
            fontWeight: FontWeight.w500),
        unselectedLabelStyle: TextStyle(
            color: isDarkMode ? Color(0xff616161) : Color(0xffbebebe),
            fontSize: 20.sp,
            fontWeight: FontWeight.w500),
        splashFactory: NoSplash.splashFactory,
        tabs: [
          Tab(
            text: "News",
          ),
          Tab(
            text: "Video",
          ),
          Tab(
            text: "Artists",
          ),
          Tab(
            text: "Podcasts",
          ),
        ],
      ),
    );
  }

  Widget _tabview() {
    return SizedBox(
      height: (247 + 26).h,
      child: TabBarView(
        controller: _tabController,
        children: [
          BlocBuilder<SongsCubit, SongsState>(
            builder: (context, state) {
              if (state is FetchingSongSuccess) {
                var songs = state.songs;
                return Container(
                  margin: EdgeInsets.only(
                      top: !isNavigationEnabled ? 24.h : 10.h, left: 28.w),
                  padding: EdgeInsets.symmetric(vertical: 0, horizontal: 0),
                  width: null,
                  height: (242).h,
                  alignment: Alignment.centerLeft,
                  decoration: ContainerBoxDecoration(),
                  child: ListView.separated(
                    separatorBuilder: (context, index) => SizedBox(width: 14.w),
                    scrollDirection: Axis.horizontal,
                    itemCount: songs.length,
                    itemBuilder: (context, index) {
                      return _newsSong(songs[index]);
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
          Center(child: Text("Videos", style: TextStyle(color: null, fontSize: 30, fontWeight: FontWeight.w500),)),
          Center(child: Text("Artists", style: TextStyle(color: null, fontSize: 30, fontWeight: FontWeight.w500),)),
          Center(child: Text("Podcasts", style: TextStyle(color: null, fontSize: 30, fontWeight: FontWeight.w500),)),

        ],
      ),
    );
  }

  Widget _newsSong(SongModel song) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => SongPlayerScreen(song: song),
            ));
      },
      child: Container(
        margin: EdgeInsets.only(top: 0, left: 0),
        padding: EdgeInsets.symmetric(vertical: 0, horizontal: 0),
        width: 147.w,
        height: isSmall ? 230.h : 240.h,
        decoration: ContainerBoxDecoration(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              // width: 147.w,
              // height: isSmall ? 230.h : 240.h,
              child: Stack(
                children: [
                  Container(
                    margin: EdgeInsets.only(top: 0, left: 0),
                    padding: EdgeInsets.symmetric(vertical: 0, horizontal: 0),
                    width: 147.w,
                    height: isSmall ? 180.h : 185.h,
                    alignment: Alignment.centerLeft,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(30.r),
                      child: CachedNetworkImage(
                        imageUrl: song.thumbanil!,
                        fadeInDuration: Duration(seconds: 0),
                        fit: BoxFit.cover,
                        width: double.infinity,
                        height: double.infinity,
                        placeholder: (context, url) => Container(
                          color: Colors
                              .grey[300], // or CircularProgressIndicator()
                        ),
                        errorWidget: (context, url, error) => Icon(Icons.error),
                      ),
                    ),
                  ),
                  // play button,
                  Positioned(
                    top: isSmall ? (160).h : (165).h,
                    right: 11.w,
                    child: Container(
                      margin: EdgeInsets.only(top: 0, left: 0),
                      padding: EdgeInsets.symmetric(vertical: 0, horizontal: 0),
                      width: 29.w,
                      height: 29.h,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                          color: isDarkMode
                              ? Color(0xff2c2c2c)
                              : Color(0xffe6e6e6),
                          shape: BoxShape.circle),
                      child: Icon(
                        IconData(0xf04b, fontFamily: 'FontAwesome6ProSolid'),
                        size: 14.r,
                        color:
                            isDarkMode ? Color(0xff959595) : Color(0xff555555),
                      ),
                    ),
                  ),
                  Positioned(
                    top: isSmall ? (180 + 13).h : (185 + 13).h,
                    child: Padding(
                      padding: EdgeInsets.only(left: 10.w),
                      child: Text(
                        song.title!,
                        style: TextStyle(
                            color: isDarkMode
                                ? Color(0xffe1e1e1)
                                : Color(0xff000000),
                            fontSize: 16.sp,
                            fontWeight: FontWeight.w700),
                      ),
                    ),
                  ),
                  Positioned(
                    top: isSmall ? (180 + 38).h : (185 + 38).h,
                    child: Padding(
                      padding: EdgeInsets.only(left: 10.w),
                      child: Text(
                        song.artitst!,
                        style: TextStyle(
                            color: isDarkMode
                                ? Color(0xffe1e1e1)
                                : Color(0xff000000),
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w400),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _playlist() {
    return Container(
      margin: EdgeInsets.only(
          top: !isNavigationEnabled ? (isSmall ? 37.h : 20.h) : 25.h,
          left: 28.w,
          right: 29.w),
      padding: EdgeInsets.symmetric(vertical: 0, horizontal: 0),
      constraints: BoxConstraints(maxHeight: 500.h),
      alignment: Alignment.centerLeft,
      decoration: ContainerBoxDecoration(),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
            padding: EdgeInsets.only(left: 6.w),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Playlist",
                  style: TextStyle(
                      color: isDarkMode ? Color(0xffDBDBDB) : Color(0xff131313),
                      fontSize: 20.sp,
                      fontWeight: FontWeight.w700),
                ),
                Text(
                  "See More",
                  style: TextStyle(
                      color: isDarkMode ? Color(0xffC6C6C6) : Color(0xff131313),
                      fontSize: 12.sp,
                      fontWeight: FontWeight.w400),
                )
              ],
            ),
          ),
          BlocBuilder<SongsCubit, SongsState>(
            builder: (context, state) {
              if (state is FetchingSongSuccess) {
                var playlistSongs = state.songs;
                var reversedPlaylist = playlistSongs.reversed.toList();
                return Expanded(
                  child: Container(
                    margin: EdgeInsets.only(top: 23.h),
                    padding: EdgeInsets.symmetric(vertical: 0, horizontal: 0),
                    width: null,
                    height: null,
                    decoration: ContainerBoxDecoration(),
                    child: ListView.separated(
                      padding: EdgeInsets.zero,
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      separatorBuilder: (context, index) =>
                          SizedBox(width: 19.h),
                      scrollDirection: Axis.vertical,
                      itemCount: reversedPlaylist.length,
                      itemBuilder: (context, index) {
                        return _plyslistSong(reversedPlaylist[index]);
                      },
                    ),
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
        ],
      ),
    );
  }

  Widget _plyslistSong(SongModel song) {
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
                  shape: BoxShape.circle,
                  color: isDarkMode ? Color(0xff2C2C2C) : Color(0xffe6e6e6),
                ),
                width: 37.w,
                height: 37.h,
                child: Icon(
                  IconData(0xf04b, fontFamily: 'FontAwesome6ProSolid'),
                  size: 14.r,
                  color: isDarkMode ? Color(0xff959595) : Color(0xff555555),
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
                        color:
                            isDarkMode ? Color(0xffD6D6D6) : Color(0xff000000),
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w700),
                  ),
                  Text(
                    song.artitst!,
                    style: TextStyle(
                        color:
                            isDarkMode ? Color(0xffD6D6D6) : Color(0xff000000),
                        fontSize: 12.sp,
                        fontWeight: FontWeight.w400),
                  ),
                ],
              ),
              Spacer(),
              Text(
                song.duration!,
                style: TextStyle(
                    color: isDarkMode ? Color(0xffD6D6D6) : Color(0xff000000),
                    fontSize: 15.sp,
                    fontWeight: FontWeight.w400),
              ),
              SizedBox(
                width: (49 - (48 - 21) / 2).w,
              ),
              IconButton(
                  onPressed: () {},
                  icon: Icon(
                    IconData(0xf004, fontFamily: 'FontAwesome6ProSolid'),
                    size: 21.r,
                    color: isDarkMode ? Color(0xff565656) : Color(0xffb4b4b4),
                  ))
            ],
          ),
        ),
      ),
    );
  }
}
