import '../models/banner.dart';
import '../models/coupon.dart';
import '../responses/home_resopnse.dart';
import '../services/api.dart';
import 'package:get/get.dart';
import '../models/brand.dart';

class HomeController extends GetxController {


  @override
  void onInit() {
    // TODO: implement onInit
    getHomeData();
    super.onInit();
  }

  var isLoading = true.obs;
  var banners = <Banner>[].obs;
  var brands = <Brand>[].obs;
  var coupons = <Coupon>[].obs;

  Future<void> getHomeData() async {
    isLoading.value =true;
    var response = await Api.homeData();
    print('errrrrrr ${response.statusCode}');
    print(response.statusMessage);


    var homeResponse = HomeResponse.fromJson(response.data);

    banners.clear();
    banners.addAll(homeResponse.banners);

    brands.clear();
    brands.addAll(homeResponse.brands);

    coupons.clear();
    coupons.addAll(homeResponse.coupons);
    isLoading.value = false;
  } // end of getBanners
} //end of controller
