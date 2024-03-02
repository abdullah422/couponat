import '../models/coupon.dart';
import '../responses/coupon_response.dart';
import '../services/api.dart';
import 'package:get/get.dart';

import 'auth_controller.dart';

class CouponController extends GetxController {
  final authController = Get.find<AuthController>();

  var isLoading = true.obs;
  var isLoadingPagination = false.obs;
  var currentPage = 1.obs;
  var lastPage = 1.obs;
  var favorites = {}.obs;
  var coupons = <Coupon>[];

  Future<void> getCoupons({int page = 1, int? brandId}) async {
    dynamic response;
    if (authController.isLoggedIn.value) {
      response = await Api.getPrivateCoupons(page: page, brandId: brandId);
    } else {
      response = await Api.getPublicCoupons(page: page, brandId: brandId);
    }
    var couponsResponse = CouponResponse.fromJson(response.data);
    if (page == 1) {
      coupons.clear();
    }
    coupons.addAll(couponsResponse.coupons);
    if(authController.isLoggedIn.value){
      for (var element in coupons) {
        favorites.addAll({
          element.id :element.inFavorites,
        });
      }
    }
    lastPage.value = couponsResponse.lastPage;
    isLoading.value = false;
    isLoadingPagination.value = false;
  } // end of getCoupons

  Future<void> addOrRemoveFromFavourites({required int couponId}) async {
   if(favorites[couponId]==true){
     favorites[couponId]=false;
   }else{
     favorites[couponId]=true;
   }
    var response =
        await Api.addOrRemoveFormFavourite(couponId: couponId).then((value) {
          print(favorites.toString());
          print(favorites[couponId].toString());
        });
  } // end of addOrRemoveFromFavourites
} //end of controller
