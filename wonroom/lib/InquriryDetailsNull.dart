import 'package:flutter/material.dart';

class InquriryDetailsNull extends StatefulWidget {
  const InquriryDetailsNull({super.key});

  @override
  _InquriryDetailsNullState createState() => _InquriryDetailsNullState();
}

class _InquriryDetailsNullState extends State<InquriryDetailsNull> {
  // 현재 선택된 버튼의 인덱스
  int _selectedIndex = 0;

  // 버튼의 스타일을 반환하는 함수
  ButtonStyle _buttonStyle(bool isSelected) {
    return ElevatedButton.styleFrom(
      backgroundColor: isSelected ? Color(0xff595959) : Colors.white, // 선택된 버튼 색상
      padding: EdgeInsets.symmetric(vertical: 8, horizontal: 20), // 내부 여백
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
        side: BorderSide(color: Color(0xffcccccc), width: 1), // 테두리 색상
      ),
      elevation: 0,
    );
  }

  // 버튼의 텍스트 스타일을 반환하는 함수
  TextStyle _buttonTextStyle(bool isSelected) {
    return TextStyle(
      color: isSelected ? Colors.white : Colors.grey, // 텍스트 색상
      fontSize: 16,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('문의내역', style: TextStyle(color: Colors.black)),
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
      body: Container(
        color: Colors.white,
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Container(
                        margin: EdgeInsets.only(right: 5),
                        child: ElevatedButton(
                          style: _buttonStyle(_selectedIndex == 0),
                          onPressed: () {
                            setState(() {
                              _selectedIndex = 0; // 버튼 인덱스를 0으로 설정
                            });
                          },
                          child: Text(
                            '전체',
                            style: _buttonTextStyle(_selectedIndex == 0), // 텍스트 스타일
                          ),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(right: 5),
                        child: ElevatedButton(
                          style: _buttonStyle(_selectedIndex == 1),
                          onPressed: () {
                            setState(() {
                              _selectedIndex = 1; // 버튼 인덱스를 1로 설정
                            });
                          },
                          child: Text(
                            '답변완료',
                            style: _buttonTextStyle(_selectedIndex == 1), // 텍스트 스타일
                          ),
                        ),
                      ),
                      ElevatedButton(
                        style: _buttonStyle(_selectedIndex == 2),
                        onPressed: () {
                          setState(() {
                            _selectedIndex = 2; // 버튼 인덱스를 2로 설정
                          });
                        },
                        child: Text(
                          '답변대기',
                          style: _buttonTextStyle(_selectedIndex == 2), // 텍스트 스타일
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Container(
              child: Divider(
                color: Colors.grey[300], // 줄 색상
                thickness: 1, // 줄 두께
              ),
            ),
            // 안내 메시지
            Expanded(
              child: Center(
                child: Column(
                  children: [
                    SizedBox(height: 200,), // 위쪽 여백 조정
                    ImageIcon(
                      AssetImage('images/info.png'),
                      size: 50,
                      color: Color(0xffc2c2c2),
                    ),
                    SizedBox(height: 10,),
                    Text(
                      '문의하신 내용이 없습니다. \n문의하기 전에 FAQ를 확인해주세요.',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Color(0xff787878),
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            // 하단 버튼
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(24),
              child: ElevatedButton(
                onPressed: () {
                  // 도감 등록하기 버튼 클릭 시 실행될 코드
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xff787878),
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(3),
                  ),
                  minimumSize: const Size.fromHeight(50),
                ),
                child: const Text(
                  '문의하기',
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
