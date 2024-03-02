import '../screens/home/home_screen.dart';
import 'package:get/get.dart';

import '../screens/brands/brands_screen.dart';
import '../screens/favourite_screen.dart';
import '../screens/profile/profile_screen.dart';

class WelcomeController extends GetxController {


  /*void dependencies() {
    Get.lazyPut(() => WelcomeController());
    }*/
  var currentIndex = 0.obs;
  var screens = [
    HomeScreen(),
    BrandsScreen(),
    FavouriteScreen(),
    ProfileScreen(),
  ]; 


}//end of controller