import 'package:courtship_to_marriage/const/colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class QuizWidget extends StatefulWidget {
  const QuizWidget({super.key});

  @override
  State<QuizWidget> createState() => _QuizWidgetState();
}

class _QuizWidgetState extends State<QuizWidget> {
  var score=0;
  var n=0;
  var start = false;
  var complete = false;
  List que_list=[
    Questions("1.  Does it seem that all the \"good men\" and \"good women\" are taken?", "क्या आपको ऐसा लगता है कि सभी \"अच्छे पुरुष\" और \"अच्छी महिलाएँ\" पहले से ही किसी के साथ रिश्ते में हैं?", true),
    Questions("2.  Are you frustrated going to Church, meetings, marriages, gym or just about everywhere else hoping to connect with Mr or Mrs Right?", "क्या आप किसी सही व्यक्ति के साथ जुड़ने की उम्मीद में चर्च, संगति, विवाह समारोह, जिम या हर जगह जाते हैं?", true),
    Questions("3.  Are you about to settle for any Mr X or Mrs Y because you cannot find them in your town?", "क्या आप किसी भी श्री या श्रीमती के साथ विवाह के लिए तैयार होने वाले हैं, क्योंकि वे लोग आपको अपने शहर में नहीं मिल सकते?", true),
    Questions("4.  Are you continually disappointed with men and women because they don't measure up to your father or mother?", "क्या आप लगातार पुरुषों और महिलाओं से निराश हैं क्योंकि वे आपके पिता या माता के बराबर नहीं हैं?", true),
    Questions("5.  Are you still going to the same place doing the same thing with the same people and never meeting the man or woman you are looking for?", "क्या आप अभी भी उसी स्थान पर जा रहे हैं और उन्हीं लोगों के साथ वही काम करते जा रहे हैं, और उस पुरुष या महिला से कभी नहीं मिल पा रहे हैं जिसे आप ढूँढ़ रहे हैं?", true),
    Questions("6.  Are you waiting for God to mysteriously deliver your future husband or wife to you without you having to do anything?", "क्या आप इस विषय के लिए परमेश्वर पर निर्भर हैं कि वह आपके होने वाले पति या पत्नी को आपके बिना कुछ भी किए रहस्यमय तरीके से आपके पास पहुँचाएँ?", true),
    Questions("7.  Do you think living with someone before marriage is a practical way to prepare for a strong marriage?", "क्या आपको लगता है कि शादी से पहले किसी के साथ रहना एक मजबूत शादी की तैयारी का एक व्यावहारिक तरीका है?", true),
    Questions("8.  Do you think that your real life will finally begin once you are married?", "क्या आप ऐसा सोचते हैं कि विवाह के बाद ही आपका असल जीवन आरम्भ होगा?", true),
    Questions("9.  Do you believe that he or she is \"the one\" every time you date or court someone?", "हर बार जब आप किसी को डेट या कोर्ट करते हैं तो क्या आपको हमेशा लगता है कि वह व्यक्ति आपका भावी पति या पत्नी है?", true),
    Questions("10.  Do you find yourself in an abusive relationship but always believe this one will be different?", "क्या आप अपने आप को हमेशा एक अपमानजनक रिश्ते में पाते हैं परन्तु हमेशा मानते हैं कि यह रिश्ता अलग होगा?", true),
  ];

  void checkAnswer(bool choice,BuildContext ctx){
    setState(() {
      if(n<que_list.length-1)
        {
          n=n+1;
        }
      else{
        start = false;
        complete = true;
      }
    });
  }

  void reset(){
    setState(() {
      n=0;
      score=0;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            // height: 100,
            margin: const EdgeInsets.all(10.0),
            padding: EdgeInsets.symmetric(vertical: 20,horizontal: 15),
            width: double.infinity,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15.0),
              border: Border.all(color: AppColor.appPrimary, width: 2),
            ),
            child: (start == true)?Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Text(
                                que_list[n].que.toString(),
                                textAlign: TextAlign.left,
                                style: GoogleFonts.inter(
                                    textStyle: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w700,
                                        color: AppColor.titleText)),
                              ),
                const SizedBox(height: 10,),
                Text(
                                que_list[n].quehindi.toString(),
                                textAlign: TextAlign.left,
                                style: GoogleFonts.inter(
                                    textStyle: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w400,
                                        color: AppColor.titleText)),
                              ),
                const SizedBox(height: 25,),
                // Progress(),
                Text(
                                "${n+1} out of 10",
                                textAlign: TextAlign.left,
                                style: GoogleFonts.inter(
                                    textStyle: TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.w500,
                                        color: AppColor.subText.withOpacity(0.6))),
                              ),
              const SizedBox(height: 10,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    checkQuiz(context, "Yes", () => checkAnswer(true,context)),
                    checkQuiz(context, "No", () => checkAnswer(false,context)),
                  ],
                ),
              ],
            )
            :(complete == true)?Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                                "Thanks for submitting your response!",
                                textAlign: TextAlign.center,
                                style: GoogleFonts.inter(
                                    textStyle: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.w700,
                                        color: AppColor.titleText)),
                              ),
                const SizedBox(height: 10,),
                Text(
                                "If you've answered any of these questions with \"Yes,\" then I urge you to take this course and begin taking steps toward the relationship you've always hoped for.",
                                textAlign: TextAlign.center,
                                style: GoogleFonts.inter(
                                    textStyle: TextStyle(
                                        fontSize: 15,
                                        fontWeight: FontWeight.w500,
                                        color: AppColor.titleText)),
                              ),
                const SizedBox(height: 20,),
                quizButton(context, "Retake", (){
                  setState(() {
                    score=0;
                    n=0;
                    start = false;
                    complete = false;
                  });
                })
              ],
            )
            :Column(
              children: [
                Text(
                                "10 simple questions to know whether this course is for you.",
                                textAlign: TextAlign.left,
                                style: GoogleFonts.inter(
                                    textStyle: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.w700,
                                        color: AppColor.titleText)),
                              ),
                const SizedBox(height: 10,),
                Text(
                                "यह कोर्स आपके लिए है या नहीं यह जानने के लिए 10 सरल प्रश्नों के उत्तर दें।",
                                textAlign: TextAlign.left,
                                style: GoogleFonts.inter(
                                    textStyle: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.w400,
                                        color: AppColor.titleText)),
                              ),
                const SizedBox(height: 25,),
                Text(
                                "Click the button below to start.",
                                textAlign: TextAlign.center,
                                style: GoogleFonts.inter(
                                    textStyle: TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.w400,
                                        color: AppColor.subText.withOpacity(0.6))),
                              ),
                const SizedBox(height: 10,),
                quizButton(context, "Start", (){
                    start = true;
                    setState(() {});
                  }),
                
              ],
            ),
          ),
        ],
      );
  }


  Widget quizButton(BuildContext context, String text, Function()? onTap){
    return InkWell(
      onTap: onTap,
      child: Container(
                      width: 75,
                                padding: EdgeInsets.symmetric(vertical: 8),
                                decoration: BoxDecoration(
                                  color: AppColor.subText.withOpacity(0.075),
                                  border: Border.all(color: AppColor.appPrimary),
                                  borderRadius: BorderRadius.circular(10)
                                ),
                      child: Text(
                                                  text,
                                                  textAlign: TextAlign.center,
                                                  style: GoogleFonts.inter(
                                                      textStyle: TextStyle(
                                                          fontSize: 16,
                                                          fontWeight: FontWeight.w700,
                                                          color: AppColor.titleText.withOpacity(0.75))),
                                                ),
                    ),
    );
  }

  Widget checkQuiz(BuildContext context, String ans, Function()? onTap){
    return InkWell(
      onTap: onTap,
      child: Container(
                            width: 75,
                            padding: EdgeInsets.symmetric(vertical: 5),
                            decoration: BoxDecoration(
                              color: AppColor.subText.withOpacity(0.075),
                              border: Border.all(color: AppColor.appPrimary),
                              borderRadius: BorderRadius.circular(10)
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon((ans == "Yes")?CupertinoIcons.checkmark_alt:CupertinoIcons.clear_thick, color: AppColor.appPrimary, size: (ans == "Yes")?18:14,),
                                const SizedBox(width: 4,),
                                Text(
                                              ans,
                                              textAlign: TextAlign.center,
                                              style: GoogleFonts.inter(
                                                  textStyle: TextStyle(
                                                      fontSize: 14,
                                                      fontWeight: FontWeight.w700,
                                                      color: AppColor.titleText.withOpacity(0.75))),
                                            ),
                              ],
                            ),
                          ),
    );
  }
}


class Questions{
  String que;
  String quehindi;
  bool ans;
  Questions(this.que, this.quehindi, this.ans);
}