import 'package:flutter/material.dart';
import 'package:wonroom/CreatePost.dart';
import 'package:wonroom/Finding_Pw.dart';
import 'package:wonroom/Finding_Pw_Temporarily.dart';
import 'package:wonroom/InquriryDetailsNull.dart';
import 'package:wonroom/MyCommunityManage.dart';
import 'package:wonroom/PlantDetailPage.dart';
import 'package:wonroom/community.dart';
import 'package:wonroom/customerService.dart';
import 'package:wonroom/index.dart';
import 'package:wonroom/inqurityDetails.dart';
import 'package:wonroom/intro.dart';
import 'package:wonroom/intro.dart';
import 'package:wonroom/join.dart';
import 'package:wonroom/login.dart';
import 'package:wonroom/myComments.dart';
import 'package:wonroom/myCommentsNull.dart';
import 'package:wonroom/myPage.dart';
import 'package:wonroom/myPlant.dart';
import 'package:wonroom/myPlantClinic.dart';
import 'package:wonroom/myPlantNull.dart';
import 'package:wonroom/myPost.dart';
import 'package:wonroom/myPostNull.dart';
import 'package:wonroom/notificationPage.dart';
import 'package:wonroom/notificationNulll.dart';
import 'package:wonroom/plantClinicChat.dart';
import 'package:wonroom/plantDictionary.dart';
import 'package:wonroom/PostDetailPage.dart';
import 'package:wonroom/pwChange.dart';
import 'package:wonroom/search.dart';
import 'package:wonroom/splash.dart';
import 'package:wonroom/writePage.dart';


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
    theme: ThemeData(
      fontFamily: 'Pretendard',
      scaffoldBackgroundColor: Colors.white,
      primaryColor : Colors.white,
      appBarTheme: AppBarTheme(
        backgroundColor: Colors.white, // 앱바 배경색
      ),
    ),
      home: PlantClinicChat(),
    );
  }
}

