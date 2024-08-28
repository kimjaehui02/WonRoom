

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

List<Widget> menuButton(int count)
{
  return List.generate(count, (index) {
    return Container(
      margin: EdgeInsets.only(right: 10),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: Color(0xff595959), // 배경 색상
          padding: EdgeInsets.symmetric(vertical: 8, horizontal: 20), // 내부 여백
          shape: RoundedRectangleBorder( // 테두리 모양
            borderRadius: BorderRadius.circular(20),
          ),
        ),
        onPressed: () {
          // 버튼 클릭 시 실행될 코드
          print("도감1");
          print("도감1");
          print("도감1");
          print("도감1");
        },
        child: Text(
          '도감1',
          style: TextStyle(color: Colors.white), // 텍스트 스타일
        ),
      ),
    );
  });
}



