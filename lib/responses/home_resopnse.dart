import '../models/coupon.dart';

import '../models/banner.dart';
import '../models/brand.dart';

class HomeResponse {
  List<Banner> banners = [];
  List<Brand> brands = [];
  List<Coupon> coupons = [];

  HomeResponse.fromJson(Map<dynamic, dynamic> json) {
    json['data']['banners']
        .forEach((banner) => banners.add(Banner.fromJson(banner)));

    json['data']['brands']
        .forEach((brand) => brands.add(Brand.fromJson(brand)));
    json['data']['coupons']
        .forEach((coupon) => coupons.add(Coupon.fromJson(coupon)));
  }
}
