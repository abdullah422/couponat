import '../models/banner.dart';

class BannerResponse {
  List<Banner> banners = [];
  BannerResponse.fromJson(Map<String, dynamic> json) {
    json['data'].forEach((banner) => banners.add(Banner.fromJson(banner)));
  }
}
