import 'package:courtship_to_marriage/const/colors.dart';
import 'package:courtship_to_marriage/utils/validator.dart';
import 'package:courtship_to_marriage/view/widget/custom_app_bar.dart';
import 'package:courtship_to_marriage/view/widget/custom_elevated_button.dart';
import 'package:courtship_to_marriage/view/widget/custom_text_form_field_with_label.dart';
import 'package:flutter/material.dart';
import 'package:flutter_email_sender/flutter_email_sender.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';

class HelpCenter extends StatefulWidget {
  const HelpCenter({super.key});

  @override
  State<HelpCenter> createState() => _HelpCenterState();
}

class _HelpCenterState extends State<HelpCenter> {
  final helpFormKey = GlobalKey<FormState>();
  TextEditingController fullnameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController messageController = TextEditingController();

  late FocusNode fullnameFocusNode = FocusNode();
  late FocusNode emailFocusNode = FocusNode();
  late FocusNode messageFocusNode = FocusNode();

  @override
  void initState() {
    // TODO: implement initState
    fullnameFocusNode.addListener(() {
      setState(() {});
    });
    emailFocusNode.addListener(() {
      setState(() {});
    });
    messageFocusNode.addListener(() {
      setState(() {});
    });
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: CustomAppBar(title: "Help & Support",),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 30),
            child: Form(
              key: helpFormKey,
              child: Column(
                children: [
                  Lottie.asset('assets/animation/help.json',
                          width: MediaQuery.of(context).size.width * 0.5),
                  CustomTextFormFieldWithLabel(
                          controller: fullnameController,
                          labelText: "Full Name",
                          hintText: "Full Name",
                          svgAsset: "assets/svg/username.svg",
                          focusNode: fullnameFocusNode,
                          validator: (value) =>
                              Validator.validateNull("Full Name", value),
                        ),
                  CustomTextFormFieldWithLabel(
                        controller: emailController,
                        labelText: "Email",
                        hintText: "Email",
                        svgAsset: "assets/svg/email.svg",
                        focusNode: emailFocusNode,
                        validator: (value) => Validator.validateEmail(
                          value,
                        ),
                      ),
                  CustomTextFormFieldWithLabel(
                          controller: messageController,
                          labelText: "Comment or Message",
                          hintText: "Comment or Message",
                          // svgAsset: "assets/svg/username.svg",
                          focusNode: messageFocusNode,
                          maxLines: 5,
                          validator: (value) =>
                              Validator.validateNull("Comment or Message", value),
                        ),
                  Container(
                        width: double.infinity,
                        margin: EdgeInsets.only(top: 20),
                        child: CustomElevatedButton(
                            text: "Submit",
                            onPressed: () async {
                              // if(helpFormKey.currentState!.validate()){
                                final Email email = Email(
                                  body: 'Email body',
                                  subject: 'Email subject',
                                  recipients: ['contact@evansfrancis.org'],
                                  // cc: ['cc@example.com'],
                                  // bcc: ['bcc@example.com'],
                                  // attachmentPaths: ['/path/to/attachment.zip'],
                                  isHTML: false,
                                );

                                await FlutterEmailSender.send(email);
                              // }
                            }),
                      ),
                  Container(
                          width: MediaQuery.of(context).size.width * 0.9,
                          alignment: Alignment.center,
                          margin: EdgeInsets.only(top: 30),
                          decoration: BoxDecoration(
                              // color: AppColor.subText.withOpacity(0.05),
                              border: Border.all(color: AppColor.appPrimary, width: 1),
                              // color: Colors.red,
                              borderRadius: BorderRadius.circular(8)),
                          padding: EdgeInsets.symmetric(horizontal: 18, vertical: 12),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                width: double.infinity,
                                child: Text(
                                      "You can find us at",
                                      textAlign: TextAlign.center,
                                      overflow: TextOverflow.ellipsis,
                                      style: GoogleFonts.inter(
                                          textStyle: TextStyle(
                                              fontSize: 18,
                                              fontWeight: FontWeight.w700,
                                              color: AppColor.titleText)),
                                    ),
                              ),
                                const SizedBox(height: 10,),
                                richText(context, "Email: ", "contact@evansfrancis.org"),
                                const SizedBox(height: 10,),
                                richText(context, "Phone number: ", "+91-9960877313"),
                                const SizedBox(height: 10,),
                                richText(context, "Location: ", "Nagpur, 440026, Maharashtra, India"),
                            ],
                          )
                          ),
                    const SizedBox(height: 100,),
                ],
              ),
            ),
          ),
        )),
    );
  }

  Widget richText(BuildContext context, String title, String text){
    return RichText(text: TextSpan(
                                    children: <TextSpan>[
                                      TextSpan(
                                          text: title, 
                                          style: GoogleFonts.inter(
                                              textStyle: TextStyle(
                                                fontSize: 15,
                                                fontWeight: FontWeight.w600,
                                                color: AppColor.titleText
                                              )
                                            ),),
                                      TextSpan(
                                          text: text, 
                                          style: GoogleFonts.inter(
                                              textStyle: TextStyle(
                                                fontSize: 15,
                                                fontWeight: FontWeight.w600,
                                                color: AppColor.subText,
                                              )
                                            ),),
                                    ],
                                  ),
                                );
  }
}