import 'package:flutter/material.dart';

class PlantDetailPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xff779d60),
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios, color: Colors.white),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text('몬스테라', style: TextStyle(color: Colors.white)),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Stack(
              clipBehavior: Clip.none, // Positioned가 Stack 밖으로 나갈 수 있도록 함
              children: [
                Container(
                  width: double.infinity,
                  height: 25,
                  color: Color(0xff779d60),
                ),
                Positioned(
                  bottom: -1, // 위쪽 위치 조정
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    height: 20,
                    padding: EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(20),
                        topRight: Radius.circular(20),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                children: [
                  Text(
                    'Monstera',
                    style: TextStyle(
                      fontSize: 20,
                      color: Color(0xffe7ece4),
                    ),
                  ),
                  SizedBox(height: 16),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(15.0),
                    child: Image.asset(
                      'images/plant_0.jpg',
                      width: MediaQuery.of(context).size.width * 0.85,
                      height: MediaQuery.of(context).size.width * 0.85,
                      fit: BoxFit.cover,
                    ),
                  ),
                  SizedBox(height: 16),
                  Text(
                    '• 큰 잎과 독특한 구멍이 있는 열대 식물입니다.\n'
                        '• 실내에서 쉽게 키울 수 있어 인기가 많습니다.\n'
                        '• 공기 정화 능력도 뛰어납니다.\n'
                        '• 인테리어에 포인트를 주기에 좋습니다.',
                    style: TextStyle(fontSize: 16, color: Color(0xff595959)),
                  ),
                  SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Expanded(
                        child: Container(
                          padding: EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            color: Color(0xfffafafa),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Column(
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(Icons.water_drop, color: Colors.lightBlueAccent),
                                  SizedBox(width: 5),
                                  Text(
                                    '물주기:',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(color: Color(0xff595959), fontSize: 16),
                                  ),
                                ],
                              ),
                              SizedBox(height: 5),
                              Text(
                                '10 Day',
                                textAlign: TextAlign.center,
                                style: TextStyle(color: Color(0xff595959),
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(width: 10),
                      Expanded(
                        child: Container(
                          padding: EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            color: Color(0xfffafafa),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Column(
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(Icons.wb_sunny, color: Colors.yellow),
                                  SizedBox(width: 5),
                                  Text(
                                    '온도:',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(color: Color(0xff595959), fontSize: 16),
                                  ),
                                ],
                              ),
                              SizedBox(height: 5),
                              Text(
                                '18-30℃',
                                textAlign: TextAlign.center,
                                style: TextStyle(color: Color(0xff595959),
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),

                  SizedBox(height: 10),
                  Container(
                    width: double.infinity,
                    padding: EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Color(0xfffafafa),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.spa, color: Colors.green),
                            SizedBox(width: 5),
                            Text(
                              '식물 위치:',
                              textAlign: TextAlign.center,
                              style: TextStyle(color: Color(0xff595959), fontSize: 16),
                            ),
                          ],
                        ),
                        SizedBox(height: 5),
                        Text(
                          '반그늘, 차광된 빛이 들어오는 밝은 그늘',
                          textAlign: TextAlign.center,
                          style: TextStyle(color: Color(0xff595959),
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
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
            Container(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  Container(
                    padding: EdgeInsets.only(bottom: 12, left: 10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '몬스테라 심기 및 재배',
                          style: TextStyle(
                            fontSize: 21,
                            fontWeight: FontWeight.bold,
                          ),
                        ),

                        Table(
                          // border: TableBorder.all(color: Colors.grey), // 테두리 색상 설정
                          columnWidths: {
                            0: FlexColumnWidth(2), // 첫 번째 열 비율
                            1: FlexColumnWidth(3), // 두 번째 열 비율
                          },
                          children: [
                            _buildTableRow("강도", "어려움", true),
                            _buildTableRow("관리 수준", "낮음", false),
                            _buildTableRow("관리 난이도", "쉬움", true),
                            _buildTableRow("수명", "다년생", false),
                            _buildTableRow("급수 일정", "매주", true),
                            _buildTableRow("햇빛 요건", "부분 햇빛", false),
                            _buildTableRow("토양 pH", "5.5-6.5", true),
                            _buildTableRow("심는 시기", "사계절", false),
                            _buildTableRow("내한성 구역", "10-13", true),
                            _buildTableRow("독성", "사람 & 동물에게 유독함", false),
                          ],
                        ),

                      ],
                    ),
                  ),
                  SizedBox(height: 12),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// 테이블 행 생성 메서드
TableRow _buildTableRow(String parameter, String value, bool isOdd) {
  return TableRow(
    decoration: BoxDecoration(
      color: isOdd ? Colors.grey[200] : Colors.white, // 홀수 행에 회색 배경색 적용
    ),
    children: [
      Container(
        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
        child: Text(parameter, style: TextStyle(fontSize: 16)),
      ),
      Container(
        padding: const EdgeInsets.all(8.0),
        child: Text(
          value,
          style: TextStyle(fontSize: 16),
          textAlign: TextAlign.right,
        ),
      ),
    ],
  );
}
