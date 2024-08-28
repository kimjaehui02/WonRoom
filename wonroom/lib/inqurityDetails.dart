import 'package:flutter/material.dart';

class InqurityDetails extends StatefulWidget {
  const InqurityDetails({super.key});

  @override
  _InqurityDetailsState createState() => _InqurityDetailsState();
}

class _InqurityDetailsState extends State<InqurityDetails> {
  // 현재 선택된 버튼의 인덱스
  int _selectedIndex = 0;

  // 버튼의 스타일을 반환하는 함수
  ButtonStyle _buttonStyle(bool isSelected) {
    return ElevatedButton.styleFrom(
      backgroundColor: isSelected ? Color(0xff787878) : Colors.white, // 선택된 버튼 색상
      padding: EdgeInsets.symmetric(vertical: 8, horizontal: 23), // 내부 여백
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
        side: BorderSide(color: Colors.grey, width: 1), // 테두리 색상
      ),
    );
  }

  // 버튼의 텍스트 스타일을 반환하는 함수
  TextStyle _buttonTextStyle(bool isSelected) {
    return TextStyle(
      color: isSelected ? Colors.white : Color(0xff595959), // 텍스트 색상
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

            // 앱 기능 제목 및 설명 추가
            Container(
              padding: EdgeInsets.symmetric(vertical: 16, horizontal: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '[앱 기능 및 사용 방법] 식물의 상태를 어떻게 추적하나요?????',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                  SizedBox(height: 8),
                  Divider(
                    color: Colors.grey[300], // 얇은 선 색상
                    thickness: 1, // 얇은 선 두께
                  ),
                  SizedBox(height: 8),
                  Text(
                    '등록한 식물의 기록을 보고 싶은데 어떻게 들어가나요?',
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.grey,
                    ),
                  ),
                ],
              ),
            ),

            // 하단 버튼
            Spacer(),
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(24),
              child: ElevatedButton(
                onPressed: () {
                  // 문의하기 버튼 클릭 시 실행될 코드
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
