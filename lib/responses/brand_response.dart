import '../models/brand.dart';

class BrandResponse {
  List<Brand> brands = [];

  BrandResponse.fromJson(Map<String, dynamic> json) {
    json['data'].forEach((brand) => brands.add(Brand.fromJson(brand)));
  }
} //end of response
