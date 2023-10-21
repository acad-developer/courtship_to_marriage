import 'dart:convert';
import 'package:appwrite/appwrite.dart';
import 'package:courtship_to_marriage/model/register_model/email_verify_model.dart';
import 'package:courtship_to_marriage/model/register_model/register_model.dart';
import 'package:courtship_to_marriage/utils/appwrite.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;

class RegisterController extends GetxController{
  Future<Register> register(
      BuildContext context, String userName, String email, String password) async {
    var response = await http.post(
        Uri.parse("https://courtshiptomarriage.com/wp-json/evans/v1/register_customer/"),
        body: {"username": userName, "email": email, "password": password},
        headers: {
          'Authorization': "Bearer f3c24268e31744dc8c650e8a8f3b7081bd9b05b6b1c8e49f778385c8c34a825e"
        });
    if (response.statusCode == 200 || response.statusCode == 409) {
      var res = response.body;
      final document = await AppWrite.databases.createDocument(
          databaseId: AppWrite.userDatabaseID,
          collectionId: AppWrite.loginCollectionID,
          documentId: ID.unique(),
          data: { "email": email}
      );
      final storeID = GetStorage();
      storeID.write('docID', document.$id);
      return Register.fromJson(
        json.decode(res),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: const Text('Information is Incorrect'),
        backgroundColor: (Colors.red[400]),
      ));
      throw Exception('Failed to load data!');
    }
  }

  Future<bool> checkCredential(BuildContext context, String email) async{
    try {
          var response = await http.get(
      Uri.parse(
          'https://api.sendbridge.com/v1/validate/yDohSMRft4wifyG0HbWJy1L1cQZR3RsB/$email'),
    );
    if(response.statusCode == 200){
      var jsonResponse = json.decode(response.body);
      EmailVerify emailCheck = EmailVerify.fromJson(jsonResponse);
      if(emailCheck.score! <= 50){
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                content: const Text('This email address is not verify.'),
                backgroundColor: (Colors.red[400]),
              ));
        return false;
      }
    }

          final documentList = await AppWrite.databases.listDocuments(
            // databaseId: '652d6c685c3cb93b433a',
            // collectionId: '652d956628971b3c4d19',
            databaseId: AppWrite.userDatabaseID,
            collectionId: AppWrite.loginCollectionID,
          );
          // return documentList.documents.map((d) => SuccessStory.fromMap(d.data)).toList();
          List checkEmail = documentList.documents.map((e) => e.data["email"]).toList();
          for(int i=0; i<checkEmail.length; i++){
            if(checkEmail[i] == email){
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                content: const Text('This email address is already logged in.'),
                backgroundColor: (Colors.red[400]),
              ));
              return false;
            }
          }
          return true;
          // print(checkEmail[0]);
        } catch (e){
          throw Exception(e);
        }
    // return true;
  }


  Future<bool> checkEmail(BuildContext context, String email) async{
    try {
       var response = await http.get(
      Uri.parse(
          'https://api.sendbridge.com/v1/validate/yDohSMRft4wifyG0HbWJy1L1cQZR3RsB/$email'),
    );
    if(response.statusCode == 200){
      var jsonResponse = json.decode(response.body);
      EmailVerify emailCheck = EmailVerify.fromJson(jsonResponse);
      if(emailCheck.score! <= 50){
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                content: const Text('This email address is not valid.'),
                backgroundColor: (Colors.red[400]),
              ));
        return false;
      }
      return true;
    }
      return false;
    } catch (e){
      throw Exception(e);
    }
  }


  // var response = await http.get(
  //     Uri.parse(
  //         'https://courtshiptomarriage.com/wp-json/evant/v1/blogs'),
  //     headers: {'Authorization': "Bearer f3c24268e31744dc8c650e8a8f3b7081bd9b05b6b1c8e49f778385c8c34a825e"},
  //   );
  //   if (response.statusCode == 200) {
  //     // print("Data");
  //     // var data = json.decode(response.body.toString());
  //     // // print(data);
  //     // print(Blog.fromJson(data));
  //     // print("Complete");
  //     // return Blog.fromJson(data);
  //     List jsonResponse = json.decode(response.body);
  //     return jsonResponse.map((data) => new Blog.fromJson(data)).toList();
  //   } else {
  //     throw Exception('Failed to load album');
  //   }
  // }

}