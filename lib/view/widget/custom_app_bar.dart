import 'package:courtship_to_marriage/const/colors.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CustomAppBar(
      {this.title = "",
      this.centerTitle = false,
      this.showImage = false,
      super.key});
  final String? title;
  final bool? centerTitle;
  final bool? showImage;
  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.transparent,
      centerTitle: centerTitle,
      elevation: 0,
      scrolledUnderElevation: 0,
      automaticallyImplyLeading: true,
      leadingWidth: 40,
      title: Text(
        title!,
        textAlign: TextAlign.center,
        style: GoogleFonts.inter(
            textStyle: TextStyle(
                fontSize: 26,
                fontWeight: FontWeight.w700,
                color: AppColor.titleText)),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
