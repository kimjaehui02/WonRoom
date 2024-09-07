import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:wonroom/DB/plant_management_records/plant_management_model.dart';
import 'package:wonroom/DB/plant_management_records/plant_management_records_service.dart';
import 'package:wonroom/myPlantNull.dart';


class PlantAction {
  final String label;
  final IconData icon;
  final String actionDate;
  final String imageAsset; // 이미지가 필요한 경우
  bool? active = true;

  PlantAction({
    required this.label,
    this.icon = Icons.help, // 기본 아이콘
    this.actionDate = "N/A",
    this.imageAsset = "",
    this.active = true
  });
}


List<Widget> menuButton(int count, black, setState, _userPlants)
{
  return List.generate(count, (index) {
    return Container(
      margin: EdgeInsets.only(right: 10),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: index == black ? Color(0xff595959) : Colors.white, // 배경 색상 // 배경 색상
          padding: EdgeInsets.symmetric(vertical: 8, horizontal: 20), // 내부 여백
          shape: RoundedRectangleBorder( // 테두리 모양
            borderRadius: BorderRadius.circular(20),
          ),
        ),
        onPressed: () {
          // 버튼 클릭 시 실행될 코드
          print("도감1");
          print(black);

          // black = index;
          setState(index);
          print(black);
          print("도감1");
          print("도감1");
          print("도감1");
        },
        child: Text(
          // ('도감' + (index+1).toString()),
            _userPlants[index].diaryTitle ?? 'Default Title',
          style: TextStyle(color: index != black ? Color(0xff595959) : Colors.white), // 텍스트 스타일
        ),
      ),
    );
  });
}


// PlantAction을 매개변수로 받아 컨테이너를 생성하는 함수
// 사진 바로 아래의 일정들을 표기해주는 역할을 한다
List<Widget> buildPlantActionContainers(
    List<PlantAction> actions,
    int _id,  // int로 수정
    Function() _loading,
    Function(int) _updatePlant,
    int index,
    Future<void> Function(String, int, int, diagnosis) _getImageFromCamera,
    diagnosis detailss
    ) {
  return actions.map((action) {
    return Container(
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
            onPressed: () async {
              if (action.label != '진단') {
                // 버튼의 로직은 그대로 유지
                await plants(action.label, _id, _loading, detailss);
                _updatePlant(index);
              } else {
                // Future<void> Function(int, Function(), Function(int), diagnosis) _getImageFromCamera,

                print(_id);
                print(_updatePlant(index));
                print(index);
                print(detailss);
                await _getImageFromCamera(action.label, _id, index, detailss);
                // 진단 결과를 사용해서 추가 작업을 수행할 수 있습니다.
                // 예: await registerDiagnosis(_diagnosis.getstring());
              }
            },
            icon: action.imageAsset.isNotEmpty
                ? Image.asset(
              action.imageAsset,
              width: 18,
              height: 18,
              color: (action.active ?? true) ? null : Colors.grey[300],
            )
                : Icon(
              action.icon,
              size: 18,
              color: (action.active ?? true) ? Colors.lightBlueAccent : Colors.grey[300],
            ),
            label: Text(
              action.label,
              style: TextStyle(
                color: (action.active ?? true) ? Color(0xff787878) : Colors.grey[300],
              ),
            ),
            style: OutlinedButton.styleFrom(
              side: BorderSide(
                color: (action.active ?? true) ? Color(0xffc2c2c2) : Colors.grey[300]!,
              ),
            ),
          ),
          SizedBox(width: 20),
          RichText(
            text: TextSpan(
              text: action.actionDate.contains("다음 권장 날짜")
                  ? '다음 권장 날짜 : '
                  : '마지막 활동 날짜 : ',
              style: TextStyle(
                color: Color(0xffc2c2c2),
              ),
              children: [
                TextSpan(
                  text: action.actionDate,
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
    );
  }).toList();
}


// 얘는 무슨함수이냐
// 플랜
Future<bool> plants(String label, int _id, _loading, diagnosis detailss)async
{
  bool returnbool = false;

  int numb = 0;
  try {
    // 디버깅용 출력
    print("Starting action...");

    // 일정 테이블 매니저 초기화
    PlantManagementService _pms = PlantManagementService();
    print("PlantManagementService _pms = new PlantManagementService();");

    // 어떤 종류의 일정인지 타입을 확인
    ManagementType _type;

    // 스위치문으로 일정 타입 결정
    switch (label)
        {
      case '물주기':
        numb = 1;
        _type = ManagementType.Watering;
        break;
      case '영양제':
        numb = 2;
        _type = ManagementType.Fertilizing;
        break;
      case '가지치기':
        numb = 3;
        _type = ManagementType.Pruning;
        break;
      case '분갈이':
        numb = 4;
        _type = ManagementType.Repotting;
        break;
      case '진단':
        numb = 5;
        _type = ManagementType.Diagnosis;
        break;
      default:
        throw ArgumentError('Unknown label: ${label}');
    }

    // 일정 데이터 가져오기
    List<PlantManagementRecord> _check = await _pms.getRecords(_id);
    print("List<PlantManagementRecord> _check = await _pms.getRecords(_id);");

    // 오늘 날짜와 같은 일정이 있는지 확인
    bool shouldAddRecord = true; // 기본적으로 레코드를 추가하도록 설정
    if (_check != null && _check.isNotEmpty)
    {
      // 같은 날짜와 같은 관리 타입의 레코드가 있는지 확인
      for (var record in _check) {
        bool isToday = _pms.isDateToday(record.managementDate);
        bool isSameType = record.managementType == _type;

        if (isToday && isSameType) {
          // 해당 레코드 삭제
          await _pms.deleteRecord(record.recordId ?? -1);
          print("Record ${record.recordId} has been deleted.");
          shouldAddRecord = false; // 레코드가 삭제되었으므로 새로운 레코드를 추가하지 않음

          break; // 루프 종료
        }


      }
    }

    // 새로운 레코드 추가 조건 확인
    if (shouldAddRecord) {
      // 새로운 일정 모델 생성
      PlantManagementRecord _pmr = PlantManagementRecord(
          catalogNumber: 0,
          managementDate: DateTime.now(),
          managementType: _type,
          details: detailss.getstring(),
          plantId: _id
      );

      // 서버에 일정 추가
      await _pms.addRecord(_pmr);
      print("New record has been added.");
    }

    // 화면 업데이트
    if(_loading != null)
      {
        _loading();
      }


  } catch (e) {
    // 예외 처리
    print("An error occurred: $e");
  }

  return returnbool;
}

