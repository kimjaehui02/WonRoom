import 'package:flutter/material.dart';

class NotificationNull extends StatelessWidget {
  const NotificationNull({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('알림 목록', style: TextStyle(color: Colors.black)),
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
      body: Container(
        color: Colors.white,
        child: Column(
          children: [
            SizedBox(height: 3,),
            Container(
              padding: EdgeInsets.all(16),
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.08), // 더 연한 그림자
                    blurRadius: 10,
                  ),
                ],
              ),
              child: RichText(
                text: TextSpan(
                  text: '수신거부  |  마이페이지  >  내 정보 수정 \n',
                  style: TextStyle(
                    color: Color(0xffc2c2c2),
                    height: 1.5,
                    fontSize: 14,
                  ),
                  children: [
                    TextSpan(text: '알림은 최대 30일 까지만 보여집니다.',
                    style: TextStyle(color: Color(0xff787878),)
                    ),
                  ],
                ),
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
                      color: Color(0xffeeeeee),
                    ),
                    SizedBox(height: 10,),
                    Text(
                      '알림 내역이 없습니다. \n곧 좋은 소식 정보 알려드릴게요!',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Color(0xffc2c2c2),
                        fontSize: 14,
                      ),
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
