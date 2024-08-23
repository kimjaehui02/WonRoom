import 'package:flutter/material.dart';

class MyplantNull extends StatelessWidget {
  const MyplantNull({super.key});

  @override
  Widget build(BuildContext context) {
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
            // 뒤로가기 기능 (추후 구현 필요)
          },
        ),
      ),
      body: Container(
        color: Colors.white,
        child: Column(
          children: [
            // 도감
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

            // 안내 메시지
            Expanded(
              child: Center(
                child: Column(
                  // mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(height: 250,),
                    ImageIcon(AssetImage('images/info.png'),
                      size: 50,
                      color: Color(0xffc2c2c2),
                    ),
                    SizedBox(height: 10,),
                    Text(
                      '알림 내역이 없습니다. \n곧 좋은 소식 정보 알려드릴게요!',
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
                  backgroundColor: Color(0xff6bbe45),
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  minimumSize: const Size.fromHeight(50),
                ),
                child: const Text(
                  '다이어리 등록하기',
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
