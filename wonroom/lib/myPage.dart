import 'package:flutter/material.dart';

class MyPage extends StatefulWidget {
  @override
  State<MyPage> createState() => _MyPageState();
}

class _MyPageState extends State<MyPage> {
  // 변수 선언
  String userName = '게스트';
  String userEmail = 'wonroom@naver.com';


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('마이페이지', style: TextStyle(fontWeight: FontWeight.bold)),
        centerTitle: true,
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.all(0),
        children: [
          // 프로필 정보
          Padding(
            padding: const EdgeInsets.fromLTRB(30, 16, 16, 16),
            child: Row(
              children: [
                CircleAvatar(
                  radius: 30,
                  backgroundImage: AssetImage('assets/profile_image.png'), // 프로필 이미지
                ),
                SizedBox(width: 16),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      userName,
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      userEmail,
                      style: TextStyle(
                        color: Colors.grey,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          SizedBox(height: 20),
          Divider(thickness: 15, color: Colors.grey[300]),
          // 리스트 항목들
          ListTile(
            title: Text('개인 정보 변경'),
            leading: Icon(Icons.person),
            trailing: Icon(Icons.arrow_forward_ios),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => PersonalInfoEditPage(),
                ),
              );
            },
          ),
          Divider(),
          ListTile(
            title: Text('내 문의글'),
            leading: Icon(Icons.question_answer),
            trailing: Icon(Icons.arrow_forward_ios),
            onTap: () {
              // 내 문의글 클릭 시 동작
            },
          ),
          Divider(),
          ListTile(
            title: Text('내 댓글'),
            leading: Icon(Icons.comment),
            trailing: Icon(Icons.arrow_forward_ios),
            onTap: () {
              // 내 댓글 클릭 시 동작
            },
          ),
          Divider(),
          ListTile(
            title: Text('내 게시글'),
            leading: Icon(Icons.article),
            trailing: Icon(Icons.arrow_forward_ios),
            onTap: () {
              // 내 게시글 클릭 시 동작
            },
          ),
          Divider(),
          ListTile(
            title: Text('고객센터'),
            leading: Icon(Icons.support_agent),
            trailing: Icon(Icons.arrow_forward_ios),
            onTap: () {
              // 고객센터 클릭 시 동작
            },
          ),
        ],
      ),
    );
  }
}

////////////////////////////개인정보 수정//////////////////////////

class PersonalInfoEditPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('기본 정보 변경', style: TextStyle(fontWeight: FontWeight.bold)),
        centerTitle: true,
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(0),
        child: ListView(
          children: [
            Center(
              child: Stack(
                children: [
                  CircleAvatar(
                    radius: 50,
                    backgroundImage: AssetImage('assets/profile_image.png'), // 프로필 이미지
                  ),
                  Positioned(
                    bottom: 0,
                    right: 0,
                    child: GestureDetector(
                      onTap: () {
                        // 클릭 시 실행될 코드
                        print('프로필 이미지 변경 클릭됨');
                        // 여기에 프로필 이미지를 변경하는 기능을 추가할 수 있습니다.
                      },
                      child: Container(
                        width: 30,
                        height: 30,
                        decoration: BoxDecoration(
                          color: Colors.green,
                          shape: BoxShape.circle,
                        ),
                        child: Icon(
                          Icons.camera_alt,
                          color: Colors.white,
                          size: 20,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '기본 정보',
                    style: TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                      color: Colors.grey,
                    ),
                  ),
                  SizedBox(height: 20),
                  Row(
                    children: [
                      Icon(Icons.person_outline),
                      SizedBox(width: 8), // 아이콘과 텍스트 사이 간격 조절
                      Text(
                        '닉네임',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 20),
                  TextField(
                    decoration: InputDecoration(
                      prefixIcon: Icon(Icons.person_outline),
                      labelText: '닉네임',
                      labelStyle: TextStyle(color: Colors.grey),
                      border: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey),
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                  ),
                  SizedBox(height: 20),
                  Row(
                    children: [
                      Icon(Icons.email_outlined),
                      SizedBox(width: 8), // 아이콘과 텍스트 사이 간격 조절
                      Text(
                        '이메일',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 20),
                  TextField(
                    decoration: InputDecoration(
                      prefixIcon: Icon(Icons.email_outlined),
                      labelText: '이메일',
                      labelStyle: TextStyle(color: Colors.grey),
                      border: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey),
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Divider(thickness: 2, color: Colors.grey[300]),
            SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                '알림 설정',
                style: TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                  color: Colors.grey,
                ),
              ),
            ),
            SwitchListTile(
              title: Text('앱PUSH'),
              value: true,
              onChanged: (bool value) {
                // 알림 설정 변경
              },
            ),
            Divider(thickness: 2, color: Colors.grey[300]),
            SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                '로그인 설정',
                style: TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                  color: Colors.grey,
                ),
              ),
            ),
            SwitchListTile(
              title: Text('자동로그인'),
              value: true,
              onChanged: (bool value) {
                // 알림 설정 변경
              },
            ),
            Divider(thickness: 2, color: Colors.grey[300]),
            ListTile(
              title: Text('비밀번호 변경'),
              trailing: Icon(Icons.arrow_forward_ios),
              onTap: () {
                // 비밀번호 변경 화면으로 이동
              },
            ),
            ListTile(
              title: Text('로그아웃'),
              trailing: Icon(Icons.arrow_forward_ios),
              onTap: () {
                // 로그아웃 처리
              },
            ),
            ListTile(
              title: Text('회원탈퇴'),
              trailing: Icon(Icons.arrow_forward_ios),
              onTap: () {
                // 회원탈퇴 처리
              },
            ),
            SizedBox(height: 40),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: ElevatedButton(
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return Dialog(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                '변경이 완료되었습니다.',
                                style: TextStyle(
                                  fontSize: 25,
                                  fontWeight: FontWeight.bold,
                                ),
                                textAlign: TextAlign.center,
                              ),
                              SizedBox(height: 16),
                              Text(
                                '확인 버튼을 누르면 \n이전 페이지로 이동합니다.',
                                style: TextStyle(fontSize: 16, color: Colors.grey),
                                textAlign: TextAlign.center,
                              ),
                              SizedBox(height: 24),
                              Align(
                                alignment: Alignment.center,
                                child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.black, // 버튼 배경색을 검정색으로 설정
                                    padding: EdgeInsets.symmetric(vertical: 12, horizontal: 32), // 버튼 크기 조절
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(8), // 버튼 모서리를 둥글게 설정
                                    ),
                                  ),
                                  child: Text('확인', style: TextStyle(fontSize: 18, color: Colors.white)),
                                  onPressed: () {
                                    Navigator.pop(context); // 다이얼로그를 닫음
                                    Navigator.pop(context); // 이전 페이지로 이동
                                  },
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  );

                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green, // 버튼 배경색을 녹색으로 설정
                  padding: EdgeInsets.symmetric(vertical: 16), // 버튼 높이 조절
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8), // 버튼 모서리를 둥글게 설정
                  ),
                ),
                child: Text(
                  '정보 수정',
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
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
