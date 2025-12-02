import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:spotify/common/helpers/is_dark_mode.dart';
import 'package:spotify/core/configs/assets/app_vectors.dart';
import 'package:spotify/src/presentation/authentication/pages/register_screen.dart';
import 'package:spotify/src/presentation/authentication/pages/signin_screen.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class RegisterSigninScreen extends StatefulWidget {
  const RegisterSigninScreen({super.key});

  @override
  State<RegisterSigninScreen> createState() => _RegisterSigninScreenState();
}

class _RegisterSigninScreenState extends State<RegisterSigninScreen> {
  @override
  Widget build(BuildContext context) {
    bool isDarkMode = context.isDarkMode;
    return Scaffold(
      body: Stack(
        children: [
          // icon go back,
          Positioned(
            top: 64.h,
            left: 28.w,
            child: GestureDetector(
              onTap: () {
                Navigator.pop(context);
              },
              child: Container(
                width: 33.w,
                height: 33.h,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: isDarkMode
                      ? Color(0xffffffff).withAlpha(8)
                      : Color(0xff000000).withAlpha(10),
                ),
                child: Center(
                  child: Icon(
                    Icons.arrow_back_ios_rounded,
                    color: isDarkMode ? Color(0xffdddddd) : Color(0xff414141),
                    size: 20.r,
                  ),
                ),
              ),
            ),
          ),

          // top shape
          Align(
            alignment: Alignment.topRight,
            child: Image.asset("assets/images/union_top.png"),
          ),
          Align(
            alignment: Alignment.bottomRight,
            child: Image.asset("assets/images/union_bottom.png"),
          ),
          Positioned(
            bottom: -10,
            left: -10,
            child: Image.asset("assets/images/register_billie.png"),
          ),
          Positioned(
              right: 35.w,
              left: 35.w,
              bottom: 340.h,
              child: Column(
                children: [
                  SvgPicture.asset(
                    AppVectors.splashLogo,
                    width: 235.w,
                  ),
                  SizedBox(height: 35.h),
                  Text(
                    "Enjoy Listening To Music",
                    style: TextStyle(
                        color:
                            isDarkMode ? Color(0xfff2f2f2) : Color(0xff383838),
                        fontSize: 26.sp,
                        fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 21.h),
                  SizedBox(
                    width: 306.w,
                    child: Text(
                      "Spotify is a proprietary Swedish audio streaming and media services provider ",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color:
                            isDarkMode ? Color(0xffa0a0a0) : Color(0xff797979),
                        fontSize: 17.sp,
                      ),
                    ),
                  ),
                  SizedBox(height: 30.h),
                  Row(
                    children: [
                      ElevatedButton(
                        onPressed: () {
                          Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => RegisterScreen(),
                          ));
                        },
                        style: ElevatedButton.styleFrom(
                            padding: EdgeInsets.symmetric(
                                horizontal: 38.w, vertical: 23.h)),
                        child: Text(
                          "Register",
                          style: TextStyle(
                              color: Color(0xffffffff),
                              fontSize: 19.sp,
                              fontWeight: FontWeight.w500),
                        ),
                      ),
                      SizedBox(width: 89.w),
                      TextButton(
                          onPressed: () {
                            Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => SigninScreen(),
                            ));
                          },
                          style: TextButton.styleFrom(
                              // padding: EdgeInsets.only(right: 35.w),

                              ),
                          child: Text(
                            "Sign in",
                            style: TextStyle(
                                color: context.isDarkMode
                                    ? Color(0xffd7d7d7)
                                    : Color(0xff313131),
                                fontSize: 19.sp,
                                fontWeight: FontWeight.w500),
                          ))
                    ],
                  )
                ],
              ))
        ],
      ),
    );
  }
}
