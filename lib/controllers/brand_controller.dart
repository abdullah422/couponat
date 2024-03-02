import '../models/brand.dart';
import '../responses/brand_response.dart';
import 'package:get/get.dart';

import '../services/api.dart';

class BrandController extends GetxController {

  @override
  void onInit() {
    // TODO: implement onInit
    getBrands();
    super.onInit();
  }
  var brands = <Brand>[].obs;

   Future<void> getBrands ()async{

     var response = await Api.getBrands();

     var brandResponse = BrandResponse.fromJson(response.data);

     brands.clear();

     brands.addAll(brandResponse.brands);
     brands.sort((a, b) => a.name.compareTo(b.name),);

   }// end of getBrands




}//end of controller