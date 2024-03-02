import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:share_plus/share_plus.dart';
import 'package:transparent_image/transparent_image.dart';

import '../../contants.dart';
import '../../models/coupon.dart';
import 'coupons_screen.dart';

class BrandCouponItem extends StatelessWidget {
  final Coupon coupon;
  final int index;

  const BrandCouponItem({super.key, required this.coupon, required this.index});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom:12.h),
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