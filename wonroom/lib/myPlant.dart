import 'package:flutter/material.dart';
import 'package:wonroom/myPlantClinic.dart';

class Myplant extends StatefulWidget {
  const Myplant({super.key});





  @override
  State<Myplant> createState() => _MyplantState();
}

class _MyplantState extends State<Myplant> {

  @override
  Widget build(BuildContext context) {

    void _showDeletionSuccessDialog(BuildContext context) {
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) {
          return AlertDialog(
            contentPadding: EdgeInsets.symmetric(horizontal: 24.0, vertical: 20.0),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                SizedBox(height: 10,),
                Text(
                  '삭제되었습니다.',
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                      color: Colors.black),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 3),
                Text(
                  '확인 버튼을 누르면 \n 이전 페이지로 이동합니다.',
                  style: TextStyle(color: Colors.grey, fontSize: 16),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 15),
                Center(
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.black,
                      minimumSize: Size(200, 45),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(3),
                      ),
                    ),
                    child: Text(
                      '확인',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.bold
                      ), // 흰색 글씨
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      );
    }


    // 삭제버튼 클릭 시 팝업
    void _showDeleteConfirmationSheet(BuildContext context) {
      showModalBottomSheet(
        context: context,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
        ),
        builder: (context) {
          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                SizedBox(height: 20),
                Text(
                  '정말 삭제하시겠습니까?',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 3),
                Text(
                  '삭제하기를 누르시면\n해당 식물 다이어리가 삭제됩니다.',
                  style: TextStyle(color: Colors.grey, fontSize: 16),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 24),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    TextButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      style: TextButton.styleFrom(
                        backgroundColor: Colors.grey[300],
                        minimumSize: Size(170, 50),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(3),
                        ),
                      ),
                      child: Text(
                        '취소',
                        style: TextStyle(
                            color: Color(0xff787878),
                            fontSize: 16,
                            fontWeight: FontWeight.bold
                        ),
                      ),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        Navigator.pop(context);
                        _showDeletionSuccessDialog(context);
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Color(0xff595959),
                        minimumSize: Size(170, 50),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(3),
                        ),
                      ),
                      child: Text(
                        '삭제',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.bold
                        ), // 흰색 글씨
                      ),
                    ),
                  ],
                ),
              ],
            ),
          );
        },
      );
    }



    // 수정, 삭제 팝업
    void _showBottomSheet(BuildContext context) {
      showModalBottomSheet(
        context: context,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
        ),
        builder: (context) {
          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                ListTile(
                  leading: Icon(Icons.edit_outlined),
                  title: Text('수정하기'),
                  onTap: () {
                    // 수정하기 기능 추가
                    Navigator.pop(context);
                  },
                ),
                ListTile(
                  leading: Icon(Icons.delete_outline_outlined),
                  title: Text('삭제하기'),
                  onTap: () {
                    Navigator.pop(context);
                    _showDeleteConfirmationSheet(context);
                  },
                ),
              ],
            ),
          );
        },
      );
    }



    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('다이어리', style: TextStyle(color: Colors.black)),
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios,
            color: Colors.grey,
          ),
          onPressed: () {
            Navigator.pop(context);
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
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Flexible(
                            flex: 1,
                            child: Align(
                              alignment: Alignment.centerLeft, // 왼쪽 아이콘을 왼쪽에 배치
                              child: Padding(
                                padding: EdgeInsets.only(left: 32),
                                child: IconButton(
                                  icon: Icon(Icons.star_border_rounded, color: Color(0xff787878)),
                                  onPressed: () {
                                    // 아이콘 클릭 시 실행될 기능 구현
                                  },
                                ),
                              ),
                            ),
                          ),
                          Flexible(
                            flex: 5, // 중앙 텍스트가 많이 차지하도록 설정
                            child: Align(
                              alignment: Alignment.center, // 텍스트를 중앙에 배치
                              child: Text(
                                '몬스테라',
                                style: TextStyle(
                                  fontSize: 24,
                                  fontWeight: FontWeight.bold,
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ),
                          Flexible(
                            flex: 1,
                            child: Align(
                              alignment: Alignment.centerRight, // 오른쪽 아이콘을 오른쪽에 배치
                              child: Padding(
                                padding: EdgeInsets.only(right: 32),
                                child: IconButton(
                                  icon: Icon(Icons.more_vert, color: Color(0xff787878)),
                                  onPressed: () => _showBottomSheet(context),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),


                      SizedBox(height: 16),

                      // 이미지
                      Container(
                        width: MediaQuery.of(context).size.width * 0.85,
                        height: MediaQuery.of(context).size.width * 0.85,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          image: DecorationImage(
                            fit: BoxFit.fill,
                            image: AssetImage('images/img01.jpg'), // 로컬 이미지 경로
                          ),
                        ),
                      ),

                      Container(
                        padding: EdgeInsets.only(left: 24, right: 24),
                        child: Column(
                          children: [
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

                          ],
                        ),
                      ),


                    ],
                  ),

                  // 구분
                  Container(
                    margin: EdgeInsets.only(top: 40, bottom: 24),
                    width: MediaQuery.of(context).size.width,
                    height: 8,
                    color: Color(0xffeeeeee),
                  ),

                  // 기록
                  Container(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          padding: EdgeInsets.only(bottom: 12, left: 10),
                          child: Text(
                            '이전 기록',
                            style: TextStyle(
                              fontSize: 21,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),

                        SizedBox(height: 12),

                        // 물주기 기록
                        Center(
                          child: Container(
                            width: MediaQuery.of(context).size.width,
                            padding: EdgeInsets.all(30),
                            decoration: BoxDecoration(
                                color : Color(0xfffafafa),
                                borderRadius: BorderRadius.circular(10)
                            ),
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
                            decoration: BoxDecoration(
                                color : Color(0xfffafafa),
                                borderRadius: BorderRadius.circular(10)
                            ),
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
                            decoration: BoxDecoration(
                                color : Color(0xfffafafa),
                                borderRadius: BorderRadius.circular(10)
                            ),
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
                                      Text('기록이 없습니다. \n 기록을 추가해보세요.',
                                      textAlign: TextAlign.center,
                                      style: TextStyle(color: Color(0xff787878)),),
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
                            decoration: BoxDecoration(
                                color : Color(0xfffafafa),
                                borderRadius: BorderRadius.circular(10)
                            ),
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
                                      Text('기록이 없습니다. \n 기록을 추가해보세요.',
                                        textAlign: TextAlign.center,
                                      style: TextStyle(color: Color(0xff787878)),),
                                    ],
                                  ),
                                )
                              ],
                            ),
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

                  // 진단
                  Container(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          padding: EdgeInsets.only(left: 10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                '진단 기록',
                                style: TextStyle(
                                  fontSize: 21,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),

                              TextButton(onPressed: (){
                                Navigator.push(context,
                                  MaterialPageRoute(builder: (_)=>MyPlantClinic()),
                                );
                              },
                                  child: Row(
                                    children: [
                                      Text(
                                        '자세히 보기 ',
                                        style: TextStyle(
                                          color: Color(0xff787878),
                                        ),
                                      ),
                                      Icon(Icons.arrow_forward_ios,
                                        size: 12,
                                      )
                                    ],
                                  ),
                              ),
                            ],
                          ),
                        ),

                        SizedBox(height: 12),

                        // 진단 기록
                        Center(
                          child: Container(
                            width: MediaQuery.of(context).size.width,
                            padding: EdgeInsets.all(30),
                            decoration: BoxDecoration(
                                color : Color(0xfffafafa),
                                borderRadius: BorderRadius.circular(10)
                            ),
                            child: Column(
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(
                                      Icons.eco,
                                      size: 32,
                                      color: Colors.lightGreen,
                                    ),
                                    SizedBox(width: 4),
                                    Text(
                                      '건강 기록',
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
                                    buildTimelineItem("03.19 \n 정상", true),
                                    buildTimelineItem("04.19 \n 질병", true),
                                    buildTimelineItem("05.19 \n 해충", true),
                                    buildTimelineItem("06.19 \n 정상", true),
                                    buildTimelineItem(" \n ", false),
                                  ],
                                )
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),

                  SizedBox(height: 100,),

                  Padding(
                    padding: const EdgeInsets.all(16),
                      // 버튼
                    child: ElevatedButton(onPressed: (){

                    },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Color(0xff595959),
                        elevation: 0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        minimumSize: const Size.fromHeight(50),
                      ),
                        child: const Text('해당 식물 정보 알아보기',
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.white,
                          ),
                        ),
                      )
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