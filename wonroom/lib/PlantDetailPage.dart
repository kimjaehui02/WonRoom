import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

List<int> intList = List<int>.generate(6, (index) => index++, growable: false);

class PlantDetailPage extends StatelessWidget {
  final PageController _pageController = PageController();
  String analysisResult = "플랜테라";
  // PlantDetailPage({required this.analysisResult});
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
                        '• 인테리어에 포인트를 주기에 좋습니다.\n'
                        '${analysisResult}',
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
                                  Icon(Icons.water_drop,
                                      color: Colors.lightBlueAccent),
                                  SizedBox(width: 5),
                                  Text(
                                    '물주기:',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        color: Color(0xff595959), fontSize: 16),
                                  ),
                                ],
                              ),
                              SizedBox(height: 5),
                              Text(
                                '10 Day',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: Color(0xff595959),
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
                                    style: TextStyle(
                                        color: Color(0xff595959), fontSize: 16),
                                  ),
                                ],
                              ),
                              SizedBox(height: 5),
                              Text(
                                '18-30℃',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: Color(0xff595959),
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
                              style: TextStyle(
                                  color: Color(0xff595959), fontSize: 16),
                            ),
                          ],
                        ),
                        SizedBox(height: 5),
                        Text(
                          '반그늘, 차광된 빛이 들어오는 밝은 그늘',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Color(0xff595959),
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
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding: EdgeInsets.only(bottom: 12, left: 10),
                    child: Text(
                      '몬스테라 심기 및 재배',
                      style: TextStyle(
                        fontSize: 21,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  SizedBox(height: 12),
                  Table(
                    columnWidths: {
                      0: FlexColumnWidth(2),
                      1: FlexColumnWidth(3),
                    },
                    children: List<TableRow>.generate(
                      _tableData.length,
                          (index) {
                        return _buildTableRow(
                          _tableData[index]['parameter']!,
                          _tableData[index]['value']!,
                          index,
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),

            // 구분
            Container(
              margin: EdgeInsets.only(top: 24, bottom: 24),
              width: MediaQuery.of(context).size.width,
              height: 8,
              color: Color(0xffeeeeee),
            ),

            // PageView와 SmoothPageIndicator 추가
            Column(
              children: [
                // PageView.builder가 내부 요소의 크기에 맞게 조정
                Container(
                  padding: EdgeInsets.all(16), // Padding around the PageView
                  child: Column(
                    children: [
                      ConstrainedBox(
                        constraints: BoxConstraints(
                          maxHeight: 260,
                        ),
                        child: PageView.builder(
                          controller: _pageController,
                          itemCount: 3, // 카드 개수
                          itemBuilder: (context, index) {
                            return Container(
                              padding: EdgeInsets.only(
                                  left: 30, right: 30, top: 30, bottom: 40),
                              decoration: BoxDecoration(
                                color: Color(0xfffafafa),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Column(
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Icon(
                                        Icons.tips_and_updates_sharp,
                                        color: Colors.amber,
                                        size: 26,
                                      ),
                                      SizedBox(width: 5),
                                      Text(
                                        '식물 관리 Tip',
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                            color: Color(0xff595959),
                                            fontSize: 20),
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: 20),
                                  Text(
                                    '\" 적절한 빛 관리 \"',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      color: Color(0xff595959),
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  SizedBox(height: 10),
                                  Align(
                                    alignment: Alignment.centerLeft,
                                    child: RichText(
                                      text: TextSpan(
                                        style: TextStyle(
                                          height: 2,
                                          color: Color(0xff595959),
                                          fontSize: 16,
                                        ),
                                        children: [
                                          TextSpan(
                                              text:'밝은 간접광을 선호하지만 직사광선은 피하세요.\n'),
                                          TextSpan(
                                              text:'빛이 부족하면 성장이 느려질 수 있습니다.\n'),
                                          TextSpan(text: '통풍이 잘 되는 곳에 두면 이상적입니다.'),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            );
                          },
                        ),
                      ),
                      SizedBox(height: 16),
                      SmoothPageIndicator(
                        controller: _pageController, // PageView의 controller를 연결
                        count: 3,
                        effect: ExpandingDotsEffect(
                          dotHeight: 8,
                          dotWidth: 8,
                          activeDotColor: Color(0xff779d60),
                          dotColor: Colors.grey,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),



            // 구분

            Container(
              margin: EdgeInsets.only(top: 24, bottom: 24),
              width: MediaQuery.of(context).size.width,
              height: 8,
              color: Color(0xffeeeeee),
            ),

            Padding(
              padding: const EdgeInsets.only(left: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding: EdgeInsets.only(top: 24, bottom: 12, left: 10),
                    child: Text(
                      '몬스테라에 대한 일반적인 해충 및 질병',
                      style: TextStyle(
                        fontSize: 21,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Container(
                    height: 200, // ListView의 높이를 고정합니다.
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: intList.length,
                      itemBuilder: (context, index) {
                        return Container(
                          width: MediaQuery.of(context).size.width * 0.35,
                          margin: EdgeInsets.only(right: 8.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                height: 150,
                                decoration: BoxDecoration(
                                  color: Colors.blueAccent,
                                  borderRadius: BorderRadius.circular(8.0),
                                  image: DecorationImage(
                                    image: AssetImage(
                                        'images/plant_${intList[index]}.jpg'),
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                              SizedBox(height: 8),
                              Padding(
                                padding: const EdgeInsets.only(
                                    left: 10, right: 10, top: 4),
                                child: Text(
                                  '${intList[index]}번째',
                                  style: TextStyle(
                                      color: Colors.black, fontSize: 16),
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),

            SizedBox(height: 24,)
          ],
        ),
      ),
    );
  }
}

// 테이블 데이터
final List<Map<String, String>> _tableData = [
  {"parameter": "강도", "value": "어려움"},
  {"parameter": "관리 수준", "value": "낮음"},
  {"parameter": "관리 난이도", "value": "쉬움"},
  {"parameter": "수명", "value": "다년생"},
  {"parameter": "급수 일정", "value": "매주"},
  {"parameter": "햇빛 요건", "value": "부분 햇빛"},
  {"parameter": "토양 pH", "value": "5.5-6.5"},
  {"parameter": "심는 시기", "value": "사계절"},
  {"parameter": "내한성 구역", "value": "10-13"},
  {"parameter": "독성", "value": "사람 & 동물에게 유독함"},
];

// 테이블 행 생성 메서드
TableRow _buildTableRow(String parameter, String value, int index) {
  return TableRow(
    decoration: BoxDecoration(
      color: index.isOdd ? Colors.white : Color(0xffeeeeee),
      borderRadius: BorderRadius.circular(5),
    ),
    children: [
      _buildTableCell(parameter, TextAlign.left),
      _buildTableCell(value, TextAlign.right),
    ],
  );
}

// 테이블 셀 생성 메서드
Widget _buildTableCell(String text, TextAlign textAlign) {
  return Container(
    padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(5), // 셀의 둥근 모서리 설정
    ),
    child: Text(
      text,
      style: TextStyle(fontSize: 16),
      textAlign: textAlign,
    ),
  );
}
