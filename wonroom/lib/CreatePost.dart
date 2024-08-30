import 'package:flutter/material.dart';

class CreatePost extends StatelessWidget {
  const CreatePost({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          '게시글 작성',
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
            fontSize: 20, // 앱바 제목 텍스트 크기 조정
          ),
        ),
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
      body: SingleChildScrollView( // 스크롤 가능하도록 래핑
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // 게시글 유형 선택
              Text(
                '게시글 유형',
                style: TextStyle(
                  fontSize: 18, // 텍스트 크기 조정
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 8),
              // 드롭다운 버튼
              DropdownButtonFormField<String>(
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(4),
                  ),
                  contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 16),
                ),
                dropdownColor: Colors.white, // 드롭다운 배경색 설정
                onChanged: (value) {},
                items: [
                  DropdownMenuItem(
                    value: 'option1',
                    child: Container(
                      width: 80, // 드롭다운 선택창의 넓이 조정
                      child: Text('질문하기'),
                    ),
                  ),
                  DropdownMenuItem(
                    value: 'option2',
                    child: Container(
                      width: 80, // 드롭다운 선택창의 넓이 조정
                      child: Text('자랑하기'),
                    ),
                  ),
                  DropdownMenuItem(
                    value: 'option3',
                    child: Container(
                      width: 80, // 드롭다운 선택창의 넓이 조정
                      child: Text('자유게시판'),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 20),
              // 게시글 제목 입력
              Text(
                '게시글 제목',
                style: TextStyle(
                  fontSize: 18, // 텍스트 크기 조정
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 8),
              TextField(
                decoration: InputDecoration(
                  hintText: '제목을 입력해주세요.',
                  border: OutlineInputBorder(),
                  contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 16),
                ),
              ),
              SizedBox(height: 20),
              // 게시글 내용 입력
              Text(
                '게시글 내용',
                style: TextStyle(
                  fontSize: 18, // 텍스트 크기 조정
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 8),
              // 카메라 아이콘과 이미지 3개
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // 카메라 아이콘과 '1/3' 텍스트를 포함한 Stack
                  Container(
                    width: 80,
                    height: 80,
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Stack(
                      children: [
                        Center(
                          child: Icon(Icons.camera_alt_outlined, color: Colors.grey, size: 32),
                        ),
                        Align(
                          alignment: Alignment.bottomCenter,
                          child: Container(
                            padding: EdgeInsets.symmetric(vertical: 5, horizontal: 8),
                            child: Text(
                              '1/3',
                              style: TextStyle(fontSize: 14, color: Colors.grey),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(width: 30),
                  Expanded(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween, // 균일한 간격
                      children: [
                        _buildImageContainer('images/멕시코소철.jpg'), // 이미지 1
                        _buildImageContainer('images/백량금.jpg'), // 이미지 2
                        _buildImageContainer('images/산세베리아.jpg'), // 이미지 3
                      ],
                    ),
                  ),
                ],
              ),
              SizedBox(height: 20),
              TextField(
                maxLines: 10,
                decoration: InputDecoration(
                  hintText: '게시할 내용을 작성해주세요.',
                  border: OutlineInputBorder(),
                  contentPadding: EdgeInsets.all(12),
                ),
              ),
              SizedBox(height: 110), // 여백 추가

              // 하단 버튼들
              Row(
                children: [
                  Expanded(
                    child: OutlinedButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: Text(
                        '취소',
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      style: OutlinedButton.styleFrom(
                        backgroundColor: Color(0xffEEEEEE),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(3),
                        ),
                        side: BorderSide.none, // 모서리 색을 없애는 설정
                      ),
                    ),
                  ),
                  SizedBox(width: 8), // 버튼들 사이의 간격
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {
                        _showSuccessDialog(context); // 등록 버튼 클릭 시 다이얼로그 표시
                      },
                      child: Text(
                        '등록',
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Color(0xff6bbe45),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(3),
                        ),
                        side: BorderSide.none,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildImageContainer(String imagePath) {
    return Container(
      width: 80,
      height: 80,
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey),
        borderRadius: BorderRadius.circular(8),
        image: DecorationImage(
          image: AssetImage(imagePath), // 실제 이미지 로드
          fit: BoxFit.cover,
        ),
      ),
    );
  }

  // 등록 버튼 클릭 시 팝업창
  void _showSuccessDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(5),
          ),
          content: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  '등록이 완료되었습니다.',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center, // 텍스트 가운데 정렬
                ),
                SizedBox(height: 5),
                Text(
                  '확인 버튼을 누르면\n 이전 페이지로 이동합니다.',
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.grey,
                  ),
                  textAlign: TextAlign.center, // 텍스트 가운데 정렬
                ),
                SizedBox(height: 16),
                SizedBox(
                  width: double.infinity, // 버튼을 화면 너비에 맞게 확장
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context); // 다이얼로그 닫기
                      Navigator.pop(context); // 이전 페이지로 이동
                    },
                    child: Text(
                      '확인',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.black, // 검정색 배경
                      padding: EdgeInsets.symmetric(vertical: 16), // 버튼의 세로 패딩
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(3), // 직사각형 모양
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }






}
