import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:wonroom/DB/comments/comments_model.dart';
import 'package:wonroom/DB/comments/comments_service.dart';
import 'package:wonroom/DB/likes/likes_model.dart';
import 'package:wonroom/DB/likes/likes_service.dart';
import 'package:wonroom/DB/photos/photos_model.dart';
import 'package:wonroom/DB/photos/photos_service.dart';
import 'package:wonroom/DB/posts/posts_model.dart';
import 'package:wonroom/DB/posts/posts_service.dart';
import 'package:wonroom/DB/user_plants/user_plants_model.dart';
import 'package:wonroom/DB/user_plants/user_plants_service.dart';
import 'package:wonroom/Flask/storage_manager.dart';
import 'package:wonroom/MyPlant/myPlant_functions.dart';
import 'package:wonroom/myPlantClinic.dart';
import 'package:wonroom/myPlantRegistration.dart';

class MyplantNull extends StatefulWidget {
  const MyplantNull({super.key});

  @override
  State<MyplantNull> createState() => _MyplantNullState();
}

class _MyplantNullState extends State<MyplantNull> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('다이어리', style: TextStyle(color: Colors.black)),
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios,
            color: Colors.grey,
          ),
          onPressed: () {
            // 뒤로가기 기능 (추후 구현 필요)
            // 이전 페이지로 돌아가기
            Navigator.pop(context);
          },
        ),
      ),
      body: false ? _buildScrollView() : _buildContainer(),
    );
  }

  // SingleChildScrollView를 반환합니다.
  Widget _buildScrollView() {
    return SingleChildScrollView(
      child: Column(
        children: [
          _buildEncyclopedia(),

          Container(
            color: Colors.white,
            child: Column(
              children: [
                SizedBox(height: 32),
                Column(
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Container(
                            padding: EdgeInsets.only(left: 50), // 오른쪽 여백 추가
                            child: Text(
                              '몬스테라',
                              style: TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                              ),
                              textAlign: TextAlign.center, // 텍스트 중앙 정렬
                            ),
                          ),
                        ),
                        IconButton(
                          padding: EdgeInsets.only(right: 16), // 오른쪽 여백 추가
                          icon: Icon(Icons.more_vert, color: Color(0xff787878)),
                          onPressed: () {
                            // 아이콘 클릭 시 실행될 기능 구현
                          },
                        ),
                      ],
                    ),

                    SizedBox(height: 16),

                    // 이미지
                    Container(
                      width: MediaQuery.of(context).size.width * 0.85,
                      height: MediaQuery.of(context).size.width * 0.85,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        image: DecorationImage(
                          fit: BoxFit.fill,
                          image: AssetImage('images/img01.jpg'), // 로컬 이미지 경로
                        ),
                      ),
                    ),

                    Container(
                      padding: EdgeInsets.only(left: 24, right: 24),
                      child: Column(
                        children: [
                          Container(
                            padding: const EdgeInsets.symmetric(vertical: 20),
                            decoration: BoxDecoration(
                              border: Border(
                                bottom: BorderSide(
                                  color: Color(0xffeeeeee),
                                  width: 1,
                                ),
                              ),
                            ),

                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                OutlinedButton.icon(
                                  onPressed: () {},
                                  icon: Icon(
                                    Icons.water_drop,
                                    size: 18,
                                    color: Colors.lightBlueAccent,
                                  ),
                                  label: Text(
                                    "물주기",
                                    style: TextStyle(color: Color(0xff787878)),
                                  ),
                                  style: OutlinedButton.styleFrom(
                                    side: BorderSide(color: Color(0xffc2c2c2)),
                                  ),
                                ),
                                SizedBox(width: 20),
                                RichText(
                                  text: TextSpan(
                                    text: '다음 권장 날짜 : ',
                                    style: TextStyle(
                                      color: Color(0xffc2c2c2),
                                    ),
                                    children: [
                                      TextSpan(
                                        text: "09.12",
                                        style: TextStyle(
                                          color: Color(0xff787878),
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),

                          Container(
                            padding: const EdgeInsets.symmetric(vertical: 20),
                            decoration: BoxDecoration(
                              border: Border(
                                bottom: BorderSide(
                                  color: Color(0xffeeeeee),
                                  width: 1,
                                ),
                              ),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                OutlinedButton.icon(
                                  onPressed: () {},
                                  icon: Image.asset(
                                    'images/potion.png', // 영양제 아이콘
                                    width: 18,
                                    height: 18,
                                  ),
                                  label: Text(
                                    "영양제",
                                    style: TextStyle(color: Color(0xff787878)),
                                  ),
                                  style: OutlinedButton.styleFrom(
                                    side: BorderSide(color: Color(0xffc2c2c2)),
                                  ),
                                ),
                                SizedBox(width: 20),
                                RichText(
                                  text: TextSpan(
                                    text: '다음 권장 날짜 : ',
                                    style: TextStyle(
                                      color: Color(0xffc2c2c2),
                                    ),
                                    children: [
                                      TextSpan(
                                        text: "09.12",
                                        style: TextStyle(
                                          color: Color(0xff787878),
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),

                          Container(
                            padding: const EdgeInsets.symmetric(vertical: 20),
                            decoration: BoxDecoration(
                              border: Border(
                                bottom: BorderSide(
                                  color: Color(0xffeeeeee),
                                  width: 1,
                                ),
                              ),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                OutlinedButton.icon(
                                  onPressed: () {},
                                  icon: Image.asset(
                                    'images/scissor.png', // 가지치기 아이콘
                                    width: 18,
                                    height: 18,
                                  ),
                                  label: Text(
                                    "가지치기",
                                    style: TextStyle(color: Color(0xff787878)),
                                  ),
                                  style: OutlinedButton.styleFrom(
                                    side: BorderSide(color: Color(0xffc2c2c2)),
                                  ),
                                ),
                                SizedBox(width: 20),
                                RichText(
                                  text: TextSpan(
                                    text: '마지막 활동 날짜 : ',
                                    style: TextStyle(
                                      color: Color(0xffc2c2c2),
                                    ),
                                    children: [
                                      TextSpan(
                                        text: "09.12",
                                        style: TextStyle(
                                          color: Color(0xff787878),
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),

                          Container(
                            padding: const EdgeInsets.symmetric(vertical: 20),
                            decoration: BoxDecoration(
                              border: Border(
                                bottom: BorderSide(
                                  color: Color(0xffeeeeee),
                                  width: 1,
                                ),
                              ),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                OutlinedButton.icon(
                                  onPressed: () {},
                                  icon: Image.asset(
                                    'images/soil.png', // 분갈이 아이콘
                                    width: 18,
                                    height: 18,
                                  ),
                                  label: Text(
                                    "분갈이",
                                    style: TextStyle(color: Color(0xff787878)),
                                  ),
                                  style: OutlinedButton.styleFrom(
                                    side: BorderSide(color: Color(0xffc2c2c2)),
                                  ),
                                ),
                                SizedBox(width: 20),
                                RichText(
                                  text: TextSpan(
                                    text: '마지막 활동 날짜 : ',
                                    style: TextStyle(
                                      color: Color(0xffc2c2c2),
                                    ),
                                    children: [
                                      TextSpan(
                                        text: "09.12",
                                        style: TextStyle(
                                          color: Color(0xff787878),
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),

                          Container(
                            padding: const EdgeInsets.symmetric(vertical: 20),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                OutlinedButton.icon(
                                  onPressed: () {},
                                  icon: Icon(
                                    Icons.eco,
                                    size: 18,
                                    color: Colors.lightGreen,
                                  ),
                                  label: Text(
                                    "진단",
                                    style: TextStyle(color: Color(0xff787878)),
                                  ),
                                  style: OutlinedButton.styleFrom(
                                    side: BorderSide(color: Color(0xffc2c2c2)),
                                  ),
                                ),
                                SizedBox(width: 20),
                                RichText(
                                  text: TextSpan(
                                    text: '마지막 진단 날짜 : ',
                                    style: TextStyle(
                                      color: Color(0xffc2c2c2),
                                    ),
                                    children: [
                                      TextSpan(
                                        text: "09.12",
                                        style: TextStyle(
                                          color: Color(0xff787878),
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),

                        ],
                      ),
                    ),


                  ],
                ),

                // 구분
                Container(
                  margin: EdgeInsets.only(top: 40, bottom: 24),
                  width: MediaQuery.of(context).size.width,
                  height: 8,
                  color: Color(0xffeeeeee),
                ),

                // 기록
                Container(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        padding: EdgeInsets.only(bottom: 12, left: 10),
                        child: Text(
                          '이전 기록',
                          style: TextStyle(
                            fontSize: 21,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),

                      SizedBox(height: 12),

                      // 물주기 기록
                      Center(
                        child: Container(
                          width: MediaQuery.of(context).size.width,
                          padding: EdgeInsets.all(30),
                          decoration: BoxDecoration(
                              color : Color(0xfffafafa),
                              borderRadius: BorderRadius.circular(10)
                          ),
                          child: Column(
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(
                                    Icons.water_drop,
                                    size: 32,
                                    color: Colors.lightBlueAccent,
                                  ),
                                  SizedBox(width: 4),
                                  Text(
                                    '물주기 기록',
                                    style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: 20),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  buildTimelineItem("03.19", true),
                                  buildTimelineItem("04.19", true),
                                  buildTimelineItem("05.19", true),
                                  buildTimelineItem("06.19", true),
                                  buildTimelineItem(" ", false),
                                ],
                              )
                            ],
                          ),
                        ),
                      ),

                      SizedBox(height: 24),

                      // 영양제 기록
                      Center(
                        child: Container(
                          width: MediaQuery.of(context).size.width,
                          padding: EdgeInsets.all(30),
                          decoration: BoxDecoration(
                              color : Color(0xfffafafa),
                              borderRadius: BorderRadius.circular(10)
                          ),
                          child: Column(
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Image.asset(
                                    'images/potion.png', // 영양제 아이콘
                                    width: 32,
                                    height: 32,
                                  ),
                                  SizedBox(width: 4),
                                  Text(
                                    '영양제 기록',
                                    style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: 20),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  buildTimelineItem("03.19", true),
                                  buildTimelineItem("04.19", true),
                                  buildTimelineItem(" ", false),
                                  buildTimelineItem(" ", false),
                                  buildTimelineItem(" ", false),
                                ],
                              )
                            ],
                          ),
                        ),
                      ),
                      SizedBox(height: 24),

                      // 가지치기 기록
                      Center(
                        child: Container(
                          width: MediaQuery.of(context).size.width,
                          padding: EdgeInsets.all(30),
                          decoration: BoxDecoration(
                              color : Color(0xfffafafa),
                              borderRadius: BorderRadius.circular(10)
                          ),
                          child: Column(
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Image.asset(
                                    'images/scissor.png', // 가지치기 아이콘
                                    width: 32,
                                    height: 32,
                                  ),
                                  SizedBox(width: 4),
                                  Text(
                                    '가지치기 기록',
                                    style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: 20),
                              Container(
                                child: Column(
                                  children: [
                                    Text('기록이 없습니다. \n 기록을 추가해보세요.',
                                      textAlign: TextAlign.center,
                                      style: TextStyle(color: Color(0xff787878)),),
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                      SizedBox(height: 24),

                      // 분갈이 기록
                      Center(
                        child: Container(
                          width: MediaQuery.of(context).size.width,
                          padding: EdgeInsets.all(30),
                          decoration: BoxDecoration(
                              color : Color(0xfffafafa),
                              borderRadius: BorderRadius.circular(10)
                          ),
                          child: Column(
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Image.asset(
                                    'images/soil.png', // 분갈이 아이콘
                                    width: 32,
                                    height: 32,
                                  ),
                                  SizedBox(width: 4),
                                  Text(
                                    '분갈이 기록',
                                    style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: 20),
                              Container(
                                child: Column(
                                  children: [
                                    Text('기록이 없습니다. \n 기록을 추가해보세요.',
                                      textAlign: TextAlign.center,
                                      style: TextStyle(color: Color(0xff787878)),),
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                      ),

                    ],
                  ),
                ),

                // 구분
                Container(
                  margin: EdgeInsets.only(top: 40, bottom: 24),
                  width: MediaQuery.of(context).size.width,
                  height: 8,
                  color: Color(0xffeeeeee),
                ),

                // 진단
                Container(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        padding: EdgeInsets.only(left: 10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              '진단 기록',
                              style: TextStyle(
                                fontSize: 21,
                                fontWeight: FontWeight.bold,
                              ),
                            ),

                            TextButton(onPressed: (){
                              Navigator.push(context,
                                MaterialPageRoute(builder: (_)=>MyPlantClinic()),
                              );
                            },
                              child: Row(
                                children: [
                                  Text(
                                    '자세히 보기 ',
                                    style: TextStyle(
                                      color: Color(0xff787878),
                                    ),
                                  ),
                                  Icon(Icons.arrow_forward_ios,
                                    size: 12,
                                  )
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),

                      SizedBox(height: 12),

                      // 진단 기록
                      Center(
                        child: Container(
                          width: MediaQuery.of(context).size.width,
                          padding: EdgeInsets.all(30),
                          decoration: BoxDecoration(
                              color : Color(0xfffafafa),
                              borderRadius: BorderRadius.circular(10)
                          ),
                          child: Column(
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(
                                    Icons.eco,
                                    size: 32,
                                    color: Colors.lightGreen,
                                  ),
                                  SizedBox(width: 4),
                                  Text(
                                    '건강 기록',
                                    style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: 20),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  buildTimelineItem("03.19 \n 정상", true),
                                  buildTimelineItem("04.19 \n 질병", true),
                                  buildTimelineItem("05.19 \n 해충", true),
                                  buildTimelineItem("06.19 \n 정상", true),
                                  buildTimelineItem(" \n ", false),
                                ],
                              )
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                SizedBox(height: 100,),

                Padding(
                    padding: const EdgeInsets.all(16),
                    // 버튼
                    child: ElevatedButton(onPressed: (){

                    },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Color(0xff595959),
                        elevation: 0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        minimumSize: const Size.fromHeight(50),
                      ),
                      child: const Text('해당 식물 정보 알아보기',
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.white,
                        ),
                      ),
                    )
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // Container를 반환합니다.
  Widget _buildContainer() {
    return Container(
      color: Colors.white,
      child: Column(
        children: [
          // 도감
          _buildEncyclopedia(),

          // 안내 메시지
          Expanded(
            child: Center(
              child: Column(
                // mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(height: 250,),
                  ImageIcon(AssetImage('images/info.png'),
                    size: 50,
                    color: Color(0xffc2c2c2),
                  ),
                  SizedBox(height: 10,),
                  Text(
                    '알림 내역이 없습니다. \n곧 좋은 소식 정보 알려드릴게요!',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Color(0xff787878),
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
            ),
          ),

          // 하단 버튼
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(24),
            child: ElevatedButton(
              onPressed: () {
                // 도감 등록하기 버튼 클릭 시 실행될 코드
                print("도감 등록하기 버튼 클릭 시 실행될 코드");
                print("도감 등록하기 버튼 클릭 시 실행될 코드");
                print("도감 등록하기 버튼 클릭 시 실행될 코드");
                print("도감 등록하기 버튼 클릭 시 실행될 코드");
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Color(0xff6bbe45),
                elevation: 0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                minimumSize: const Size.fromHeight(50),
              ),
              child: const Text(
                '다이어리 등록하기',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildEncyclopedia()
  {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      color: Color(0xffeeeeee),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: menuButton(4),

          ),

          // 도감 추가
          ElevatedButton(
            onPressed: () async{
              // 버튼 클릭 시 실행될 코드
              print("+버튼");

              // showPlantRegistrationModal(context);
              // String? userId = await getUserId();

              // LikeService likeService = new LikeService();
              // Like like = new Like(userId: "tested", postId: 111, createdAt: DateTime.now());
              //
              // // likeService.addLike(like);
              // likeService.getLikes(3);
              PhotoService photoService = new PhotoService();
              Photo photo = new Photo(photoId: 2, postId: 11, category: 1, isPrimary: false, fileName: "스플래시32.png", serverPath: "미정2", fileType: "png", createdAt: DateTime.now());

              // photoService.addPhoto(photo);
              photoService.deletePhoto(2);

              print("+버튼의 종료");


            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Color(0xff86b26a), // 배경 색상
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(50), // 모서리를 둥글게
              ),
              padding: EdgeInsets.all(0), // 패딩 없앰
              minimumSize: Size(36, 36), // 버튼의 최소 크기
            ),
            child: Icon(
              Icons.add,
              color: Colors.white,
            ),
          )
        ],
      ),
    );
  }

}



Widget buildTimelineItem(String date, bool isActive) {
  return Column(
    children: [
      Container(
        width: 16,
        height: 16,
        decoration: BoxDecoration(
          color: isActive ? Colors.grey : Colors.transparent,
          shape: BoxShape.circle,
          border: Border.all(
            color: Colors.grey,
            width: 2.0,
          ),
        ),
      ),
      SizedBox(height: 5),
      Text(
        date,
        style: TextStyle(
          color: Colors.grey,
          fontSize: 14,
        ),
      ),
    ],
  );
}

// 보존된 리스트
// children: [
//   Container(
//     margin: EdgeInsets.only(right: 10),
//     child: ElevatedButton(
//       style: ElevatedButton.styleFrom(
//         backgroundColor: Color(0xff595959), // 배경 색상
//         padding: EdgeInsets.symmetric(vertical: 8, horizontal: 20), // 내부 여백
//         shape: RoundedRectangleBorder( // 테두리 모양
//           borderRadius: BorderRadius.circular(20),
//         ),
//       ),
//       onPressed: () {
//         // 버튼 클릭 시 실행될 코드
//         print("도감1");
//         print("도감1");
//         print("도감1");
//         print("도감1");
//       },
//       child: Text(
//         '도감1',
//         style: TextStyle(color: Colors.white), // 텍스트 스타일
//       ),
//     ),
//   ),
// ],

