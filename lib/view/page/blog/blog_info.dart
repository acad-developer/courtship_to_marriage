import 'package:courtship_to_marriage/view/widget/custom_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:get/get.dart';

class BlogInfo extends StatelessWidget {
  const BlogInfo({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(),
      body: SafeArea(
          child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(left: 12, right: 12, bottom: 12),
          child: Column(
            children: [
              // Padding(
              //                 padding: const EdgeInsets.symmetric(horizontal: 8),
              //                 child: Text(
              //                   Get.arguments.title.toString(),
              //                   textAlign: TextAlign.left,
              //                   style: GoogleFonts.inter(
              //                       textStyle: TextStyle(
              //                           fontSize: 20,
              //                           fontWeight: FontWeight.w700,
              //                           color: AppColor.titleText)),
              //                 ),
              //               ),
              Container(
                margin: EdgeInsets.only(top: 10, bottom: 10),
                height: 200,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    image: DecorationImage(
                        image: NetworkImage(Get.arguments.thumbnail!),
                        fit: BoxFit.fill)),
                // child: Image.network("https://courtshiptomarriage.com/wp-content/uploads/2023/10/Discerning-Gods-will-in-courtship.png", fit: BoxFit.fill,)
              ),
              HtmlWidget(
                Get.arguments.content,
              ),

              const SizedBox(
                height: 100,
              ),
            ],
          ),
        ),
      )),
    );
  }
}
