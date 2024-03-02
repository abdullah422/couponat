import 'package:dotted_border/dotted_border.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../controllers/favourite_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import '../contants.dart';
import '../controllers/auth_controller.dart';
import '../controllers/welcom_controller.dart';
import '../models/coupon.dart';
import 'coupons/coupons_screen.dart';
import 'logintest.dart';

class FavouriteScreen extends StatefulWidget {
  @override
  State<FavouriteScreen> createState() => _FavouriteScreenState();
}

class _FavouriteScreenState extends State<FavouriteScreen> {
  final favouriteController = Get.put(FavouriteController());

  @override
  void initState() {
    // TODO: implement initState
    if (Get.find<AuthController>().isLoggedIn.value) {
      favouriteController.getFCoupons();
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Scaffold(
        backgroundColor: backgroundColor,
        appBar: AppBar(
          title: const Text('Favourites',
              style: TextStyle(
              fontSize: 24, color: Colors.white, fontWeight: FontWeight.w600),),
        ),
        body: Get.find<AuthController>().isLoggedIn.value
            ? favouriteController.isLoading.value
                ? Center(
                    child: CircularProgressIndicator(
                    color: mainColor,
                  ))
                : favouriteController.fCoupons.isEmpty
                    ? Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SvgPicture.asset(
                            'assets/svg/undraw_wishlist_re_m7tv.svg',
                            width: 260,
                            height: 250,
                          ),
                          const SizedBox(
                            height: 30,
                          ),
                          const Text(
                              'You don\'t have any coupon in favourite list'),
                          const SizedBox(
                            height: 15,
                          ),
                          Center(
                            child: TextButton(
                              onPressed: () {
                                Get.find<WelcomeController>()
                                    .currentIndex
                                    .value = 0;
                                //Get.offAll(() => WelcomeScreen());
                              },
                              child: const Text(
                                'Explore',
                                style: TextStyle(
                                  color: Colors.black,
                                  decoration: TextDecoration.underline,
                                ),
                              ),
                            ),
                          ),
                        ],
                      )
                    : Container(
                        margin: EdgeInsets.only(
                            top: MediaQuery.of(context).size.height / 90,
                            left: MediaQuery.of(context).size.width / 50,
                            right: MediaQuery.of(context).size.width / 50),
                        child: SingleChildScrollView(
                          child: ListView.separated(
                            itemBuilder: (context, index) {
                              return couponItem(
                                  favouriteController.fCoupons[index], index);
                            },
                            scrollDirection: Axis.vertical,
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: favouriteController.fCoupons.length,
                            separatorBuilder: (context, index) => SizedBox(
                              height: MediaQuery.of(context).size.height / 90,
                            ),
                          ),
                        ),
                      )
            : Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SvgPicture.asset(
                    'assets/svg/undraw_security_re_a2rk.svg',
                    width: 260,
                    height: 250,
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  const Text('You have to login First'),
                  const SizedBox(
                    height: 15,
                  ),
                  Center(
                    child: TextButton(
                      onPressed: () {
                        Get.to(() => MyLogin());
                      },
                      child: const Text(
                        'login',
                        style: TextStyle(
                          color: Colors.black,
                          decoration: TextDecoration.underline,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
      ),
    );
  }

  Widget couponItem(Coupon coupon, int index) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height / 4.1,
      color: Colors.white,
      // padding: EdgeInsets.only(left: 12,right: 12,),
      //margin: EdgeInsets.all(15),
      child: DottedBorder(
        borderType: BorderType.RRect,
        radius: Radius.circular(12.sp),
        //padding: EdgeInsets.all(10), Column(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: MediaQuery.of(context).size.height / 12,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    padding: EdgeInsets.only(left: 10),
                    height: MediaQuery.of(context).size.height / 15,
                    width: MediaQuery.of(context).size.width / 3.8,
                    child: Image.network(
                      url + coupon.brand.image,
                      fit: BoxFit.fill,
                      height: MediaQuery.of(context).size.height / 15,
                      width: MediaQuery.of(context).size.width / 3.8,
                    ),
                  ),
                  Row(
                    children: [
                      IconButton(
                        onPressed: () {
                          /* favouriteController
                                      .addOrRemoveFromFavourites(
                                          couponId: coupon.id)
                                      .then((value) {
                                    setState((){});
                                  });*/
                          favouriteController.removeFromFavourites(
                              index: index, couponId: coupon.id);
                        },
                        padding: EdgeInsets.all(0),
                        icon: CircleAvatar(
                          backgroundColor:
                              favouriteController.favorites[coupon.id] == true
                                  ? mainColor
                                  : Colors.grey,
                          child: Icon(
                            Icons.favorite_border_outlined,
                            color: Colors.white,
                          ),
                        ),
                      ),
                      IconButton(
                          onPressed: () {}, icon: Icon(Icons.share_outlined))
                    ],
                  )
                ],
              ),
            ),
            Container(
              height: MediaQuery.of(context).size.height / 11,
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: Text(
                  coupon.des,
                  style: TextStyle(fontWeight: FontWeight.w700, fontSize: 19),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ),
            Spacer(),
            GetCouponButton(
              coupon: coupon,
            )
          ],
        ),
      ),
    );
  }
}
