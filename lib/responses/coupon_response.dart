import '../models/coupon.dart';

class CouponResponse {
  List<Coupon> coupons = [];
  late int lastPage;

  CouponResponse.fromJson(Map<String, dynamic> json) {
    json['data']['coupons']['data']
        .forEach((coupon) => coupons.add(Coupon.fromJson(coupon)));
    lastPage = json['data']['coupons']['meta']['last_page'];
  }
}
