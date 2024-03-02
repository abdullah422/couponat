import '../models/category.dart';
import '../responses/category_response.dart';
import '../services/api.dart';
import 'package:get/get.dart';


class CategoryController extends GetxController {

  @override
  void onInit() {
    // TODO: implement onInit
    getCategories();
    super.onInit();
  }
  var categories = <Category>[].obs;

  Future<void> getCategories() async {
    var response = await Api.getCategories();
    var categoryResponse = CategoryResponse.fromJson(response.data);
    categories.clear();
    categories.addAll(categoryResponse.categories);
  } // end of getCategories

} //end of controller
