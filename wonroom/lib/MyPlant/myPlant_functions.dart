import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:wonroom/DB/plant_management_records/plant_management_model.dart';
import 'package:wonroom/DB/plant_management_records/plant_management_records_service.dart';


class PlantAction {
  final String label;
  final IconData icon;
  final String actionDate;
  final String imageAsset; // 이미지가 필요한 경우

  PlantAction({
    required this.label,
    this.icon = Icons.help, // 기본 아이콘
    this.actionDate = "N/A",
    this.imageAsset = "",
  });
}

class Record {
  final String date;
  final bool hasRecord;

  Record({
    required this.date,
    required this.hasRecord,
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
List<Widget> buildPlantActionContainers(List<PlantAction> actions, _id, _loading) {
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
            onPressed: () async
            {
              PlantManagementService _pms = new PlantManagementService();

              _pms.getRecords(_id).;

              ManagementType _type;

              switch (action.label) {
                case '물주기':
                  _type = ManagementType.Watering;
                case '영양제':
                  _type =  ManagementType.Fertilizing;
                case '가지치기':
                  _type =  ManagementType.Pruning;
                case '분갈이':
                  _type =  ManagementType.Repotting;
                case '진단':
                  _type =  ManagementType.Diagnosis;
                default:
                  throw ArgumentError('Unknown label: _type');
              }

              PlantManagementRecord _pmr = new PlantManagementRecord(
                  catalogNumber: 0,
                  managementDate: DateTime.now(),
                  managementType: _type,
                  details: "세부사항",
                  plantId: _id
              );

              await _pms.addRecord(_pmr);

              _loading();

            },
            icon: action.imageAsset.isNotEmpty
                ? Image.asset(
              action.imageAsset,
              width: 18,
              height: 18,
            )
                : Icon(
              action.icon,
              size: 18,
              color: Colors.lightBlueAccent,
            ),
            label: Text(
              action.label,
              style: TextStyle(color: Color(0xff787878)),
            ),
            style: OutlinedButton.styleFrom(
              side: BorderSide(color: Color(0xffc2c2c2)),
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

Widget buildRecordSection({
  required BuildContext context,
  required String title,
  required Widget icon,
  required List<Record> records,
}) {
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
              icon,
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
          records.isEmpty
              ? Container(
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
              : Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: records.map((record) => buildTimelineItem(record.date, record.hasRecord)).toList(),
          ),
        ],
      ),
    ),
  );
}

Widget buildTimelineItem(String date, bool hasRecord) {
  return Expanded(
    child: Column(
      children: [
        Container(
          height: 2,
          color: hasRecord ? Colors.blue : Colors.grey,
        ),
        SizedBox(height: 4),
        Text(
          date,
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    ),
  );
}



/*

[
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

                        ]


*/

