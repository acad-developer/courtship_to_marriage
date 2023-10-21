import 'package:courtship_to_marriage/const/colors.dart';
import 'package:courtship_to_marriage/view/page/course/course.dart';
import 'package:courtship_to_marriage/view/page/home/home.dart';
import 'package:courtship_to_marriage/view/page/profile/profile.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_fonts/google_fonts.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  List<Widget> pages = [
    HomeScreen(),
    CourseScreen(),
    Center(child: Text("Affilate"),),
    ProfileScreen()
  ];
  final readToken = GetStorage();
  RxInt selectedIndex = 0.obs;
  @override
  void initState() {
    // TODO: implement initState
    print(readToken.read('username'));
    showPopUp();
    super.initState();
  }

  showPopUp() async {
    await Future.delayed(Duration(milliseconds: 50));
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return new AlertDialog(
            elevation: 0,
            shadowColor: Colors.transparent,
            backgroundColor: Colors.transparent,
            titlePadding: EdgeInsets.all(0),
            title: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                InkWell(
                  onTap: (){
                    Get.back();
                  },
                  child: Container(
                    width: 40,
                    height: 35,
                    margin: EdgeInsets.only(bottom: 6),
                    alignment: Alignment.center,
                    // padding: EdgeInsets.all(20),
                    decoration: BoxDecoration(
                       color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Icon(CupertinoIcons.clear_thick, size: 18,),
                  ),
                ),
                InkWell(
                  onTap: (){
                    selectedIndex.value = 1;
                    Get.back();
                  },
                  child: Container(
                    width: MediaQuery.of(context).size.width * 0.9,
                    height: MediaQuery.of(context).size.height * 0.5,
                    decoration: BoxDecoration(
                      // borderRadius: BorderRadius.circular(12),
                      image: DecorationImage(
                        image: AssetImage("assets/images/pop_up.jpg"),
                        fit: BoxFit.fill
                      )
                    ),
                  ),
                ),
              ],
            ),
            
            // Image.asset("assets/images/pop_up.jpg", ,),
            // width: 100,
            // height: 100,
            // color: Colors.white,
          );
        });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Obx(
        () {
          return pages[selectedIndex.value];
        }
      ),
      bottomNavigationBar: Obx(
        () {
          return BottomNavigationBar(
            type: BottomNavigationBarType.fixed,
            backgroundColor: Colors.transparent,
            elevation: 0,
            currentIndex: selectedIndex.value,
            selectedItemColor: AppColor.appPrimary,
            selectedIconTheme: IconThemeData(color: Colors.red, size: 50),
            selectedLabelStyle: GoogleFonts.inter(
                textStyle: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w500,
            )),
            showUnselectedLabels: false,
            items: <BottomNavigationBarItem>[
              BottomNavigationBarItem(
                  icon: SvgPicture.asset(
                    "assets/svg/house_simple.svg",
                    width: 26,
                    color: AppColor.appPrimary
                        .withOpacity((selectedIndex == 0) ? 1 : 0.5),
                  ),
                  label: "Home"),
              BottomNavigationBarItem(
                  icon: SvgPicture.asset(
                    "assets/svg/courses.svg",
                    width: 26,
                    color: AppColor.appPrimary
                        .withOpacity((selectedIndex == 1) ? 1 : 0.5),
                  ),
                  label: "Course"),
              BottomNavigationBarItem(
                  icon: SvgPicture.asset(
                    "assets/svg/affiliate.svg",
                    width: 26,
                    color: AppColor.appPrimary
                        .withOpacity((selectedIndex == 2) ? 1 : 0.5),
                  ),
                  label: "Affiliate"),
              BottomNavigationBarItem(
                  icon: SvgPicture.asset(
                    "assets/svg/profile.svg",
                    width: 26,
                    color: AppColor.appPrimary
                        .withOpacity((selectedIndex == 3) ? 1 : 0.5),
                  ),
                  label: "Profile"),
            ],
            onTap: (index) {
              selectedIndex.value = index;
            },
          );
        }
      ),
    );
  }
}