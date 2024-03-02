import 'dart:developer';

import 'package:couponat/screens/login_screen.dart';
import 'package:couponat/screens/logintest.dart';
import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_neumorphic_plus/flutter_neumorphic.dart';
import 'package:flutter_svg/svg.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';
import 'package:transparent_image/transparent_image.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../controllers/auth_controller.dart';
import '/widgets/app_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:share_plus/share_plus.dart';

import '../../contants.dart';
import '../../controllers/coupon_controller.dart';
import '../../models/coupon.dart';
import 'coupon_Item.dart';

class CouponsScreen extends StatefulWidget {
  final int? page, brandId;

  final String? brandName;

  const CouponsScreen({Key? key, this.page, this.brandId, this.brandName})
      : super(key: key);

  @override
  State<CouponsScreen> createState() => _CouponsScreenState();
}

class _CouponsScreenState extends State<CouponsScreen> {
  var couponController = Get.put(CouponController());
  final scrollController = ScrollController();

  @override
  void initState() {
    // TODO: implement initState
    couponController.getCoupons(
      brandId: widget.brandId,
    );

    scrollController.addListener(() {
      var sControllerOffset = scrollController.offset;
      var sControllerMax = scrollController.position.maxScrollExtent - 100;
      var isLoadingPagination = couponController.isLoadingPagination.value;
      var hasMorePages =
          couponController.currentPage.value < couponController.lastPage.value;

      if (sControllerOffset > sControllerMax &&
          isLoadingPagination == false &&
          hasMorePages) {
        couponController.isLoadingPagination.value = true;
        couponController.currentPage.value++;
        couponController.getCoupons(
          page: couponController.currentPage.value,
          brandId: widget.brandId,
        );
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Scaffold(
        backgroundColor: backgroundColor,
        appBar: CustomAppBar(
            title: widget.brandName == null
                ? 'Coupons'
                : widget.brandName.toString()),
        body: couponController.isLoading.value
            ? Center(
                child: CircularProgressIndicator(
                  color: progressIndicatorColor,
                ),
              )
            : couponController.coupons.isEmpty
                ? Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SvgPicture.asset(
                        'assets/svg/undraw_no_data_re_kwbl (1).svg',
                        width: 260.w,
                        height: 250.h,
                      ),
                      SizedBox(
                        height: 20.h,
                      ),
                      const Center(child: Text('No data found')),
                    ],
                  )
                : Container(
                    margin: EdgeInsets.only(left: 12.w, right: 12.w, top: 12.h),
                    height: MediaQuery.of(context).size.height,
                    child: SingleChildScrollView(
                      controller: scrollController,
                      physics: BouncingScrollPhysics(),
                      child: Column(
                        children: [
                          GridView.builder(
                            gridDelegate:
                                SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              childAspectRatio: 3 / 3.4,
                              crossAxisSpacing: 16.w,
                            ),
                            itemBuilder: (context, index) {
                              return couponItem(
                                  couponController.coupons[index]);
                            },
                            scrollDirection: Axis.vertical,
                            shrinkWrap: true,
                            physics: NeverScrollableScrollPhysics(),
                            itemCount: couponController.coupons.length,
                          ),
                          Visibility(
                            visible: couponController.isLoadingPagination.value,
                            child: Container(
                              padding: const EdgeInsets.all(5),
                              width: 40,
                              height: 40,
                              child: Center(
                                  child: CircularProgressIndicator(
                                color: mainColor,
                              )),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
      ),
    );
  }

  Widget couponItem(Coupon coupon) {
    return Container(
      margin: EdgeInsets.only(bottom: 12.h),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(
          Radius.circular(12.sp),
        ),
        color: Colors.white,
      ),
      width: 180.w,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            height: MediaQuery.of(context).size.height / 19,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                IconButton(
                  onPressed: () {
                    if (Get.find<AuthController>().isLoggedIn.value) {
                      couponController
                          .addOrRemoveFromFavourites(couponId: coupon.id)
                          .then((value) {
                        setState(() {});
                      });
                    } else {
                      Get.to(() => MyLogin());
                    }
                  },
                  padding: EdgeInsets.all(0),
                  icon: CircleAvatar(
                    backgroundColor:
                        couponController.favorites[coupon.id] == true
                            ? mainColor
                            : Colors.grey,
                    child: Icon(
                      Icons.favorite_border_outlined,
                      color: Colors.white,
                    ),
                  ),
                ),
                IconButton(
                    onPressed: () {
                      _onShare(
                          context: context,
                          text: coupon.title,
                          des: coupon.des);
                    },
                    icon: Icon(Icons.share_outlined))
              ],
            ),
          ),
          Container(
            height: MediaQuery.of(context).size.height / 20,
            width: MediaQuery.of(context).size.width / 4.8,
            margin: EdgeInsets.only(left: 12),
            child: Stack(
              alignment: Alignment.center,
              children: [
                Center(
                  child: Container(
                    padding: EdgeInsets.all(5),
                    child: CircularProgressIndicator(
                      color: progressIndicatorColor,
                    ),
                  ),
                ),
                FadeInImage.memoryNetwork(
                  placeholder: kTransparentImage,
                  image: url + coupon.brand.image,
                  fit: BoxFit.cover,
                  height: 100,
                  width: 100,
                )
              ],
            ),
          ),
          Container(
            height: MediaQuery.of(context).size.height / 15.5,
            padding: const EdgeInsets.all(10.0),
            child: Text(
              coupon.des,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(fontSize: 17, fontWeight: FontWeight.w500),
            ),
          ),
          Spacer(),
          GetCouponButton(coupon: coupon),
        ],
      ),
    );
  }

  void _onShare(
      {required BuildContext context, required String text, des}) async {
    final box = context.findRenderObject() as RenderBox?;
    await Share.share(
      text,
      subject: des,
      sharePositionOrigin: box!.localToGlobal(Offset.zero) & box.size,
    );
  }
}

class CouponItem extends StatelessWidget {
  final Coupon coupon;
  final int index;

  CouponItem({required this.coupon, required this.index});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 12.h),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(
          Radius.circular(12.sp),
        ),
        color: Colors.white,
      ),
      width: 180.w,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            height: MediaQuery.of(context).size.height / 19,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                IconButton(
                  onPressed: () {
                    _onShare(
                        context: context, text: coupon.title, des: coupon.des);
                  },
                  icon: Icon(
                    Icons.share_outlined,
                    size: MediaQuery.of(context).size.height / 35,
                  ),
                )
              ],
            ),
          ),
          Container(
            height: MediaQuery.of(context).size.height / 20,
            width: MediaQuery.of(context).size.width / 4.8,
            margin: EdgeInsets.only(left: 12),
            child: Stack(
              alignment: Alignment.center,
              children: [
                Center(
                  child: Container(
                    padding: EdgeInsets.all(5),
                    child: CircularProgressIndicator(
                      color: progressIndicatorColor,
                    ),
                  ),
                ),
                FadeInImage.memoryNetwork(
                  placeholder: kTransparentImage,
                  image: url + coupon.brand.image,
                  fit: BoxFit.cover,
                  height: 100,
                  width: 100,
                )
              ],
            ),
          ),
          Container(
            height: MediaQuery.of(context).size.height / 15.5,
            padding: const EdgeInsets.all(10.0),
            child: Text(
              coupon.des,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(fontSize: 17, fontWeight: FontWeight.w500),
            ),
          ),
          Spacer(),
          GetCouponButton(coupon: coupon),
        ],
      ),
    );
  }

  void _onShare(
      {required BuildContext context, required String text, des}) async {
    final box = context.findRenderObject() as RenderBox?;
    await Share.share(
      text,
      subject: des,
      sharePositionOrigin: box!.localToGlobal(Offset.zero) & box.size,
    );
  }
}

class GetCouponButton extends StatelessWidget {
  final Coupon coupon;

  const GetCouponButton({
    required this.coupon,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      //padding: const EdgeInsets.only(left: 10, right: 10),
      width: double.infinity,
      height: 50.h,
      child: InkWell(
        onTap: () {
          showMaterialModalBottomSheet(
            context: context,
            builder: (context) {
              return bottomSheetBody(context, coupon);
            },
            // barrierColor: backgroundColor?.withOpacity(0.3),
            backgroundColor: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12.sp),
            ),
            duration: Duration(milliseconds: 500),
          );
        },
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(12.sp),
                bottomRight: Radius.circular(12.sp)),
            color: thirdColor,
          ),
          width: MediaQuery.of(context).size.width / 1.29,
          height: double.infinity,
          child: const Center(
            child: Text(
              'Get Coupon',
              style: TextStyle(color: Colors.black),
            ),
          ),
        ),
      ),
    );
  }

  Widget bottomSheetBody(BuildContext context, Coupon coupon) {
    return Container(
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(15),
          topRight: Radius.circular(15),
        ),
      ),
      margin: const EdgeInsets.only(left: 10),
      height: MediaQuery.of(context).size.height / 3,
      child: Column(
        children: [
          SizedBox(
            height: MediaQuery.of(context).size.height / 40,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.network(
                url + coupon.brand.image,
                fit: BoxFit.fill,
                height: MediaQuery.of(context).size.height / 15,
                width: MediaQuery.of(context).size.width / 3.8,
              ),
            ],
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height / 40,
          ),
          Visibility(
            visible: coupon.code.isNotEmpty,
            child: Container(
              height: MediaQuery.of(context).size.height / 13,
              width: MediaQuery.of(context).size.width / 2,
              child: Neumorphic(
                style: NeumorphicStyle(depth: -5, color: backgroundColor),
                child: Center(
                    child: Text(
                  coupon.code,
                  style: const TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 4),
                )),
              ),
            ),
          ),
          Visibility(
            visible: coupon.code.isEmpty,
            child: Container(
                height: MediaQuery.of(context).size.height / 13,
                width: MediaQuery.of(context).size.width / 2,
                child: Text(
                  coupon.des,
                  overflow: TextOverflow.ellipsis,
                  maxLines: 4,
                  style: TextStyle(fontSize: 17, fontWeight: FontWeight.w500),
                )),
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height / 30,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Visibility(
                visible: coupon.url.isNotEmpty,
                child: NeumorphicButton(
                  child: Text(
                      coupon.code.isEmpty
                          ? 'Go to store'
                          : 'Copy & Go to store',
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                  onPressed: () async {
                    if (coupon.url.isEmpty) {
                    } else {
                      Clipboard.setData(ClipboardData(text: coupon.code));
                      if (await canLaunchUrl(Uri.parse(coupon.url))) {
                        await launchUrl(Uri.parse(coupon.url));
                      }
                    }
                  },
                  style: NeumorphicStyle(color: mainColor, depth: 2),
                ),
              ),
              Visibility(
                visible: coupon.code.isNotEmpty && coupon.url.isNotEmpty,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text('OR'),
                ),
              ),
              Visibility(
                  visible: coupon.code.isNotEmpty,
                  child: NeumorphicButton(
                    onPressed: () {
                      Clipboard.setData(ClipboardData(text: coupon.code))
                          .then((v) {
                        showTopSnackBar(
                          Overlay.of(context),
                          const CustomSnackBar.success(
                            message: "Copied Successfully",
                          ),
                        );
                      });
                    },
                    style: NeumorphicStyle(color: mainColor, depth: 2),
                    child: const Text('Copy',
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold)),
                  )),
            ],
          ),
          Spacer()
        ],
      ),
    );
  }
}
