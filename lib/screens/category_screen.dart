import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/category_controller.dart';

class CategoryScreen extends StatelessWidget {

  final categoryController = Get.find<CategoryController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.all(10),
        child: GridView.builder(
          itemCount: categoryController.categories.length,
          physics: BouncingScrollPhysics(),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio: 3 / 2,
            crossAxisSpacing: 5,
            mainAxisSpacing: 5,
          ),
          itemBuilder: (context, index) {
            return Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text('${categoryController.categories[index].name}',
                      style: TextStyle(fontSize: 17)),
                  SizedBox(
                    height: 10,
                  ),
                  Text('${categoryController.categories[index].couponsCount}',
                      style: TextStyle(fontSize: 19)),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
