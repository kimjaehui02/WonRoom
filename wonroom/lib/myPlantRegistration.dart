import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:wonroom/DB/plant_management_records/plant_management_records_service.dart';
import 'package:wonroom/DB/user_plants/user_plants_model.dart';
import 'package:wonroom/DB/user_plants/user_plants_service.dart';
import 'package:wonroom/DB/plant_management_records/plant_management_model.dart';
import 'package:wonroom/Flask/storage_manager.dart';


// 관리 유형 Enum 정의
// enum ManagementType { Watering, Pruning, Repotting, Fertilizing, Diagnosis }

void showPlantRegistrationModal(BuildContext context, Function? onRefresh) async {
  final userPlantService = UserPlantService(); // UserPlantService 인스턴스 생성
  final plantManagementService = PlantManagementService(); // PlantManagementService 인스턴스 생성
  final StorageManager _sm = StorageManager();
  final TextEditingController _plantNameController = TextEditingController(); // 식물 이름 입력 컨트롤러

  final TextEditingController _lastWateredController = TextEditingController(); // 각 날짜별 컨트롤러
  final TextEditingController _lastFertilizedController = TextEditingController();
  final TextEditingController _lastRepottedController = TextEditingController();
  final TextEditingController _lastPrunedController = TextEditingController();

  DateTime? _lastWateredDate; // 마지막 물 준 날짜
  DateTime? _lastFertilizedDate; // 마지막 영양제 준 날짜
  DateTime? _lastRepottedDate; // 마지막 분갈이 날짜
  DateTime? _lastPrunedDate; // 마지막 가지치기 날짜

  File? _image; // 이미지 파일
  bool _showImageInField = false; // 네 버튼을 눌렀을 때 이미지를 표시할지 여부
  bool _isUploading = false; // 이미지 업로드 중 여부
  String _plantName = ''; // 서버에서 받아온 식물 이름
  final picker = ImagePicker(); // ImagePicker 인스턴스 생성

  Future<void> _showConfirmationDialog(
      BuildContext context,
      String plantName,
      StateSetter setState,
      ) async {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('식물 이름 확인'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              if (_image != null) Image.file(_image!), // 모달창에 이미지 미리보기
              SizedBox(height: 10),
              Text('받아온 식물 이름 "$plantName"이(가) 맞나요?'),
            ],
          ),
          actions: <Widget>[
            TextButton(
              child: Text('아니요'),
              onPressed: () {
                setState(() {
                  _plantNameController.clear(); // 텍스트 필드 초기화
                  _showImageInField = false; // 이미지 표시 제거
                });
                Navigator.of(context).pop(); // 다이얼로그 닫기
              },
            ),
            TextButton(
              child: Text('네'),
              onPressed: () {
                setState(() {
                  // 텍스트 필드에 값 반영 및 이미지를 표시하지 않음
                  _plantNameController.text = plantName;
                  _showImageInField = false; // 이미지를 표시하지 않도록 설정
                });
                Navigator.of(context).pop(); // 다이얼로그 닫기
              },
            ),
          ],
        );
      },
    );
  }

  Future<void> _pickDate(BuildContext context, TextEditingController controller) async {
    final DateTime? selectedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );
    if (selectedDate != null) {
      // 선택된 날짜를 텍스트 필드에 반영
      controller.text = "${selectedDate.year}-${selectedDate.month}-${selectedDate.day}";
    }
  }

  void _registerPlant() async {
    if (_plantNameController.text.isEmpty) {
      print('식물 이름을 입력해주세요');
      return;
    }

    String inputId = await _sm.getUserId() ?? "";

    final userPlant = UserPlant(
      userId: inputId.isNotEmpty ? inputId : 'defaultUserId',
      catalogNumber: 0,
      diaryTitle: _plantNameController.text,
      nextWateringDate: _lastWateredDate ?? DateTime.now(),
      createdAt: DateTime.now(),
    );

    try {
      final int? plantId = await userPlantService.addPlantAndGetId(userPlant);

      if (plantId == null) {
        print('식물 등록 실패: ID를 얻지 못했습니다.');
        return;
      }

      int newinput = plantId;

      if (_lastWateredDate != null) {
        await plantManagementService.addRecord(PlantManagementRecord(
          catalogNumber: newinput, // catalogNumber 대신 newinput 사용
          managementDate: _lastWateredDate!,
          managementType: ManagementType.Watering,
          details: 'Watering details',
          plantId: newinput,
        ));
      }

      if (_lastFertilizedDate != null) {
        await plantManagementService.addRecord(PlantManagementRecord(
          catalogNumber: newinput, // catalogNumber 대신 newinput 사용
          managementDate: _lastFertilizedDate!,
          managementType: ManagementType.Fertilizing,
          details: 'Fertilizing details',
          plantId: newinput,
        ));
      }

      if (_lastRepottedDate != null) {
        await plantManagementService.addRecord(PlantManagementRecord(
          catalogNumber: newinput, // catalogNumber 대신 newinput 사용
          managementDate: _lastRepottedDate!,
          managementType: ManagementType.Repotting,
          details: 'Repotting details',
          plantId: newinput,
        ));
      }

      if (_lastPrunedDate != null) {
        await plantManagementService.addRecord(PlantManagementRecord(
          catalogNumber: newinput, // catalogNumber 대신 newinput 사용
          managementDate: _lastPrunedDate!,
          managementType: ManagementType.Pruning,
          details: 'Pruning details',
          plantId: newinput,
        ));
      }

      Navigator.pop(context);
      if (onRefresh != null) {
        onRefresh();
      }
      print('식물 등록 완료');
    } catch (e) {
      print('식물 등록 실패: $e');
    }
  }

  // 모달을 화면에 표시
  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(20)), // 모달 상단 둥글게
    ),
    builder: (BuildContext context) {
      return Padding(
        padding: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewInsets.bottom, // 키보드가 있을 때 모달 위치 조정
        ),
        child: DraggableScrollableSheet(
          expand: false,
          initialChildSize: 0.85, // 모달 초기 높이 비율
          maxChildSize: 0.9, // 모달 최대 높이 비율
          minChildSize: 0.5, // 모달 최소 높이 비율
          builder: (BuildContext context, ScrollController scrollController) {
            return StatefulBuilder(
              builder: (BuildContext context, StateSetter setState) {
                Future<void> _uploadImage(File image) async {
                  setState(() {
                    _isUploading = true;
                    _plantNameController.text = "검색중입니다..."; // 검색중일 때 표시
                  });

                  try {
                    final imageBytes = await image.readAsBytes();
                    final base64Image = base64Encode(imageBytes);

                    // 서버로 이미지를 전송하여 텍스트(식물 이름)를 받아옴
                    final response = await http.post(
                      Uri.parse('https://2f60-34-23-46-115.ngrok-free.app/plant_register'),
                      headers: {'Content-Type': 'application/json'},
                      body: json.encode({'image': base64Image}),
                    );

                    if (response.statusCode == 200) {
                      final data = json.decode(response.body);
                      print('서버 응답: $data');

                      // 서버에서 받아온 텍스트 확인 후 적용하는 다이얼로그 호출
                      _showConfirmationDialog(
                          context, data['plant_name'], setState); // setState 추가
                    } else {
                      print('API 호출 오류: ${response.statusCode}');
                    }
                  } catch (e) {
                    print('API 호출 중 오류 발생: $e');
                  } finally {
                    setState(() {
                      _isUploading = false;
                    });
                  }
                }

                Future<void> _pickImage(ImageSource source) async {
                  final pickedFile = await picker.pickImage(source: source);
                  if (pickedFile != null) {
                    final selectedImage = File(pickedFile.path);
                    setState(() {
                      _image = selectedImage; // 이미지를 표시하기 위해 설정
                    });
                    await _uploadImage(selectedImage); // 이미지를 서버로 전송
                  }
                }

                return Column(
                  children: [
                    Expanded(
                      child: SingleChildScrollView(
                        controller: scrollController,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Center(
                              child: Container(
                                width: 60,
                                height: 5,
                                decoration: BoxDecoration(
                                  color: Colors.grey[300],
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              ),
                            ),
                            SizedBox(height: 20),
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: 20),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    '식물 등록',
                                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                                  ),
                                  SizedBox(height: 20),
                                  // 이미지 추가 버튼
                                  if (_image != null)
                                    Container(
                                      width: double.infinity,
                                      child: Image.file(_image!, fit: BoxFit.cover),
                                    ),
                                  ElevatedButton(
                                    onPressed: () => _pickImage(ImageSource.camera),
                                    child: Text('사진 촬영'),
                                  ),
                                  ElevatedButton(
                                    onPressed: () => _pickImage(ImageSource.gallery),
                                    child: Text('갤러리에서 선택'),
                                  ),
                                  SizedBox(height: 20),
                                  TextField(
                                    controller: _plantNameController,
                                    decoration: InputDecoration(
                                      labelText: '식물 이름',
                                      border: OutlineInputBorder(),
                                    ),
                                  ),
                                  SizedBox(height: 20),
                                  Text('마지막 물 준 날짜'),
                                  TextField(
                                    controller: _lastWateredController,
                                    readOnly: true,
                                    onTap: () => _pickDate(context, _lastWateredController),
                                    decoration: InputDecoration(
                                      labelText: '날짜 선택',
                                      border: OutlineInputBorder(),
                                    ),
                                  ),
                                  SizedBox(height: 10),
                                  Text('마지막 영양제 준 날짜'),
                                  TextField(
                                    controller: _lastFertilizedController,
                                    readOnly: true,
                                    onTap: () => _pickDate(context, _lastFertilizedController),
                                    decoration: InputDecoration(
                                      labelText: '날짜 선택',
                                      border: OutlineInputBorder(),
                                    ),
                                  ),
                                  SizedBox(height: 10),
                                  Text('마지막 분갈이 날짜'),
                                  TextField(
                                    controller: _lastRepottedController,
                                    readOnly: true,
                                    onTap: () => _pickDate(context, _lastRepottedController),
                                    decoration: InputDecoration(
                                      labelText: '날짜 선택',
                                      border: OutlineInputBorder(),
                                    ),
                                  ),
                                  SizedBox(height: 10),
                                  Text('마지막 가지치기 날짜'),
                                  TextField(
                                    controller: _lastPrunedController,
                                    readOnly: true,
                                    onTap: () => _pickDate(context, _lastPrunedController),
                                    decoration: InputDecoration(
                                      labelText: '날짜 선택',
                                      border: OutlineInputBorder(),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(vertical: 10),
                      child: Center(
                        child: ElevatedButton(
                          onPressed: _isUploading ? null : _registerPlant,
                          child: _isUploading
                              ? CircularProgressIndicator()
                              : Text('등록'),
                        ),
                      ),
                    ),
                  ],
                );
              },
            );
          },
        ),
      );
    },
  );
}


// 텍스트 필드를 생성하는 위젯
Widget _buildTextField({
  required String label,
  required String hintText,
  required TextEditingController controller,
}) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Padding(
        padding: const EdgeInsets.only(left: 6),
        child: Text(
          label, // 필드 레이블
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
      ),
      SizedBox(height: 8),
      TextField(
        controller: controller,
        decoration: InputDecoration(
          hintText: hintText, // 힌트 텍스트
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
          ),
          contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        ),
      ),
    ],
  );
}

// 날짜 선택기를 생성하는 위젯
Widget _buildDatePicker(
    BuildContext context, {
      required String label,
      required TextEditingController controller,
      required void Function(DateTime) onDateSelected,
    }) {
  DateTime? _selectedDate;

  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Padding(
        padding: const EdgeInsets.only(left: 6),
        child: Text(
          label, // 날짜 선택기 레이블
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
      ),
      SizedBox(height: 8),
      GestureDetector(
        onTap: () async {
          final DateTime? pickedDate = await showDatePicker(
            context: context,
            initialDate: _selectedDate ?? DateTime.now(),
            firstDate: DateTime(1900),
            lastDate: DateTime(2100),
          );

          if (pickedDate != null && pickedDate != _selectedDate) {
            _selectedDate = pickedDate;
            controller.text = DateFormat('yyyy-MM-dd').format(_selectedDate!); // 텍스트 필드 업데이트
            onDateSelected(_selectedDate!); // 날짜 선택 처리
          }
        },
        child: AbsorbPointer(
          child: TextField(
            controller: controller, // 컨트롤러 연결
            decoration: InputDecoration(
              hintText: controller.text.isNotEmpty
                  ? controller.text
                  : '날짜를 선택하세요', // 힌트 텍스트
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
              ),
              contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            ),
          ),
        ),
      ),
    ],
  );
}


