import 'dart:math' as math;

import '../contants.dart';
import '../controllers/auth_controller.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';

import '../controllers/home_controller.dart';
import '../main.dart';

class SplashScreen extends StatefulWidget {

   SplashScreen({super.key});
  //final homeController = Get.put(HomeController());
  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  final authController = Get.put(AuthController());


  @override
  void initState(){
    // TODO: implement initState

    super.initState();

    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      RemoteNotification? notification = message.notification;
      AndroidNotification? android = message.notification?.android;
      if (notification != null && android != null) {
        flutterLocalNotificationsPlugin.show(
            notification.hashCode,
            notification.title,
            notification.body,
            NotificationDetails(
              android: AndroidNotificationDetails(
                channel.id,
                channel.name,
                color: Colors.blue,
                playSound: true,
                icon: '@mipmap/ic_launcher',
              ),
            ));
      }
    });

    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      print('A new messageopen app event was published');
      RemoteNotification? notification = message.notification;
      AndroidNotification? android = message.notification?.android;
      if (notification != null && android != null) {
        //Navigator.pushReplacementNamed(context, AppRoutes.loadingPage);
      }
    });

    FirebaseMessaging.instance.getToken().then((value){
      print("MFC_token = "+value.toString());
    });

    /*if (SharedPrefHelper.getCurrentMFCToken() == null) {
      FirebaseMessaging.instance.getToken().then((value) {
        SharedPrefHelper.saveMFCToken(mFCToken: value.toString())
            .then((value) {});
      });
    }
    print('don\'t save');
    print(SharedPrefHelper.getCurrentMFCToken());*/

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: mainColor,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Transform.rotate(
            angle: -math.pi / 11,
            child: Image.asset('assets/images/coupon.png',height: 140,),
          ),
          SizedBox(height:20),
          Container(
            width: double.infinity,
              child: Center(child: Text('Couponaty',style: TextStyle(fontSize:40,color: Colors.white),))),

          SizedBox(height:35),
          CircularProgressIndicator(color:Colors.white,),
        ],
      ),
    );
  }
}

