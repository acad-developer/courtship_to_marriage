import 'package:courtship_to_marriage/const/colors.dart';
import 'package:courtship_to_marriage/controller/blog_controller/blog_controller.dart';
import 'package:courtship_to_marriage/model/blog_model/blog_model.dart';
import 'package:courtship_to_marriage/view/page/blog/widget/blog_widget.dart';
import 'package:courtship_to_marriage/view/widget/custom_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BlogScreen extends StatefulWidget {
  const BlogScreen({super.key});

  @override
  State<BlogScreen> createState() => _BlogScreenState();
}

class _BlogScreenState extends State<BlogScreen> {
  final BlogController blogController = Get.isRegistered<BlogController>()
      ? Get.find()
      : Get.put(BlogController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: "Latest Blogs",),
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: FutureBuilder<List<Blog>>(
                  future: blogController.getBlogContent(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Center(
                          child: CircularProgressIndicator(
                        color: AppColor.appPrimary,
                      ));
                    } else {
                      // print(snapshot.data!.thumbnail);
                      if (snapshot.hasData == true) {
                        return GridView.builder(
                            itemCount: snapshot.data!.length,
                            gridDelegate:
                                SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 2,
                                    crossAxisSpacing: 0,
                                    mainAxisExtent: 360,
                                    mainAxisSpacing: 20),
                            itemBuilder: (context, index) {
                              return BlogWidget(data: snapshot.data![index]);
                            });
                      }
                      return Center(
                          child: CircularProgressIndicator(
                        color: AppColor.appPrimary,
                      ));
                    }
                  }),
            ),
          ],
        ),
      )),
    );
  }
}
