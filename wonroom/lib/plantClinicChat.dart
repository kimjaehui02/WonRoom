import 'package:flutter/material.dart';

class PlantClinicChat extends StatelessWidget {
  const PlantClinicChat({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            // 뒤로 가기 동작 추가
          },
        ),
        title: Text('식물 클리닉'),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView(
              padding: EdgeInsets.all(16.0),
              children: [
                // 사용자 메시지
                _buildMessageBubble(
                  message: '안녕하세요, 식물에 문제가 있는 것 같습니다.',
                  isUser: true,
                ),
                SizedBox(height: 10),

                // 시스템 메시지
                _buildMessageBubble(
                  message: '안녕하세요! 어떻게 도와드릴까요?',
                  isUser: false,
                ),
                SizedBox(height: 10),

                // 이미지 섹션
                Container(
                  width: MediaQuery.of(context).size.width * 0.6,
                  height: MediaQuery.of(context).size.width * 0.6,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    image: DecorationImage(
                      image: AssetImage('images/아레카야자.jpg'), // 이미지 경로를 적절히 수정
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                SizedBox(height: 10),

                // 시스템 메시지
                _buildMessageBubble(
                  message: '식물의 상태를 보니 시들음병 같아요. 자세한 증상과 원인은 다음과 같습니다.',
                  isUser: false,
                ),
                SizedBox(height: 10),

                // 질병명 및 설명
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: 50,
                      height: 50,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: Color(0xffeeeeee),
                          width: 1,
                        ),
                        color: Colors.white,
                      ),
                      child: Center(
                        child: Image.asset(
                          'images/chat-bot.png', // 아이콘 파일 경로
                          width: 25,
                          height: 25,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    SizedBox(width: 10),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            '시들음병 Wilt Disease',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: 4),
                          Text(
                            '식물의 잎과 줄기가 시들어가는 증상을 보이며, 주로 ...', // 텍스트 요약
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.grey[600],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 10),

                // 원인
                Text(
                  '원인',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 10),
                Text(
                  '- 원인1: 일반적으로 ...\n- 원인2: 다른 식물에서 전염된 ...', // 원인 텍스트
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.grey[800],
                  ),
                ),
                SizedBox(height: 10),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    decoration: InputDecoration(
                      hintText: '메시지를 입력하세요...',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                      contentPadding: EdgeInsets.symmetric(horizontal: 16),
                    ),
                  ),
                ),
                SizedBox(width: 8),
                ElevatedButton(
                  onPressed: () {
                    // 버튼 클릭 이벤트 처리
                  },
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                    padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  ),
                  child: Text('전송'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMessageBubble({required String message, required bool isUser}) {
    return Align(
      alignment: isUser ? Alignment.centerRight : Alignment.centerLeft,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (!isUser)
            Container(
              width: 50,
              height: 50,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: Color(0xffeeeeee),
                  width: 1,
                ),
                color: Colors.white,
              ),
              child: Center(
                child: Image.asset(
                  'images/chat-bot.png', // 아이콘 파일 경로
                  width: 25,
                  height: 25,
                  fit: BoxFit.cover,
                ),
              ),
            ),
          SizedBox(width: 8),
          Flexible(
            child: Container(
              padding: EdgeInsets.symmetric(vertical: 10, horizontal: 16),
              decoration: BoxDecoration(
                color: isUser ? Colors.blueAccent : Colors.grey[300],
                borderRadius: BorderRadius.circular(20),
              ),
              child: Text(
                message,
                style: TextStyle(
                  color: isUser ? Colors.white : Colors.black,
                ),
              ),
            ),
          ),
          SizedBox(width: 8),
          if (isUser)
            Container(
              width: 50,
              height: 50,
            ),
        ],
      ),
    );
  }
}
