import 'dart:convert';

import 'package:courtship_to_marriage/model/blog_model/blog_model.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class BlogController extends GetxController {

  Future<List<Blog>> getBlogContent() async {
    var response = await http.get(
      Uri.parse(
          'https://courtshiptomarriage.com/wp-json/evant/v1/blogs'),
      headers: {'Authorization': "Bearer f3c24268e31744dc8c650e8a8f3b7081bd9b05b6b1c8e49f778385c8c34a825e"},
    );
    if (response.statusCode == 200) {
      // print("Data");
      // var data = json.decode(response.body.toString());
      // // print(data);
      // print(Blog.fromJson(data));
      // print("Complete");
      // return Blog.fromJson(data);
      List jsonResponse = json.decode(response.body);
      return jsonResponse.map((data) => new Blog.fromJson(data)).toList();
    } else {
      throw Exception('Failed to load album');
    }
  }
}