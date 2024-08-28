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
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 이미지 섹션
            Container(
              width: MediaQuery.of(context).size.width * 0.35,
              height: MediaQuery.of(context).size.width * 0.35,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                image: DecorationImage(
                  image: AssetImage('images/아레카야자.jpg'), // 이미지 경로를 적절히 수정
                  fit: BoxFit.cover,
                ),
              ),
            ),
            SizedBox(height: 20),

            // 질병명 섹션
            Row(
              children: [
                Icon(Icons.local_florist, size: 24),
                SizedBox(width: 8.0),
                Column(
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
              ],
            ),
            SizedBox(height: 20),

            // 원인 섹션
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
            Spacer(),

            // 버튼 섹션
            ElevatedButton(
              onPressed: () {
                // 버튼 클릭 이벤트 처리
              },
              style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                padding: EdgeInsets.symmetric(vertical: 16),
              ),
              child: Center(
                child: Text(
                  '방충제 목록에 대해',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
            SizedBox(height: 16),
          ],
        ),
      ),
    );
  }
}
