import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:hexcolor/hexcolor.dart';

import '../contants.dart';
import '../controllers/welcom_controller.dart';
import '../custom_dialog.dart';

class WelcomeScreen extends StatelessWidget {
  final welcomeController = Get.put(WelcomeController(), permanent: true);

  // WelcomeController welcomeController = Get.find();
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () => showExitPopup(context),
      child: Obx(() {
        return Scaffold(
            backgroundColor: backgroundColor,
            body: SafeArea(
                child: welcomeController
                    .screens[welcomeController.currentIndex.value]),
            bottomNavigationBar: BottomNavigationBar(
              currentIndex: welcomeController.currentIndex.value,
              type: BottomNavigationBarType.fixed,
              backgroundColor: secondaryColor,
              iconSize: 5.sp,
              unselectedItemColor: grayColor,
              selectedItemColor: mainColor,
              unselectedLabelStyle:
                  TextStyle(fontSize: 10.0, color: HexColor('#A6A6A6')),
              selectedLabelStyle:
                  TextStyle(fontSize: 13.0, color:mainColor),
              items: [
                BottomNavigationBarItem(
                    icon: SizedBox(
                      height: 46.h,
                      child: Image.asset(
                        welcomeController.currentIndex.value == 0
                            ? "assets/images/color/coupon.png"
                            : 'assets/images/gray/coupon.png',
                        width: 37,
                        height: 29,
                      ),
                    ),
                    label: 'Home'),
                BottomNavigationBarItem(
                    icon: Image.asset(
                      welcomeController.currentIndex.value == 1
                          ? 'assets/images/color/brand.png'
                          : "assets/images/gray/brand.png",
                      width: 35,
                      height: 28
                      //color: Colors.grey,
                    ),
                    label: 'Brand'),
                BottomNavigationBarItem(
                  label: 'My Favorites',
                  icon: Image.asset(
                    welcomeController.currentIndex.value ==2
                        ? 'assets/images/color/favorite.png'
                        : "assets/images/gray/favorite.png",
                    width: 35,
                    height: 30,
                    //color: Colors.grey,
                  ),
                ),
                BottomNavigationBarItem(
                  label: 'More',
                  icon: Image.asset(
                    welcomeController.currentIndex.value == 3
                        ? 'assets/images/color/more.png'
                        : "assets/images/gray/more.png",
                    width: 35,
                    height: 30,
                    //color: Colors.grey,
                  ),
                ),
              ],
              onTap: (index) {
                welcomeController.currentIndex.value = index;
              },
            ));
      }),
    );
  }
}
