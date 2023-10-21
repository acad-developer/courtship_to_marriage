import 'package:courtship_to_marriage/view/widget/custom_app_bar.dart';
import 'package:flutter/material.dart';

class CheckCourses extends StatelessWidget {
  const CheckCourses({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: CustomAppBar(title: "Courses",),
    );
  }
}