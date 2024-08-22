import 'package:flutter/material.dart';
import 'package:wonroom/Finding_Pw.dart';
import 'join.dart'; // Join 화면을 가져옵니다.

class Login extends StatelessWidget {
  Login({super.key});

  // _passwordController 선언
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.chevron_left),
          onPressed: () {
            Navigator.of(context).pop(); // 뒤로 가기
          },
        ),
        title: const Text('로그인'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Expanded(
              child: SingleChildScrollView(
                child: Form(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Row(
                        children: const <Widget>[
                          Icon(Icons.person_outline, size: 24), // person 아이콘
                          SizedBox(width: 8.0), // 아이콘과 텍스트 사이의 간격
                          Text(
                            '아이디',
                            style: TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 8.0),
                      TextFormField(
                        decoration: const InputDecoration(
                          labelText: '아이디',
                          border: OutlineInputBorder(),
                          contentPadding: EdgeInsets.symmetric(horizontal: 12.0, vertical: 10.0),
                          errorStyle: TextStyle(
                            color: Colors.red, // 에러 메시지의 색상
                            fontSize: 12, // 에러 메시지의 글자 크기
                          ),
                        ),
                      ),
                      const SizedBox(height: 25.0),
                      Row(
                        children: const <Widget>[
                          Icon(Icons.lock_outline, size: 24),
                          SizedBox(width: 8.0), // 아이콘과 텍스트 사이의 간격
                          Text(
                            '비밀번호',
                            style: TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 8.0),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          TextFormField(
                            controller: _passwordController,
                            decoration: const InputDecoration(
                              hintText: 'ex. won01room%',
                              border: OutlineInputBorder(),
                              contentPadding: EdgeInsets.symmetric(horizontal: 12.0, vertical: 10.0),
                              suffixIcon: Icon(Icons.visibility_off_outlined),
                            ),
                            obscureText: true,
                            validator: (value) {
                              if (value == null || value.length < 8) {
                                return '비밀번호는 8자리 이상이어야 합니다.';
                              }
                              return null;
                            },
                          ),
                          const SizedBox(height: 4.0), // 비밀번호 조건과 필드 사이의 간격
                          Text(
                            '영문, 숫자, 특수문자("제외) 포함 8자리 이상',
                            style: TextStyle(
                              fontSize: 13,
                              color: Colors.grey[700], // 설명 텍스트 색상
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 45.0),
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: () {
                            // 로그인 버튼 클릭 시 실행될 코드
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.grey[400], // 회색 배경색
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.zero, // 직사각형 모양
                            ),
                            padding: const EdgeInsets.symmetric(vertical: 12), // 버튼 높이 설정
                          ),
                          child: const Text(
                            '로그인',
                            style: TextStyle(color: Colors.white, fontSize: 22), // 흰색 글씨
                          ),
                        ),
                      ),
                      const SizedBox(height: 16.0),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          TextButton(
                            onPressed: () {
                              // 아이디 찾기 클릭 시 실행될 코드
                            },
                            child: const Text(
                              '아이디 찾기',
                              style: TextStyle(fontSize: 17, color: Colors.grey),
                            ),
                          ),
                          const Text('|', style: TextStyle(color: Colors.black)),
                          TextButton(
                            onPressed: () {
                              // 비밀번호 찾기 클릭 시 실행될 코드
                              Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) => FindingPw()),
                              );
                            },
                            child: const Text(
                              '비밀번호 찾기',
                              style: TextStyle(fontSize: 17, color: Colors.grey),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 56.0),
                      SizedBox(
                        width: double.infinity,
                        child: OutlinedButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => Join()),
                            );
                          },
                          style: OutlinedButton.styleFrom(
                            side: BorderSide(color: Color(0xff6bbe45), width: 2), // 테두리 색상과 두께
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.zero, // 직사각형 모양
                            ),
                            padding: const EdgeInsets.symmetric(vertical: 12.0), // 버튼 높이 설정
                          ),
                          child: const Text(
                            '회원가입',
                            style: TextStyle(color: Color(0xff6bbe45), fontSize: 22), // 초록색 글씨
                          ),
                        ),
                      ),
                    ],
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
