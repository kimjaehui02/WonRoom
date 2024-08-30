import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

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


List<Widget> menuButton(int count, black, setState)
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
          ('도감' + (index+1).toString()),
          style: TextStyle(color: index != black ? Color(0xff595959) : Colors.white), // 텍스트 스타일
        ),
      ),
    );
  });
}


// PlantAction을 매개변수로 받아 컨테이너를 생성하는 함수
List<Widget> buildPlantActionContainers(List<PlantAction> actions) {
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
            onPressed: () {},
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


