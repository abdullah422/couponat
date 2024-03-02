import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:transparent_image/transparent_image.dart';

import '../../contants.dart';
import '../../models/brand.dart';
import '../coupons/coupons_screen.dart';

class BrandItem extends StatelessWidget {
  final Brand brand;
  final int index;

  BrandItem({required this.brand, required this.index});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Get.to(
          () => CouponsScreen(brandId: brand.id, brandName: brand.name),
          preventDuplicates: false,
        );
      },
      child: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.all(
              Radius.circular(12.sp),
            ),
            //color: Colors.red,

        ),
        margin: EdgeInsets.only(left: index == 0 ? 0.w : 12.w,top: 5.h,bottom: 5.h),
        width: 120.w,
        child: Card(

          elevation: 4,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12.sp), //<-- SEE HERE
          ),

          child: ClipRRect(
            borderRadius: BorderRadius.all(Radius.circular(12.sp)),
            child: Stack(
              alignment: Alignment.center,
              children: [
                Center(
                  child: CircularProgressIndicator(
                    color: progressIndicatorColor,
                  ),
                ),
                FadeInImage.memoryNetwork(
                  placeholder: kTransparentImage,
                  image: url + brand.image,
                  fit: BoxFit.fill,
                  width: 120.w,
                  height: 100.h,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
