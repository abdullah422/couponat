class Category {
  late int id;
  late String name;
  late  int couponsCount;

  Category.fromJson(Map<String,dynamic> json){

    id = json['id'];
    name = json['name'];
    couponsCount = json['coupons_count'] ?? 0;

  }



}//end of model
