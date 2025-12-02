import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:spotify/common/helpers/is_dark_mode.dart';
import 'package:spotify/core/configs/assets/app_vectors.dart';
import 'package:spotify/core/configs/theme/app_colors.dart';
import 'package:spotify/injection_container.dart';
import 'package:spotify/src/data/models/auth/user_model.dart';
import 'package:spotify/src/logic/usecases/auth/register_usecase.dart';
import 'package:spotify/src/presentation/authentication/pages/signin_screen.dart';
import 'package:spotify/src/presentation/home/pages/homepage.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();
  bool obscureText = true;
  String name = "";
  String email = "";
  String password = "";

  void submit() async {
    if (_formkey.currentState!.validate()) {
      _formkey.currentState!.save();

      var either = await getIt<RegisterUsecase>().call(
          params: UserModel(fullName: name, email: email, password: password));
      either.fold(
        (failure) {
          print(failure);
          // fialure goes here

          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(
                failure,
                style: TextStyle(
                    color: Color(0xffffffff),
                    fontSize: null,
                    fontWeight: FontWeight.w400),
              ),
              duration: Duration(seconds: 7),
            ),
          );
        },
        (user) {
          // success goes here
          Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(
              builder: (context) => Homepage(),
            ),
            (route) => false,
          );
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    bool isDarkMode = context.isDarkMode;
    return Scaffold(
      body: Stack(
        children: [
          // icon go back,
          Positioned(
            top: 36.h,
            left: 22.w,
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
          // logo,
          Positioned(
            top: 36.h,
            left: null,
            right: 140.w,
            child: SvgPicture.asset(
              AppVectors.splashLogo,
              width: 108.w,
            ),
          ),
          // column of data,
          Positioned(
            top: 100.h,
            left: 28.w,
            right: 28.w,
            child: Column(
              children: [
                Text(
                  "Register",
                  style: TextStyle(
                      color: isDarkMode ? Color(0xfff2f2f2) : Color(0xff383838),
                      fontSize: 30.sp,
                      fontWeight: FontWeight.w700),
                ),
                SizedBox(height: 21.h),
                RichText(
                  text: TextSpan(
                    text: "If You Need Any Support ",
                    style: TextStyle(
                        color:
                            isDarkMode ? Color(0xffe1e1e1) : Color(0xff383838),
                        fontSize: 12.sp,
                        fontWeight: FontWeight.w400),
                    children: [
                      TextSpan(
                          text: "Click Here",
                          style: TextStyle(
                              color: AppColors.primary,
                              fontSize: null,
                              fontWeight: FontWeight.w400),
                          recognizer: TapGestureRecognizer()..onTap = () {}),
                    ],
                  ),
                ),
                //
                SizedBox(height: 26.h),
                // start form fields
                Form(
                  key: _formkey,
                  child: Column(
                    children: [
                      // Full name field
                      TextFormField(
                        cursorColor: isDarkMode
                            ? Color(0xffe1e1e1)
                            : Color(0xff383838).withAlpha(150),
                        keyboardType: TextInputType.name,
                        style: TextStyle(
                            color: isDarkMode
                                ? Color(0xffe1e1e1)
                                : Color(0xff383838),
                            fontSize: 18.sp,
                            fontWeight: FontWeight.w600),
                        decoration: InputDecoration()
                            .applyDefaults(
                                Theme.of(context).inputDecorationTheme)
                            .copyWith(
                              hintText: "Full Name",
                            ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Full name is required';
                          }
                          // Optional: ensure at least two words
                          if (!value.trim().contains(' ')) {
                            return 'Enter your first and last name';
                          }
                          return null;
                        },
                        onSaved: (newValue) {
                          name = newValue!;
                        },
                      ),
                      SizedBox(height: 16.h),
                      // Emeail field
                      TextFormField(
                        cursorColor: isDarkMode
                            ? Color(0xffe1e1e1)
                            : Color(0xff383838).withAlpha(150),
                        keyboardType: TextInputType.emailAddress,
                        style: TextStyle(
                            color: isDarkMode
                                ? Color(0xffe1e1e1)
                                : Color(0xff383838),
                            fontSize: 18.sp,
                            fontWeight: FontWeight.w600),
                        decoration: InputDecoration()
                            .applyDefaults(
                                Theme.of(context).inputDecorationTheme)
                            .copyWith(
                              hintText: "Enter Email",
                            ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Email is required';
                          }
                          // Basic email regex
                          final emailRegex =
                              RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
                          if (!emailRegex.hasMatch(value)) {
                            return 'Enter a valid email';
                          }
                          return null;
                        },
                        onSaved: (newValue) {
                          email = newValue!;
                        },
                      ),
                      SizedBox(height: 16.h),
                      // Password field
                      TextFormField(
                        obscureText: obscureText,
                        cursorColor: isDarkMode
                            ? Color(0xffe1e1e1)
                            : Color(0xff383838).withAlpha(150),
                        keyboardType: TextInputType.text,
                        style: TextStyle(
                            color: isDarkMode
                                ? Color(0xffe1e1e1)
                                : Color(0xff383838),
                            fontSize: 18.sp,
                            fontWeight: FontWeight.w600),
                        decoration: InputDecoration()
                            .applyDefaults(
                                Theme.of(context).inputDecorationTheme)
                            .copyWith(
                              hintText: "Password",
                              suffixIcon: Padding(
                                padding: EdgeInsets.only(right: 32.w),
                                child: GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      obscureText = !obscureText;
                                    });
                                  },
                                  child: Icon(
                                    obscureText
                                        ? IconData(0xf06e,
                                            fontFamily:
                                                'FontAwesome6ProRegular')
                                        : IconData(0xf070,
                                            fontFamily:
                                                'FontAwesome6ProRegular'),
                                    size: 27.r,
                                  ),
                                ),
                              ),
                              suffixIconColor: isDarkMode
                                  ? Color(0xff5b5b5b)
                                  : Color(0xff383838).withAlpha(100),
                            ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Password is required';
                          }
                          if (value.length < 8) {
                            return 'Password must be at least 8 characters';
                          }
                          // Optional: require at least one number and one letter
                          if (!RegExp(r'^(?=.*[A-Za-z])(?=.*\d)')
                              .hasMatch(value)) {
                            return 'Password must contain letters and numbers';
                          }
                          return null;
                        },
                        onSaved: (newValue) {
                          password = newValue!;
                        },
                      ),
                      SizedBox(height: 34.h),
                      // submit button
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                            onPressed: submit,
                            style: ElevatedButton.styleFrom(
                              padding: EdgeInsets.symmetric(
                                  vertical: 30.h, horizontal: 20.w),
                            ),
                            child: Text(
                              textAlign: TextAlign.center,
                              "Create Account",
                              style: TextStyle(
                                  color: Color(0xffffffff),
                                  fontSize: 20.sp,
                                  fontWeight: FontWeight.w700),
                            )),
                      ),
                      SizedBox(height: 28.h),
                      // or other lines
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset(
                            "assets/images/line_auth_left.png",
                            width: 150.w,
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 8.w),
                            child: Text(
                              "Or",
                              style: TextStyle(
                                  color: isDarkMode
                                      ? Color(0xff383838)
                                      : Color(0xff383838),
                                  fontSize: 12.sp,
                                  fontWeight: FontWeight.w400),
                            ),
                          ),
                          Image.asset(
                            "assets/images/line_auth_right.png",
                            width: 150.w,
                          ),
                        ],
                      ),
                      SizedBox(height: 30.h),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset("assets/images/google_icon.png"),
                          SizedBox(width: 60.w),
                          Image.asset(
                            "assets/images/apple_icon.png",
                            color: isDarkMode ? Color(0xffd3d3d3) : null,
                          ),
                        ],
                      ),
                      SizedBox(height: 35.h),
                      RichText(
                        text: TextSpan(
                          text: "Do You Have An Account? ",
                          style: TextStyle(
                              color: isDarkMode
                                  ? Color(0xffdbdbdb)
                                  : Color(0xff383838),
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w500),
                          children: [
                            TextSpan(
                                text: "Sign In",
                                style: TextStyle(
                                    color: Color(0xff288CE9),
                                    fontSize: null,
                                    fontWeight: FontWeight.w700),
                                recognizer: TapGestureRecognizer()
                                  ..onTap = () {
                                    Navigator.of(context)
                                        .push(MaterialPageRoute(
                                      builder: (context) => SigninScreen(),
                                    ));
                                  }),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
