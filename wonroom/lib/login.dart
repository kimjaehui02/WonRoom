import 'package:flutter/material.dart';
import 'package:wonroom/findingPw.dart';
import 'package:wonroom/Finding_Pw/Finding_Pw_functions.dart';
import 'package:wonroom/Login/LoginValidators.dart';
import 'package:wonroom/findingId.dart';
import 'join.dart'; // Join 화면을 가져옵니다.

class Login extends StatefulWidget {
  Login({super.key});

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final TextEditingController _idController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  bool _obscurePassword = true;

  bool _buttonAble = false;

  String _idHint = ' '; // 초기 힌트 텍스트
  String _passwordHint = '영문, 숫자, 특수문자("제외) 포함 8자리 이상'; // 초기 힌트 텍스트

  @override
  void initState() {
    super.initState();

    // 리스너 등록
    _idController.addListener(_onTextChanged);
    _passwordController.addListener(_onTextChanged);
  }

  @override
  void dispose() {
    // 리스너 해제
    _idController.removeListener(_onTextChanged);
    _passwordController.removeListener(_onTextChanged);

    // 컨트롤러 해제
    _idController.dispose();
    _passwordController.dispose();

    super.dispose();
  }

  // 입력값 변경 시 호출될 함수
  void _onTextChanged() {
    // 여기에 입력값 변경 시 실행할 작업을 추가
    // print('ID: ${_idController.text}');
    // print('Password: ${_passwordController.text}');

    // 예를 들어, 입력값에 따라 로그인 버튼의 활성화 상태를 조절할 수 있습니다.
    // setState(() {
    //   // 버튼 활성화/비활성화 로직
    // });

    print(_idController.text);
    print(_passwordController.text);
    // 텍스트를 입력받으면 힌트메세지를 바꿔서 어떤상황인지 알려준다
    setState(() {
      // 올바르게 클래스 변수 업데이트
      if (_idController.text.isEmpty) {
        _idHint = ' ';
      } else {
        _idHint = LoginValidators.validateUserId(_idController.text) ?? ' ';
      }

      // _passwordHint = LoginValidators.validatePassword(_passwordController.text) ?? ' ';
    });


    print(_idHint);
    print(_passwordHint);
    // 둘다 문제가 없다면 실행하여 버튼 활성화를 시켜준다
    _buttonAble = LoginValidators.buttonAble(_idController.text, _passwordController.text);
  }


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
                        controller: _idController, // 컨트롤러를 지정합니다.
                        decoration: const InputDecoration(
                          // labelText: '아이디',
                          hintText: 'wonroom',
                          border: OutlineInputBorder(),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Color(0xff6bbe45), width: 2.0), // 포커스 시 테두리 색상 및 두께
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Color(0xffc2c2c2), width: 1.0), // 비포커스 상태에서의 테두리 색상 및 두께
                          ),
                          contentPadding: EdgeInsets.symmetric(horizontal: 12.0, vertical: 10.0),
                          errorStyle: TextStyle(
                            color: Colors.red, // 에러 메시지의 색상
                            fontSize: 12, // 에러 메시지의 글자 크기
                          ),
                        ),
                      ),
                      const SizedBox(height: 4.0), // 비밀번호 조건과 필드 사이의 간격
                      Padding(
                        padding: const EdgeInsets.only(left: 10),
                        child: Text(
                          _idHint,
                          style: TextStyle(
                            fontSize: 13,
                            color: Colors.grey[700], // 설명 텍스트 색상
                          ),
                        ),
                      ),
                      const SizedBox(height: 16),
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
                            decoration: InputDecoration(
                              hintText: 'ex. won01room%',
                              border: OutlineInputBorder(),
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: Color(0xff6bbe45), width: 2.0), // 포커스 시 테두리 색상 및 두께
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: Color(0xffc2c2c2), width: 1.0), // 비포커스 상태에서의 테두리 색상 및 두께
                              ),
                              contentPadding: EdgeInsets.symmetric(horizontal: 12.0, vertical: 10.0),
                              suffixIcon: IconButton(
                                icon: Icon(
                                  _obscurePassword ? Icons.visibility_off_outlined : Icons.visibility_outlined,
                                  color: Color(0xffc2c2c2),
                                ),
                                onPressed: () {
                                  setState(() {
                                    _obscurePassword = !_obscurePassword;
                                  });
                                },
                              ),
                            ),
                            obscureText: _obscurePassword,
                            validator: (value) {
                              if (value == null || value.length < 8) {
                                return '비밀번호는 8자리 이상이어야 합니다.';
                              }
                              return null;
                            },
                          ),
                          const SizedBox(height: 4.0), // 비밀번호 조건과 필드 사이의 간격
                          Padding(
                            padding: const EdgeInsets.only(left: 10),
                            child: Text(
                              _passwordHint,
                              style: TextStyle(
                                fontSize: 13,
                                color: Colors.grey[700], // 설명 텍스트 색상
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 45.0),
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: () async
                          {
                            // 로그인시 사용되는 버튼

                            // 로그인 버튼 클릭 시 실행될 코드
                            
                            // 버튼이 누를 수 있는 상태를 미리 bool형으로 저장해둠
                            // 그걸 기준으로 버튼 클릭시 작동을 정함
                            if(_buttonAble == true)
                            {
                              // 버튼이 누를 수 있는 경우
                              // LoginValidators는 로그인시 중복되는값이나 규칙을 미리 만들어둔 클래스
                              // 규칙에 전부 맞으면 check는 환영합니다 라고 리턴함
                              String check = await LoginValidators.validateLogin(_idController.text, _passwordController.text) ?? "예외상황 발생";
                              print(check);
                              print(check);
                              print(check);
                              print(check);
                              if(check == '환영합니다.')
                              {

                                LoginValidators.showSuccessDialog(context, check);
                              }
                              else
                              {
                                LoginValidators.showErrorDialog(context, check);
                              }


                            }
                            // 로그인 결과 처리
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: _buttonAble ? Colors.green : Colors.grey,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(3)
                            ),
                            padding: const EdgeInsets.symmetric(vertical: 10), // 버튼 높이 설정
                          ),
                          child: const Text(
                            '로그인',
                            style: TextStyle(color: Colors.white, fontSize: 22, fontWeight: FontWeight.bold), // 흰색 글씨
                          ),
                        ),
                      ),
                      const SizedBox(height: 10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          TextButton(
                            onPressed: () {
                              // 아이디 찾기 클릭 시 실행될 코드
                              findUserId('602호고양이도둑', 'qwerqwer@naver.com');
                              Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) => FindingId()),
                              );
                            },
                            child: const Text(
                              '아이디 찾기',
                              style: TextStyle(fontSize: 17, color: Color(0xff787878)),
                            ),
                          ),
                          const Text('|', style: TextStyle(color: Color(0xffc2c2c2))),
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
                              style: TextStyle(fontSize: 17, color: Color(0xff787878)),
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
                            side: BorderSide(color: Color(0xff6bbe45), width: 1.5), // 테두리 색상과 두께
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(3),
                            ),
                            padding: const EdgeInsets.symmetric(vertical: 10), // 버튼 높이 설정
                          ),
                          child: const Text(
                            '회원가입',
                            style: TextStyle(color: Color(0xff6bbe45), fontSize: 22, fontWeight: FontWeight.bold), // 초록색 글씨
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
