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
import 'package:wonroom/DB/users/user_service.dart';
import 'package:wonroom/DB/users/users_model.dart';
import 'package:wonroom/Flask/storage_manager.dart';
import 'package:wonroom/MyPlant/myPlant_functions.dart';
import 'package:wonroom/myPlantClinic.dart';
import 'package:wonroom/myPlantRegistration.dart';
import 'package:wonroom/showFloatingActionModal.dart';

import 'package:intl/intl.dart';



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

  // 당신의 식물 정보의 위젯들
  List<Widget> actionContainers = [];

  // 현재 값이 존재하는지 아닌지
  bool checks = false;

  // 현재 로딩이 완료되었는지 아닌디
  bool _isLoading = false;

  // 지금 보고 있는 식물의 인덱스값
  int plantIndex = 0;

  // Table: user_plants
  // Columns:
  // plant_id int AI PK
  // user_id varchar(50)
  // catalog_number int
  // diary_title varchar(255)
  // next_watering_date date
  // created_at timestamp

  User? user;

  // 1. diary_title
  // 식물 이름쯔음이면 되겟따
  String diary_title = "";
  

  // 2. 일정 라벨링
  // 리스트 - 맵 - 리스트
  // 인덱스(식물별) - 일정종류 - 일정 낱개
  List<Map<ManagementType, List<PlantManagementRecord>>> sortedGroupedRecords = [{}];

  // 3. 별체크
  // 즐겨찾기 항목이라면 별을 체크합니다
  int _userfav = -10;
  int _plantid = -100;

  bool _1 = true;
  bool _2 = true;
  bool _3 = true;
  bool _4 = true;
  bool _5 = true;

  // 불값들을관리해줄 콜백함수입니다
  // void boolcalback(bool _input, int numb)
  // {
  //   // switch(numb)
  //   // {
  //   //   case 1:
  //   //     _1 = _input;
  //   //     break;
  //   //   case 2:
  //   //     _2 = _input;
  //   //     break;
  //   //   case 3:
  //   //     _3 = _input;
  //   //     break;
  //   //   case 4:
  //   //     _4 = _input;
  //   //     break;
  //   //   case 5:
  //   //     _5 = _input;
  //   //     break;
  //   // }
  //
  // }

  @override
  void initState() {
    super.initState();
    setState(() {
      _loadData(); // 페이지가 처음 로드될 때 데이터를 불러옵니다.

    });
  }

  void _loading() async
  {
    final _id = await readUserData();

// favorite_plant_id를 8로 업데이트
    await updateFavoritePlantId(8);

// favorite_plant_id 값을 읽어와서 출력
    final _userfav = await getUserFav();
    print(_userfav);
    print(_userfav);
    print(_userfav);
    print(_userfav);
    print(_userfav);

// 업데이트된 데이터를 다시 읽어서 확인
    final updatedData = await readUserData();
    print(updatedData?["favorite_plant_id"] ?? "");

    print("페이버릿입니다");

    setState(() {

      _loadData(); // 페이지가 처음 로드될 때 데이터를 불러옵니다.

    });
  }

  // db연결을 이용해 값을 최신화 합니다
  // 자주 부르면 안됩니다
  void _loadData() async
  {
    print("데이터 불러오기 작업을 수행합니다. inputss: $plantIndex");
    user = await readUser(); // user 객체 가져오기
    print("User? user = await readUser();");

    if (user != null) {
      // print(user.getuserId()); // 사용자 ID 출력
      // print(user.getuserId()); // 사용자 ID 출력
      // print(user.getuserId()); // 사용자 ID 출력

      String? userId = user?.getuserId(); // 사용자 ID 변수에 할당
      if (userId != null) {
        UserPlantService ups = UserPlantService();

        // 비동기 호출로 사용자 식별자에 따라 식물 목록 가져오기
        List<UserPlant>? userPlants = await ups.getPlants(userId);

        if (userPlants != null) {
          setState(() {
            _userPlants = userPlants; // 데이터 할당 후 상태 업데이트


            _updateDoubleList();



            checks = true;
            _isLoading = true;
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



  // db연결을 이용해 값을 최신화 합니다
  // 자주 부르면 안됩니다
  // 그중에서도 일정을 최신화 해줍니다
  void _updateDoubleList() async {

    // 식물매니저서비스를 소환합니다
    PlantManagementService pms = PlantManagementService();

    // 식물 일정이 담긴 이중 리스트를 초기화합니다
    int numbOfPlant = _userPlants.length;

    // 이중 리스트 초기화 (각 식물에 대해 빈 리스트 생성)
    _PMR = List.generate(numbOfPlant, (index) => []);


    // sortedGroupedRecords를 빈 Map으로 초기화
    sortedGroupedRecords = List.generate(
        numbOfPlant,
            (index) => {
          ManagementType.Watering: [],
          ManagementType.Pruning: [],
          ManagementType.Repotting: [],
          ManagementType.Fertilizing: [],
          ManagementType.Diagnosis: [],
        }
    );

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

          _PMR[i] = pmr;

          // 식물 관리 기록을 더 쉽게 관리하기위해 매핑합니다
          sortedGroupedRecords[i] = sortAndGroupRecords(_PMR[i]);



        }
      } catch (e) {
        print("Error loading plant management records: $e");
      }
    }



    print(sortedGroupedRecords.length);
    print(sortedGroupedRecords.length);
    print(sortedGroupedRecords.length);
    print(sortedGroupedRecords.length);
    _updatePlant(plantIndex);
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


  // db연결 없이 이미 가진 값들로 화면을 최신화합니다
  void _updatePlant(int index) {
    setState(() {
      // 현재 날짜를 MM.DD 형식으로 가져오기
      String todayDate = DateFormat('MM.dd').format(DateTime.now());

      // UserPlant의 다이어리 제목 설정
      diary_title = _userPlants[index].diaryTitle ?? 'Default Title';

      // UserPlant의 식물 ID 설정
      _plantid = _userPlants[index].plantId ?? -1;

      // 각 ManagementType에 대해 안전하게 접근
      String getActionDate(List<PlantManagementRecord>? records) {
        return (records != null && records.isNotEmpty)
            ? records[0].getFormattedDate()
            : "--.--";
      }

      bool isActive(List<PlantManagementRecord>? records) {
        return (records != null && records.isNotEmpty)
            ? records[0].getFormattedDate() != todayDate
            : true;
      }

      // PlantAction 리스트를 생성하면서 날짜에 따라 active 값을 설정
      List<PlantAction> plantActions = [
        PlantAction(
          label: "물주기",
          icon: Icons.water_drop,
          actionDate: getActionDate(sortedGroupedRecords[index][ManagementType.Watering]),
          active: isActive(sortedGroupedRecords[index][ManagementType.Watering]),
        ),
        PlantAction(
          label: "영양제",
          imageAsset: 'images/potion.png', // 영양제 아이콘
          actionDate: getActionDate(sortedGroupedRecords[index][ManagementType.Fertilizing]),
          active: isActive(sortedGroupedRecords[index][ManagementType.Fertilizing]),
        ),
        PlantAction(
          label: "가지치기",
          imageAsset: 'images/scissor.png', // 가지치기 아이콘
          actionDate: getActionDate(sortedGroupedRecords[index][ManagementType.Pruning]),
          active: isActive(sortedGroupedRecords[index][ManagementType.Pruning]),
        ),
        PlantAction(
          label: "분갈이",
          imageAsset: 'images/soil.png', // 분갈이 아이콘
          actionDate: getActionDate(sortedGroupedRecords[index][ManagementType.Repotting]),
          active: isActive(sortedGroupedRecords[index][ManagementType.Repotting]),
        ),
        PlantAction(
          label: "진단",
          icon: Icons.eco,
          actionDate: getActionDate(sortedGroupedRecords[index][ManagementType.Diagnosis]),
          active: isActive(sortedGroupedRecords[index][ManagementType.Diagnosis]),
        ),
      ];

      // PlantActionContainers를 빌드
      actionContainers = buildPlantActionContainers(plantActions, _userPlants[index].plantId, _loading);
    });

    print("최신화입니다");
    print("최신화입니다");
    print("최신화입니다");
    print("최신화입니다");
    print("최신화입니다");
    print("최신화입니다");
    print("최신화입니다");
  }



  void _showDeletionSuccessDialog(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return AlertDialog(
          contentPadding: EdgeInsets.symmetric(horizontal: 24.0, vertical: 20.0),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(height: 10,),
              Text(
                '삭제되었습니다.',
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                    color: Colors.black),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 3),
              Text(
                '확인 버튼을 누르면 \n 이전 페이지로 이동합니다.',
                style: TextStyle(color: Colors.grey, fontSize: 16),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 15),
              Center(
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.black,
                    minimumSize: Size(200, 45),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(3),
                    ),
                  ),
                  child: Text(
                    '확인',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.bold
                    ), // 흰색 글씨
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  // 삭제버튼 클릭 시 팝업
  void _showDeleteConfirmationSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        return Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(height: 20),
              Text(
                '정말 삭제하시겠습니까?',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 3),
              Text(
                '삭제하기를 누르시면\n해당 식물 다이어리가 삭제됩니다.',
                style: TextStyle(color: Colors.grey, fontSize: 16),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 24),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    style: TextButton.styleFrom(
                      backgroundColor: Colors.grey[300],
                      minimumSize: Size(170, 50),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(3),
                      ),
                    ),
                    child: Text(
                      '취소',
                      style: TextStyle(
                          color: Color(0xff787878),
                          fontSize: 16,
                          fontWeight: FontWeight.bold
                      ),
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context);
                      _showDeletionSuccessDialog(context);
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color(0xff595959),
                      minimumSize: Size(170, 50),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(3),
                      ),
                    ),
                    child: Text(
                      '삭제',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.bold
                      ), // 흰색 글씨
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }

  // 수정, 삭제 팝업
  void _showBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        return Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                leading: Icon(Icons.edit_outlined),
                title: Text('수정하기'),
                onTap: () {
                  // 수정하기 기능 추가
                  Navigator.pop(context);
                  showPlantRegistrationModal(context);
                },
              ),
              ListTile(
                leading: Icon(Icons.delete_outline_outlined),
                title: Text('삭제하기'),
                onTap: () {
                  Navigator.pop(context);
                  _showDeleteConfirmationSheet(context);
                },
              ),
            ],
          ),
        );
      },
    );
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

  // 데이터가 잘 있으면 그제서야 반환합니다
  Widget _buildScrollView()
  {
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
                    // Row(
                    //   children: [
                    //     Expanded(
                    //       child: Container(
                    //         padding: EdgeInsets.only(left: 50), // 오른쪽 여백 추가
                    //         child: Text(
                    //           diary_title,
                    //           style: TextStyle(
                    //             fontSize: 24,
                    //             fontWeight: FontWeight.bold,
                    //           ),
                    //           textAlign: TextAlign.center, // 텍스트 중앙 정렬
                    //         ),
                    //       ),
                    //     ),
                    //     IconButton(
                    //       padding: EdgeInsets.only(right: 16), // 오른쪽 여백 추가
                    //       icon: Icon(Icons.more_vert, color: Color(0xff787878)),
                    //       onPressed: () {
                    //         // 아이콘 클릭 시 실행될 기능 구현
                    //       },
                    //     ),
                    //   ],
                    // ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Flexible(
                          flex: 1,
                          child: Align(
                            alignment: Alignment.centerLeft,
                            child: Padding(
                              padding: EdgeInsets.only(left: 32),
                              child: IconButton(
                                icon: Icon(_userfav == _plantid ? Icons.star_border_rounded : Icons.star_rounded, color: _userfav == _plantid ? Color(0xff787878) : Colors.amber),
                                onPressed: () async {
                                  // 아이콘 클릭 시 실행될 기능 구현
                                  UserService _us = new UserService();
                                  Map<String, dynamic> _read = await readUserData() ?? {};
                                  _us.usersUpdate(
                                      _read["user_pw"],
                                      _read["user_nick"],
                                      _read["user_email"],
                                      7);


                                  // showDeletionSuccessDialog(context: context);
                                  print("즐겨찾기");
                                  print("즐겨찾기");
                                  print("즐겨찾기");
                                  print("즐겨찾기");
                                  print("즐겨찾기");
                                },
                              ),
                            ),
                          ),
                        ),
                        Flexible(
                          flex: 5,
                          child: Align(
                            alignment: Alignment.center,
                            child: Text(
                              diary_title, // 여기에 동적으로 받아온 데이터 변수
                              style: TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ),
                        Flexible(
                          flex: 1,
                          child: Align(
                            alignment: Alignment.centerRight,
                            child: Padding(
                              padding: EdgeInsets.only(right: 32),
                              child: IconButton(
                                icon: Icon(Icons.more_vert, color: Color(0xff787878)),
                                onPressed: () {
                                  // 아이콘 클릭 시 실행될 기능 구현
                                  _showBottomSheet(context);
                                },
                              ),
                            ),
                          ),
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
                        children: actionContainers,
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
                      // Center(
                      //   child: Container(
                      //     width: MediaQuery.of(context).size.width,
                      //     padding: EdgeInsets.all(30),
                      //     decoration: BoxDecoration(
                      //         color : Color(0xfffafafa),
                      //         borderRadius: BorderRadius.circular(10)
                      //     ),
                      //     child: Column(
                      //       children: [
                      //         Row(
                      //           mainAxisAlignment: MainAxisAlignment.center,
                      //           children: [
                      //             Icon(
                      //               Icons.water_drop,
                      //               size: 32,
                      //               color: Colors.lightBlueAccent,
                      //             ),
                      //             SizedBox(width: 4),
                      //             Text(
                      //               '물주기 기록',
                      //               style: TextStyle(
                      //                 fontSize: 20,
                      //                 fontWeight: FontWeight.bold,
                      //               ),
                      //             ),
                      //           ],
                      //         ),
                      //         SizedBox(height: 20),
                      //         Row(
                      //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      //           children: [
                      //             buildTimelineItem("03.19", true),
                      //             buildTimelineItem("04.19", true),
                      //             buildTimelineItem("05.19", true),
                      //             buildTimelineItem("06.19", true),
                      //             buildTimelineItem(" ", false),
                      //           ],
                      //         )
                      //       ],
                      //     ),
                      //   ),
                      // ),

                      makeBox(context, Icons.water_drop, "물주기 기록", sortedGroupedRecords[plantIndex], ManagementType.Watering),

                      SizedBox(height: 24),

                      // 영양제 기록
                      // Center(
                      //   child: Container(
                      //     width: MediaQuery.of(context).size.width,
                      //     padding: EdgeInsets.all(30),
                      //     decoration: BoxDecoration(
                      //         color : Color(0xfffafafa),
                      //         borderRadius: BorderRadius.circular(10)
                      //     ),
                      //     child: Column(
                      //       children: [
                      //         Row(
                      //           mainAxisAlignment: MainAxisAlignment.center,
                      //           children: [
                      //             Image.asset(
                      //               'images/potion.png', // 영양제 아이콘
                      //               width: 32,
                      //               height: 32,
                      //             ),
                      //             SizedBox(width: 4),
                      //             Text(
                      //               '영양제 기록',
                      //               style: TextStyle(
                      //                 fontSize: 20,
                      //                 fontWeight: FontWeight.bold,
                      //               ),
                      //             ),
                      //           ],
                      //         ),
                      //         SizedBox(height: 20),
                      //         Row(
                      //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      //           children: [
                      //             buildTimelineItem("03.19", true),
                      //             buildTimelineItem("04.19", true),
                      //             buildTimelineItem(" ", false),
                      //             buildTimelineItem(" ", false),
                      //             buildTimelineItem(" ", false),
                      //           ],
                      //         )
                      //       ],
                      //     ),
                      //   ),
                      // ),
                      makeBox(context, 'images/potion.png', "영양제 기록", sortedGroupedRecords[plantIndex], ManagementType.Fertilizing),

                      SizedBox(height: 24),

                      // 가지치기 기록
                      // Center(
                      //   child: Container(
                      //     width: MediaQuery.of(context).size.width,
                      //     padding: EdgeInsets.all(30),
                      //     decoration: BoxDecoration(
                      //         color : Color(0xfffafafa),
                      //         borderRadius: BorderRadius.circular(10)
                      //     ),
                      //     child: Column(
                      //       children: [
                      //         Row(
                      //           mainAxisAlignment: MainAxisAlignment.center,
                      //           children: [
                      //             Image.asset(
                      //               'images/scissor.png', // 가지치기 아이콘
                      //               width: 32,
                      //               height: 32,
                      //             ),
                      //             SizedBox(width: 4),
                      //             Text(
                      //               '가지치기 기록',
                      //               style: TextStyle(
                      //                 fontSize: 20,
                      //                 fontWeight: FontWeight.bold,
                      //               ),
                      //             ),
                      //           ],
                      //         ),
                      //         SizedBox(height: 20),
                      //         Container(
                      //           child: Column(
                      //             children: [
                      //               Text('기록이 없습니다. \n 기록을 추가해보세요.',
                      //                 textAlign: TextAlign.center,
                      //                 style: TextStyle(color: Color(0xff787878)),),
                      //             ],
                      //           ),
                      //         )
                      //       ],
                      //     ),
                      //   ),
                      // ),

                      makeBox(context, 'images/scissor.png', "가지치기 기록", sortedGroupedRecords[plantIndex], ManagementType.Pruning),

                      SizedBox(height: 24),

                      makeBox(context, 'images/soil.png', "분갈이 기록", sortedGroupedRecords[plantIndex], ManagementType.Repotting),

                      // 분갈이 기록
                      // Center(
                      //   child: Container(
                      //     width: MediaQuery.of(context).size.width,
                      //     padding: EdgeInsets.all(30),
                      //     decoration: BoxDecoration(
                      //         color : Color(0xfffafafa),
                      //         borderRadius: BorderRadius.circular(10)
                      //     ),
                      //     child: Column(
                      //       children: [
                      //         Row(
                      //           mainAxisAlignment: MainAxisAlignment.center,
                      //           children: [
                      //             Image.asset(
                      //               'images/soil.png', // 분갈이 아이콘
                      //               width: 32,
                      //               height: 32,
                      //             ),
                      //             SizedBox(width: 4),
                      //             Text(
                      //               '분갈이 기록',
                      //               style: TextStyle(
                      //                 fontSize: 20,
                      //                 fontWeight: FontWeight.bold,
                      //               ),
                      //             ),
                      //           ],
                      //         ),
                      //         SizedBox(height: 20),
                      //         Container(
                      //           child: Column(
                      //             children: [
                      //               Text('기록이 없습니다. \n 기록을 추가해보세요.',
                      //                 textAlign: TextAlign.center,
                      //                 style: TextStyle(color: Color(0xff787878)),),
                      //             ],
                      //           ),
                      //         )
                      //       ],
                      //     ),
                      //   ),
                      // ),

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
                // Container(
                //   padding: const EdgeInsets.all(16),
                //   child: Column(
                //     crossAxisAlignment: CrossAxisAlignment.start,
                //     children: [
                //       Container(
                //         padding: EdgeInsets.only(left: 10),
                //         child: Row(
                //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
                //           children: [
                //             Text(
                //               '진단 기록',
                //               style: TextStyle(
                //                 fontSize: 21,
                //                 fontWeight: FontWeight.bold,
                //               ),
                //             ),
                //
                //             TextButton(onPressed: (){
                //               Navigator.push(context,
                //                 MaterialPageRoute(builder: (_)=>MyPlantClinic()),
                //               );
                //             },
                //               child: Row(
                //                 children: [
                //                   Text(
                //                     '자세히 보기 ',
                //                     style: TextStyle(
                //                       color: Color(0xff787878),
                //                     ),
                //                   ),
                //                   Icon(Icons.arrow_forward_ios,
                //                     size: 12,
                //                   )
                //                 ],
                //               ),
                //             ),
                //           ],
                //         ),
                //       ),
                //
                //       SizedBox(height: 12),
                //
                //       // 진단 기록
                //       Center(
                //         child: Container(
                //           width: MediaQuery.of(context).size.width,
                //           padding: EdgeInsets.all(30),
                //           decoration: BoxDecoration(
                //               color : Color(0xfffafafa),
                //               borderRadius: BorderRadius.circular(10)
                //           ),
                //           child: Column(
                //             children: [
                //               Row(
                //                 mainAxisAlignment: MainAxisAlignment.center,
                //                 children: [
                //                   Icon(
                //                     Icons.eco,
                //                     size: 32,
                //                     color: Colors.lightGreen,
                //                   ),
                //                   SizedBox(width: 4),
                //                   Text(
                //                     '건강 기록',
                //                     style: TextStyle(
                //                       fontSize: 20,
                //                       fontWeight: FontWeight.bold,
                //                     ),
                //                   ),
                //                 ],
                //               ),
                //               SizedBox(height: 20),
                //               Row(
                //                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
                //                 children: [
                //                   buildTimelineItem("03.19 \n 정상", true),
                //                   buildTimelineItem("14.19 \n 질병", true),
                //                   buildTimelineItem("05.19 \n 해충", true),
                //                   buildTimelineItem("06.19 \n 정상", true),
                //                   buildTimelineItem(" \n ", false),
                //                 ],
                //               )
                //             ],
                //           ),
                //         ),
                //       ),
                //     ],
                //   ),
                // ),
                makeBox(context, Icons.eco, "진단 기록", sortedGroupedRecords[plantIndex], ManagementType.Diagnosis),
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

  // 데이터가 없는경우 반환합니다
  Widget _buildContainer()
  {
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

                }, _userPlants),
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

Widget makeBox(BuildContext context, dynamic icon, String title, Map<ManagementType, List<PlantManagementRecord>> records, type) {
  List<PlantManagementRecord> recordList = records[type] ?? [];

  return Center(
    child: Container(
      width: MediaQuery.of(context).size.width,
      padding: EdgeInsets.all(30),
      decoration: BoxDecoration(
          color: Color(0xfffafafa),
          borderRadius: BorderRadius.circular(10)),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              icon is String
                ? Image.asset(
              icon, // 이미지 아이콘
              width: 32,
              height: 32,
            )
                : Icon(
                icon,
                              size: 32,
                              color: Colors.lightBlueAccent,
                            ),
              SizedBox(width: 4),
              Text(
                title,
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          SizedBox(height: 20),
          recordList.isNotEmpty
              ? Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: buildTimelineItemsForManagementType(recordList),
          )
              : Container(
            child: Column(
              children: [
                Text(
                  '기록이 없습니다. \n 기록을 추가해보세요.',
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Color(0xff787878)),
                ),
              ],
            ),
          )
        ],
      ),
    ),
  );
}

List<Widget> buildTimelineItemsForManagementType(List<PlantManagementRecord> records) {
  // 가장 최근 5개의 기록만 사용 (최신순으로 정렬되어 있다고 가정)
  int displayCount = records.length > 5 ? 5 : records.length;

  // 최신 5개 기록만 선택하고 오래된 순서로 정렬
  List<PlantManagementRecord> displayRecords = records.take(displayCount).toList().reversed.toList();

  // 5개의 슬롯을 만들고 해당 슬롯에 기록을 채우기
  return List.generate(5, (index) {
    if (index < displayRecords.length) {
      return buildTimelineItem(
        displayRecords[index].getFormattedDate(),
        true, // 활성화 상태
      );
    } else {
      return buildTimelineItem(
        " ", // 빈 문자열
        false, // 비활성화 상태
      );
    }
  });
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

