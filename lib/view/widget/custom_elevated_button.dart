import 'package:courtship_to_marriage/const/colors.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomElevatedButton extends StatelessWidget {
  const CustomElevatedButton(
      {required this.text, 
      required this.onPressed,
      this.showBorder = false, 
      this.isValidate = true,
      super.key});
  final String text;
  final Function()? onPressed;
  final bool? showBorder;
  final bool? isValidate;
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
          elevation: (showBorder == false) ? (isValidate == false)?0 :3 : 0,
          shadowColor: AppColor.appPrimary,
          padding: EdgeInsets.all(14),
          backgroundColor: (showBorder == false) ? (isValidate == false)?AppColor.appPrimary.withOpacity(0.62) : AppColor.appPrimary  : Colors.white,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(24),
              side: (showBorder == false) ? BorderSide.none : BorderSide(color: AppColor.appPrimary, width: 1.5))),
      child: Text(
        text,
        textAlign: TextAlign.center,
        style: GoogleFonts.inter(
            textStyle: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w600,
          color: (showBorder == false) ? Colors.white : AppColor.appPrimary,
        )),
      ),
    );
  }
}
