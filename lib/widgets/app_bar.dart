

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../contants.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String? title;
  final int? index;

  const CustomAppBar({Key? key, this.title, this.index}) : super(key: key);

  @override
  Size get preferredSize => Size.fromHeight(100.h);

  @override
  Widget build(BuildContext context) {

    return AppBar(
      title: Text(title!,style:TextStyle(fontSize: 24,color: Colors.white,fontWeight: FontWeight.w600),),
      //titleTextStyle: headingStyle,
      //centerTitle: true,
      //backgroundColor: mainColor,
      elevation: 0,
      toolbarHeight: 100.h,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(18.r),
          bottomRight: Radius.circular(18.r),
        ),
      ),
      leadingWidth: 63.w,
      leading: title != null
          ? IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: Icon(
                Icons.arrow_back,
                size: 28.sp,
                color:Colors.white,
              ),
            )
          : null,

      automaticallyImplyLeading: false,
      /*systemOverlayStyle: const SystemUiOverlayStyle(
        statusBarColor: Colors.white,
        statusBarBrightness: Brightness.dark,
        statusBarIconBrightness: Brightness.dark,
      ),*/
    );
  }
}



