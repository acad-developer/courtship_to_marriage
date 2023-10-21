import 'package:courtship_to_marriage/const/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

class CustomTextFormFieldWithLabel extends StatefulWidget {
  CustomTextFormFieldWithLabel({
    required this.labelText,
    required this.hintText,
    required this.focusNode,
    this.svgAsset,
    this.controller,
    this.maxLines = 1,
    this.isPassword = false,
    this.isDate = false,
    this.validator,
    super.key});
  final String labelText;
  final String hintText;
  final String? svgAsset;
  TextEditingController? controller;
  final int maxLines;
  final bool? isPassword;
  final bool? isDate;
  final String? Function(String?)? validator;
  final FocusNode? focusNode;
  @override
  State<CustomTextFormFieldWithLabel> createState() => _CustomTextFormFieldWithLabelState();
}

class _CustomTextFormFieldWithLabelState extends State<CustomTextFormFieldWithLabel> {
  bool visible = false;
  @override
  void initState() {
    if(widget.isPassword == true){
      visible = true;
    }
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
        //   RichText(text: TextSpan(
        //     style: DefaultTextStyle.of(context).style,
        //     children: <TextSpan>[
        //       TextSpan(
        //           text: widget.labelText, 
        //           style: GoogleFonts.inter(
        //               textStyle: const TextStyle(
        //                 fontSize: 14,
        //                 fontWeight: FontWeight.w600,
        //               )
        //             ),),
        //       TextSpan(
        //           text: '*', 
        //           style: GoogleFonts.inter(
        //               textStyle: const TextStyle(
        //                 fontSize: 18,
        //                 fontWeight: FontWeight.w600,
        //                 color: Colors.red,
        //               )
        //             ),),
        //     ],
        //   ),
        // ),
          Container(
                margin: const EdgeInsets.only(top: 10),
                decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      color: widget.focusNode!.hasFocus? Colors.transparent: Colors.grey.shade200,
                     blurRadius: 25.0,
                    //  spreadRadius: 1.0
                      ),
                  ]
                ),
                child: TextFormField(
                  controller: widget.controller,
                  focusNode: widget.focusNode,
                  onChanged: ((value) {
                    
                  }),
                  maxLines: widget.maxLines,
                  obscureText: visible,
                  obscuringCharacter: '*',
                  decoration: InputDecoration(
                    hintText: widget.hintText,
                    hintStyle: GoogleFonts.inter(
                      textStyle: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        color: Color.fromRGBO(22, 28, 43, 0.5),
                      )
                    ),
                    prefixIcon: (widget.svgAsset != null)?Padding(
                      padding: const EdgeInsets.all(20.0),
                      // child: Icon(Icons.add, color: Colors.red,),
                      child: SvgPicture.asset(
                        widget.svgAsset.toString(),
                        color: widget.focusNode!.hasFocus? AppColor.appPrimary: Color.fromRGBO(22, 28, 43, 0.5),
                        ),
                    ):null,
                    suffixIcon: (widget.isPassword == true)?InkWell(
                      onTap: (){
                        visible = !visible;
                        setState(() {}); 
                      },
                      child: (visible == true)?Icon(Icons.visibility_off_rounded, 
                      color: widget.focusNode!.hasFocus? AppColor.appPrimary : Color.fromRGBO(22, 28, 43, 0.5),
                      size: 20,):
                      Icon(Icons.visibility_rounded, 
                      color: widget.focusNode!.hasFocus? AppColor.appPrimary : Color.fromRGBO(22, 28, 43, 0.5),
                      size: 20,),
                    ):(widget.isDate == true)?
                    InkWell(
                      onTap: () async {
                        DateTime? pickedDate = await showDatePicker(
                            context: context,
                            initialDate: DateTime.now(), //get today's date
                            firstDate: DateTime(
                                1950), //DateTime.now() - not to allow to choose before today.
                            lastDate: DateTime(2100));  
                        widget.controller!.text = DateFormat('dd/MM/yyyy').format(pickedDate!);
                        print(widget.controller!.text);
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(13.0),
                        child: SvgPicture.asset(
                            "assets/svg/date.svg",
                            color: widget.focusNode!.hasFocus? AppColor.appPrimary: Color.fromRGBO(22, 28, 43, 0.5),
                            ),
                      ),
                    )
                      // Image.asset("assets/images/date.png")
                    :null,
                    isDense: true,
                    filled: true,
                    fillColor:widget.focusNode!.hasFocus? AppColor.appPrimary.withOpacity(0.07): Colors.white,
                    focusColor: AppColor.appPrimary,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(24),
                      borderSide: BorderSide.none
                    ),
                    enabled: true,
                  focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(width: 0.95, color: AppColor.appPrimary),
                      borderRadius: BorderRadius.circular(24),
                    ),
                  focusedErrorBorder: OutlineInputBorder(
                      borderSide: BorderSide(width: 0.95, color: AppColor.appPrimary),
                      borderRadius: BorderRadius.circular(24),
                    ),
                  ),
                  validator: widget.validator,
                ),
              ),
        ],
      ),
    );
  }
}