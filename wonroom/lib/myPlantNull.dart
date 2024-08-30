import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:wonroom/DB/chat_messages/chat_messages_model.dart';
import 'package:wonroom/DB/chat_messages/chat_messages_service.dart';
import 'package:wonroom/DB/comments/comments_model.dart';
import 'package:wonroom/DB/comments/comments_service.dart';
import 'package:wonroom/DB/likes/likes_model.dart';
import 'package:wonroom/DB/likes/likes_service.dart';
import 'package:wonroom/DB/photos/photos_model.dart';
import 'package:wonroom/DB/photos/photos_service.dart';
import 'package:wonroom/DB/plant_management_records/plant_management_model.dart';
import 'package:wonroom/DB/plant_management_records/plant_management_records_service.dart';
import 'package:wonroom/DB/posts/posts_model.dart';
import 'package:wonroom/DB/posts/posts_service.dart';
import 'package:wonroom/DB/queries/queries_model.dart';
import 'package:wonroom/DB/queries/queries_service.dart';
import 'package:wonroom/DB/user_plants/user_plants_model.dart';
import 'package:wonroom/DB/user_plants/user_plants_service.dart';
import 'package:wonroom/DB/users/users_model.dart';
import 'package:wonroom/Flask/storage_manager.dart';
import 'package:wonroom/MyPlant/myPlant_functions.dart';
import 'package:wonroom/myPlantClinic.dart';
import 'package:wonroom/myPlantRegistration.dart';
import 'package:wonroom/showFloatingActionModal.dart';





class MyplantNull extends StatefulWidget {
  const MyplantNull({super.key});

  @override
  State<MyplantNull> createState() => _MyplantNullState();
}

class _MyplantNullState extends State<MyplantNull> {

  // 당신의 식물 정보
  List<UserPlant> _userPlants = [];
  // 당신의 식물 정보의 일정들
  List<List<PlantManagementRecord>> _PMR = [];

  // 보여줄 페이지 불값
  bool checks = true;

  int plantIndex = 0;

  // Table: user_plants
  // Columns:
  // plant_id int AI PK
  // user_id varchar(50)
  // catalog_number int
  // diary_title varchar(255)
  // next_watering_date date
  // created_at timestamp

  // 1. diary_title
  // 식물 이름쯔음이면 되겟따
  String diary_title = "";

  @override
  void initState() {
    super.initState();
    setState(() {
      _loadData(); // 페이지가 처음 로드될 때 데이터를 불러옵니다.

    });
  }

  void _loadData() async
  {
    print("데이터 불러오기 작업을 수행합니다. inputss: $plantIndex");
    User? user = await readUser(); // user 객체 가져오기
    print("User? user = await readUser();");

    if (user != null) {
      print(user.getuserId()); // 사용자 ID 출력
      print(user.getuserId()); // 사용자 ID 출력
      print(user.getuserId()); // 사용자 ID 출력

      String? userId = user.getuserId(); // 사용자 ID 변수에 할당
      if (userId != null) {
        UserPlantService ups = UserPlantService();

        // 비동기 호출로 사용자 식별자에 따라 식물 목록 가져오기
        List<UserPlant>? userPlants = await ups.getPlants(userId);

        if (userPlants != null) {
          setState(() {
            _userPlants = userPlants; // 데이터 할당 후 상태 업데이트
            print("성공");
            print("성공");
            print("성공");

            _updateDoubleList();



            checks = true;
          });
        } else {
          print("No plants found for user ID: $userId");
        }
      } else {
        print("User ID is null.");
      }
    } else {
      print("User object is null.");
    }

    _updatePlant(plantIndex);
  }



  void _updateDoubleList() async {

    // 식물매니저서비스를 소환합니다
    PlantManagementService pms = PlantManagementService();

    // 식물 일정이 담긴 이중 리스트를 초기화합니다
    int numbOfPlant = _userPlants.length;

    // 이중 리스트 초기화 (각 식물에 대해 빈 리스트 생성)
    _PMR = List.generate(numbOfPlant, (index) => []);

    for (int i = 0; i < numbOfPlant; i++) {
      // 식물 ID를 가져옵니다
      int plantId = _userPlants[i].plantId ?? -1;

      if (plantId == -1) {
        // 식물 ID가 유효하지 않으면 건너뜁니다
        continue;
      }

      try {
        // 식물 ID로 식물 관리 기록을 가져옵니다

        // PlantManagementRecord pmr2 = new PlantManagementRecord
        //   (catalogNumber: plantId*2,
        //     managementDate: DateTime.now(),
        //     managementType: ManagementType.Repotting,
        //     details: "디테일" + plantId.toString(),
        //     plantId: plantId);
        //
        // pms.addRecord(pmr2);
        List<PlantManagementRecord>? pmr = await pms.getRecords(plantId);

        if (pmr != null) {
          setState(() {
            // 식물 관리 기록을 이중 리스트에 저장합니다
            _PMR[i] = pmr;
            print("결과출력!!!!");
            print("결과출력!!!!");
            print("결과출력!!!!");

            print(i);
            print(pmr.length);
            print("결과출력!!!!");
            print("결과출력!!!!");
            print("결과출력!!!!");
          });
        }
      } catch (e) {
        print("Error loading plant management records: $e");
      }
    }

    // 이중 리스트 초기화 후 추가적인 작업이 필요하다면 여기에 추가합니다
    print("식물 일정 이중 리스트가 업데이트되었습니다.");
  }


  // 식물 일정이 담긴 이중리스트를 초기화 합니다
  // _PMS = List.generate(userPlants.length, (index) => []);

  // 지금 식물 일정들이 담긴 이중리스트를 초기화 해야 합니다
  // 그렇기 위해서 for문이 2개가 필요하고
  // 첫번째 포문에선 식물의갯수만큼
  // 두번째 포문에선 인덱싱된 식물id로 셀렉트 한 일정길이만큼

  // 그러면 일단 2가지의 변수를 먼저 준비해둔다


  void _updatePlant(index)
  {
    setState(() {
      diary_title = _userPlants[index].diaryTitle ?? 'Default Title';

    });
  }

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
      body: checks ? _buildScrollView() : _buildContainer(),
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
                              diary_title,
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
                    color: Color(0xffeeeeee),
                  ),
                  SizedBox(height: 10,),
                  Text(
                    '등록된 식물이 없습니다. \n나의 반려 식물을 등록해 주세요.',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Color(0xffc2c2c2),
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

  // 상단 도감 버튼을 만듭니다
  Widget _buildEncyclopedia()
  {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      color: Color(0xffeeeeee),
      child: Row(
        // mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: menuButton(_userPlants.length, plantIndex, (index1) {
                  setState(() {
                    plantIndex = index1;
                    _updatePlant(plantIndex);
                    // return index1;
                  });
                  print("메인쪽");
                  print("메인쪽");
                  print(plantIndex);
                  print("메인쪽");
                  print("메인쪽");
                }),
              ),
            ),
          ),

          // 도감 추가
          ElevatedButton(
            onPressed: () async{
              // 버튼 클릭 시 실행될 코드
              print("+버튼");
              // showFloatingActionModal(context);
              // ChatMessagesService chatMessagesService = new ChatMessagesService();
              // ChatMessage chatMessage = new ChatMessage
              //   (chatId: 1, chatText: "채팅내역2", speaker: true, chatTime: DateTime.now());
              showPlantRegistrationModal(context);
              // chatMessagesService.getChatMessages(DateTime(2000), DateTime(2100));

              // chatMessagesService.updateChatMessage(chatMessage);

              // chatMessagesService.deleteChatMessage(1);

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

