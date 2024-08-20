import 'package:flutter/material.dart';

class Myplant extends StatelessWidget {
  const Myplant({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('마이 도감', style: TextStyle(color: Colors.black)),
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios,
            color: Colors.grey,
          ),
          onPressed: () {
            // 뒤로가기 기능 (추후 구현 필요)
          },
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
              color: Color(0xffeeeeee),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Container(
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
                          },
                          child: Text(
                            '도감1',
                            style: TextStyle(color: Colors.white), // 텍스트 스타일
                          ),
                        ),
                      ),

                      Container(
                        margin: EdgeInsets.only(right: 10),
                        child: OutlinedButton(
                          style: OutlinedButton.styleFrom(
                            backgroundColor: Colors.white, // 배경 색상
                            padding: EdgeInsets.symmetric(vertical: 8, horizontal: 20), // 내부 여백
                            side: BorderSide( // 테두리 스타일
                              color: Color(0xffc2c2c2), // 테두리 색상
                              width: 1, // 테두리 두께
                            ),
                            shape: RoundedRectangleBorder( // 모서리 둥글게
                              borderRadius: BorderRadius.circular(20),
                            ),
                          ),
                          onPressed: () {
                            // 버튼 클릭 시 실행될 코드
                          },
                          child: Text(
                            '도감2',
                            style: TextStyle(color: Color(0xff787878)), // 텍스트 스타일
                          ),
                        ),
                      ),

                    ],
                  ),

                  // 도감 추가
                  ElevatedButton(
                    onPressed: () {
                      // 버튼 클릭 시 실행될 코드
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color(0xff86b26a), // 배경 색상
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(50), // 모서리를 둥글게
                      ),
                      padding: EdgeInsets.all(0), // 패딩 없앰
                      minimumSize: Size(36, 36), // 버튼의 최소 크기
                    ),
                    child: Icon(
                      Icons.add,
                      color: Colors.white,
                    ),
                  )
                ],
              ),
            ),
            Container(
              color: Colors.white,
              child: Column(
                children: [
                  SizedBox(height: 32),
                  Column(
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: Container(
                              padding: EdgeInsets.only(left: 50), // 오른쪽 여백 추가
                              child: Text(
                                '몬스테라',
                                style: TextStyle(
                                  fontSize: 24,
                                  fontWeight: FontWeight.bold,
                                ),
                                textAlign: TextAlign.center, // 텍스트 중앙 정렬
                              ),
                            ),
                          ),
                          IconButton(
                            padding: EdgeInsets.only(right: 16), // 오른쪽 여백 추가
                            icon: Icon(Icons.more_vert, color: Color(0xff787878)),
                            onPressed: () {
                              // 아이콘 클릭 시 실행될 기능 구현
                            },
                          ),
                        ],
                      ),

                      SizedBox(height: 24),

                      Container(
                        width: MediaQuery.of(context).size.width * 0.8,
                        height: MediaQuery.of(context).size.width * 0.8,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.redAccent,
                          image: DecorationImage(
                            fit: BoxFit.fill,
                            image: AssetImage('images/img01.jpg'), // 로컬 이미지 경로
                          ),
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
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
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
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
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
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
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
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
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
                    ],
                  ),

                  // 구분
                  Container(
                    margin: EdgeInsets.only(top: 40),
                    width: MediaQuery.of(context).size.width,
                    height: 8,
                    color: Color(0xffeeeeee),
                  ),

                  Container(
                    padding: const EdgeInsets.all(32),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Text(
                              '이전 기록',
                              style: TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 24),

                        // 물주기 기록
                        Center(
                          child: Container(
                            width: MediaQuery.of(context).size.width,
                            padding: EdgeInsets.all(30),
                            color: Color(0xfffafafa),
                            child: Column(
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(
                                      Icons.water_drop,
                                      size: 32,
                                      color: Colors.lightBlueAccent,
                                    ),
                                    SizedBox(width: 4),
                                    Text(
                                      '물주기 기록',
                                      style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(height: 20),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    buildTimelineItem("03.19", true),
                                    buildTimelineItem("04.19", true),
                                    buildTimelineItem("05.19", true),
                                    buildTimelineItem("06.19", true),
                                    buildTimelineItem(" ", false),
                                  ],
                                )
                              ],
                            ),
                          ),
                        ),
                        SizedBox(height: 24),

                        // 영양제 기록
                        Center(
                          child: Container(
                            width: MediaQuery.of(context).size.width,
                            padding: EdgeInsets.all(30),
                            color: Color(0xfffafafa),
                            child: Column(
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Image.asset(
                                      'images/potion.png', // 영양제 아이콘
                                      width: 32,
                                      height: 32,
                                    ),
                                    SizedBox(width: 4),
                                    Text(
                                      '영양제 기록',
                                      style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(height: 20),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    buildTimelineItem("03.19", true),
                                    buildTimelineItem("04.19", true),
                                    buildTimelineItem(" ", false),
                                    buildTimelineItem(" ", false),
                                    buildTimelineItem(" ", false),
                                  ],
                                )
                              ],
                            ),
                          ),
                        ),
                        SizedBox(height: 24),

                        // 가지치기 기록
                        Center(
                          child: Container(
                            width: MediaQuery.of(context).size.width,
                            padding: EdgeInsets.all(30),
                            color: Color(0xfffafafa),
                            child: Column(
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Image.asset(
                                      'images/scissor.png', // 가지치기 아이콘
                                      width: 32,
                                      height: 32,
                                    ),
                                    SizedBox(width: 4),
                                    Text(
                                      '가지치기 기록',
                                      style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(height: 20),
                                Container(
                                  child: Column(
                                    children: [
                                      Text('기록이 없습니다.'),
                                      Text('기록을 추가해보세요.')
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                        SizedBox(height: 24),


                        // 분갈이 기록
                        Center(
                          child: Container(
                            width: MediaQuery.of(context).size.width,
                            padding: EdgeInsets.all(30),
                            color: Color(0xfffafafa),
                            child: Column(
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Image.asset(
                                      'images/soil.png', // 분갈이 아이콘
                                      width: 32,
                                      height: 32,
                                    ),
                                    SizedBox(width: 4),
                                    Text(
                                      '분갈이 기록',
                                      style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(height: 20),
                                Container(
                                  child: Column(
                                    children: [
                                      Text('기록이 없습니다.'),
                                      Text('기록을 추가해보세요.')
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),

                        SizedBox(height: 100,),

                        // 버튼
                        ElevatedButton(onPressed: (){

                        }, style: ElevatedButton.styleFrom(
                          backgroundColor: Color(0xff595959),
                          elevation: 0,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          minimumSize: const Size.fromHeight(50),
                        ),
                          child: const Text('도감 등록하기',
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.white,
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}


Widget buildTimelineItem(String date, bool isActive) {
  return Column(
    children: [
      Container(
        width: 16,
        height: 16,
        decoration: BoxDecoration(
          color: isActive ? Colors.grey : Colors.transparent,
          shape: BoxShape.circle,
          border: Border.all(
            color: Colors.grey,
            width: 2.0,
          ),
        ),
      ),
      SizedBox(height: 5),
      Text(
        date,
        style: TextStyle(
          color: Colors.grey,
          fontSize: 14,
        ),
      ),
    ],
  );
}