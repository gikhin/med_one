import 'package:flutter/material.dart';
import 'package:med_one/view/Creating%20Profile/daily_routine.dart';
import 'package:med_one/view/Creating%20Profile/profile%20for%20name.dart';
import 'package:med_one/view/Login%20Page.dart';



void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
fontFamily: 'Poppins',
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: LoginPage(),
    );
  }
}

