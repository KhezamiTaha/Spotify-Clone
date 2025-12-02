import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:spotify/core/configs/assets/app_images.dart';
import 'package:spotify/core/configs/assets/app_vectors.dart';
import 'package:spotify/src/presentation/chose_mode/pages/chose_mode_screen.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({super.key});

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  void redirect() {
    Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => ChoseModeScreen(),
        ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff0E111A),
      body: Stack(
        children: [
          // the background Image
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage(AppImages.welcomeGetStartedImage),
                  fit: BoxFit.cover),
            ),
          ),
          // the logo in the top
          Positioned(
            top: 56.h,
            right: 97.w,
            left: 97.w,
            child: SvgPicture.asset(AppVectors.splashLogo),
          ),
          // heading 1
          Positioned(
            bottom: 321.h,
            right: 40.w,
            left: 40.w,
            child: Text(
              "Enjoy Listening To Music",
              style: TextStyle(
                  color: Color(0xffdadada),
                  fontSize: 25.sp,
                  fontWeight: FontWeight.bold),
            ),
          ),
          // the description
          Positioned(
            bottom: 200.h,
            right: 53.w,
            left: 53.w,
            child: Text(
              textAlign: TextAlign.center,
              "Dive into a world of endless\n melodies. Explore playlists and enjoy the music that matches every mood  anytime, anywhere.",
              style: TextStyle(
                color: Color(0xff797979),
                fontSize: 17.sp,
              ),
            ),
          ),
          // tthe button,
          Positioned(
            bottom: 69.h,
            right: 28.w,
            left: 28.w,
            child: ElevatedButton(
              onPressed: redirect,
              style: ElevatedButton.styleFrom(
                  padding:
                      EdgeInsets.symmetric(horizontal: 10.w, vertical: 31.h)),
              child: Text(
                "Get Started",
                style: TextStyle(
                    color: Color(0xfff6f6f6),
                    fontSize: 22.sp,
                    fontWeight: FontWeight.bold),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
