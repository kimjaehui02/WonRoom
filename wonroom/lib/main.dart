import 'package:flutter/material.dart';
import 'package:wonroom/Finding_Pw_Temporarily.dart';
import 'package:wonroom/index.dart';
import 'package:wonroom/intro.dart';
import 'package:wonroom/join.dart';
import 'package:wonroom/login.dart';
import 'package:wonroom/myPlant.dart';
import 'package:wonroom/myPlantNull.dart';

void main() {
  runApp(const MyApp());
}
// 주석
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
    home: Index(),
    );
  }
}

