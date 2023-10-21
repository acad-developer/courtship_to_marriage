import 'package:carousel_slider/carousel_slider.dart';
import 'package:courtship_to_marriage/const/colors.dart';
import 'package:courtship_to_marriage/controller/blog_controller/blog_controller.dart';
import 'package:courtship_to_marriage/controller/home_controller/home_controller.dart';
import 'package:courtship_to_marriage/model/blog_model/blog_model.dart';
import 'package:courtship_to_marriage/model/recommendation_model/recommendation_model.dart';
import 'package:courtship_to_marriage/model/success_story_model/success_story_model.dart';
import 'package:courtship_to_marriage/utils/app_routes.dart';
import 'package:courtship_to_marriage/view/page/blog/widget/blog_widget.dart';
import 'package:courtship_to_marriage/view/page/home/quize.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final List<Map<String, dynamic>> list = [
    {
      "image":
          "https://courtshiptomarriage.com/wp-content/uploads/2023/10/25Uar0ChTdiwMfwc8D3W_Untitled_design_29-120x120.jpg",
      "review":
          "This course is great if you are looking for help starting a relationship or are already in one. It will help you understand the foundations of relationships and how to build upon them.",
      "name": "Ankur Masih",
      "address": "Worshipper (Ludhiana, Punjab)"
    },
    {
      "image":
          "https://courtshiptomarriage.com/wp-content/uploads/2023/10/pko0Lu3oQ7ydSowiwZOB_yItSnPzTQKVBUrPOWwQl_Untitled_design_23-120x120.jpg",
      "review":
          "Evans’ courtship to marriage will help you divert your focus from the distractions of wedding ceremony and helps you to focus on handling the main issues in marriage talking about, communication, conflict fixing, and finding solutions for issues in the marriage. I highly recommend this course for you.",
      "name": "Sis. Pragati Vaish",
      "address":
          "Worshipper, Songwriter, Composer, Co-founder - Theholysoulrevelation Ministry (Bilaspur, Chhattisgarh)"
    },
    {
      "image":
          "https://courtshiptomarriage.com/wp-content/uploads/2023/10/F1jdXm2LSFGt462nAdlw_d545ba4-167a-04fc-4fa2-bfcc040a7f0b_Untitled_design_22_-120x120.jpg",
      "review":
          "This is the best course for people seeking marriage. The best part is that it’s built around the principles found in the Bible. This course applies that with a modern approach and practical application. It will make courtship to marriage easy for many.",
      "name": "Ashish Chauhan",
      "address": "Worshipper (Pune)"
    },
    {
      "image":
          "https://courtshiptomarriage.com/wp-content/uploads/2023/10/ta6rxITES7ixoF9mFg0p_C6qMNi69QcaJYj3y5kBy_Untitled_design_6-120x120.jpg",
      "review":
          "The course is very informative, and the lessons are easy to follow. I recommend this course to anyone who wants to prepare their young people for marriage.",
      "name": "Sister Jyoti Masih",
      "address": "Worshipper (Patiala, Punjab)"
    },
    {
      "image":
          "https://courtshiptomarriage.com/wp-content/uploads/2023/10/vpiWTDRqTiakWmsKyiEt_AApRsQVwQMyLk6LTSz2V_Untitled_design_19-120x120.jpg",
      "review":
          "Evans’ Courtship to Marriage is a great course for young people preparing for marriage. It helps you understand how it applies to your life and gives you a set of tools to help you navigate through the process of courtship to marriage. I highly recommend it!",
      "name": "Jesse Jonathan David",
      "address": "Worshipper (Indore, MP)"
    },
  ];

  final List<Map<String, dynamic>> student = [
    {
      "name": "Akash R",
      "review":
          "“I never thought taking a marriage course will be such a mindset changer for me! Initially, I was skeptical about taking it but now that I have, I’m so glad I did. We get so lost in the glamour of weddings and Evans’s teachings are reality-based setting the couple’s expectations straight for marriage”"
    },
    {
      "name": "Susan M",
      "review":
          "“Can’t recommend Courtship to Marriage course enough! Marriage is such a big aspect of our lives but sadly nobody prepares us for it. Most people get romanticize the idea of courtship from movies, but this course gives insights and advice that are practical and applicable. I truly feel as if I’m ready for stepping into the next phase of my life.”"
    },
    {
      "review":
          "“My fiancée suggested that we take this course together and I, to be honest, initially I only agreed to take it because of her. But now that we have completed this course, I feel so prepared. I had no idea that we as a couple should talk and work out the stuff that this course tells us to!”",
      "name": "Luke H"
    },
    {
      "review":
          "“I come from a family where my parents didn’t really set an ideal example of marriage. So I never knew what an ideal marriage looks like or how you’re supposed to tackle agreements in relationships. This course has been a guide for me. Highly recommend!”",
      "name": "Sharon K"
    },
    {
      "review":
          "“As a parent, it’s hard to talk about this stuff to your children especially when they are not keen on listening to your advice. So, I gifted my son and my daughter-in-law this course so they can start their new chapter in life with happiness and love.”",
      "name": "Deborah A"
    },
    {
      "review":
          "“We always believe “everything will be all right” after marriage but there are innumerable marital problems in our society. I’m so glad Evans educated us because you don’t know what you’re getting yourself into unless you are prepared and educated for it”",
      "name": "Amit M"
    },
    {
      "review":
          "“I wish that we got this education sooner. How to disagree without fighting or blaming, ways to defuse arguments, and how to make your partner feel heard and understood. Absolutely loved this course!”",
      "name": "Sheena D"
    },
    {
      "review":
          "“I learned a lot from the course, and I think I’m going to use what I learned in my marriage.”",
      "name": "Ramesh C"
    },
    {
      "review":
          "“I really liked how this course took my attention away from wedding planning ( which is one day) and made me think about dealing with the problems discussing and arriving at solutions for their marriage, which if we are lucky will last a lifetime!”",
      "name": "Rohit G"
    },
    {
      "review":
          "“I think it’s important for everyone to understand what marriage is, how it works and why we need to take responsibility for our relationship. The course was very easy to understand and follow along with, I highly recommend this course!”",
      "name": "Angel D"
    },
    {
      "review":
          "“If you’re looking to make your marriage, be happier and stronger, this course is for you! I learned so many things, especially about how to make it work in difficult times that I wonder why no one teaches us this stuff before!”",
      "name": "Prerna B"
    },
  ];

  final List<Map<String, dynamic>> videoList = [
    {
      "thumbnail":
          "assets/images/english.png"
    },
    {
      "thumbnail":
          "assets/images/hindi.png"
    },
  ];

  final List<String> slider = [
    "assets/images/slider_1.jpg",
    "assets/images/slider_2.jpg",
    "assets/images/slider_3.jpg",
  ];

  final List<Map<String, dynamic>> partner = [
    {"image" : "assets/images/1.jpg", "title" : "Visionary Radio & Tv", "subtitle" : "Jaipur, India"},
    {"image" : "assets/images/2.jpg", "title" : "Evans Francis Ministries", "subtitle" : "Nagpur, India"},
    {"image" : "assets/images/3.jpg", "title" : "House of Deliverance", "subtitle" : "Nagpur, India"},
  ];

  final BlogController blogController = Get.isRegistered<BlogController>()
      ? Get.find()
      : Get.put(BlogController());

  final HomeController homeController = Get.isRegistered<HomeController>()
      ? Get.find()
      : Get.put(HomeController());
  // final databases = Databases(client);

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Home",
                  textAlign: TextAlign.left,
                  style: GoogleFonts.inter(
                      textStyle: TextStyle(
                          fontSize: 36,
                          fontWeight: FontWeight.w700,
                          color: AppColor.titleText)),
                ),
                const SizedBox(
                  height: 10,
                ),
                CarouselSlider(
                    items: [
                        for(int i=0;i<slider.length; i++)...[
                          Padding(
                            padding: const EdgeInsets.only(right: 10),
                            child: AspectRatio(
                              aspectRatio: 16/9,
                              child: Container(
                              width: double.infinity,
                              // margin: EdgeInsets.only(right: 10),
                              decoration: BoxDecoration(
                                  // borderRadius: BorderRadius.circular(16),
                                  image: DecorationImage(
                                      image:
                                          AssetImage(slider[i].toString()),
                                      fit: BoxFit.fill)),
                              
                                                    ),
                            ),
                          )
                        ]
                        
                      
                    ],
                    options: CarouselOptions(
                      height: 200,
                      aspectRatio: 16 / 9,
                      viewportFraction: 1,
                      initialPage: 0,
                      enableInfiniteScroll: true,
                      reverse: false,
                      autoPlay: true,
                      autoPlayInterval: Duration(seconds: 5),
                      autoPlayCurve: Curves.fastOutSlowIn,
                      enlargeCenterPage: false,
                      enlargeFactor: 0.2,
                      scrollDirection: Axis.horizontal,
                    )),
                Padding(
                  padding: const EdgeInsets.only(top: 20, bottom: 10),
                  child: Text(
                    "Watch the First Lesson for Free",
                    textAlign: TextAlign.center,
                    style: GoogleFonts.inter(
                        textStyle: TextStyle(
                            fontSize: 21,
                            fontWeight: FontWeight.w700,
                            color: AppColor.titleText)),
                  ),
                ),
                CarouselSlider(
                    items: [
                      for (int i = 0; i < videoList.length; i++) ...[
                        Container(
                          width: double.infinity,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(16),
                              image: DecorationImage(
                                  image:
                                      AssetImage(videoList[i]["thumbnail"]),
                                  fit: BoxFit.fill)),
                          child: Center(
                            child: CircleAvatar(
                              radius: 24,
                              backgroundColor:
                                  AppColor.appPrimary.withOpacity(0.8),
                              child: Icon(
                                Icons.play_arrow_rounded,
                                size: 30,
                                color: AppColor.titleText,
                              ),
                            ),
                          ),
                        )
                      ]
                    ],
                    options: CarouselOptions(
                      height: 200,
                      aspectRatio: 16 / 9,
                      viewportFraction: 0.92,
                      initialPage: 0,
                      enableInfiniteScroll: true,
                      reverse: false,
                      autoPlay: true,
                      autoPlayInterval: Duration(seconds: 5),
                      autoPlayCurve: Curves.fastOutSlowIn,
                      enlargeCenterPage: true,
                      enlargeFactor: 0.15,
                      scrollDirection: Axis.horizontal,
                    )),
                const SizedBox(
                  height: 20,
                ),
                QuizWidget(),
                Padding(
                  padding: const EdgeInsets.only(top: 20, bottom: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Blogs",
                        textAlign: TextAlign.center,
                        style: GoogleFonts.inter(
                            textStyle: TextStyle(
                                fontSize: 22,
                                fontWeight: FontWeight.w700,
                                color: AppColor.titleText)),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(right: 6),
                        child: InkWell(
                            onTap: (){
                              Get.toNamed(AppRoutes.blog);
                            },
                            child: Text(
                                                    "See all",
                                                    textAlign: TextAlign.center,
                                                    style: GoogleFonts.inter(
                                                        textStyle: TextStyle(
                                                            fontSize: 16,
                                                            fontWeight: FontWeight.w700,
                                                            color: AppColor.appPrimary)),
                                                  ),
                          ),
                      ),
    
                    ],
                  ),
                ),
                FutureBuilder<List<Blog>>(
                    future: blogController.getBlogContent(),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return Center(
                            child: CircularProgressIndicator(
                          color: AppColor.appPrimary,
                        ));
                      }
                      return Container(
                        // width: 3,
                        height: 350,
                        child: ListView.builder(
                            itemCount: snapshot.data!.length,
                            scrollDirection: Axis.horizontal,
                            itemBuilder: (context, index) {
                              return Container(
                                  width: 200,
                                  color: Colors.white,
                                  child:
                                      BlogWidget(data: snapshot.data![index]));
                            }),
                      );
                    }),
                Padding(
                  padding: const EdgeInsets.only(top: 20, bottom: 10),
                  child: Text(
                    "Recommendation",
                    textAlign: TextAlign.center,
                    style: GoogleFonts.inter(
                        textStyle: TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.w700,
                            color: AppColor.titleText)),
                  ),
                ),
                FutureBuilder<List<Recommendation>>(
                      future: homeController.getRecommendationData(), 
                      builder: (context, snapshot){
                         if (snapshot.connectionState == ConnectionState.waiting) {
                        return Center(
                            child: CircularProgressIndicator(
                          color: AppColor.appPrimary,
                        ));
                      }
                      if(snapshot.hasData == true){
                         return CarouselSlider(
                    items: [
                      for (int i = 0; i < snapshot.data!.length; i++)...[
                        Container(
                          width: MediaQuery.of(context).size.width * 0.9,
                          decoration: BoxDecoration(
                              color: AppColor.subText.withOpacity(0.05),
                              // color: Colors.red,
                              border: Border.all(color: AppColor.appPrimary, width: 1),
                              borderRadius: BorderRadius.circular(16)),
                          padding: EdgeInsets.all(16),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              CircleAvatar(
                                radius: 50,
                                backgroundImage: NetworkImage(snapshot.data![i].image),
                              ),
                              Text(
                                "\"${snapshot.data![i].review.toString()}\"",
                                textAlign: TextAlign.center,
                                maxLines: 6,
                                overflow: TextOverflow.ellipsis,
                                style: GoogleFonts.inter(
                                    textStyle: TextStyle(
                                        fontSize: 11,
                                        fontWeight: FontWeight.w500,
                                        color: AppColor.titleText)),
                              ),
                              // const SizedBox(height: 10,),
                              Column(
                                children: [
                                  Text(
                                    snapshot.data![i].name.toString(),
                                    textAlign: TextAlign.center,
                                    style: GoogleFonts.inter(
                                        textStyle: TextStyle(
                                            fontSize: 10,
                                            fontWeight: FontWeight.w700,
                                            color: AppColor.titleText)),
                                  ),
                                  const SizedBox(
                                    height: 2,
                                  ),
                                  Text(
                                    snapshot.data![i].address.toString(),
                                    textAlign: TextAlign.center,
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                    style: GoogleFonts.inter(
                                        textStyle: TextStyle(
                                            fontSize: 10,
                                            fontWeight: FontWeight.w500,
                                            color: AppColor.titleText)),
                                  ),
                                ],
                              ),
                              // const SizedBox(height: 2,),
                            ],
                          ),
                        )
                      ]
                    ],
                    options: CarouselOptions(
                      height: 300,
                      aspectRatio: 16 / 9,
                      viewportFraction: 0.9,
                      initialPage: 0,
                      enableInfiniteScroll: true,
                      reverse: false,
                      autoPlay: true,
                      autoPlayInterval: Duration(seconds: 3),
                      autoPlayAnimationDuration: Duration(milliseconds: 800),
                      autoPlayCurve: Curves.fastOutSlowIn,
                      enlargeCenterPage: true,
                      enlargeFactor: 0.15,
                      // onPageChanged: callbackFunction,
                      scrollDirection: Axis.horizontal,
                    ));
                      }
                        return Center(
                            child: CircularProgressIndicator(
                          color: AppColor.appPrimary,
                        )); 
                        // return Text(snapshot.data![0].address.toString());
                      }),
                
                Padding(
                  padding: const EdgeInsets.only(top: 20, bottom: 10),
                  child: Text(
                    "Happy Many Students",
                    textAlign: TextAlign.center,
                    style: GoogleFonts.inter(
                        textStyle: TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.w700,
                            color: AppColor.titleText)),
                  ),
                ),
                FutureBuilder<List<SuccessStory>>(
                  future: homeController.getSuccessStoryData(), 
                      builder: (context, snapshot){
                         if (snapshot.connectionState == ConnectionState.waiting) {
                          return Center(
                              child: CircularProgressIndicator(
                            color: AppColor.appPrimary,
                          ));
                        }
                        if(snapshot.hasData == true){
                          return CarouselSlider(
                    items: [
                      for (int i = 0; i < snapshot.data!.length; i++) ...[
                        Container(
                          width: MediaQuery.of(context).size.width * 0.9,
                          decoration: BoxDecoration(
                              color: AppColor.subText.withOpacity(0.05),
                              border: Border.all(color: AppColor.appPrimary, width: 1),
                              // color: Colors.red,
                              borderRadius: BorderRadius.circular(16)),
                          padding: EdgeInsets.all(16),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              // CircleAvatar(
                              //   radius: 50,
                              //   backgroundImage: NetworkImage(list[i]["image"]),
                              // ),
                              Text(
                                "\"${snapshot.data![i].review}\"",
                                textAlign: TextAlign.center,
                                maxLines: 6,
                                overflow: TextOverflow.ellipsis,
                                style: GoogleFonts.inter(
                                    textStyle: TextStyle(
                                        fontSize: 11,
                                        fontWeight: FontWeight.w500,
                                        color: AppColor.titleText)),
                              ),
                              // const SizedBox(height: 10,),
                              // Column(
                              //   children: [
                                  Text(
                                    "- ${snapshot.data![i].name}",
                                    textAlign: TextAlign.center,
                                    style: GoogleFonts.inter(
                                        textStyle: TextStyle(
                                            fontSize: 10,
                                            fontWeight: FontWeight.w700,
                                            color: AppColor.titleText)),
                                  ),
                                  // const SizedBox(
                                  //   height: 2,
                                  // ),
                                  // Text(
                                  //   list[i]["address"].toString(),
                                  //   textAlign: TextAlign.center,
                                  //   maxLines: 2,
                                  //   overflow: TextOverflow.ellipsis,
                                  //   style: GoogleFonts.inter(
                                  //       textStyle: TextStyle(
                                  //           fontSize: 10,
                                  //           fontWeight: FontWeight.w500,
                                  //           color: AppColor.titleText)),
                                  // ),
                              //   ],
                              // ),
                              // const SizedBox(height: 2,),
                            ],
                          ),
                        )
                      ]
                    ],
                    options: CarouselOptions(
                      height: 200,
                      aspectRatio: 16 / 9,
                      viewportFraction: 0.9,
                      initialPage: 0,
                      enableInfiniteScroll: true,
                      reverse: false,
                      autoPlay: true,
                      autoPlayInterval: Duration(seconds: 3),
                      autoPlayAnimationDuration: Duration(milliseconds: 800),
                      autoPlayCurve: Curves.fastOutSlowIn,
                      enlargeCenterPage: true,
                      enlargeFactor: 0.15,
                      // onPageChanged: callbackFunction,
                      scrollDirection: Axis.horizontal,
                    ));
                        }
                        return Center(
                            child: CircularProgressIndicator(
                          color: AppColor.appPrimary,
                        ));
                        
                      }
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 20, bottom: 10),
                  child: Text(
                    "Our Partners",
                    textAlign: TextAlign.center,
                    style: GoogleFonts.inter(
                        textStyle: TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.w700,
                            color: AppColor.titleText)),
                  ),
                ),
                // FutureBuilder<List<SuccessStory>>(
                //   future: homeController.getSuccessStoryData(), 
                //       builder: (context, snapshot){
                //          if (snapshot.connectionState == ConnectionState.waiting) {
                //           return Center(
                //               child: CircularProgressIndicator(
                //             color: AppColor.appPrimary,
                //           ));
                //         }
                //         if(snapshot.hasData == true){
                          CarouselSlider(
                    items: [
                      for (int i = 0; i < partner.length; i++) ...[
                        Container(
                          width: MediaQuery.of(context).size.width * 0.9,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                              color: AppColor.subText.withOpacity(0.05),
                              border: Border.all(color: AppColor.appPrimary, width: 1),
                              // color: Colors.red,
                              borderRadius: BorderRadius.circular(16)),
                          padding: EdgeInsets.all(4),
                          child: ListTile(
                            minLeadingWidth: 0,
                            isThreeLine: false,
                            minVerticalPadding: 0,
                            dense: true,
                            titleAlignment: ListTileTitleAlignment.center,
                            contentPadding: EdgeInsets.all(0),
                            horizontalTitleGap: 0,
                            visualDensity: VisualDensity(vertical: 2),
                            leading: CircleAvatar(
                                radius: 45,
                                backgroundImage: AssetImage(partner[i]["image"]),
                              ),
                            title: Text(
                                    partner[i]["title"].toString(),
                                    textAlign: TextAlign.left,
                                    overflow: TextOverflow.ellipsis,
                                    style: GoogleFonts.inter(
                                        textStyle: TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.w700,
                                            color: AppColor.titleText)),
                                  ),
                            subtitle: Text(
                                        partner[i]["subtitle"].toString(),
                                        textAlign: TextAlign.left,
                                        style: GoogleFonts.inter(
                                            textStyle: TextStyle(
                                                fontSize: 12,
                                                fontWeight: FontWeight.w700,
                                                color: AppColor.titleText)),
                                      ),
                          ),
                          // Row(
                          //   crossAxisAlignment: CrossAxisAlignment.center,
                          //   children: [
                          //     CircleAvatar(
                          //       radius: 40,
                          //       backgroundImage: AssetImage(partner[i]["image"]),
                          //     ),
                          //     const SizedBox(width: 6,),
                          //     Column(
                          //       mainAxisAlignment: MainAxisAlignment.center,
                          //       children: [
                          //         // CircleAvatar(
                          //         //   radius: 50,
                          //         //   backgroundImage: NetworkImage(list[i]["image"]),
                          //         // ),
                          //         Text(
                          //           partner[i]["title"].toString(),
                          //           textAlign: TextAlign.center,
                          //           overflow: TextOverflow.ellipsis,
                          //           style: GoogleFonts.inter(
                          //               textStyle: TextStyle(
                          //                   fontSize: 18,
                          //                   fontWeight: FontWeight.w700,
                          //                   color: AppColor.titleText)),
                          //         ),
                          //         // const SizedBox(height: 10,),
                          //         // Column(
                          //         //   children: [
                          //             Text(
                          //               partner[i]["subtitle"].toString(),
                          //               textAlign: TextAlign.center,
                          //               style: GoogleFonts.inter(
                          //                   textStyle: TextStyle(
                          //                       fontSize: 10,
                          //                       fontWeight: FontWeight.w700,
                          //                       color: AppColor.titleText)),
                          //             ),
                          //             // const SizedBox(
                          //             //   height: 2,
                          //             // ),
                          //             // Text(
                          //             //   list[i]["address"].toString(),
                          //             //   textAlign: TextAlign.center,
                          //             //   maxLines: 2,
                          //             //   overflow: TextOverflow.ellipsis,
                          //             //   style: GoogleFonts.inter(
                          //             //       textStyle: TextStyle(
                          //             //           fontSize: 10,
                          //             //           fontWeight: FontWeight.w500,
                          //             //           color: AppColor.titleText)),
                          //             // ),
                          //         //   ],
                          //         // ),
                          //         // const SizedBox(height: 2,),
                          //       ],
                          //     ),
                          //   ],
                          // ),
                        )
                      ]
                    ],
                    options: CarouselOptions(
                      height: 100,
                      aspectRatio: 16 / 9,
                      viewportFraction: 0.9,
                      initialPage: 0,
                      enableInfiniteScroll: true,
                      reverse: false,
                      autoPlay: true,
                      autoPlayInterval: Duration(seconds: 3),
                      autoPlayAnimationDuration: Duration(milliseconds: 800),
                      autoPlayCurve: Curves.fastOutSlowIn,
                      enlargeCenterPage: true,
                      enlargeFactor: 0.15,
                      // onPageChanged: callbackFunction,
                      scrollDirection: Axis.horizontal,
                    )),
                //         }
                //         return Center(
                //             child: CircularProgressIndicator(
                //           color: AppColor.appPrimary,
                //         ));
                        
                //       }
                // ),
                  const SizedBox(height: 50,)
                // Container(
                //   padding: EdgeInsets.all(13),
                //   decoration: BoxDecoration(
                //       borderRadius: BorderRadius.circular(14),
                //       border: Border.all(color: AppColor.appPrimary, width: 2)),
                //   child: Column(
                //     children: [
                //       for (int i = 0; i < student.length; i++) ...[
                //         Padding(
                //           padding: const EdgeInsets.symmetric(vertical: 4),
                //           child: RichText(
                //             textAlign: TextAlign.justify,
                //             text: TextSpan(
                //                 text: student[i]["review"].toString(),
                //                 style: GoogleFonts.inter(
                //                     textStyle: TextStyle(
                //                         fontSize: 12,
                //                         fontWeight: FontWeight.w500,
                //                         color: AppColor.titleText)),
                //                 children: <TextSpan>[
                //                   TextSpan(
                //                     text: " - ${student[i]["name"]}.",
                //                     style: GoogleFonts.inter(
                //                         textStyle: TextStyle(
                //                             fontSize: 12,
                //                             fontWeight: FontWeight.w700,
                //                             color: AppColor.titleText)),
                //                   )
                //                 ]),
                //           ),
                //         ),
                //       ],
                //     ],
                //   ),
                // ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
