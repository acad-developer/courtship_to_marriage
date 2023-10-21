import 'dart:async';
import 'package:courtship_to_marriage/const/colors.dart';
import 'package:courtship_to_marriage/utils/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:lottie/lottie.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  final readToken = GetStorage();
  @override
  void initState() {
    print(readToken.read('username'));
    // TODO: implement initState
    Timer(
  const Duration(seconds: 3),
  () {
    // if(readToken.read('username').toString().isEmpty == true || readToken.read('username') == null ){
      // Get.toNamed(AppRoutes.login);
    // } else {
      Get.toNamed(AppRoutes.main);
    // }
  },
);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
          width: double.infinity,
          height: double.infinity,
          alignment: Alignment.center,
          color: AppColor.appPrimary,
              child: Lottie.asset('assets/animation/splash.json', width: MediaQuery.of(context).size.width * 0.85),
        );
  }
}