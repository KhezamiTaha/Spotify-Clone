import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:spotify/common/helpers/is_dark_mode.dart';
import 'package:spotify/core/configs/theme/app_colors.dart';

class CustomBottomNavbar extends StatelessWidget {
  final int selectedIndex;
  final void Function(int index) onPageSelected;

  const CustomBottomNavbar(
      {super.key, required this.selectedIndex, required this.onPageSelected});

  @override
  Widget build(BuildContext context) {
    bool isDarkMode = context.isDarkMode;
    final icons = [
      "assets/images/filled_home_icon.svg",
      "assets/images/filled_explore_icon.svg",
      "assets/images/filled_favorite_icon.svg",
      "assets/images/filled_profile_icon.svg",
      "assets/images/home_icon.svg",
      "assets/images/explore_icon.svg",
      "assets/images/favorite_icon.svg",
      "assets/images/profile_icon.svg",
    ];

    double bottonmPadding = MediaQuery.of(context).padding.bottom;
    bool isNavigationEnabled = bottonmPadding > 27;

    return Container(
      height: isNavigationEnabled ? 73.h + bottonmPadding.h : 73.h,
      padding: isNavigationEnabled
          ? EdgeInsets.only(bottom: bottonmPadding.h)
          : null,
      // margin: isNavigationEnabled? EdgeInsets.only(bottom: 30): null,
      decoration: BoxDecoration(
        color:
            isDarkMode ? Color(0xff343434) : const Color.fromARGB(255, 255, 255, 255),
        // boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 0)],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: List.generate(
          (4),
          (index) {
            final isSelected = index == selectedIndex;
            return GestureDetector(
              behavior: HitTestBehavior.translucent,
              onTap: () => onPageSelected(index),
              child: Container(
                constraints: BoxConstraints(minWidth: 70.w),
                child: Column(
                  children: [
                    AnimatedContainer(
                      duration: const Duration(milliseconds: 100),
                      margin: EdgeInsets.only(bottom: 21.h),
                      height: 4.h,
                      width: 23.w,
                      decoration: BoxDecoration(
                        color:
                            isSelected ? AppColors.primary : Colors.transparent,
                        borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(3),
                            bottomRight: Radius.circular(3)),
                      ),
                    ),
                    AnimatedScale(
                      scale: isSelected ? 1.17 : 1,
                      duration: Duration(milliseconds: 200),
                      child: SvgPicture.asset(
                        // width: 24.r,
                        isSelected ? icons[index] : icons[index + 4],
                        colorFilter: index != 1
                            ? ColorFilter.mode(
                                isSelected
                                    ? AppColors.primary
                                    :(    isDarkMode ? Color(0xff737373) :   Color(0xff808080)) ,
                                BlendMode.srcIn)
                            : null,
                      ),
                    )
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
