import 'package:flutter/material.dart';

class WriteInquiry extends StatefulWidget {
  const WriteInquiry({super.key});

  @override
  State<WriteInquiry> createState() => _WriteInquiryState();
}

class _WriteInquiryState extends State<WriteInquiry> {
  String? _selectedCategory;
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _contentController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('문의하기', style: TextStyle(fontWeight: FontWeight.bold)),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios,
            color: Colors.grey,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      '문의유형',
                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                    ),
                    const SizedBox(height: 8),
                    DropdownButtonFormField<String>(
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        contentPadding: EdgeInsets.symmetric(horizontal: 12),
                      ),
                      hint: const Text('문의유형을 선택해주세요.'),
                      items: [
                        '계정 및 로그인',
                        '앱 기능 및 사용 방법',
                        '문제 해결 및 기술 지원',
                        '개인정보 보호 및 보안',
                        '기타',
                      ].map((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                      onChanged: (newValue) {
                        setState(() {
                          _selectedCategory = newValue;
                        });
                      },
                    ),
                    const SizedBox(height: 16),
                    const Text(
                      '문의제목',
                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                    ),
                    const SizedBox(height: 8),
                    TextFormField(
                      controller: _titleController,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        contentPadding: EdgeInsets.all(12),
                        hintText: '제목을 입력하세요',
                        hintStyle: TextStyle(color: Colors.grey, fontSize: 14), // 힌트 텍스트 크기 조절
                      ),
                    ),
                    const SizedBox(height: 16),
                    const Text(
                      '문의내용',
                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                    ),
                    const SizedBox(height: 8),
                    SizedBox(
                      height: 200,
                      child: TextFormField(
                        controller: _contentController,
                        maxLines: 10,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          contentPadding: const EdgeInsets.all(12),
                          hintText: '고객센터 > 자주 묻는 질문에서 궁금한 내용에 대한\n'
                              '답을 찾지 못하셨다면, 1:1 문의하기에 남겨주세요.\n'
                              '자세한 내용과 함께 캡쳐본을 전달해주시면 더욱\n'
                              '빠르게 답변드릴 수 있습니다.',
                          hintStyle: TextStyle(color: Colors.grey, fontSize: 14), // 힌트 텍스트 크기 조절
                        ),
                      ),
                    ),
                    const SizedBox(height: 15),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          width: 80,
                          height: 80,
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.grey),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Stack(
                            children: [
                              const Center(
                                child: Icon(Icons.camera_alt_outlined, color: Colors.grey, size: 32),
                              ),
                              Align(
                                alignment: Alignment.bottomCenter,
                                child: Container(
                                  padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 8),
                                  child: const Text(
                                    '1/3',
                                    style: TextStyle(fontSize: 14, color: Colors.grey),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(width: 30),
                        Expanded(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              _buildImageContainer('images/멕시코소철.jpg'),
                              _buildImageContainer('images/백량금.jpg'),
                              _buildImageContainer('images/산세베리아.jpg'),
                            ],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                  ],
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 20),
            child: Row(
              children: [
                Expanded(
                  child: SizedBox(
                    height: 50,
                    child: ElevatedButton(
                      onPressed: () {
                        // 취소 버튼 클릭 시의 동작
                        Navigator.pop(context);
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Color(0xffEEEEEE),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(3), // 둥근 모서리
                        ),
                        elevation: 0, // 그림자 제거
                      ),
                      child: const Text(
                        '취소',
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 16,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 16), // 버튼 사이 간격 조정
                Expanded(
                  child: SizedBox(
                    height: 50,
                    child: ElevatedButton(
                      onPressed: () {
                        // 등록 버튼 클릭 시의 동작
                        // 예를 들어, 폼 제출 로직을 여기에 추가
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xff6bbe45), // 초록색 배경
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(3), // 둥근 모서리
                        ),
                        elevation: 0, // 그림자 제거
                      ),
                      child: const Text(
                        '등록',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.bold), // 흰색 글씨
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
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
          image: AssetImage(imagePath),
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
