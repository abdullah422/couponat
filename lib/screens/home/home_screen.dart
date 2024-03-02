import 'package:carousel_slider/carousel_options.dart';
import 'package:carousel_slider/carousel_slider.dart';
import '../../controllers/auth_controller.dart';
import '/controllers/welcom_controller.dart';
import '/screens/coupons/coupons_screen.dart';
import '/screens/home/brand_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:transparent_image/transparent_image.dart';

import '../../contants.dart';
import '../../controllers/home_controller.dart';
import '../../custom_dialog.dart';
import 'home_coupon_Item.dart';

class HomeScreen extends StatelessWidget {
  final homeController = Get.find<AuthController>();

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () => showExitPopup(context),
      child: Obx(
        () => Scaffold(
          backgroundColor: mainColor,
          body: SafeArea(
            child: homeController.isLoading.value == true
                ? Center(
                    child: CircularProgressIndicator(
                      color: HexColor('#79BD9A'),
                    ),
                  )
                : Stack(
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Container(
                            height: 150.h,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(height: 18.h,),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      'Coupnaty',
                                      style: TextStyle(
                                          fontSize: 25.r,
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ],
                                ),
                                SizedBox(height: 10.h,),
                                Row(
                                  children: [
                                    SizedBox(width: 30.w,),
                                    Text(
                                      'Hi, Good Morning',
                                      style: TextStyle(
                                          fontSize: 18.r,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ],
                                ),
                                SizedBox(height: 5.h,),
                                Row(
                                  children: [
                                    SizedBox(width: 30.w,),
                                    Text(
                                      'We have exciting discounts for you',
                                      style: TextStyle(
                                          fontSize: 12.r,
                                          fontWeight: FontWeight.w500),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            // color: Colors.blue,
                          ),
                          Expanded(
                            child: Container(
                              decoration: BoxDecoration(
                                color: backgroundColor,
                                borderRadius: const BorderRadius.only(
                                  topLeft: Radius.circular(30),
                                  topRight: Radius.circular(30),
                                ),
                              ),
                              padding: EdgeInsets.symmetric(horizontal: 12.w),
                              child: SingleChildScrollView(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    SizedBox(
                                      height: 50.h,
                                    ),
                                    SizedBox(
                                      height: 15.h,
                                    ),
                                    Container(
                                      height: 146.h,
                                      decoration: BoxDecoration(
                                        borderRadius: const BorderRadius.all(
                                            Radius.circular(10)),
                                        color: backgroundColor,
                                      ),
                                      child: CarouselSlider(
                                        items: homeController.banners
                                            .map((e) => ClipRRect(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          20.sp),
                                                  child: Stack(
                                                    children: [
                                                      Center(
                                                        child:
                                                            CircularProgressIndicator(
                                                          color:
                                                              progressIndicatorColor,
                                                        ),
                                                      ),
                                                      FadeInImage.memoryNetwork(
                                                        placeholder:
                                                            kTransparentImage,
                                                        image: url + e.image,
                                                        fit: BoxFit.fill,
                                                        height: 146.h,
                                                        width: 404.w,
                                                      )
                                                    ],
                                                  ),
                                                ))
                                            .toList(),
                                        options: CarouselOptions(
                                          viewportFraction: 1.0,
                                          height: 200.0,
                                          autoPlay: true,
                                          initialPage: 0,
                                          enableInfiniteScroll: true,
                                          reverse: false,
                                          autoPlayInterval:
                                              const Duration(seconds: 3),
                                          autoPlayAnimationDuration:
                                              const Duration(seconds: 1),
                                          autoPlayCurve: Curves.easeInBack,
                                          scrollDirection: Axis.horizontal,
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      height: 16.h,
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          'Top Stores',
                                          style: TextStyle(
                                              fontSize: 20.r,
                                              fontWeight: FontWeight.bold),
                                        ),
                                        InkWell(
                                          onTap: () {
                                            Get.find<WelcomeController>()
                                                .currentIndex
                                                .value = 1;
                                          },
                                          child: Text(
                                            'Show All ...',
                                            style: TextStyle(
                                                fontWeight: FontWeight.w500,
                                                fontSize: 16.r),
                                          ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(
                                      height: 16.h,
                                    ),
                                    Container(
                                      height: 110.h,
                                      child: ListView.builder(
                                        itemBuilder: (context, index) {
                                          return BrandItem(
                                              brand:
                                                  homeController.brands[index],
                                              index: index);
                                        },
                                        itemCount: homeController.brands.length,
                                        scrollDirection: Axis.horizontal,
                                      ),
                                    ),
                                    SizedBox(
                                      height: 16.h,
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          'Top Coupons',
                                          style: TextStyle(
                                              fontSize: 20.r,
                                              fontWeight: FontWeight.bold),
                                        ),
                                        InkWell(
                                          onTap: () {
                                            Get.to(
                                              () => CouponsScreen(),
                                              preventDuplicates: false,
                                            );
                                          },
                                          child: Text(
                                            'Show All ...',
                                            style: TextStyle(
                                                fontWeight: FontWeight.w500,
                                                fontSize: 16.r),
                                          ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(
                                      height: 16.h,
                                    ),
                                    Container(
                                      height: 227.h,
                                      child: ListView.builder(
                                        itemBuilder: (context, index) {
                                          return HomeCouponItem(
                                            coupon:
                                                homeController.coupons[index],
                                            index: index,
                                          );
                                        },
                                        itemCount:
                                            homeController.coupons.length,
                                        scrollDirection: Axis.horizontal,
                                      ),
                                    ),
                                    SizedBox(
                                      height: 12.h,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      Positioned(
                        top: 120.h,
                        left: 30.w,
                        right: 30.w,
                        child: Card(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30),
                              ),
                          elevation: 8,
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(30),
                              color: Colors.white,
                            ),
                            height: 60.h,
                            child: Row(children: [
                              SizedBox(width: 16.w,),
                              Icon(Icons.search,color:mainColor,size: 28.r,),
                              SizedBox(width: 15.w,),
                              Text('Search',style: TextStyle(fontSize: 15.r,color: grayColor,)),
                            ],),
                          ),
                        ),
                      ),
                    ],
                  ),
          ),
        ),
      ),
    );
  }
}
