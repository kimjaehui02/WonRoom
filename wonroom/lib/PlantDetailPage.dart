import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class PlantDetailPage extends StatelessWidget {
  final PageController _pageController = PageController();
  final Map<String, dynamic> data;

  PlantDetailPage({required this.data});

  @override
  Widget build(BuildContext context) {
    final careTips = (data['care_tips'] as List<dynamic>? ?? [])
        .map((tip) => tip['content'] as String)
        .toList();

    // "pasete" 필드를 쉼표로 분리하여 리스트로 변환
    final pestInfo = (data['pasete'] as String? ?? '')
        .split(',')
        .map((pest) => pest.trim()) // 공백 제거
        .toList();

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
        title: Text(
            '${data['name'] ?? '정보가 없습니다.'}',
            style: TextStyle(color: Colors.white)
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Stack(
              clipBehavior: Clip.none,
              children: [
                Container(
                  width: double.infinity,
                  height: 25,
                  color: Color(0xff779d60),
                ),
                Positioned(
                  bottom: -1,
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
                    '',
                    style: TextStyle(
                      fontSize: 0,
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
                    '${(data['functional_info'] as List<dynamic>?)?.map((info) => '• $info').join('\n') ?? '정보가 없습니다.'}',
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
                                '${data['watering'] ?? '정보가 없습니다.'}',
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
                                    style: TextStyle(color: Color(0xff595959), fontSize: 16),
                                  ),
                                ],
                              ),
                              SizedBox(height: 5),
                              Text(
                                '${data['temperature'] ?? '정보가 없습니다.'}',
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
                              style: TextStyle(color: Color(0xff595959), fontSize: 16),
                            ),
                          ],
                        ),
                        SizedBox(height: 5),
                        Text(
                          '${data['location'] ?? '정보가 없습니다.'}',
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
                      '${data['name'] ?? '정보가 없습니다.'} 심기 및 재배',
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
                      _buildTableData().length,
                          (index) {
                        return _buildTableRow(
                          _buildTableData()[index]['parameter']!,
                          _buildTableData()[index]['value']!,
                          index,
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 24, bottom: 24),
              width: MediaQuery.of(context).size.width,
              height: 8,
              color: Color(0xffeeeeee),
            ),
            Column(
              children: [
                Container(
                  padding: EdgeInsets.all(16),
                  child: Column(
                    children: [
                      ConstrainedBox(
                        constraints: BoxConstraints(
                          maxHeight: 260,
                        ),
                        child: PageView.builder(
                          controller: _pageController,
                          itemCount: careTips.length,
                          itemBuilder: (context, index) {
                            final tip = careTips[index];
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
                                    tip,
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      color: Color(0xff595959),
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
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
                        controller: _pageController,
                        count: careTips.length,
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
                      '${data['name'] ?? '정보가 없습니다.'}에 대한 일반적인 해충 및 질병',
                      style: TextStyle(
                        fontSize: 21,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Container(
                    height: 200,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: pestInfo.length,
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
                                        'images/pest_${index}.jpg'), // 이미지 경로 수정 필요
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                              SizedBox(height: 8),
                              Padding(
                                padding: const EdgeInsets.only(
                                    left: 10, right: 10, top: 4),
                                child: Text(
                                  '${pestInfo[index]}', // 해충/질병 이름 표시
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

  List<Map<String, String>> _buildTableData() {
    return [
      {"parameter": "생장 속도", "value": data['growth_rate'] ?? '정보가 없습니다.'},
      {"parameter": "관리 수준", "value": data['management_level'] ?? '정보가 없습니다.'},
      {"parameter": "생육 형태", "value": data['growth_form'] ?? '정보가 없습니다.'},
      {"parameter": "습도", "value": data['humidity'] ?? '정보가 없습니다.'},
      {"parameter": "급수 일정", "value": data['watering'] ?? '정보가 없습니다.'},
      {"parameter": "광 요구도", "value": data['light_requirement'] ?? '정보가 없습니다.'},
      {"parameter": "비료 정보", "value": data['fertilizer_info'] ?? '정보가 없습니다.'},
      {"parameter": "번식 방법", "value": data['propagation_method'] ?? '정보가 없습니다.'},
      {"parameter": "냄새", "value": data['odor'] ?? '정보가 없습니다.'},
      {"parameter": "독성", "value": data['toxicity'] ?? '정보가 없습니다.'},
    ];
  }

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

  Widget _buildTableCell(String text, TextAlign textAlign) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
      ),
      child: Text(
        text,
        style: TextStyle(fontSize: 16),
        textAlign: textAlign,
      ),
    );
  }
}
