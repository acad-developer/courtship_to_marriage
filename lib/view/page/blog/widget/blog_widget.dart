import 'package:courtship_to_marriage/const/colors.dart';
import 'package:courtship_to_marriage/view/page/blog/blog_info.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class BlogWidget extends StatelessWidget {
  const BlogWidget({
    required this.data,
    super.key});
  final data;
  @override
  Widget build(BuildContext context) {
    return InkWell(
                                onTap: () {
                                  Get.to(BlogInfo(),
                                      arguments: data);
                                },
                                child: Container(
                                  // color: Colors.red,
                                  margin: EdgeInsets.all(5),
                                  // width: MediaQuery.of(context).size.width * 0.5,
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(12),
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.grey.shade200,
                                          blurRadius: 25.0,
                                          //  spreadRadius: 1.0
                                        ),
                                      ]),
                                  child: Column(
                                    children: [
                                      Container(
                                        height: 100,
                                        decoration: BoxDecoration(
                                            borderRadius: BorderRadius.only(
                                                topLeft: Radius.circular(12),
                                                topRight: Radius.circular(12)),
                                            image: DecorationImage(
                                                image: NetworkImage(data.thumbnail!),
                                                fit: BoxFit.fill)),
                                        // child: Image.network("https://courtshiptomarriage.com/wp-content/uploads/2023/10/Discerning-Gods-will-in-courtship.png", fit: BoxFit.fill,)
                                      ),
                                      const SizedBox(
                                        height: 10,
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 8),
                                        child: Text(
                                          data.title
                                              .toString(),
                                          textAlign: TextAlign.left,
                                          style: GoogleFonts.inter(
                                              textStyle: TextStyle(
                                                  fontSize: 12,
                                                  fontWeight: FontWeight.w700,
                                                  color: AppColor.titleText)),
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 10,
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 8),
                                        child: Text(
                                          data.excerpt
                                              .toString(),
                                          textAlign: TextAlign.left,
                                          style: GoogleFonts.inter(
                                              textStyle: TextStyle(
                                                  fontSize: 12,
                                                  fontWeight: FontWeight.w400,
                                                  color: AppColor.titleText)),
                                        ),
                                      ),
                                      Spacer(),
                                      InkWell(
                                        onTap: () {
                                          Get.to(BlogInfo(),
                                              arguments: data);
                                        },
                                        child: Padding(
                                          padding: const EdgeInsets.symmetric(
                                              vertical: 8, horizontal: 8),
                                          child: Row(
                                            children: [
                                              Text(
                                                "Conitnue Reading ",
                                                textAlign: TextAlign.left,
                                                style: GoogleFonts.inter(
                                                    textStyle: TextStyle(
                                                  fontSize: 12,
                                                  fontWeight: FontWeight.w700,
                                                  color: AppColor.appPrimary,
                                                )),
                                              ),
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    top: 1),
                                                child: Icon(
                                                  Icons.arrow_forward_rounded,
                                                  color: AppColor.appPrimary,
                                                  size: 14,
                                                ),
                                              )
                                            ],
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              );
  }
}