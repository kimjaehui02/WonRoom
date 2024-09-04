// import 'dart:nativewrappers/_internal/vm/lib/core_patch.dart';

import 'package:flutter/material.dart';
import 'package:wonroom/DB/users/user_service.dart';
import 'package:wonroom/Flask/storage_manager.dart';
import 'package:wonroom/intro.dart';

class UserDeletePw extends StatefulWidget {
  const UserDeletePw({super.key});

  @override
  State<UserDeletePw> createState() => _UserDeletePwState();
}

class _UserDeletePwState extends State<UserDeletePw> {
  // 컨트롤러 추가
  final TextEditingController _confirmPasswordController = TextEditingController();
  bool _obscureConfirmPassword = true;

  // userData는 유저 테이블을 json형태로 저장하기 위해 쓰인다
  Map<dynamic, dynamic>? userData;

  // user_id가 null이거나 존재하지 않을 경우 기본값을 설정합니다.
  // json파일에서 유저id정보를 저장하기위해 사용합니다
  dynamic userId = "";
  dynamic userPw = "";

  UserService userService = new UserService();

  @override
  void initState() {
    super.initState();
  }

  void getUser() async
  {
    // 유저 데이터를 핸드폰 기본 스토리지에서 json형태로 가져온다
    userData = await readUserData();
    // 가져온 json에서 user_id만 가져온다 ?? 뒤의 문자열은 에외처리
    // userData?["user_id"]가 널이면 ??뒤의 문자열로 userId를 초기화 해준다
    userId = userData?["user_id"] ?? "user_id";

  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('본인 확인', style: TextStyle(fontWeight: FontWeight.bold)),
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
      body: Stack(
        children: [
          Padding(
            padding: EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 6),
                  child: Text(
                    '회원탈퇴를 진행하기 전에\n본인 확인이 필요합니다.',
                    style: TextStyle(
                      fontSize: 20,
                      color: Color(0xff595959),
                    ),
                  ),
                ),
                SizedBox(height: 40),
                Padding(
                  padding: const EdgeInsets.only(left: 6),
                  child: Row(
                    children: const <Widget>[
                      Icon(Icons.lock_outline, size: 24),
                      SizedBox(width: 8.0),
                      Text(
                        '비밀번호 확인',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 8.0),
                TextFormField(
                  controller: _confirmPasswordController, // 컨트롤러 설정
                  decoration: InputDecoration(
                    hintText: '현재 비밀번호',
                    border: OutlineInputBorder(),
                    contentPadding: EdgeInsets.symmetric(horizontal: 12.0, vertical: 10.0),
                    suffixIcon: IconButton(
                      icon: Icon(
                        _obscureConfirmPassword ? Icons.visibility_off_outlined : Icons.visibility_outlined,
                        color: Color(0xffc2c2c2),
                      ),
                      onPressed: () {
                        setState(() {
                          _obscureConfirmPassword = !_obscureConfirmPassword;
                        });
                      },
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Color(0xff6bbe45), width: 2.0),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Color(0xffc2c2c2), width: 1.0),
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  obscureText: _obscureConfirmPassword,
                ),
              ],
            ),
          ),

          Positioned(
            bottom: 16,
            left: 0,
            right: 0,
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: ElevatedButton(
                onPressed: () {
                  // 비밀번호 확인
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => UserDelete(),
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xff595959),
                  elevation: 0,
                  padding: EdgeInsets.symmetric(vertical: 16), // 버튼 높이 조절
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: Text(
                  '다음',
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class UserDelete extends StatefulWidget {
  const UserDelete({super.key});

  @override
  State<UserDelete> createState() => _UserDeleteState();
}

class _UserDeleteState extends State<UserDelete> {
  // 사용자가 선택한 탈퇴 이유를 저장하는 변수
  String? _selectedReason;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('회원탈퇴', style: TextStyle(fontWeight: FontWeight.bold)),
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
      body: Stack(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 30, left: 22),
                child: Text(
                  '떠나시는 이유는 있을까요?',
                  style: TextStyle(
                    fontSize: 20,
                    color: Color(0xff222222),
                  ),
                ),
              ),
              SizedBox(height: 30),

              // 라디오 버튼 선택지
              Column(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      border: Border(
                        top: BorderSide(
                          color: Color(0xffeeeeee),
                          width: 1,
                        ),
                      ),
                    ),
                    child: RadioListTile<String>(
                      title: const Text('서비스가 기대에 미치지 못해요', style: TextStyle(
                        color: Color(0xff333333),
                      ),),
                      value: '서비스가 기대에 미치지 못해요',
                      groupValue: _selectedReason,
                      onChanged: (String? value) {
                        setState(() {
                          _selectedReason = value;
                        });
                      },
                      // contentPadding: EdgeInsets.zero,
                      visualDensity: VisualDensity(horizontal: -4),
                      activeColor: Colors.green,
                      selectedTileColor: Colors.lightGreen[100],
                    ),
                  ),

                  Container(
                    decoration: BoxDecoration(
                      border: Border(
                        top: BorderSide(
                          color: Color(0xffeeeeee),
                          width: 1,
                        ),
                      ),
                    ),
                    child: RadioListTile<String>(
                      title: const Text('사용을 잘 안하게 돼요', style: TextStyle(
                          color: Color(0xff333333)
                      ),),
                      value: '사용을 잘 안하게 돼요',
                      groupValue: _selectedReason,
                      onChanged: (String? value) {
                        setState(() {
                          _selectedReason = value;
                        });
                      },
                      // contentPadding: EdgeInsets.zero,
                      visualDensity: VisualDensity(horizontal: -4),
                      activeColor: Colors.green,
                      selectedTileColor: Colors.lightGreen[100],
                    ),
                  ),

                  Container(
                    decoration: BoxDecoration(
                      border: Border(
                        top: BorderSide(
                          color: Color(0xffeeeeee),
                          width: 1,
                        ),
                      ),
                    ),
                    child: RadioListTile<String>(
                      title: const Text('앱 사용이 불편해요', style: TextStyle(
                          color: Color(0xff333333)
                      ),),
                      value: '앱 사용이 불편해요',
                      groupValue: _selectedReason,
                      onChanged: (String? value) {
                        setState(() {
                          _selectedReason = value;
                        });
                      },
                      // contentPadding: EdgeInsets.zero,
                      visualDensity: VisualDensity(horizontal: -4),
                      activeColor: Colors.green,
                      selectedTileColor: Colors.lightGreen[100],
                    ),
                  ),

                  Container(
                    decoration: BoxDecoration(
                      border: Border(
                        top: BorderSide(
                          color: Color(0xffeeeeee),
                          width: 1,
                        ),
                      ),
                    ),
                    child: RadioListTile<String>(
                      title: const Text('다른 계정이 있어요', style: TextStyle(
                          color: Color(0xff333333)
                      ),),
                      value: '다른 계정이 있어요',
                      groupValue: _selectedReason,
                      onChanged: (String? value) {
                        setState(() {
                          _selectedReason = value;
                        });
                      },
                      // contentPadding: EdgeInsets.zero,
                      visualDensity: VisualDensity(horizontal: -4),
                      activeColor: Colors.green,
                      selectedTileColor: Colors.lightGreen[100],
                    ),
                  ),

                  Container(
                    decoration: BoxDecoration(
                      border: Border(
                        top: BorderSide(
                          color: Color(0xffeeeeee),
                          width: 1,
                        ),

                        bottom: BorderSide(
                          color: Color(0xffeeeeee),
                          width: 1,
                        ),
                      ),
                    ),
                    child: RadioListTile<String>(
                      title: const Text('기타', style: TextStyle(
                          color: Color(0xff333333)
                      ),),
                      value: '기타',
                      groupValue: _selectedReason,
                      onChanged: (String? value) {
                        setState(() {
                          _selectedReason = value;
                        });
                      },
                      // contentPadding: EdgeInsets.zero,
                      visualDensity: VisualDensity(horizontal: -4),
                      activeColor: Colors.green,
                      selectedTileColor: Colors.lightGreen[100],
                    ),
                  ),
                ],
              ),
            ],
          ),

          Positioned(
            bottom: 16,
            left: 0,
            right: 0,
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: ElevatedButton(
                onPressed: _selectedReason != null ? () {
                  showModalBottomSheet(
                    context: context,
                    builder: (BuildContext context) {
                      return Container(
                        padding: EdgeInsets.symmetric(vertical: 40, horizontal: 32),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            Text(
                              '정말 탈퇴 하시겠습니까?',
                              style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold
                              ),
                            ),
                            SizedBox(height: 10,),
                            Text(
                              '회원탈퇴되면 원룸의 일부 기능의\n사용이 제한됩니다.',
                              style: TextStyle(
                                  fontSize: 16,
                                  color: Color(0xff787878)
                              ),
                              textAlign: TextAlign.center,
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
                                                        '회원탈퇴가 완료되었습니다',
                                                        style: TextStyle(
                                                          fontSize: 20,
                                                          fontWeight: FontWeight.bold,
                                                        ),
                                                        textAlign: TextAlign.center,
                                                      ),
                                                      SizedBox(height: 5),
                                                      Text(
                                                        '다시 찾아주실때는 더욱\n만족하실 수 있도록 노력하겠습니다.',
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
                                                            // 회원탈퇴 기능

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
                                          '탈퇴',
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
                } : null, // 선택하지 않은 경우 버튼 비활성화
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xff595959),
                  elevation: 0,
                  padding: EdgeInsets.symmetric(vertical: 16), // 버튼 높이 조절
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: Text(
                  '회원탈퇴',
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

