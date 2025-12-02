import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:spotify/core/configs/assets/app_images.dart';
import 'package:spotify/core/configs/assets/app_vectors.dart';
import 'package:spotify/src/presentation/authentication/pages/register_signin_screen.dart';
import 'package:spotify/src/presentation/chose_mode/cubits/theme_cubit.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ChoseModeScreen extends StatefulWidget {
  const ChoseModeScreen({super.key});

  @override
  State<ChoseModeScreen> createState() => _ChoseModeScreenState();
}

class _ChoseModeScreenState extends State<ChoseModeScreen> {
  bool isLightMode = false;
  bool isDarktMode = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff3c261e),
      body: Stack(
        children: [
          // the background Image
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage(AppImages.choseModeBackground),
                  fit: BoxFit.cover),
            ),
          ),
          Container(
            margin: EdgeInsets.only(top: 0.h, left: 0.w),
            padding: EdgeInsets.symmetric(vertical: 0.h, horizontal: 0.w),
            color: const Color.fromARGB(141, 0, 0, 0),
            width: double.infinity,
            height: double.infinity,
            alignment: Alignment.centerLeft,
            decoration: null,
            child: null,
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
            bottom: 229.h,
            right: 80.w,
            left: 80.w,
            child: Column(
              children: [
                Text(
                  "Chose Mode",
                  style: TextStyle(
                      color: Color(0xffdadada),
                      fontSize: 25.sp,
                      fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 31.h),
                Row(
                  children: [
                    Column(
                      children: [
                        InkWell(
                          onTap: () {
                            context
                                .read<ThemeCubit>()
                                .updateAppTheme(ThemeMode.dark);
                            setState(() {
                              isDarktMode = !isDarktMode;
                              isLightMode = false;
                            });
                          },
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(
                                50), // same radius as your container
                            child: BackdropFilter(
                              filter:
                                  ImageFilter.blur(sigmaX: 100, sigmaY: 100),
                              child: Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(50.r),
                                  color: isDarktMode
                                      ? const Color.fromARGB(224, 122, 122, 122)
                                      : const Color.fromARGB(30, 199, 199, 199),
                                ),
                                width: 73.w,
                                height: 73.h,
                                child: Image.asset(AppImages.moonIcon),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: 17.h),
                        Text(
                          "Dark Mode",
                          style: TextStyle(
                              color: Color(0xffdadada),
                              fontSize: 17.sp,
                              fontWeight: FontWeight.w500),
                        )
                      ],
                    ),
                    Spacer(),
                    Column(
                      children: [
                        GestureDetector(
                          onTap: () {
                            context
                                .read<ThemeCubit>()
                                .updateAppTheme(ThemeMode.light);
                            setState(() {
                              isLightMode = !isLightMode;
                              isDarktMode = false;
                            });
                          },
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(50.r),
                            child: BackdropFilter(
                              filter:
                                  ImageFilter.blur(sigmaX: 100, sigmaY: 100),
                              child: Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(50.r),
                                  color: isLightMode
                                      ? const Color.fromARGB(224, 122, 122, 122)
                                      : const Color.fromARGB(30, 199, 199, 199),
                                ),
                                width: 73.w,
                                height: 73.h,
                                child: Padding(
                                  padding: EdgeInsets.all(20.w),
                                  child: SvgPicture.asset(
                                    AppVectors.sunIcon,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: 17.h),
                        Text(
                          "Light Mode",
                          style: TextStyle(
                              color: Color(0xffdadada),
                              fontSize: 17.sp,
                              fontWeight: FontWeight.w500),
                        )
                      ],
                    ),
                  ],
                )
              ],
            ),
          ),

          // tthe button,
          Positioned(
            bottom: 69.h,
            right: 28.w,
            left: 28.w,
            child: ElevatedButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => RegisterSigninScreen()));
              },
              style: ElevatedButton.styleFrom(
                  padding:
                      EdgeInsets.symmetric(horizontal: 10.w, vertical: 31.h)),
              child: Text(
                "Continue",
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
