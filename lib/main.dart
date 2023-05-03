import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'screens/home/home.dart';

void main() async {
  await Firebase.initializeApp(
    options: const Placeholder(); // Your Firebase API Key
  runApp(const AeroCode());
}

class AeroCode extends StatelessWidget {
  const AeroCode({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'AeroCode',
      theme: ThemeData(
        fontFamily: 'Telegraf',
      ),
      home: const Home(),
    );
  }
}
