import '../models/category.dart';

import 'brand.dart';

class Coupon {
  late int id;
  late String title;
  late String des;
  late Category category;
  late Brand brand;
  late String code;
  late String url;
  late bool inFavorites;

  Coupon.fromJson(Map<dynamic, dynamic> json) {
    id = json['id'];
    des = json['description'] ?? '';
    title = json['title'] ?? '';
    code = json['code'] ?? '';
    url = json['url'] ?? '';
    //category = Category.fromJson(json['categories']);();
    brand = Brand.fromJson(json['brand']);
    inFavorites = json['in_favourite'] == 1 ? true : false;
  }
}
