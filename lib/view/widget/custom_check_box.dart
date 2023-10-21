import 'package:courtship_to_marriage/const/colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CustomCheckBox extends StatelessWidget {
  const CustomCheckBox({required this.isCheck, super.key});
  final RxBool isCheck;
  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return InkWell(
        onTap: () {
          isCheck.value = !isCheck.value;
        },
        child: Container(
          height: 18,
          width: 18,
          margin: EdgeInsets.only(right: 6),
          decoration: BoxDecoration(
              color: isCheck.value == false ? null : AppColor.appPrimary,
              borderRadius: BorderRadius.circular(4),
              border: Border.all(width: 2.5, color: AppColor.appPrimary)),
          child: isCheck.value == true
              ? Icon(
                  Icons.check,
                  size: 14.0,
                  color: Colors.white,
                )
              : null,
        ),
      );
    });
  }
}
