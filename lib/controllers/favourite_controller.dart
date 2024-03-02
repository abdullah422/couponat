import '../models/coupon.dart';
import '../services/api.dart';
import 'package:get/get.dart';

import '../responses/favourite_response.dart';

class FavouriteController extends GetxController {
  var fCoupons = <Coupon>[].obs;
  var isLoading = true.obs;
  var favorites = {}.obs;

  Future<void> getFCoupons() async{
    isLoading.value=true;
    var response = await Api.getFavourites();
    var fCouponsResponse = FavouriteCouponResponse.fromJson(response.data);
    fCoupons.clear();
    fCoupons.addAll(fCouponsResponse.coupons);
    for (var element in fCoupons) {
      favorites.addAll({
        element.id :element.inFavorites,
      });
    }
    isLoading.value=false;
  }

  Future<void> addOrRemoveFromFavourites({required int couponId}) async {
    var coupon=Coupon;
    coupon = favorites[couponId];
    /*favorites.remove(couponId);
    print('skip');*/
    if(favorites[couponId]==true){
      favorites[couponId]=false;
      favorites.forEach((key, value) {});
      var coupon=Coupon;
    }else{
      favorites[couponId]=true;
    }
    var response =
    await Api.addOrRemoveFormFavourite(couponId: couponId).then((value) {
      print(favorites.toString());
      print(favorites[couponId].toString());
    });
  }// end of getFCoupons
  Future<void> removeFromFavourites({required int couponId,index}) async {
    fCoupons.removeAt(index);
    print(fCoupons.length);
    var response =
    await Api.addOrRemoveFormFavourite(couponId: couponId).then((value) {
      print(favorites.toString());
      print(favorites[couponId].toString());
    });
  }// end of getFCoupons
} //end of controller
