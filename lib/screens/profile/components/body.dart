import '/screens/logintest.dart';
import '/screens/registertest.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../../controllers/auth_controller.dart';
import 'profile_menu.dart';
import 'profile_pic.dart';

class Body extends StatelessWidget {
  final authController = Get.find<AuthController>();

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.symmetric(vertical: 20),
      child: Column(
        children: [
          Visibility(
            visible: authController.isLoggedIn.value,
            child: ProfilePic(),
          ),
          SizedBox(height: 20),
          Visibility(
            visible: authController.isLoggedIn.value,
            child: ProfileMenu(
              text: "My Account",
              icon: "assets/icons/User_Icon.svg",
              press: () => {},
            ),
          ),
          ProfileMenu(
            text: "Settings",
            icon: "assets/icons/Settings.svg",
            press: () {},
          ),

          authController.isLoggedIn.value
              ? ProfileMenu(
                  text: "Log Out",
                  icon: "assets/icons/Log_out.svg",
                  press: () {
                    Get.dialog(
                        AlertDialog(
                          content: Container(
                            height:100,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(height: 2),
                                Text("Are you sure to exit"),
                                SizedBox(height: 20),
                                Row(
                                  children: [
                                    Expanded(
                                      child: ElevatedButton(
                                        onPressed: () {
                                          authController.logout();
                                        },
                                        child: Text("Yes"),
                                        style: ElevatedButton.styleFrom(
                                            backgroundColor: Colors.red.shade800),
                                      ),
                                    ),
                                    SizedBox(width: 15),
                                    Expanded(
                                        child: ElevatedButton(
                                          onPressed: () {
                                            Navigator.of(context).pop();
                                          },
                                          child: Text('No', style: TextStyle(color: Colors.black)),
                                          style: ElevatedButton.styleFrom(
                                            backgroundColor: Colors.white,
                                          ),
                                        ))
                                  ],
                                )
                              ],
                            ),
                          ),
                        ));
                  },
                )
              : Column(
                  children: [
                    ProfileMenu(
                      text: "Login",
                      icon: "assets/icons/login-svgrepo-com.svg",
                      press: () {
                        Get.to(
                          () => MyLogin(),
                          preventDuplicates: false,
                        );
                      },
                    ),
                    ProfileMenu(
                      text: "Register",
                      icon: "assets/icons/add-new-user-svgrepo-com.svg",
                      press: () {
                        Get.to(
                          () => MyRegister(),
                          preventDuplicates: false,
                        );
                      },
                    ),
                  ],
                ),
          ProfileMenu(
            text: "Help Center",
            icon: "assets/icons/Question_mark.svg",
            press: () {},
          ),
        ],
      ),
    );
  }
}
