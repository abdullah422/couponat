import '../controllers/base_controller.dart';
import '../controllers/welcom_controller.dart';
import '../models/banner.dart';
import '../models/brand.dart';
import '../models/coupon.dart';
import '../models/user.dart';
import '../responses/home_resopnse.dart';
import '../responses/user_response.dart';
import '../screens/welcome_screen.dart';
import '../services/api.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';


class AuthController extends GetxController with BaseController {
  var isLoggedIn = false.obs;
  var user = User().obs;
  //final homeController = Get.put(HomeController());


  @override
  void onInit() {
    getHomeData();
    redirect();

    super.onInit();
  }
  /// this method for redirect to welcome screen
  Future<void> redirect() async {
    var token = await GetStorage().read('login_token');

    if (token != null) {
      print('==============================' + token.toString());
      getUser();
    }
    Future.delayed(Duration(seconds: 6 )).then((value) {
      Get.off(
        () => WelcomeScreen(),
        preventDuplicates: false,
      );
    }).catchError((error) {
      print('${error.toString()}');
    });
  } // end of redirect

  Future<void> login({required Map<String, dynamic> loginData}) async {
    showLoading();
    var response = await Api.login(loginData: loginData);

    var userResponse = UserResponse.fromJson(response.data);
    await GetStorage().write('login_token', userResponse.token);
    user.value = userResponse.user;
    isLoggedIn.value = true;
    hideLoading();
    Get.find<WelcomeController>().currentIndex.value = 0;
    Get.offAll(() => WelcomeScreen());
  } // end of login

  Future<void> register({required Map<String,dynamic> registerData}) async {
    showLoading();
    var response = await Api.register(registerData: registerData);

    var userResponse = UserResponse.fromJson(response.data);
    await GetStorage().write('login_token', userResponse.token);
    user.value = userResponse.user;
    isLoggedIn.value = true;
    hideLoading();
    Get.find<WelcomeController>().currentIndex.value = 0;
    Get.offAll(() => WelcomeScreen());
  } // end of register

  Future<void> getUser() async {
    var response = await Api.getUser();
    var userResponse = UserResponse.fromJson(response.data);
    user.value = userResponse.user;
    isLoggedIn.value = true;
  } // end of getUser

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

  Future<void> logout() async {
    isLoggedIn.value = false;
    await GetStorage().remove('login_token');
    Get.find<WelcomeController>().currentIndex.value = 0;
    Get.offAll(() => WelcomeScreen());
  } // end of logout

} //end of controller
