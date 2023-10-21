import 'dart:convert';

import 'package:courtship_to_marriage/model/get_course_model/get_course_model.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class GetCourseController extends GetxController {
  Future<GetCourse> getCourse() async {
    var response = await http.get(
      Uri.parse(
          'https://courtshiptomarriage.com/wp-json/custom/v1/get_courses/'),
      headers: {'Authorization': "Bearer f3c24268e31744dc8c650e8a8f3b7081bd9b05b6b1c8e49f778385c8c34a825e"},
    );

    if (response.statusCode == 200) {
      try {
        var data = json.decode(response.body);
        return GetCourse.fromJson(data as Map<String, dynamic>);
      } catch (e){
        throw Exception(e);
      }
    } else {
      throw Exception('Failed to load album');
    }
  }
}