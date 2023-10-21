import 'package:appwrite/appwrite.dart';
import 'package:courtship_to_marriage/const/colors.dart';
import 'package:courtship_to_marriage/utils/appwrite.dart';
import 'package:courtship_to_marriage/view/page/auth/login.dart';
import 'package:courtship_to_marriage/view/page/main/main_screen.dart';
import 'package:courtship_to_marriage/view/page/profile/profile_pages/affilate.dart';
import 'package:courtship_to_marriage/view/page/profile/profile_pages/check_courses.dart';
import 'package:courtship_to_marriage/view/page/profile/profile_pages/contact_us.dart';
import 'package:courtship_to_marriage/view/page/profile/profile_pages/help_center.dart';
import 'package:courtship_to_marriage/view/page/profile/profile_pages/privacy.dart';
import 'package:courtship_to_marriage/view/page/profile/profile_pages/terms_condition.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_fonts/google_fonts.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {

  final readToken = GetStorage();

  List<Map<String, dynamic>> profile = [
    {"svg":"assets/svg/courses.svg", "name" : "Courses", "route" : const CheckCourses()},
    {"svg":"assets/svg/affiliate.svg", "name" : "Affilate","route" : const Affilate()},
    {"svg":"assets/svg/privacy_policy.svg", "name" : "Privacy & Policy", "route" : const PrivacyPolicy()},
    {"svg":"assets/svg/t&c.svg", "name" : "Terms & Condition", "route" : const TermsConditions()},
    {"svg":"assets/svg/contact_us.svg", "name" : "Help & Support", "route" : const HelpCenter()},
    {"svg":"assets/svg/logout.svg", "name" : "Login","route" : const LoginScreen()},
    {"svg":"assets/svg/logout.svg", "name" : "Logout","route" : const MainScreen()},
  ];

  @override
  void initState() {
    // TODO: implement initState
    print(readToken.read('username'));
    print( readToken.read('docID'));
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Container(
              width: double.infinity,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Profile",
                    textAlign: TextAlign.center,
                    style: GoogleFonts.inter(
                        textStyle: TextStyle(
                            fontSize: 36,
                            fontWeight: FontWeight.w700,
                            color: AppColor.titleText)),
                  ),
                  // const SizedBox(height: 50,),
                  // CircleAvatar(
                  //   radius: 60,
                  //   backgroundColor: Colors.transparent,
                  //   backgroundImage: AssetImage("assets/images/profile_picture.png"),
                  // ),
                  const SizedBox(height: 10,),
                  // Text(
                  //   "Mahmoud. S",
                  //   textAlign: TextAlign.center,
                  //   style: GoogleFonts.inter(
                  //       textStyle: TextStyle(
                  //           fontSize: 20,
                  //           fontWeight: FontWeight.w600,
                  //           color: AppColor.titleText)),
                  // ),
                  // const SizedBox(height: 4,),
                  // Text(
                  //   "200 Level Computer Science",
                  //   textAlign: TextAlign.center,
                  //   style: GoogleFonts.inter(
                  //       textStyle: TextStyle(
                  //           fontSize: 12,
                  //           fontWeight: FontWeight.w400,
                  //           color: AppColor.titleText)),
                  // ),
                  const SizedBox(height: 20,),
                  ListView.builder(
                    shrinkWrap: true,
                    itemCount: profile.length,
                    itemBuilder: (context, index){
                      if(readToken.read('username') == null && (index == 0 || index == 6) ){
                        return Container();
                      } else if(readToken.read('username') != null && (index == 5)){
                        return Container();
                      } else{
                        return InkWell(
                        onTap: () async{
                          if(profile[index]["name"] != "Logout"){
                            // await AppWrite.databases.deleteDocument(
                            //   databaseId: AppWrite.userDatabaseID,
                            //   collectionId: AppWrite.loginCollectionID,
                            //   documentId: 'dummy@gmail.com'
                            // );
                            Get.to(profile[index]["route"]);
                          } else {  
                            await AppWrite.databases.deleteDocument(
                              databaseId: AppWrite.userDatabaseID,
                              collectionId: AppWrite.loginCollectionID,
                              documentId: readToken.read('docID')
                            );
                            readToken.remove('username');
                            readToken.remove('docID');
                            Get.offAll(profile[index]["route"]);
                          }
                        },
                        child: ListTile(
                          dense: true,
                          minLeadingWidth: 0,
                          leading: SvgPicture.asset(profile[index]["svg"],width: 20, colorFilter: ColorFilter.mode((profile[index]["name"] != "Logout")?AppColor.appPrimary : Colors.red, BlendMode.srcIn),),
                          trailing: SvgPicture.asset("assets/svg/back_arrow.svg", width: 11, colorFilter: ColorFilter.mode(AppColor.appPrimary, BlendMode.srcIn),),
                          title: Text(
                                          profile[index]["name"],
                                          textAlign: TextAlign.left,
                                          style: GoogleFonts.inter(
                          textStyle: TextStyle(
                              fontSize: 13,
                              fontWeight: FontWeight.w500,
                              color: (profile[index]["name"] != "Logout")?AppColor.appPrimary : Colors.red)),
                                        ),
                        ),
                      );
                      }
                      
                  })
                ],
              ),
            ),
          ),
        )),
    );
  }
}