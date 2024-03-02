class Brand {
  late int id;
  late String name;
  late String image;
  late int couponsCount;

  Brand.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    image = json['image'];
    couponsCount = json['coupons_count'];
  }
}//end of model
