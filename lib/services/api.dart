import '../contants.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart' as GET;
import 'package:get_storage/get_storage.dart';

class Api {
  static final dio = Dio(
    BaseOptions(
      baseUrl: url,
      receiveDataWhenStatusError: true,
    ),
  );

  static void initializeInterceptors() {
    dio.interceptors
        .add(InterceptorsWrapper(onRequest: (request, handler) async {
      var token = await GetStorage().read('login_token');
      var headers = {
        'Accept': 'application/json',
        'Content-Type': 'application/json',
        'Authorization': 'Bearer ${token}',
      };
      request.headers.addAll(headers);
      print('${request.method} ${request.path}');
      print('${request.headers}');
      return handler.next(request);
      //continue
    }, onResponse: (response, handler) {
      print('${response.data}');
      print('${response.data['error']}');
      if (response.data['error'] == 1) throw response.data['message'];

      return handler.next(response);
      // continue
    }, onError: (error, handler) {
          print(error);
      if (GET.Get.isDialogOpen == true) {
        GET.Get.back();
      }

      GET.Get.snackbar(
        'error'.tr,
        '${error.message}',
        snackPosition: GET.SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    }));
  }

  static Future<Response> getCategories() async {
    return dio.get('/api/categories');
  }

  static Future<Response> getBrands() async {
    return dio.get('/api/brands');
  }

  static Future<Response> getBanners() async {
    return dio.get('/api/banners');
  }

  static Future<Response> homeData() async {
    return dio.get('/api/home');
  }

  static Future<Response> getPrivateCoupons({int page = 1, int? brandId}) async {
    return dio.get('/api/private_coupons', queryParameters: {
      'brand_id': brandId,
      'page': page,
    });
  }
  static Future<Response> getPublicCoupons({int page = 1, int? brandId}) async {
    return dio.get('/api/public_coupons', queryParameters: {
      'brand_id': brandId,
      'page': page,
    });
  }

  static Future<Response> login(
      {required Map<String, dynamic> loginData}) async {
    FormData formData = FormData.fromMap(loginData);
    return dio.post('/api/login', data: formData);
  }

  static Future<Response> register(
      {required Map<String, dynamic> registerData}) async {
    FormData formData = FormData.fromMap(registerData);
    return dio.post('/api/register', data: registerData);
  }

  static Future<Response> getUser() async {
    return dio.get('/api/user');
  }
 static Future<Response> addOrRemoveFormFavourite({required int couponId}) async {
    return dio.get('/api/coupons/toggle_coupon', queryParameters: {
      'coupon_id': couponId,
    });
  }
  static Future<Response> getFavourites() async {
    return dio.get('/api/coupons/get_favourites');
  }

}
