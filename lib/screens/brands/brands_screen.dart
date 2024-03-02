import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../contants.dart';
import '../../controllers/Brand_controller.dart';
import '../../models/brand.dart';
import '../coupons/coupons_screen.dart';

class BrandsScreen extends StatelessWidget {
  final brandController = Get.put(BrandController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Brands',
          style: TextStyle(
              fontSize: 24, color: Colors.white, fontWeight: FontWeight.w600),
        ),
      ),
      body: Container(
        padding: const EdgeInsets.all(15),
        child: GridView.builder(
          shrinkWrap: true,
          itemCount: brandController.brands.length,
          physics: const BouncingScrollPhysics(),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio: 3 / 3,
            crossAxisSpacing: 5,
            mainAxisSpacing: 5,
          ),
          itemBuilder: (context, index) {
            return InkWell(
              onTap: () {
                Get.to(
                  () => CouponsScreen(
                      brandId: brandController.brands[index].id,
                      brandName: brandController.brands[index].name),
                  preventDuplicates: false,
                );
              },
              child: Card(
                elevation: 2,
                color: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12.sp),
                ),
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(
                      12.sp,
                    ),
                      color: Colors.white
                  ),
                  child: Column(
                    children: [
                      SizedBox(
                        height: MediaQuery.of(context).size.height / 30,
                      ),
                      Container(
                        width: 100,
                        child: Image.network(
                          url + brandController.brands[index].image,
                          fit: BoxFit.fill,
                          width: 100,
                          height: 70,
                        ),
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(
                            height: 10,
                          ),
                          Text(
                            brandController.brands[index].name,
                            style: const TextStyle(
                                fontSize: 17, fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Text(
                              '${brandController.brands[index].couponsCount} Coupons'),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}

class BrandForAllBrandsItem extends StatelessWidget {
  final Brand brand;

  const BrandForAllBrandsItem(this.brand, {super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: const BoxDecoration(
        color: Colors.red,
        border: Border(
          bottom: BorderSide(color: Colors.grey, width: 0.2),
        ),
      ),
      child: Row(
        children: [
          const SizedBox(
            width: 20,
          ),
          SizedBox(
            width: 100,
            child: Image.network(
              url + brand.image,
              fit: BoxFit.fill,
              width: 100,
              height: 100,
            ),
          ),
          const SizedBox(
            width: 20,
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                brand.name,
                style:
                    const TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
              ),
              Text('${brand.couponsCount} Coupons'),
            ],
          ),
        ],
      ),
    );
  }
}
