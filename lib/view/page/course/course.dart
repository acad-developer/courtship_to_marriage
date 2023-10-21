import 'package:courtship_to_marriage/const/colors.dart';
import 'package:courtship_to_marriage/controller/get_course_controller/get_course_controller.dart';
import 'package:courtship_to_marriage/model/get_course_model/get_course_model.dart';
import 'package:courtship_to_marriage/view/page/course/course_video.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:video_player/video_player.dart';

class CourseScreen extends StatefulWidget {
  const CourseScreen({super.key});

  @override
  State<CourseScreen> createState() => _CourseScreenState();
}

class _CourseScreenState extends State<CourseScreen> {

  final GetCourseController getCourseController = Get.isRegistered<GetCourseController>()
      ? Get.find()
      : Get.put(GetCourseController());


  // late VideoPlayerController controller;

  // @override
  // void initState() {
  //   super.initState();
  //   controller = VideoPlayerController.networkUrl(Uri.parse(
  //       'https://video.bunnycdn.com/play/160771/79325914-9181-4c8d-b10b-1c6be3f9d658'))
  //     ..initialize().then((_) {
  //       // Ensure the first frame is shown after the video is initialized, even before the play button has been pressed.
  //       setState(() {
  //         controller.play();
  //       });
  //     });
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: SafeArea(
            child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Courses",
                textAlign: TextAlign.center,
                style: GoogleFonts.inter(
                    textStyle: TextStyle(
                        fontSize: 36,
                        fontWeight: FontWeight.w700,
                        color: AppColor.titleText)),
              ),
              const SizedBox(
                height: 10,
              ),
              // AspectRatio(
              //     aspectRatio: controller.value.aspectRatio,
              //     child: VideoPlayer(controller),
              //   ),
              FutureBuilder<GetCourse>(
                future: getCourseController.getCourse(), 
                builder: (contetx, snapshot){
                  if(snapshot.connectionState == ConnectionState.waiting){
                    return Center(
                            child: CircularProgressIndicator(
                          color: AppColor.appPrimary,
                        ));
                  }
                  // if(snapshot.hasData == true){
                  //   return Text(snapshot.data!.data!.courses!.length.toString());
                  // }
                  return Column(
                    children: [
                      for(int i=0; i<snapshot.data!.data!.courses!.length; i++)...[
                        InkWell(
                          onTap: (){
                            Get.to(CourseVideo());
                          },
                          child: Container(
                            margin: EdgeInsets.symmetric(vertical: 10),
                                        decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(6),
                                            border: Border.all(color: AppColor.subText)),
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Container(
                                              width: MediaQuery.of(context).size.width * 0.93,
                                              height: 180,
                                              decoration: BoxDecoration(
                            borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(6),
                                topRight: Radius.circular(6)),
                            image: DecorationImage(
                                image: NetworkImage(snapshot.data!.data!.courses![1].featuredImage),
                                fit: BoxFit.fill)),
                                            ),
                                            const SizedBox(
                                              height: 10,
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.only(left: 10),
                                              child: Text(
                          snapshot.data!.data!.courses![1].postTitle.toString(),
                          textAlign: TextAlign.left,
                          style: GoogleFonts.inter(
                              textStyle: TextStyle(
                                  fontSize: 22,
                                  fontWeight: FontWeight.w500,
                                  color: AppColor.titleText)),
                                              ),
                                            ),
                                            const SizedBox(
                                              height: 15,
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.only(bottom: 6, left: 10),
                                              child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Row(
                              children: [
                                Text(
                                  "\$${snapshot.data!.data!.courses![1].productData!.regularPrice}.00",
                                  textAlign: TextAlign.left,
                                  style: GoogleFonts.inter(
                                      textStyle: TextStyle(
                                          decoration: TextDecoration.lineThrough,
                                          fontSize: 16,
                                          fontWeight: FontWeight.w400,
                                          color: AppColor.subText)),
                                ),
                                const SizedBox(
                                  width: 5,
                                ),
                                Text(
                                  "\$${snapshot.data!.data!.courses![1].productData!.salePrice}",
                                  textAlign: TextAlign.left,
                                  style: GoogleFonts.inter(
                                      textStyle: TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.w600,
                                          color: AppColor.titleText)),
                                ),
                              ],
                            ),
                            Container(
                              padding: EdgeInsets.all(6),
                              margin: EdgeInsets.only(bottom: 6, right: 10),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(4),
                                  border: Border.all(color: AppColor.titleText)),
                              child: Row(
                                children: [
                                  Icon(
                                    CupertinoIcons.cart,
                                    size: 17,
                                  ),
                                  const SizedBox(
                                    width: 5,
                                  ),
                                  Text(
                                    "Buy Now",
                                    textAlign: TextAlign.left,
                                    style: GoogleFonts.inter(
                                        textStyle: TextStyle(
                                            fontSize: 17,
                                            fontWeight: FontWeight.w600,
                                            color: AppColor.titleText)),
                                  ),
                                ],
                              ),
                            )
                          ],
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                        )
                      ]
                    ],
                  );
                }),
            ],
          ),
        )),
      ),
    );
  }
}
