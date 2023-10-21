import 'package:appwrite/appwrite.dart';
import 'package:courtship_to_marriage/utils/routes.dart';
import 'package:courtship_to_marriage/view/page/splash/splash.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

Client client = Client();

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  client
    .setEndpoint('https://cloud.appwrite.io/v1')
    .setProject('652d16db69cab7ed16d5')
    .setSelfSigned(status: true);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'CourtShip to Marriage',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      debugShowCheckedModeBanner: false,
      home: const SplashScreen(),
      getPages: routes(),
    );
  }
}
