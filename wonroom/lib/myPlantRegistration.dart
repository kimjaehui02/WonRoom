import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:wonroom/DB/plant_management_records/plant_management_records_service.dart';
import 'package:wonroom/DB/user_plants/user_plants_model.dart';
import 'package:wonroom/DB/user_plants/user_plants_service.dart';
import 'package:wonroom/DB/plant_management_records/plant_management_model.dart';
import 'package:wonroom/Flask/storage_manager.dart';
import 'dart:convert'; // json.decode
import 'dart:io'; // File
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart'; // ImagePicker
import 'package:http/http.dart' as http;
import 'package:wonroom/ImageService/ImageService.dart'; // http
import 'package:path/path.dart' as p;

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

  dynamic localImage;

  DateTime? parseDate(String dateString) {
    try {
      final DateFormat dateFormat = DateFormat('yyyy-MM-dd');
      return dateFormat.parse(dateString);
    } catch (e) {
      print('Date parsing error: $e');
      return null;
    }
  }

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


  Future<DateTime?> _pickDate(BuildContext context, TextEditingController controller) async {
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
    print("controller.text");
    print(controller.text);
    print("controller.text");
    print(controller.text);

    return parseDate(controller.text);
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

    print('Last Watered Date: $_lastWateredDate');
    print('Last Fertilized Date: $_lastFertilizedDate');
    print('Last Repotted Date: $_lastRepottedDate');
    print('Last Pruned Date: $_lastPrunedDate');

    final int? plantId = await userPlantService.addPlantAndGetId(userPlant);

    if (plantId == null) {
      print('식물 등록 실패: ID를 얻지 못했습니다.');
      return;
    }

    final imageService = new ImageService();



    await imageService.saveImage(localImage, plantId.toString(), "user_plants");

    imageService.countAllImages();

    int newinput = plantId;

    if (_lastWateredDate != null) {
      print("_lastWateredDate: $_lastWateredDate");

      await plantManagementService.addRecord(PlantManagementRecord(
        catalogNumber: newinput,
        managementDate: _lastWateredDate!,
        managementType: ManagementType.Watering,
        details: 'Watering details',
        plantId: newinput,
      ));
    }

    if (_lastFertilizedDate != null) {
      print("_lastFertilizedDate: $_lastFertilizedDate");

      await plantManagementService.addRecord(PlantManagementRecord(
        catalogNumber: newinput,
        managementDate: _lastFertilizedDate!,
        managementType: ManagementType.Fertilizing,
        details: 'Fertilizing details',
        plantId: newinput,
      ));
    }

    if (_lastRepottedDate != null) {
      print("_lastRepottedDate: $_lastRepottedDate");

      await plantManagementService.addRecord(PlantManagementRecord(
        catalogNumber: newinput,
        managementDate: _lastRepottedDate!,
        managementType: ManagementType.Repotting,
        details: 'Repotting details',
        plantId: newinput,
      ));
    }

    if (_lastPrunedDate != null) {
      print("_lastPrunedDate: $_lastPrunedDate");

      await plantManagementService.addRecord(PlantManagementRecord(
        catalogNumber: newinput,
        managementDate: _lastPrunedDate!,
        managementType: ManagementType.Pruning,
        details: 'Pruning details',
        plantId: newinput,
      ));
    }


    if (onRefresh != null) {
      onRefresh();
    }
    print('식물 등록 완료');
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
                      Uri.parse('https://d8f2-35-243-183-183.ngrok-free.app/plant_register'),
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

                // Future<void> _pickImage(ImageSource source) async {
                //   final pickedFile = await picker.pickImage(source: source);
                //   if (pickedFile != null) {
                //     final selectedImage = File(pickedFile.path);
                //     setState(() {
                //       _image = selectedImage; // 이미지를 표시하기 위해 설정
                //     });
                //     await _uploadImage(selectedImage); // 이미지를 서버로 전송
                //   }
                // }


                Future<void> _pickImage(ImageSource source) async {

                  print("asdsasdasdas");
                  print("asdsasdasdas");
                  print("asdsasdasdas");
                  print("asdsasdasdas");
                  print("asdsasdasdas");
                  print("asdsasdasdas");
                  print("asdsasdasdas");
                  print("asdsasdasdas");

                  final pickedFile = await picker.pickImage(source: source);
                  if (pickedFile != null) {
                    final selectedImage = File(pickedFile.path);

                    setState(() {
                      _image = selectedImage; // 이미지를 표시하기 위해 설정
                    });

                    // 파일 이름을 지정 (예: pickedFile.name 사용 또는 고유한 파일명 생성)
                    final fileName = p.basename(pickedFile.path);

                    // ImageService 인스턴스 생성
                    final imageService = ImageService();

                    // 이미지를 로컬 저장소에 저장
                    // await imageService.saveImage(selectedImage, "photos", fileName);


                    int inpudd = await imageService.countAllImages();

                    print(inpudd);
                    print(inpudd);
                    print(inpudd);
                    print(inpudd);
                    print(inpudd);
                    print(inpudd);

                    localImage = selectedImage;
                    // 저장 후 이미지를 서버로 전송
                    await _uploadImage(selectedImage);
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
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Center(
                                  child: Text(
                                    '식물 등록',
                                    style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold
                                    ),
                                  ),
                                ),
                                SizedBox(height: 20),
                                // 이미지 버튼
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                  children: [
                                    _buildImageButton(
                                      icon: Icons.camera_alt,
                                      label: '사진 촬영',
                                      onPressed: _isUploading
                                          ? null
                                          : () => _pickImage(ImageSource.camera),
                                    ),
                                    _buildImageButton(
                                      icon: Icons.photo_library,
                                      label: '앨범에서 선택',
                                      onPressed: _isUploading
                                          ? null
                                          : () => _pickImage(ImageSource.gallery),
                                    ),
                                  ],
                                ),
                                // ElevatedButton(
                                //   onPressed: () => _pickImage(ImageSource.camera),
                                //   child: Text('사진 촬영'),
                                // ),
                                // ElevatedButton(
                                //   onPressed: () => _pickImage(ImageSource.gallery),
                                //   child: Text('갤러리에서 선택'),
                                // ),
                                SizedBox(height: 20),

// 업로드 진행 표시
                                if (_isUploading)
                                  Center(child: CircularProgressIndicator()),
                                if (_image != null && !_isUploading) ...[
                                  Center(
                                    child: Stack(
                                      children: [
                                        Container(
                                          width: 200,
                                          height: 200,
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(10),
                                            image: DecorationImage(
                                              image: FileImage(_image!),
                                              fit: BoxFit.cover,
                                            ),
                                          ),
                                        ),
                                        Positioned(
                                          right: 0,
                                          top: 0,
                                          child: IconButton(
                                            icon: Icon(Icons.close, color: Colors.red),
                                            onPressed: () {
                                              setState(() {
                                                _image = null;
                                                _plantName = '';
                                                _plantNameController.clear();
                                                _showImageInField = false; // 이미지 표시 플래그 초기화
                                              });
                                            },
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  SizedBox(height: 20),
                                ],

                                Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                                  child: _buildTextField(
                                    controller: _plantNameController,
                                    hintText: '', // 힌트 텍스트를 제거하고 서버에서 받아온 텍스트 사용
                                    label: '식물 이름',
                                    enabled: !_isUploading,
                                  ),
                                ),
                                // TextField(
                                //   controller: _plantNameController,
                                //   decoration: InputDecoration(
                                //     labelText: '식물 이름',
                                //     border: OutlineInputBorder(),
                                //   ),
                                // ),
                                SizedBox(height: 20),

                                Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                                  child: GestureDetector(
                                  onTap: () async
                                    {
                                      _lastWateredDate = await _pickDate(context, _lastWateredController);
                                      print("_lastWateredController");
                                      print("_lastWateredController");
                                    },
                                    child: AbsorbPointer(
                                      child: _buildTextField(
                                        controller: _lastWateredController,
                                        hintText: '날짜를 선택하세요',
                                        label: '마지막 물준날',
                                        enabled: !_isUploading,
                                      ),
                                    ),
                                  ),
                                ),

                                // Text('마지막 물 준 날짜'),
                                // TextField(
                                //   controller: _lastWateredController,
                                //   readOnly: true,
                                //   onTap: () async
                                //   {
                                //     _lastWateredDate = await _pickDate(context, _lastWateredController);
                                //     print("_lastWateredController");
                                //     print("_lastWateredController");
                                //     },
                                //   decoration: InputDecoration(
                                //     labelText: '날짜 선택',
                                //     border: OutlineInputBorder(),
                                //   ),
                                // ),

                                SizedBox(height: 20),

                                Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                                  child: GestureDetector(
                                      onTap: () async
                                      {
                                        _lastFertilizedDate = await _pickDate(context, _lastFertilizedController);
                                        print("_lastFertilizedController");
                                        print(_lastFertilizedController);
                                        },
                                    child: AbsorbPointer(
                                      child: _buildTextField(
                                        controller: _lastFertilizedController,
                                        hintText: '날짜를 선택하세요',
                                        label: '마지막 영양제',
                                        enabled: !_isUploading,
                                      ),
                                    ),
                                  ),
                                ),

                                // Text('마지막 영양제 준 날짜'),
                                // TextField(
                                //   controller: _lastFertilizedController,
                                //   readOnly: true,
                                //   onTap: () async
                                //   {
                                //     _lastFertilizedDate = await _pickDate(context, _lastFertilizedController);
                                //     print("_lastFertilizedController");
                                //     print(_lastFertilizedController);
                                //     },
                                //   decoration: InputDecoration(
                                //     labelText: '날짜 선택',
                                //     border: OutlineInputBorder(),
                                //   ),
                                // ),

                                SizedBox(height: 20),

                                Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                                  child: GestureDetector(
                                    onTap: () async
                                    {
                                      _lastRepottedDate = await _pickDate(context, _lastRepottedController);
                                      print("_lastRepottedController");
                                      print(_lastRepottedController);
                                    },
                                    child: AbsorbPointer(
                                      child: _buildTextField(
                                        controller: _lastRepottedController,
                                        hintText: '날짜를 선택하세요',
                                        label: '마지막 분갈이',
                                        enabled: !_isUploading,
                                      ),
                                    ),
                                  ),
                                ),

                                // Text('마지막 분갈이 날짜'),
                                // TextField(
                                //   controller: _lastRepottedController,
                                //   readOnly: true,
                                //   onTap: () async
                                //   {
                                //     _lastRepottedDate = await _pickDate(context, _lastRepottedController);
                                //     print("_lastRepottedController");
                                //     print(_lastRepottedController);
                                //     },
                                //   decoration: InputDecoration(
                                //     labelText: '날짜 선택',
                                //     border: OutlineInputBorder(),
                                //   ),
                                // ),

                                SizedBox(height: 20),

                                Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                                  child: GestureDetector(
                                    onTap: () async
                                    {
                                      _lastPrunedDate = await _pickDate(context, _lastPrunedController);
                                      print("_lastPrunedController");
                                      print(_lastPrunedController);
                                    },
                                    child: AbsorbPointer(
                                      child: _buildTextField(
                                        controller: _lastPrunedController,
                                        hintText: '날짜를 선택하세요',
                                        label: '마지막 가지치기',
                                        enabled: !_isUploading,
                                      ),
                                    ),
                                  ),
                                ),

                                // Text('마지막 가지치기 날짜'),
                                // TextField(
                                //   controller: _lastPrunedController,
                                //   readOnly: true,
                                //   onTap: () async
                                //   {
                                //     _lastPrunedDate = await _pickDate(context, _lastPrunedController);
                                //     print("_lastPrunedController");
                                //     print(_lastPrunedController);
                                //   },
                                //   decoration: InputDecoration(
                                //     labelText: '날짜 선택',
                                //     border: OutlineInputBorder(),
                                //   ),
                                // ),
                                Padding(
                                  padding: const EdgeInsets.all(16.0),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                    children: [
                                      Expanded(
                                        child: OutlinedButton(
                                          onPressed: () {
                                            Navigator.pop(context);
                                          },
                                          child: Text('취소', style: TextStyle(fontSize: 25)),
                                          style: OutlinedButton.styleFrom(
                                            foregroundColor: Colors.grey,
                                            backgroundColor: Colors.white,
                                            shape: RoundedRectangleBorder(
                                              borderRadius: BorderRadius.circular(10),
                                            ),
                                            side: BorderSide(color: Colors.grey),
                                            minimumSize: Size(150, 50),
                                          ),
                                        ),
                                      ),
                                      SizedBox(width: 16),
                                      Expanded(
                                        child: ElevatedButton(
                                          onPressed: _isUploading ? null : () async {
                                            setState(() {
                                              _isUploading = true; // Start uploading
                                            });
                                            _registerPlant(); // Execute the registration
                                            print("asdasd");
                                            print("asdasd");
                                            print("asdasd");
                                            print("asdasd");
                                            Navigator.pop(context);
                                            setState(() {
                                              _isUploading = false; // Finish uploading
                                            });
                                          },
                                          child: Text('등록',
                                              style: TextStyle(
                                                  fontSize: 25, color: Colors.white)),
                                          style: ElevatedButton.styleFrom(
                                            backgroundColor: Colors.green,
                                            shape: RoundedRectangleBorder(
                                              borderRadius: BorderRadius.circular(10),
                                            ),
                                            minimumSize: Size(150, 50),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),

                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                    // Container(
                    //   padding: EdgeInsets.symmetric(vertical: 10),
                    //   child: Center(
                    //     child: ElevatedButton(
                    //       onPressed: _isUploading ? null : () async {
                    //         setState(() {
                    //           _isUploading = true; // Start uploading
                    //         });
                    //         _registerPlant(); // Execute the registration
                    //         print("asdasd");
                    //         print("asdasd");
                    //         print("asdasd");
                    //         print("asdasd");
                    //         Navigator.pop(context);
                    //         setState(() {
                    //           _isUploading = false; // Finish uploading
                    //         });
                    //       },
                    //
                    //       child: _isUploading
                    //           ? CircularProgressIndicator()
                    //           : Text('등록'),
                    //     ),
                    //   ),
                    // ),
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

Widget _buildImageButton({
  required IconData icon,
  required String label,
  required VoidCallback? onPressed,
}) {
  return Expanded(
    child: Container(
      decoration: BoxDecoration(
        border: Border(
          top: BorderSide(color: Color(0xffc2c2c2)),
          bottom: BorderSide(color: Color(0xffc2c2c2)),
        ),
      ),
      child: TextButton.icon(
        onPressed: onPressed,
        icon: Icon(icon, color: Color(0xff787878)),
        label: Text(
          label,
          style: TextStyle(
            color: Color(0xff333333),
            fontSize: 16,
          ),
        ),
        style: TextButton.styleFrom(
          padding: EdgeInsets.symmetric(vertical: 10),
        ),
      ),
    ),
  );
}

// 텍스트 필드를 생성하는 위젯
Widget _buildTextField({
  required String label,
  required String hintText,
  required TextEditingController controller,
  required bool enabled,
}) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Padding(
        padding: const EdgeInsets.only(left: 6),
        child: Text(
          label,
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
      ),
      SizedBox(height: 10),
      TextField(
        controller: controller,
        enabled: enabled,
        decoration: InputDecoration(
          hintText: hintText,
          border: OutlineInputBorder(),
          contentPadding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
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


