import 'dart:io';

import 'package:flutter/material.dart';
import 'package:wonroom/Flask/storage_manager.dart';
import 'package:image_picker/image_picker.dart';
import 'package:wonroom/customerService.dart';
import 'package:wonroom/inqurityDetails.dart';
import 'package:wonroom/intro.dart';
import 'package:wonroom/myComments.dart';
import 'package:wonroom/myPost.dart';
import 'package:wonroom/pwChange.dart';
import 'package:wonroom/userDeletePW.dart';

class MyPage extends StatefulWidget {
  @override
  State<MyPage> createState() => _MyPageState();
}

class _MyPageState extends State<MyPage> {
  // 변수 선언
  String userName = '게스트';
  String userEmail = 'wonroom@naver.com';
  File? _image;  // 선택된 이미지를 저장할 변수
  final ImagePicker _picker = ImagePicker();  // ImagePicker 인스턴스 생성

  // 앨범에서 사진 선택 함수
  Future<void> _pickImage() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
      });
    }
  }

  @override
  void initState() {
    super.initState();
    // 사용자 이름 업데이트
    updateUserName();
  }

  // 로그인 상태를 확인하는 메서드
  bool isLoggedIn() {
    // 로그인 상태를 확인하는 로직을 여기에 구현합니다.
    // 예를 들어, 세션이나 토큰을 확인할 수 있습니다.
    return true; // 로그인 상태를 가정한 예시
  }

  // 로그인된 사용자 정보 가져오기
  String getLoggedInUserName() {
    // 실제 로그인된 사용자 이름을 반환하는 로직을 여기에 구현합니다.
    // 예를 들어, 데이터베이스에서 사용자 정보를 가져오는 로직을 작성합니다.
    return "홍길동"; // 로그인된 사용자 이름 예시
  }

  // 사용자 이름 업데이트
  void updateUserName() {
    if (isLoggedIn()) {
      setState(() {
        userName = getLoggedInUserName();
      });
    } else {
      setState(() {
        userName = "게스트";
      });
    }
  }

  Future<void> _fetchUserData() async {
    StorageManager _sm = new StorageManager();

    // 비동기 작업 수행
    final data = await _sm.readUserData();
    // 상태 업데이트
    setState(() {
      userName = data?["user_id"];
      userEmail = data?["user_email"];
    });
  }

  @override
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('마이페이지', style: TextStyle(fontWeight: FontWeight.bold)),
        centerTitle: true,
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
      body: ListView(
        padding: const EdgeInsets.all(0),
        children: [
          // 프로필 정보
          Padding(
            padding: const EdgeInsets.fromLTRB(30, 16, 16, 0),
            child: Row(
              children: [
                GestureDetector(
                  onTap: () {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return Dialog(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(30),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text(
                                  '프로필 사진 설정',
                                  style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                SizedBox(height: 8),
                                TextButton(
                                  onPressed: () {
                                    _pickImage();
                                  },
                                  style: TextButton.styleFrom(
                                    padding: EdgeInsets.zero,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.zero,
                                    ),
                                    tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                                    minimumSize: Size.fromHeight(40),
                                  ),
                                  child: Align(
                                    alignment: Alignment.centerLeft,
                                    child: Text(
                                      '앨범에서 사진 선택',
                                      style: TextStyle(
                                        fontSize: 16,
                                        color: Color(0xff595959),
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(height: 2),
                                TextButton(
                                  onPressed: () {
                                    // Add functionality here
                                  },
                                  style: TextButton.styleFrom(
                                    padding: EdgeInsets.zero,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.zero,
                                    ),
                                    tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                                    minimumSize: Size.fromHeight(40),
                                  ),
                                  child: Align(
                                    alignment: Alignment.centerLeft,
                                    child: Text(
                                      '기본 이미지 적용',
                                      style: TextStyle(
                                        fontSize: 16,
                                        color: Color(0xff595959),
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
                  },
                  child: Stack(
                    clipBehavior: Clip.none,
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: Color(0xffc2c2c2), // Border color
                            width: 2, // Border width
                          ),
                        ),
                        child: CircleAvatar(
                          radius: 30,
                          backgroundImage: AssetImage('images/defaultProfile.png',
                          ),
                        ),
                      ),
                      Positioned(
                        bottom: 0,
                        right: -5,
                        child: Container(
                          width: 30,
                          height: 30,
                          decoration: BoxDecoration(
                            color: Color(0xff6bbe45),
                            shape: BoxShape.circle,
                            border: Border.all(
                              color: Colors.white,
                              width: 1,
                            ),
                          ),
                          child: Icon(
                            Icons.camera_alt_outlined,
                            color: Colors.white,
                            size: 16,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                SizedBox(width: 20),

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

          // 구분
          Container(
            margin: EdgeInsets.only(top: 30, ),
            width: MediaQuery.of(context).size.width,
            height: 8,
            color: Color(0xffeeeeee),
          ),


          // 리스트 항목들
          Container(
            padding: EdgeInsets.symmetric(vertical: 2, horizontal: 8),
            decoration: BoxDecoration(
              border: Border(
                bottom: BorderSide(
                  color: Color(0xffeeeeee),
                  width: 1,
                ),
              ),
            ),
            child: ListTile(
              title: Text('개인 정보 변경'),
              leading: Icon(Icons.person_outline,
                color: Color(0xff595959),),
              trailing: Icon(Icons.arrow_forward_ios,
                size: 16,
                color: Color(0xff787878),
              ),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => PersonalInfoEditPage(),
                  ),
                );
              },
            ),
          ),

          Container(
            padding: EdgeInsets.symmetric(vertical: 2, horizontal: 8),
            decoration: BoxDecoration(
              border: Border(
                bottom: BorderSide(
                  color: Color(0xffeeeeee),
                  width: 1,
                ),
              ),
            ),
            child: ListTile(
              title: Text('내 문의글'),
              leading: Icon(Icons.question_answer_outlined,
                color: Color(0xff595959),
              ),
              trailing: Icon(Icons.arrow_forward_ios,
                size: 16,
                color: Color(0xff787878),
              ),
              onTap: () {
                // 내 문의글 클릭 시 동작
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => InqurityDetails(),
                  ),
                );
              },
            ),
          ),

          Container(
            padding: EdgeInsets.symmetric(vertical: 2, horizontal: 8),
            decoration: BoxDecoration(
              border: Border(
                bottom: BorderSide(
                  color: Color(0xffeeeeee),
                  width: 1,
                ),
              ),
            ),
            child: ListTile(
              title: Text('내 댓글'),
              leading: Icon(Icons.comment_outlined,
                color: Color(0xff595959),),
              trailing: Icon(Icons.arrow_forward_ios,
                size: 16,
                color: Color(0xff787878),
              ),
              onTap: () {
                // 내 댓글 클릭 시 동작
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => MyComments(),
                  ),
                );
              },
            ),
          ),

          Container(
            padding: EdgeInsets.symmetric(vertical: 2, horizontal: 8),
            decoration: BoxDecoration(
              border: Border(
                bottom: BorderSide(
                  color: Color(0xffeeeeee),
                  width: 1,
                ),
              ),
            ),
            child: ListTile(
              title: Text('내 게시글'),
              leading: Icon(Icons.article_outlined,
                color: Color(0xff595959),),
              trailing: Icon(Icons.arrow_forward_ios,
                size: 16,
                color: Color(0xff787878),
              ),
              onTap: () {
                // 내 게시글 클릭 시 동작
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => MyPost(),
                  ),
                );
              },
            ),
          ),

          Container(
            padding: EdgeInsets.symmetric(vertical: 2, horizontal: 8),
            decoration: BoxDecoration(
              border: Border(
                bottom: BorderSide(
                  color: Color(0xffeeeeee),
                  width: 1,
                ),
              ),
            ),
            child: ListTile(
              title: Text('고객센터'),
              leading: Icon(Icons.support_agent_outlined,
                color: Color(0xff595959),),
              trailing: Icon(Icons.arrow_forward_ios,
                size: 16,
                color: Color(0xff787878),
              ),
              onTap: () {
                // 고객센터 클릭 시 동작
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => CustomerService(),
                  ),
                );
              },
            ),
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
          icon: Icon(
            Icons.arrow_back_ios,
            color: Colors.grey,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(0),
        child: ListView(
          children: [
            SizedBox(height: 20,),
            Center(
              child: GestureDetector(
                onTap: () {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return Dialog(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(30),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                '프로필 사진 설정',
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              SizedBox(height: 8),
                              TextButton(
                                onPressed: () {
                                  // Add functionality here
                                },
                                style: TextButton.styleFrom(
                                  padding: EdgeInsets.zero,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.zero,
                                  ),
                                  tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                                  minimumSize: Size.fromHeight(40),
                                ),
                                child: Align(
                                  alignment: Alignment.centerLeft,
                                  child: Text(
                                    '앨범에서 사진 선택',
                                    style: TextStyle(
                                      fontSize: 16,
                                      color: Color(0xff595959),
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(height: 2),
                              TextButton(
                                onPressed: () {
                                  // Add functionality here
                                },
                                style: TextButton.styleFrom(
                                  padding: EdgeInsets.zero,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.zero,
                                  ),
                                  tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                                  minimumSize: Size.fromHeight(40),
                                ),
                                child: Align(
                                  alignment: Alignment.centerLeft,
                                  child: Text(
                                    '기본 이미지 적용',
                                    style: TextStyle(
                                      fontSize: 16,
                                      color: Color(0xff595959),
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
                },
                child: Stack(
                  clipBehavior: Clip.none,
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: Color(0xffc2c2c2), // Border color
                          width: 2, // Border width
                        ),
                      ),
                      child: CircleAvatar(
                        radius: 50, // Adjusted radius to fit the container
                        backgroundImage: AssetImage('images/plant_0.jpg'),
                      ),
                    ),
                    Positioned(
                      bottom: 0,
                      right: -5,
                      child: Container(
                        width: 40,
                        height: 40,
                        decoration: BoxDecoration(
                          color: Color(0xff6bbe45),
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: Colors.white,
                            width: 1,
                          ),
                        ),
                        child: Icon(
                          Icons.camera_alt_outlined,
                          color: Colors.white,
                          size: 20,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),

            SizedBox(height: 10,),

            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding: EdgeInsets.only(bottom: 20, left: 10),
                    child: Text(
                      '기본 정보',
                      style: TextStyle(
                        fontSize: 21,
                        fontWeight: FontWeight.bold,
                        color: Color(0xff787878)
                      ),
                    ),
                  ),

                  Padding(
                    padding: const EdgeInsets.only(left: 6),
                    child: Row(
                      children: [
                        Icon(Icons.account_circle_outlined),
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
                  ),
                  SizedBox(height: 10),
                  TextField(
                    decoration: InputDecoration(
                      // labelText: '닉네임',
                      labelStyle: TextStyle(color: Colors.grey),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Color(0xff6bbe45), width: 2.0), // 포커스 시 테두리 색상 및 두께
                        // borderRadius: BorderRadius.circular(8),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Color(0xffc2c2c2), width: 1.0), // 비포커스 상태에서의 테두리 색상 및 두께
                        // borderRadius: BorderRadius.circular(8),
                      ),
                      contentPadding: EdgeInsets.symmetric(horizontal: 12.0, vertical: 10.0),
                    ),
                  ),

                  SizedBox(height: 20),

                  Padding(
                    padding: const EdgeInsets.only(left: 6),
                    child: Row(
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
                  ),
                  SizedBox(height: 10),
                  TextField(
                    decoration: InputDecoration(
                      // labelText: '이메일',
                      labelStyle: TextStyle(color: Colors.grey),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Color(0xff6bbe45), width: 2.0), // 포커스 시 테두리 색상 및 두께
                        // borderRadius: BorderRadius.circular(8),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Color(0xffc2c2c2), width: 1.0), // 비포커스 상태에서의 테두리 색상 및 두께
                        // borderRadius: BorderRadius.circular(8),
                      ),
                      contentPadding: EdgeInsets.symmetric(horizontal: 12.0, vertical: 10.0),
                    ),
                  ),
                ],
              ),
            ),

            // 구분
            Container(
              margin: EdgeInsets.only(top: 30, bottom: 24),
              width: MediaQuery.of(context).size.width,
              height: 8,
              color: Color(0xffeeeeee),
            ),

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

            // 구분
            Container(
              margin: EdgeInsets.only(top: 30, bottom: 24),
              width: MediaQuery.of(context).size.width,
              height: 8,
              color: Color(0xffeeeeee),
            ),

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

            // 구분
            Container(
              margin: EdgeInsets.only(top: 30, bottom: 0),
              width: MediaQuery.of(context).size.width,
              height: 8,
              color: Color(0xffeeeeee),
            ),

            Container(
              padding: EdgeInsets.symmetric(vertical: 2),
              decoration: BoxDecoration(
                border: Border(
                  bottom: BorderSide(
                    color: Color(0xffeeeeee),
                    width: 1,
                  ),
                ),
              ),
              child: ListTile(
                title: Text('비밀번호 변경'),
                trailing: Icon(Icons.arrow_forward_ios,
                  size: 16,
                  color: Color(0xff787878),
                ),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => PwChange(),
                    ),
                  );
                },
              ),
            ),
            Container(
              padding: EdgeInsets.symmetric(vertical: 2),
              decoration: BoxDecoration(
                border: Border(
                  bottom: BorderSide(
                    color: Color(0xffeeeeee),
                    width: 1,
                  ),
                ),
              ),
              child: ListTile(
                title: Text('로그아웃'),
                trailing: Icon(Icons.arrow_forward_ios,
                  size: 16,
                  color: Color(0xff787878),),
                onTap: () {
                  // 로그아웃 처리
                  showModalBottomSheet(
                    context: context,
                    builder: (BuildContext context) {
                      return Container(
                        padding: EdgeInsets.symmetric(vertical: 40, horizontal: 32),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            Text(
                              '로그아웃 하시겠습니까?',
                              style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold
                              ),
                            ),
                            SizedBox(height: 10,),
                            Text(
                              '로그아웃 시 알림 기능이 중지됩니다.\n그래도 로그아웃 진행하시겠습니까?',
                              style: TextStyle(
                                  fontSize: 16,
                                  color: Color(0xff787878)
                              ),
                            ),
                            SizedBox(height: 30),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: <Widget>[
                                Expanded(
                                  child: Padding(
                                    padding: EdgeInsets.only(right: 5),
                                    child: SizedBox(
                                      height: 45,
                                      child: ElevatedButton(
                                        onPressed: () {
                                          Navigator.pop(context); // 다이얼로그를 닫음
                                        },
                                        child: Text('취소', style: TextStyle(
                                          color: Colors.white
                                        ),),
                                        style: ElevatedButton.styleFrom(
                                          backgroundColor: Color(0xff595959),
                                          shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(8), // Radius 조정
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),

                                Expanded(
                                  child: Padding(
                                    padding: EdgeInsets.only(left: 5),
                                    child: SizedBox(
                                      height: 45,
                                      child: ElevatedButton(
                                        onPressed: () {
                                          showDialog(
                                            context: context,
                                            builder: (BuildContext context) {
                                              return Dialog(
                                                shape: RoundedRectangleBorder(
                                                  borderRadius: BorderRadius.circular(10),
                                                ),
                                                child: Padding(
                                                  padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 16),
                                                  child: Column(
                                                    mainAxisSize: MainAxisSize.min,
                                                    children: [
                                                      Text(
                                                        '로그아웃 되었습니다.',
                                                        style: TextStyle(
                                                          fontSize: 20,
                                                          fontWeight: FontWeight.bold,
                                                        ),
                                                        textAlign: TextAlign.center,
                                                      ),
                                                      SizedBox(height: 5),
                                                      Text(
                                                        '확인 버튼을 누르면 \n로그인 화면으로 이동합니다.',
                                                        style: TextStyle(fontSize: 16, color: Colors.grey),
                                                        textAlign: TextAlign.center,
                                                      ),
                                                      SizedBox(height: 24),
                                                      Align(
                                                        alignment: Alignment.center,
                                                        child: ElevatedButton(
                                                          style: ElevatedButton.styleFrom(
                                                            backgroundColor: Colors.black,
                                                            padding: EdgeInsets.symmetric(vertical: 10, horizontal: 32),
                                                            shape: RoundedRectangleBorder(
                                                              borderRadius: BorderRadius.circular(8),
                                                            ),
                                                          ),
                                                          child: Container(
                                                            width: MediaQuery.of(context).size.width * 0.5,
                                                            child: Text(
                                                              '확인',
                                                              style: TextStyle(
                                                                fontSize: 18,
                                                                color: Colors.white,
                                                              ),
                                                              textAlign: TextAlign.center,
                                                            ),
                                                          ),

                                                          onPressed: () {
                                                            // 로그아웃 기능

                                                            Navigator.of(context).popUntil((route) => route.isFirst); // 모든 페이지를 팝하여 첫 페이지로 이동
                                                            Navigator.push(
                                                              context,
                                                              MaterialPageRoute(
                                                                builder: (context) => Intro(), // 로그인 페이지로 이동
                                                              ),
                                                            );
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
                                        child: Text(
                                          '로그아웃',
                                          style: TextStyle(color: Colors.white),
                                        ),
                                        style: ElevatedButton.styleFrom(
                                          backgroundColor: Color(0xffc2c2c2),
                                          shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(8),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      );
                    },
                  );
                },
              ),
            ),
            Container(
              padding: EdgeInsets.symmetric(vertical: 2),
              decoration: BoxDecoration(
                border: Border(
                  bottom: BorderSide(
                    color: Color(0xffeeeeee),
                    width: 1,
                  ),
                ),
              ),
              child: ListTile(
                title: Text('회원탈퇴'),
                trailing: Icon(Icons.arrow_forward_ios,
                  size: 16,
                  color: Color(0xff787878),),
                onTap: () {
                  // 회원탈퇴 처리
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => UserDeletePw(),
                    ),
                  );
                },
              ),
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
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 16),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                '변경이 완료되었습니다.',
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                                textAlign: TextAlign.center,
                              ),
                              SizedBox(height: 5),
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
                                    padding: EdgeInsets.symmetric(vertical: 10, horizontal: 32), // 버튼 크기 조절
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(8), // 버튼 모서리를 둥글게 설정
                                    ),
                                  ),
                                  child: Container(
                                    width: MediaQuery.of(context).size.width * 0.5,
                                    child: Text('확인', style: TextStyle(
                                        fontSize: 18,
                                        color: Colors.white,
                                    ),
                                    textAlign: TextAlign.center,
                                    ),
                                  ),
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
                  backgroundColor: Color(0xff6bbe45),
                  elevation: 0,
                  padding: EdgeInsets.all(16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10), // 버튼 모서리를 둥글게 설정
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
