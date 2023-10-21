import 'package:courtship_to_marriage/const/colors.dart';
import 'package:courtship_to_marriage/controller/register_controller/register_controller.dart';
import 'package:courtship_to_marriage/model/register_model/register_model.dart';
import 'package:courtship_to_marriage/utils/app_routes.dart';
import 'package:courtship_to_marriage/utils/validator.dart';
import 'package:courtship_to_marriage/view/page/profile/profile_pages/terms_condition.dart';
import 'package:courtship_to_marriage/view/widget/custom_check_box.dart';
import 'package:courtship_to_marriage/view/widget/custom_elevated_button.dart';
import 'package:courtship_to_marriage/view/widget/custom_text_form_field_with_label.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final signUpFormKey = GlobalKey<FormState>();
  RxBool checkBox = false.obs;
  final storeToken = GetStorage();
  TextEditingController usernameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  late FocusNode emailFocusNode = FocusNode();
  late FocusNode passwordFocusNode = FocusNode();
  late FocusNode confirmPasswordFocusNode = FocusNode();
  late FocusNode usernameFocusNode = FocusNode();
  @override
  void initState() {
    emailFocusNode.addListener(() {
      setState(() {});
    });
    passwordFocusNode.addListener(() {
      setState(() {});
    });
    confirmPasswordFocusNode.addListener(() {
      setState(() {});
    });
    usernameFocusNode.addListener(() {
      setState(() {});
    });
    super.initState();
  }

  final RegisterController registerController =
      Get.isRegistered<RegisterController>()
          ? Get.find()
          : Get.put(RegisterController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30),
        child: Container(
          height: double.infinity,
          alignment: Alignment.bottomCenter,
          child: SingleChildScrollView(
            child: SafeArea(
              child: Form(
                key: signUpFormKey,
                child: Column(
                    // mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Lottie.asset('assets/animation/auth.json',
                          width: MediaQuery.of(context).size.width * 0.4),
                      // const SizedBox(
                      //   height: 4,
                      // ),
                      Text(
                        "Create an Account",
                        textAlign: TextAlign.center,
                        style: GoogleFonts.inter(
                            textStyle: const TextStyle(
                          fontSize: 25,
                          fontWeight: FontWeight.w700,
                        )),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      Text(
                        "Please create an account to continue.",
                        textAlign: TextAlign.center,
                        style: GoogleFonts.inter(
                            textStyle: const TextStyle(
                          fontSize: 11,
                          fontWeight: FontWeight.w500,
                        )),
                      ),
                      CustomTextFormFieldWithLabel(
                        controller: usernameController,
                        labelText: "Username",
                        hintText: "Username",
                        svgAsset: "assets/svg/username.svg",
                        focusNode: usernameFocusNode,
                        validator: (value) =>
                            Validator.validateNull("Username", value),
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
                        controller: passwordController,
                        focusNode: passwordFocusNode,
                        labelText: "Password",
                        hintText: "Password",
                        svgAsset: "assets/svg/password.svg",
                        isPassword: true,
                        validator: (value) => Validator.validatePassword(
                          'Password',
                          value,
                        ),
                      ),
                      CustomTextFormFieldWithLabel(
                        focusNode: confirmPasswordFocusNode,
                        labelText: "Confirm Password",
                        hintText: "Confirm Password",
                        svgAsset: "assets/svg/password.svg",
                        isPassword: true,
                        validator: (value) => Validator.validatePassword(
                          'Confirm Password',
                          value,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 18.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            CustomCheckBox(isCheck: checkBox),
                            Text(
                              "Remember me",
                              textAlign: TextAlign.center,
                              style: GoogleFonts.inter(
                                  textStyle: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                              )),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        width: double.infinity,
                        child: CustomElevatedButton(
                            text: "Register",
                            onPressed: () async {
                              if (signUpFormKey.currentState!.validate()) {
                                bool checkEmail = await registerController.checkEmail(context, emailController.text);
                                if(checkEmail == true){
                                  await showDialog<void>(
                                  context: context,
                                  barrierDismissible:
                                      false, // user must tap button!
                                  builder: (BuildContext context) {
                                    return AlertDialog(
                                      //
                                      backgroundColor: Colors.white,
                                      title: FutureBuilder<Register>(
                                          future: registerController.register(
                                              context,
                                              usernameController.text,
                                              emailController.text,
                                              passwordController.text),
                                          builder: (context, snapshot) {
                                            if (snapshot.connectionState ==
                                                ConnectionState.waiting) {
                                              return Container(
                                                  alignment: Alignment.center,
                                                  child:
                                                      CircularProgressIndicator(
                                                    color: AppColor.appPrimary,
                                                  ));
                                            } else {
                                              if (snapshot.hasData == true) {
                                                storeToken.write('username',
                                                    usernameController.text);
                                                Get.back();
                                              }
                                              return Container(
                                                  alignment: Alignment.center,
                                                  child:
                                                      CircularProgressIndicator(
                                                    color: AppColor.appPrimary,
                                                  ));
                                            }
                                          }),
                                    );
                                  },
                                );
                                Get.toNamed(AppRoutes.main);
                                }
                                
                              }
                            }),
                      ),
                      const SizedBox(
                        height: 14,
                      ),
                      InkWell(
                        onTap: () {
                          Get.to(TermsConditions());
                        },
                        child: Text(
                          "By registering, you agree to our terms and conditions",
                          textAlign: TextAlign.left,
                          style: GoogleFonts.inter(
                              textStyle: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                          )),
                        ),
                      ),
                      Container(
                        width: double.infinity,
                        padding: EdgeInsets.symmetric(vertical: 20),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "Already have an account?  ",
                              textAlign: TextAlign.center,
                              style: GoogleFonts.inter(
                                  textStyle: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w400,
                              )),
                            ),
                            InkWell(
                              onTap: () {
                                Get.toNamed(AppRoutes.login);
                              },
                              child: Text(
                                "Sign In",
                                textAlign: TextAlign.center,
                                style: GoogleFonts.inter(
                                    textStyle: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w600,
                                        color: AppColor.appPrimary)),
                              ),
                            ),
                          ],
                        ),
                      )
                    ]),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
