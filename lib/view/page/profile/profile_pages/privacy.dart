import 'package:courtship_to_marriage/const/colors.dart';
import 'package:courtship_to_marriage/view/widget/custom_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class PrivacyPolicy extends StatelessWidget {
  const PrivacyPolicy({super.key});

  static List<Map<String, dynamic>> list = [
    {"title" : "1        KEY TERMS", "text" : "In this Privacy Policy, (i) capitalised terms defined by inclusion in quotations and/or parenthesis have the meanings so ascribed; and (ii) the following terms have the meanings assigned to them herein below. Terms not defined in this Privacy Policy shall have the same meaning as assigned in the Terms and Conditions published on the Website.\n\n1.1       “Consent” means any freely given, specific, informed, and unambiguous indication of the Data Subject’s wishes by which they, by a statement or by a clear affirmative action, signify agreement to the Processing of Personal Data relating to them;\n\n1.2       “Data Subject”, “you” and “your” collectively mean any identified or identifiable natural person, including Users, whose Personal Data is Processed by us. An identifiable natural person is one who can be identified, directly or indirectly, in particular by reference to an identifier such as a name, an identification number, location data, an online identifier or to one or more factors specific to the physical, physiological, genetic, mental, economic, cultural, or social identity of that natural person; \n\n1.3       “Personal Data” means any information relating to a Data Subject; and\n\n1.4       “Processing” means any operation or set of operations which is performed on Personal Data or on sets of Personal Data, whether or not by automated means, such as collection, recording, organization, structuring, storage, adaptation or alteration, retrieval, consultation, use, disclosure by transmission, dissemination or otherwise making available, alignment or combination, restriction, erasure, or destruction."},
    {"title" : "2        INFORMATION WE COLLECT", "text" : "2.1       Log Data: When you visit the Website, our servers may automatically log the standard data provided by your web browser. It may include but not limited to, your computer’s internet protocol (IP) address, your browser type and version, the pages you visit, the time and date of your visit, the time spent on each page, and such other details.\n\n2.2       Device Data: We may collect data about the device you use to access the Website. This data may include but not limited to, the device type, operating system, unique device identifiers, device settings, and geo-location data. What we collect can depend on the individual settings of your device and software. We recommend checking the policies of your device manufacturer or software provider to learn what information they make available to us.\n\n2.3       Personal Data: We may ask for Personal Data, including but not limited to name, e – mail ID, social media profiles, phone/mobile number, home/mailing address."},
    {"title" : "3        USE AND DISCLOSURE OF INFORMATION", "text" : "3.1       Except as otherwise stated below, we do not sell, trade, or rent your Personal Data collected on the Website to others. We may collect, hold, use, and disclose your Personal Data for the following purposes but it will not be further processed in a manner that is incompatible with these purposes:\n\na)    to contact or communicate with you;\n\nb)    to run offers and other additional benefits for you or to notify you of our services or special offers that may be of interest to you;\n\nc)    for advertising and marketing, including but not limited to sending you promotional information about our services;\n\nd)    to enable you to access and use our Website;\n\ne)    to enable us to customize or personalize your experience on our Website;\n\nf)     for analytics, market research and business development, including to operate and improve our Website;\n\ng)    for statistical purposes to improve our Website;\n\nh)    for internal record keeping and administrative purposes; or\n\ni)     to comply with our legal obligations and to resolve any disputes that we may have.\n\n3.2       All credit/debit cards’ details and Personal Data relating to transactions made for placing an order will be shared with and stored by our third-party payment processor. We recommend checking the policies of our payment processors to understand the manner in which your Personal Data will be managed by these payment processors."},
    {"title" : "4        THIRD-PARTY LINKS", "text" : "4.1       Once you leave our Website or are redirected to a third-party website or application, you are no longer governed by this Privacy Policy or our Terms and Conditions.\n\n4.2       When you click on links on our Website, they may direct you away from our Website. We are not responsible for the privacy practices of other sites and encourage you to read their privacy statements before availing the services offered by them. You shall be solely responsible for your activities outside our Website."},
    {"title" : "5        ELIGIBILITY", "text" : "By booking a Service on the Website, you represent that you are at least eighteen (18) years of age or the legal age in your jurisdiction of residence and are legally capable of booking a Service and using the debit/credit card or other relevant payment details you submit. You must retain a copy of transaction records (usually sent by email) and merchant policies and rules."},
    {"title" : "6        CONSENT", "text" : "6.1       When you provide us with your Personal Data to, complete a transaction, verify your debit/credit card or any other mode of payment used by you, book a Service, or cancel a confirmed booking, we imply that that you Consent to our collecting it, and using is for that specific reason only.\n\n6.2       If we ask for your Personal Data for a secondary reason, like marketing, we will either ask you directly for your expressed Consent, or provide you with an opportunity to say no.\n\n6.3       Each User shall have the right to withdraw their Consent to the Processing of their Personal Data at any time. If you wish to exercise the right to withdraw your Consent, you may at any time directly contact us at +91-9960877313."},
    {"title" : "7        CONTACT US", "text" : "If you have any queries regarding this Privacy Policy, feel free to contact us at +91-9960877313."},
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: CustomAppBar(title: "Privacy & Policy",),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                    "We are delighted that you have shown interest in the services of https://www.courtshiptomarriage.com/ (the “Website”, “we”, “us”, or “our”). This Privacy Policy (this “Privacy Policy”) applies only to activities we engage in on the Website.\n\nYour privacy is important to us, and we respect your privacy regarding any personal data we collect when you access or use the Website and engage in transactions thereafter. We treat your personal data as confidential and in accordance with the statutory data protection regulations and this Privacy Policy.\n\nYou hereby acknowledge and admit that you have read, understood, and accepted to be bound by this Privacy Policy, as may be modified by us from time to time. Any amendments or variations thereto shall take effect from their date of publication on the Website.\n\nThis Privacy Policy forms a part of our Terms and Conditions published on the Website. You agree to be bound by this Privacy Policy when you accept our Terms and Conditions.",
                    textAlign: TextAlign.left,
                    style: GoogleFonts.inter(
                        textStyle: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                            color: AppColor.titleText)),
                  ),
                  for(int i = 0; i<list.length; i++)...[
                    const SizedBox(height: 12,),
                    Text(
                    list[i]["title"],
                    textAlign: TextAlign.left,
                    style: GoogleFonts.inter(
                        textStyle: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w700,
                            color: AppColor.titleText)),
                  ),
                  const SizedBox(height: 12,),
                  Text(
                    list[i]["text"],
                    textAlign: TextAlign.left,
                    style: GoogleFonts.inter(
                        textStyle: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                            color: AppColor.titleText)),
                  ),
                  ],
                  Text(
                    "\n\n\n\nYou acknowledge that you have read, understood, and accepted to be bound by this Privacy Policy.\n\nEffective as of 7 October 2023.",
                    textAlign: TextAlign.left,
                    style: GoogleFonts.inter(
                        textStyle: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                            color: AppColor.titleText)),
                  ),
                  const SizedBox(height: 24,),
              ],
            ),
          ),
        )),
    );
  }
}