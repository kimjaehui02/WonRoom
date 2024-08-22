import 'package:flutter/material.dart';

class PlantDetailPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xff779d60),
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios, color: Colors.white),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text('몬스테라', style: TextStyle(color: Colors.white)),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Stack(
          clipBehavior: Clip.none, // Positioned가 Stack 밖으로 나갈 수 있도록 함
          children: [
            Container(
              width: double.infinity,
              height: 200,
              color: Color(0xff779d60),
              // child: Text(
              //   'Monstera',
              //   style: TextStyle(
              //     fontSize: 24,
              //     color: Colors.white,
              //     fontWeight: FontWeight.bold,
              //   ),
              //   textAlign: TextAlign.center,
              // ),
            ),
            Positioned(
              top: -40, // 위쪽 위치 조정
              child: Container(
                width: MediaQuery.of(context).size.width,
                margin: EdgeInsets.only(top: 50),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(30),
                    topRight: Radius.circular(30),
                  ),
                ),
                padding: EdgeInsets.all(16),
                child: Column(
                  children: [
                    Container(
                      // padding: const EdgeInsets.all(12),
                      child: Text(
                        'Monstera',
                        style: TextStyle(
                          fontSize: 20,
                          color: Color(0xffe7ece4),
                        ),
                        // textAlign: TextAlign.center,
                      ),
                    ),
                    SizedBox(height: 16),
                    ClipRRect(
                      borderRadius: BorderRadius.circular(15.0),
                      child: Image.asset(
                        'images/plant_0.jpg',
                        width: MediaQuery.of(context).size.width * 0.85,
                        height: MediaQuery.of(context).size.width * 0.85,
                        fit: BoxFit.cover,
                      ),
                    ),

                    SizedBox(height: 16),
                    Text(
                      '• 큰 잎과 독특한 구멍이 있는 열대 식물입니다.\n'
                          '• 실내에서 쉽게 키울 수 있어 인기가 많습니다.\n'
                          '• 공기 정화 능력도 뛰어납니다.\n'
                          '• 인테리어에 포인트를 주기에 좋습니다.',
                      style: TextStyle(fontSize: 16, color: Colors.grey[800]),
                    ),
                    SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Expanded(
                          child: Container(
                            padding: EdgeInsets.all(16),
                            decoration: BoxDecoration(
                              color : Color(0xfffafafa),
                              borderRadius: BorderRadius.circular(10)
                            ),
                            child: Column(
                              children: [
                                Icon(Icons.opacity, color: Colors.blue),
                                SizedBox(height: 5),
                                Text(
                                  '물주기:\n10 Day',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(color: Colors.grey[800]),
                                ),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(width: 10),
                        Expanded(
                          child: Container(
                            color: Colors.blue,
                            child: Column(
                              children: [
                                Icon(Icons.wb_sunny, color: Colors.orange),
                                SizedBox(height: 5),
                                Text(
                                  '온도:\n18-30°C',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(color: Colors.grey[800]),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

