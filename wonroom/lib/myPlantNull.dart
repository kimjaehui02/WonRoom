import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
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
import 'package:wonroom/ImageService/ImageService.dart';
import 'package:wonroom/MyPlant/myPlant_functions.dart';
import 'package:wonroom/myPlantClinic.dart';
import 'package:wonroom/myPlantRegistration.dart';
import 'package:wonroom/showFloatingActionModal.dart';
import 'package:http/http.dart' as http;

import 'package:intl/intl.dart';

class diagnosis {
  String _diagnosisResult;

  String getstring()
  {
    return _diagnosisResult;
  }

  diagnosis(this._diagnosisResult);
}

class MyplantNull extends StatefulWidget {
  const MyplantNull({super.key});



  @override
  State<MyplantNull> createState() => _MyplantNullState();
}

class _MyplantNullState extends State<MyplantNull> {
  // 사용자 식물 목록 저장
  List<UserPlant> _userPlants = [];

  // 각 식물에 대한 관리 일정 저장 (이중 리스트 구조)
  List<List<PlantManagementRecord>> _PMR = [];

  // UI에서 사용될 액션 위젯들 저장
  List<Widget> actionContainers = [];

  // 데이터 로딩 완료 여부를 나타내는 플래그
  bool checks = false;

  // 데이터 로딩 상태를 나타내는 플래그
  bool _isLoading = false;

  // 현재 선택된 식물의 인덱스
  int plantIndex = 0;

  // 현재 사용자의 정보 저장
  User? user;

  // 일기 제목 저장
  String diary_title = "";

  // 각 식물별로 관리 일정들을 타입별로 그룹화하여 저장
  List<Map<ManagementType, List<PlantManagementRecord>>> sortedGroupedRecords = [{}];

  // 사용자가 선택한 즐겨찾는 식물의 ID 저장
  int _userfav = -10;

  // 현재 선택된 식물이 즐겨찾기에 등록된 식물인지 여부를 나타내는 플래그
  bool _fullStar = false;

  // 외부 서비스 호출에 필요한 객체들 초기화
  final UserService _us = new UserService();
  final StorageManager _sm = new StorageManager();
  final UserPlantService _ups = new UserPlantService();

  final imageService = new ImageService();


  @override
  void initState() {
    super.initState();
    // 위젯이 처음 생성될 때 데이터를 초기화
    _initializeData();
  }

  // 초기 데이터를 로딩하는 함수
  void _initializeData() async
  {
    // 사용자의 정보를 로컬 저장소에서 불러옴
    user = await _sm.readUser();
    if (user != null) {
      // 사용자가 존재할 경우, 사용자 식물 정보 로딩
      await _loadUserPlants(user!);
    }
    // 첫 번째 식물 정보를 화면에 업데이트
    _updatePlant(plantIndex);
  }

  // 사용자 식물 정보를 불러오는 함수
  Future<void> _loadUserPlants(User user) async {
    // 사용자의 ID를 가져옴
    String? userId = user.getuserId();
    if (userId != null) {
      // 사용자 식물 서비스에서 식물 목록을 가져옴
      UserPlantService ups = UserPlantService();
      List<UserPlant>? userPlants = await ups.getPlants(userId);

      print(userId);
      print(userId);
      print(userId);
      print(userId);
      print(userId);

      if (userPlants != null) {
        // 식물 목록을 로컬 상태에 저장하고 로딩 상태를 갱신
        setState(() {
          _userPlants = userPlants;
          checks = true;
          _isLoading = true;
        });
        // 식물에 대한 일정 데이터를 불러옴
        await _loadPlantSchedules();
      } else {
        // 식물을 찾을 수 없는 경우에 대한 처리
        print("No plants found for user ID: $userId");
      }
    }
  }

  // 각 식물에 대한 관리 일정을 로딩하는 함수
  Future<void> _loadPlantSchedules() async {
    // 식물 관리 서비스 객체 생성
    PlantManagementService pms = PlantManagementService();

    // 식물의 수만큼 관리 일정 리스트를 초기화
    int numbOfPlant = _userPlants.length;

    _PMR = List.generate(numbOfPlant, (_) => []);
    sortedGroupedRecords = List.generate(numbOfPlant, (_) => {
      ManagementType.Watering: [],
      ManagementType.Pruning: [],
      ManagementType.Repotting: [],
      ManagementType.Fertilizing: [],
      ManagementType.Diagnosis: [],
    });

    // 각 식물의 관리 일정을 순차적으로 불러옴
    for (int i = 0; i < numbOfPlant; i++) {
      int plantId = _userPlants[i].plantId ?? -1;
      if (plantId != -1) {
        try {
          // 식물 ID에 맞는 관리 일정 데이터를 불러옴
          List<PlantManagementRecord>? pmr = await pms.getRecords(plantId);
          if (pmr != null) {
            // 불러온 데이터를 로컬 리스트에 저장하고 일정 타입별로 분류
            _PMR[i] = pmr;
            sortedGroupedRecords[i] = sortAndGroupRecords(pmr);
          }
        } catch (e) {
          // 관리 일정 로딩 중 오류 발생 시 처리
          print("Error loading plant management records: $e");
        }
      }
    }

    // 첫 번째 식물의 정보를 화면에 업데이트
    _updatePlant(plantIndex);
    print("식물 일정 이중 리스트가 업데이트되었습니다.");
  }

  void _updatePlant(int index) {
    // 리스트의 유효성 확인
    if (index < 0 || index >= _userPlants.length) {
      print(_userPlants.length);
      print("Invalid plant index: $index");
      return; // 유효하지 않은 인덱스일 경우 함수 종료
    }

    setState(() {
      try {
        // 오늘의 날짜를 MM.dd 형식으로 포맷팅
        String todayDate = DateFormat('MM.dd').format(DateTime.now());

        // 선택된 식물이 즐겨찾기인지 여부 갱신
        _fullStar = _userPlants[index].plantId == _userfav;

        // 일기 제목을 갱신 (해당 식물의 일기 제목이 없으면 기본값으로 설정)
        diary_title = _userPlants[index].diaryTitle ?? 'Default Title';

        // 선택된 식물의 관리 일정에 따라 필요한 액션들을 생성
        List<PlantAction> plantActions = _buildPlantActions(index, todayDate);

        int plantIndex2 = plantIndex;
        // 생성된 액션들을 UI에 반영하기 위한 컨테이너 리스트로 변환
        actionContainers = buildPlantActionContainers(
            plantActions,
            _userPlants[index].plantId ?? -1, // plantId가 null인 경우 -1로 처리
            _initializeData, // 데이터를 로드하는 함수
                (int plantIndex) {
              _updatePlant(plantIndex); // 콜백 함수 호출 시 매개변수 전달
            },
            plantIndex, // 식물의 인덱스
              (String label, id, loading, details) {
              // 함수가 null로 전달되지 않도록 안전하게 처리
              if (label != null && id != null && _initializeData != null && details != null) {
                return _getImageFromCamera(label, id, _initializeData, details);
              } else {
                return Future.value(); // null 방지용으로 빈 Future 반환
              }
            },
            _diagnosis2 // 진단 객체
        );



        //   int id,
      //       Function() loading,
      //       Function(int) updatePlant,
      // diagnosis detailss,
      } catch (e) {
        print("Error updating plant: $e");
      }
    });
  }


  // 주어진 인덱스의 식물에 대해 관리할 액션 리스트를 생성하는 함수
  List<PlantAction> _buildPlantActions(int index, String todayDate) {
    // 관리 일정에서 가장 빠른 날짜를 가져오는 함수
    String getActionDate(List<PlantManagementRecord>? records) {
      return (records != null && records.isNotEmpty) ? records[0].getFormattedDate() : "--.--";
    }

    // 관리 일정이 오늘과 다른 날짜인지 확인하는 함수 (액션 활성화 여부 결정)
    bool isActive(List<PlantManagementRecord>? records) {
      return (records != null && records.isNotEmpty) ? records[0].getFormattedDate() != todayDate : true;
    }

    // 물주기, 영양제, 가지치기, 분갈이, 진단 등의 액션을 생성
    return [
      PlantAction(
          label: "물주기",
          icon: Icons.water_drop,
          actionDate: getActionDate(sortedGroupedRecords[index][ManagementType.Watering]),
          active: isActive(sortedGroupedRecords[index][ManagementType.Watering])
      ),
      PlantAction(
          label: "영양제",
          imageAsset: 'images/potion.png',
          actionDate: getActionDate(sortedGroupedRecords[index][ManagementType.Fertilizing]),
          active: isActive(sortedGroupedRecords[index][ManagementType.Fertilizing])
      ),
      PlantAction(
          label: "가지치기",
          imageAsset: 'images/scissor.png',
          actionDate: getActionDate(sortedGroupedRecords[index][ManagementType.Pruning]),
          active: isActive(sortedGroupedRecords[index][ManagementType.Pruning])
      ),
      PlantAction(
          label: "분갈이",
          imageAsset: 'images/soil.png',
          actionDate: getActionDate(sortedGroupedRecords[index][ManagementType.Repotting]),
          active: isActive(sortedGroupedRecords[index][ManagementType.Repotting])
      ),
      PlantAction(
          label: "진단",
          icon: Icons.eco,
          actionDate: getActionDate(sortedGroupedRecords[index][ManagementType.Diagnosis]),
          active: isActive(sortedGroupedRecords[index][ManagementType.Diagnosis])
      ),
    ];
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

                    setState(() {
                      plantIndex = 0;
                      _updatePlant(plantIndex);
                      // return index1;
                    });
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


                      _ups.deletePlantWithRecords(_userPlants[plantIndex].plantId ?? -1);

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
                  showPlantRegistrationModal(context, _initializeData);
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



  // -----------------------------------------------------------------------
  File? _image;
  // String? _diagnosisResult; // 서버에서 받은 결과값 저장.
  diagnosis _diagnosis2 = new diagnosis("");
  // bool _isLoading = false;  // 로딩 상태를 나타내는 변수

  Future<void> _getImageFromCamera(
      String label,
      int id,
      Function() loading,
      diagnosis detailss,
      ) async {
    final pickedFile = await ImagePicker().pickImage(source: ImageSource.camera);
    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
      });

      // 서버로 이미지 업로드 후 결과 받아오기
      String diagnosisResult = await _uploadImageAsBase64(_image!);

      // 진단 결과를 화면에 표시하기 위한 모달창
      _showResultDialog(context, diagnosisResult, label, id, loading, plantIndex, detailss);
    }
  }


  Future<String> _uploadImageAsBase64(File image) async {
    setState(() {
      _isLoading = true;  // 로딩 시작
    });

    try {
      List<int> imageBytes = await image.readAsBytes();
      String base64Image = base64Encode(imageBytes);

      var requestData = json.encode({
        'image': base64Image,
      });

      var response = await http.post(
        Uri.parse('https://3a1b-35-247-96-36.ngrok-free.app/myplant_pest'),
        headers: {"Content-Type": "application/json"},
        body: requestData,
      );

      if (response.statusCode == 200) {
        var responseBody = json.decode(response.body);
        if (responseBody is Map && responseBody.containsKey('pest_info')) {
          return responseBody['pest_info'].toString();
        } else {
          return '잘못된 응답 형식입니다.';
        }
      } else {
        return '서버 요청 실패';
      }
    } catch (e) {
      return '오류 발생: $e';
    } finally {
      setState(() {
        _isLoading = false;  // 로딩 종료
      });
    }
  }


  // 결과값을 모달창으로 띄우는 함수
  void _showResultDialog(
      BuildContext context,
      String result,
      String diagnosisResult,
      int id,
      Function() loading,
      int index,
      diagnosis detailss,
      )
   {
    bool isHealthy = result == "건강"; // 결과가 '건강'인지 여부 확인


    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          contentPadding: EdgeInsets.all(20),
          title: Text('진단 결과'),
          content: Text(
            isHealthy
                ? '당신의 식물은 건강합니다. 등록하시겠습니까??'
                : '$result(이)가 의심됩니다. 등록하시겠습니까?',
            style: TextStyle(fontSize: 18),
          ),
          actions: [
            TextButton(
              onPressed: () {


                Navigator.of(context).pop(); // 모달 닫기
              },
              child: Text('취소'),
            ),
            TextButton(
              onPressed: () async{

                // 등록 버튼 클릭 시 처리할 로직
                print("등록하기입니다!");
                print("등록하기입니다!");
                print("등록하기입니다!");
                print("등록하기입니다!");
                print(diagnosisResult);
                print(id);
                print(loading);
                print(result);
                detailss._diagnosisResult = result;
                print(detailss._diagnosisResult);
                print(index);

                // 건강
                // 버튼의 로직은 그대로 유지
                await plants(diagnosisResult, id, loading, detailss);

                // 이미지 저장 로직 추가
                final imageService = ImageService();
                final imageFile = _image; // 현재 선택된 이미지
                if (imageFile != null) {
                  await imageService.saveImage(imageFile, 'photos', id.toString());
                }

                _updatePlant(index);

                Navigator.of(context).pop(); // 모달 닫기
                // 등록 기능을 추가할 수 있습니다.
              },
              child: Text('등록'),
            ),
          ],
        );
      },
    );
  }


  // -----------------------------------------------------------------------


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
                                icon: Icon(_fullStar ? Icons.star_rounded : Icons.star_border_rounded, color: _fullStar ? Colors.amber : Color(0xff787878)),
                                onPressed: () async {
                                  // 아이콘 클릭 시 실행될 기능 구현
                                  int? currentPlantId = _userPlants[plantIndex].plantId;

                                  if (currentPlantId != null) {
                                    // 즐겨찾기 식물 정보 업데이트
                                    await _us.updateUserInfo(favoritePlantId: currentPlantId);

                                    // 즐겨찾기 상태를 직접 업데이트하여 전체 데이터를 다시 로드하지 않음
                                    setState(() {
                                      _userfav = currentPlantId;
                                      _fullStar = currentPlantId == _userfav; // 즐겨찾기 여부 업데이트
                                    });

                                    print("현재 즐겨찾기 식물 ID: $currentPlantId");
                                    print("업데이트된 즐겨찾기 식물 ID: $_userfav");
                                  }

                                  print("즐겨찾기 업데이트 완료");
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
                                icon: Icon(Icons.delete_outline_outlined, color: Color(0xff787878)),
                                onPressed: () {
                                  // 아이콘 클릭 시 실행될 기능 구현
                                  // _showBottomSheet(context);
                                  _showDeleteConfirmationSheet(context);

                                },
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),

                    SizedBox(height: 16),

                    // 이미지
                    // Container(
                    //   width: MediaQuery.of(context).size.width * 0.85,
                    //   height: MediaQuery.of(context).size.width * 0.85,
                    //   decoration: BoxDecoration(
                    //     borderRadius: BorderRadius.circular(10),
                    //     image: DecorationImage(
                    //       fit: BoxFit.fill,
                    //       // image: AssetImage('images/img01.jpg'), // 로컬 이미지 경로
                    //       image: imageService.loadImage2(context, plantIndex),
                    //       // image: AssetImage(imageService.loadImagesForPost(plantIndex.toString(), "user_plants") ?? 'images/img01.jpg'), // 로컬 이미지 경로
                    //     ),
                    //   ),
                    // ),
                    // 이미지
// 이미지
                    FutureBuilder<ImageProvider>(
                      future: imageService.loadImageProvider("user_plants", plantIndex.toString()),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState == ConnectionState.waiting) {
                          return Center(child: CircularProgressIndicator()); // 로딩 중에는 로딩 인디케이터를 표시합니다.
                        } else if (snapshot.hasError) {
                          return Center(child: Text('Error: ${snapshot.error}')); // 에러가 발생했을 때 에러 메시지를 표시합니다.
                        } else if (snapshot.hasData) {
                          return Container(
                            width: MediaQuery.of(context).size.width * 0.85,
                            height: MediaQuery.of(context).size.width * 0.85,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              image: DecorationImage(
                                fit: BoxFit.fill,
                                image: snapshot.data!,
                              ),
                            ),
                          );
                        } else {
                          return Center(child: Text('No image found')); // 이미지가 없을 때 메시지를 표시합니다.
                        }
                      },
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
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    padding: EdgeInsets.only(left: 10),
                    child:
                    Row(
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
                ),

                SizedBox(height: 12),

                makeBox(context, Icons.eco, "진단 기록", sortedGroupedRecords[plantIndex], ManagementType.Diagnosis),

                // SizedBox(height: 100,),
                //
                // Padding(
                //     padding: const EdgeInsets.all(16),
                //     // 버튼
                //     child: ElevatedButton(onPressed: (){
                //
                //     },
                //       style: ElevatedButton.styleFrom(
                //         backgroundColor: Color(0xff595959),
                //         elevation: 0,
                //         shape: RoundedRectangleBorder(
                //           borderRadius: BorderRadius.circular(10),
                //         ),
                //         minimumSize: const Size.fromHeight(50),
                //       ),
                //       child: const Text('해당 식물 정보 알아보기',
                //         style: TextStyle(
                //           fontSize: 16,
                //           color: Colors.white,
                //         ),
                //       ),
                //     )
                // ),

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
              showPlantRegistrationModal(context, _initializeData);
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
        borderRadius: BorderRadius.circular(10),
      ),
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
            children: buildTimelineItemsForManagementType(recordList, title),
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

List<Widget> buildTimelineItemsForManagementType(List<PlantManagementRecord> records, String title) {
  int displayCount = records.length > 5 ? 5 : records.length;
  List<PlantManagementRecord> displayRecords = records.take(displayCount).toList().reversed.toList();

  return List.generate(5, (index) {
    if (index < displayRecords.length) {
      // 진단 기록인지 확인
      bool isDiagnosisRecord = title == "진단 기록";

      // 질병명인지 확인 (세부 정보가 '건강'이 아닌 경우 병해충으로 간주)
      String displayText;
      if (displayRecords[index].details == "건강") {
        displayText = "건강";
      } else {
        displayText = "병해충";
      }

      return Column(
        children: [
          buildTimelineItem(
            displayRecords[index].getFormattedDate(),
            true, // 활성화 상태
          ),
          // 진단 기록일 때만 텍스트 표시
          if (isDiagnosisRecord)
            Text(
              displayText, // 건강 또는 병해충 표시
              style: TextStyle(fontSize: 14, color: Colors.grey), // 날짜와 비슷한 스타일 적용
            ),
        ],
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

