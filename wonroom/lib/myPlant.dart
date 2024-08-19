import 'package:flutter/material.dart';

class Myplant extends StatelessWidget {
  const Myplant({super.key});

  Widget buildTimelineItem(String date, bool isActive) {
    return Column(
      children: [
        Container(
          width: 12,
          height: 12,
          decoration: BoxDecoration(
            color: isActive ? Colors.grey : Colors.transparent,
            shape: BoxShape.circle,
            // border: Border.all(
            //   color: Colors.grey,
            //   width: 2,
            // ),
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('마이 도감'),
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios,
            color: Colors.grey,
          ),
          onPressed: () {
            // 뒤로가기 기능
          },
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // 도감, 도감2 탭
            Container(
              padding: EdgeInsets.only(top: 8, bottom: 8, right: 16, left: 16),
              color: Color(0xffeeeeee),
              child: Row(
                children : [
                  Container(
                    decoration: BoxDecoration(
                      color: Color(0xff595959),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    padding: EdgeInsets.only(top: 8, bottom: 8, right: 20, left: 20),
                    child: Text('도감1', style: TextStyle(
                        color: Colors.white
                    ),),
                  ),
                  SizedBox(width: 10,),
                  Container(
                    decoration: BoxDecoration(
                      color: Color(0xff595959),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    padding: EdgeInsets.only(top: 8, bottom: 8, right: 20, left: 20),
                    child: Text('도감1', style: TextStyle(
                        color: Colors.white
                    ),),
                  ),
                ]
              ),
            ),

            // 제목, 사진, 버튼
            Container(
              // padding: const EdgeInsets.all(16.0),
              color: Colors.white,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 32),
                  // 식물 이름과 이미지
                  Center(
                    child: Column(
                      children: [
                        Text(
                          '몬스테라',
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
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
                              image: AssetImage('images/img01.jpg'),
                            ),
                          ),
                        ),

                        // 물주기 버튼
                        Container(
                          padding: const EdgeInsets.only(top: 20, bottom: 20),
                          decoration: BoxDecoration(
                              border: Border(
                                  bottom: BorderSide(color: Color(0xffeeeeee), width: 1))),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              OutlinedButton.icon( onPressed: () { },
                                icon: Icon(Icons.water_drop, size: 18, color: Colors.lightBlueAccent,),
                                label: Text("물주기", style: TextStyle(color: Color(0xff787878)),),
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
                                                fontWeight: FontWeight.bold
                                            )
                                        )
                                      ]
                                  )
                              ),
                            ],
                          ),
                        ),

                        // 영양제 버튼
                        Container(
                          padding: const EdgeInsets.only(top: 20, bottom: 20),
                          decoration: BoxDecoration(
                              border: Border(
                                  bottom: BorderSide(color: Color(0xffeeeeee), width: 1))),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              OutlinedButton.icon( onPressed: () { },
                                icon: Image.asset('images/potion.png', // 외부 이미지 경로
                                  width: 18, // 아이콘 크기
                                  height: 18, // 아이콘 크기
                                ),
                                label: Text("영양제", style: TextStyle(color: Color(0xff787878)),),
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
                                                fontWeight: FontWeight.bold
                                            )
                                        )
                                      ]
                                  )
                              ),
                            ],
                          ),
                        ),

                        // 가지치기 버튼
                        Container(
                          padding: const EdgeInsets.only(top: 20, bottom: 20),
                          decoration: BoxDecoration(
                              border: Border(
                                  bottom: BorderSide(color: Color(0xffeeeeee), width: 1))),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              OutlinedButton.icon( onPressed: () { },
                                icon: Image.asset('images/scissor.png', // 외부 이미지 경로
                                  width: 18, // 아이콘 크기
                                  height: 18, // 아이콘 크기
                                ),
                                label: Text("가지치기", style: TextStyle(color: Color(0xff787878)),),
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
                                                fontWeight: FontWeight.bold
                                            )
                                        )
                                      ]
                                  )
                              ),
                            ],
                          ),
                        ),

                        // 분갈이 버튼
                        Container(
                          padding: const EdgeInsets.only(top: 20, bottom: 20),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              OutlinedButton.icon( onPressed: () { },
                                icon: Image.asset('images/soil.png', // 외부 이미지 경로
                                  width: 18, // 아이콘 크기
                                  height: 18, // 아이콘 크기
                                ),
                                label: Text("분갈이", style: TextStyle(color: Color(0xff787878)),),
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
                                                fontWeight: FontWeight.bold
                                            )
                                        )
                                      ]
                                  )
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),

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
                        Text('이전 기록', style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),),

                        Container(
                          width: MediaQuery.of(context).size.width * 0.8,
                          padding: EdgeInsets.all(30),
                          color: Color(0xfffafafa),
                          child: Column(
                            children: [
                              Row(
                                children: [
                                  Icon(Icons.water_drop, size: 24, color: Colors.lightBlueAccent,),
                                  SizedBox(width: 4,),
                                  Text('물주기 기록', style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold
                                  ),)
                                ],
                              ),
                              SizedBox(height: 30,),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  buildTimelineItem("03.19", true),
                                  buildTimelineItem("04.19", true),
                                  buildTimelineItem("05.19", true),
                                  // buildTimelineItem("06.19", true),
                                  // buildTimelineItem("08.12", true),
                                ],
                              )
                            ],
                          ),
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

void main() {
  runApp(MaterialApp(
    home: Myplant(),
  ));
}
