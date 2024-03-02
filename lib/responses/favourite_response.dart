import '../models/coupon.dart';

class FavouriteCouponResponse {

  List <Coupon> coupons = [];

  FavouriteCouponResponse.fromJson(Map<String,dynamic> json){
    json['data'].forEach((coupon) => coupons.add(Coupon.fromJson(coupon)));
    }
}