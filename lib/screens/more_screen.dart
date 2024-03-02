import '../screens/favourite_screen.dart';
import '../screens/logintest.dart';
import '../screens/registertest.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/auth_controller.dart';
import '../widgets/primary_button.dart';

class MoreScreen extends StatelessWidget {
  final authController = Get.find<AuthController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(children: <Widget>[buildTopBanner(), buildSettingItems()]),
    );
  }

  Widget buildTopBanner() {
    return Container(
      height: 250,
      color: Colors.amber,
      child: Center(
        child: Text('Settings',
            style: TextStyle(fontSize: 25, color: Colors.black)),
      ),
    );
  } // end of TopBanner

  Widget buildSettingItems() {
    return Container(
        padding: const EdgeInsets.all(15),
        child: authController.isLoggedIn.value == true
            ? Column(
                children: <Widget>[
                  ListTile(
                    leading: Icon(Icons.favorite),
                    title: Text('Favorite movies'),
                    onTap: () {
                      Get.to(
                        () => FavouriteScreen(),
                        preventDuplicates: false,
                      );
                    },
                  ),
                  ListTile(
                    leading: Icon(Icons.logout),
                    title: Text('Logout'),
                    onTap: () {
                      Get.dialog(
                        Dialog(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15),
                          ),
                          child: Container(
                            padding: const EdgeInsets.all(15),
                            height: 150,
                            width: 300,
                            child: Column(
                              children: <Widget>[
                                Text('Confirm logout', style: TextStyle(fontSize: 20)),
                                SizedBox(height: 15),
                                Row(
                                  children: <Widget>[
                                    Expanded(
                                      child: PrimaryButton(
                                        label: 'Yes',
                                        onPress: () {
                                          authController.logout();
                                        },
                                      ),
                                    ),
                                    SizedBox(width: 10),
                                    Expanded(
                                      child: PrimaryButton(
                                        label: 'No',
                                        onPress: () {
                                          Get.back();
                                        },
                                      ),
                                    )
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      );


                    },
                  ),
                ],
              )
            : Column(
                children: <Widget>[
                  ListTile(
                    leading: Icon(Icons.person),
                    title: Text('Login'),
                    onTap: () {
                      Get.to(
                        () =>MyLogin(),
                        preventDuplicates: false,
                      );
                    },
                  ),
                  ListTile(
                    leading: Icon(Icons.person_add),
                    title: Text('Register'),
                    onTap: () {
                      Get.to(
                        () => MyRegister(),
                        preventDuplicates: false,
                      );
                    },
                  ),
                ],
              ));
  } // end of SettingItems
} //end of widget
