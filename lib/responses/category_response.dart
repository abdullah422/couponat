import '../models/category.dart';

class CategoryResponse {
  List<Category> categories = [];

  CategoryResponse.fromJson(Map<String, dynamic> json) {
    json['data']
        .forEach((category) => categories.add(Category.fromJson(category)));
  }
} //end of response
