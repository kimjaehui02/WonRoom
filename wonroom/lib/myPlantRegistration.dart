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
            return Column(
              children: [
                Expanded(
                  child: SingleChildScrollView(
                    controller: scrollController, // 스크롤 컨트롤러 연결
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Center(
                          child: Container(
                            width: 60,
                            height: 5,
                            decoration: BoxDecoration(
                              color: Colors.grey[300], // 드래그 핸들 색상
                              borderRadius: BorderRadius.circular(10), // 핸들 둥글게
                            ),
                          ),
                        ),
                        SizedBox(height: 16),
                        Center(
                          child: Text(
                            '식물 등록', // 제목
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        SizedBox(height: 20),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16.0),
                          child: _buildTextField(
                            controller: _plantNameController,
                            label: '식물 이름',
                            hintText: '파키라',
                          ),
                        ),
                        SizedBox(height: 20),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16.0),
                          child: _buildDatePicker(
                            context,
                            label: '마지막 물준날',
                            controller: _lastWateredController,
                            onDateSelected: (date) => _lastWateredDate = date,
                          ),
                        ),
                        SizedBox(height: 20),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16.0),
                          child: _buildDatePicker(
                            context,
                            label: '마지막 영양제',
                            controller: _lastFertilizedController,
                            onDateSelected: (date) => _lastFertilizedDate = date,
                          ),
                        ),
                        SizedBox(height: 20),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16.0),
                          child: _buildDatePicker(
                            context,
                            label: '마지막 분갈이',
                            controller: _lastRepottedController,
                            onDateSelected: (date) => _lastRepottedDate = date,
                          ),
                        ),
                        SizedBox(height: 24),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16.0),
                          child: _buildDatePicker(
                            context,
                            label: '마지막 가지치기',
                            controller: _lastPrunedController,
                            onDateSelected: (date) => _lastPrunedDate = date,
                          ),
                        ),
                        SizedBox(height: 24),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Expanded(
                        child: OutlinedButton(
                          onPressed: () {
                            Navigator.pop(context); // 취소 버튼 클릭 시 모달 닫기
                          },
                          child: Text('취소', style: TextStyle(fontSize: 25)),
                          style: OutlinedButton.styleFrom(
                            foregroundColor: Colors.grey,
                            backgroundColor: Colors.white,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10), // 버튼 둥글게
                            ),
                            side: BorderSide(color: Colors.grey), // 버튼 테두리 색상
                            minimumSize: Size(150, 50), // 버튼 크기
                          ),
                        ),
                      ),
                      SizedBox(width: 16),
                      Expanded(
                        child: ElevatedButton(
                          onPressed: _registerPlant, // 등록 버튼 클릭 시 식물 등록 함수 호출
                          child: Text('등록', style: TextStyle(fontSize: 25, color: Colors.white)),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.green,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10), // 버튼 둥글게
                            ),
                            minimumSize: Size(150, 50), // 버튼 크기
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
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


