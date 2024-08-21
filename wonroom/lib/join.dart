import 'package:flutter/material.dart';

class Join extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SignUpScreen();
  }
}

class SignUpScreen extends StatefulWidget {
  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {

  final _idFocusNode = FocusNode(); // FocusNode 추가

  final _formKey = GlobalKey<FormState>();
  final _idController = TextEditingController();
  final _passwordController = TextEditingController();
  final _passwordConfirmController = TextEditingController();
  final _nicknameController = TextEditingController();
  final _emailController = TextEditingController();
  bool _isIdDuplicate = false; // 중복된 아이디 확인
  bool _isButtonEnabled = true; // 버튼 활성화 상태
  String? _emailValidationMessage; // 이메일 검증 메시지
  String? _nicknameValidationMessage; // 닉네임 검증 메시지
  String? _idValidationMessage; // 아이디 검증 메시지

  // 비밀번호 보이기/숨기기 상태 변수
  bool _obscurePassword = true;
  bool _obscureConfirmPassword = true;

  @override
  void initState() {
    super.initState();

    _idController.addListener(_updateButtonState);
    _passwordController.addListener(_updateButtonState);
    _passwordConfirmController.addListener(_updateButtonState);
    _nicknameController.addListener(_updateNicknameValidation);
    _emailController.addListener(_updateEmailValidation);
    _idController.addListener(_updateIdValidation); // 아이디 검증 호출
    _idFocusNode.addListener(_updateIdValidation); // FocusNode에 리스너 추가
  }

  void _updateButtonState() {
    setState(() {
      _isButtonEnabled = _idController.text.isNotEmpty &&
          _passwordController.text.isNotEmpty &&
          _passwordConfirmController.text.isNotEmpty &&
          _nicknameController.text.isNotEmpty &&
          _emailController.text.isNotEmpty &&
          _passwordController.text == _passwordConfirmController.text;
    });
  }

  void _updateEmailValidation() {
    final email = _emailController.text;

    setState(() {
      if (email.isEmpty) {
        _emailValidationMessage = null;
      } else if (RegExp(r'^[^@]+@[^@]+\.[^@]+$').hasMatch(email)) {
        _emailValidationMessage = '사용 가능한 이메일입니다.';
      } else {
        _emailValidationMessage = '이메일 형식이 잘못되었습니다.';
      }
    });
  }

  void _updateNicknameValidation() {
    final nickname = _nicknameController.text;

    setState(() {
      if (nickname.isEmpty) {
        _nicknameValidationMessage = null;
      } else {
        _nicknameValidationMessage = nickname.length >= 3 ? '사용 가능한 닉네임입니다.' : null;
      }
    });
  }

  void _updateIdValidation() {
    final id = _idController.text;

    if (!_idFocusNode.hasFocus) { // 포커스를 잃을 때만 검사
      setState(() {
        if (id.isEmpty) {
          _idValidationMessage = null;
        } else {
          // 아이디 중복 검사 예시 (실제 중복 체크 로직은 서버와 연동되어야 함)
          _idValidationMessage =
          id == "wonroom" ? '중복된 아이디입니다.' : '사용 가능한 아이디입니다.';
          _isIdDuplicate = id == "wonroom";
        }
      });
    }
  }

  void _showSuccessDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0), // 모달 창 모서리 둥글게
          ),
          child: Container(
            padding: EdgeInsets.all(20.0), // 모달 창 내부 패딩 추가
            constraints: BoxConstraints(maxWidth: 400), // 모달 창 최대 너비 설정
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  '회원가입 완료',
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 16.0), // 제목과 내용 사이 간격
                Text(
                  '지금 바로 건강한 반려식물\n관리를 시작해보세요.',
                  style: TextStyle(fontSize: 18),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 24.0), // 내용과 버튼 사이 간격
                SizedBox(
                  width: double.infinity, // 버튼을 창 너비에 맞추기
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).pop(); // 모달 닫기
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green, // 버튼 배경색 초록색으로 설정
                      padding: EdgeInsets.symmetric(vertical: 14.0), // 버튼 패딩 설정
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8.0), // 버튼 모서리 둥글게
                      ),
                    ),
                    child: Text(
                      '확인',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.white, // 텍스트 색상을 흰색으로 설정
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
  }


  @override
  void dispose() {
    _idController.dispose();

    _idFocusNode.dispose(); // FocusNode 리소스 해제

    _passwordController.dispose();
    _passwordConfirmController.dispose();
    _nicknameController.dispose();
    _emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.chevron_left),
          onPressed: () {
            Navigator.of(context).pop(); // 뒤로 가기
          },
        ),
        title: Text('회원가입'),
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
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Row(
                        children: <Widget>[
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
                      SizedBox(height: 8.0),
                      TextFormField(
                        controller: _idController,
                        focusNode: _idFocusNode, // FocusNode 연결
                        decoration: InputDecoration(
                          labelText: '아이디',
                          errorText: _isIdDuplicate ? _idValidationMessage : null,
                          border: OutlineInputBorder(),
                          contentPadding: EdgeInsets.symmetric(horizontal: 12.0, vertical: 10.0),
                          errorStyle: TextStyle(
                            color: Colors.red, // 에러 메시지의 색상
                            fontSize: 12, // 에러 메시지의 글자 크기
                          ),
                        ),
                        onChanged: (_) => _updateIdValidation(), // 아이디 검증 호출
                      ),
                      if (_idValidationMessage == '사용 가능한 아이디입니다.')
                        Padding(
                          padding: const EdgeInsets.only(top: 8.0),
                          child: Text(
                            _idValidationMessage!,
                            style: TextStyle(
                              color: Colors.green, // 초록색 글씨
                              fontSize: 12, // 작은 글씨
                            ),
                          ),
                        ),
                      SizedBox(height: 25.0),
                      Row(
                        children: <Widget>[
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
                      SizedBox(height: 8.0),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          TextFormField(
                            controller: _passwordController,
                            decoration: InputDecoration(
                              hintText: 'ex. won01room%',
                              border: OutlineInputBorder(),
                              contentPadding: EdgeInsets.symmetric(horizontal: 12.0, vertical: 10.0),
                              suffixIcon: IconButton(
                                icon: Icon(
                                  _obscurePassword ? Icons.visibility_off_outlined : Icons.visibility_outlined,
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
                          SizedBox(height: 4.0), // 비밀번호 조건과 필드 사이의 간격
                          Text(
                            '영문, 숫자, 특수문자("제외) 포함 8자리 이상',
                            style: TextStyle(
                              fontSize: 13,
                              color: Colors.grey[700], // 설명 텍스트 색상
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 25.0),
                      Row(
                        children: <Widget>[
                          Icon(Icons.lock_outline, size: 24),
                          SizedBox(width: 8.0), // 아이콘과 텍스트 사이의 간격
                          Text(
                            '비밀번호 확인',
                            style: TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 8.0),
                      TextFormField(
                        controller: _passwordConfirmController,
                        decoration: InputDecoration(
                          hintText: 'ex. won01room%',
                          border: OutlineInputBorder(),
                          contentPadding: EdgeInsets.symmetric(horizontal: 12.0, vertical: 10.0),
                          suffixIcon: IconButton(
                            icon: Icon(
                              _obscureConfirmPassword  ? Icons.visibility_off_outlined : Icons.visibility_outlined,
                            ),
                            onPressed: () {
                              setState(() {
                                _obscureConfirmPassword = !_obscureConfirmPassword;
                              });
                            },
                          ),
                        ),
                        obscureText: _obscureConfirmPassword,
                        validator: (value) {
                          if (value != _passwordController.text) {
                            return '비밀번호가 일치하지 않습니다.';
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: 25.0),
                      Row(
                        children: <Widget>[
                          Icon(Icons.account_circle_outlined, size: 24), // person 아이콘
                          SizedBox(width: 8.0), // 아이콘과 텍스트 사이의 간격
                          Text(
                            '닉네임',
                            style: TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 8.0),
                      TextFormField(
                        controller: _nicknameController,
                        decoration: InputDecoration(
                          labelText: '닉네임',
                          border: OutlineInputBorder(),
                          contentPadding: EdgeInsets.symmetric(horizontal: 12.0, vertical: 10.0),
                        ),
                        onChanged: (_) => _updateNicknameValidation(), // 닉네임 검증 호출
                      ),
                      if (_nicknameValidationMessage == '사용 가능한 닉네임입니다.')
                        Padding(
                          padding: const EdgeInsets.only(top: 8.0),
                          child: Text(
                            _nicknameValidationMessage!,
                            style: TextStyle(
                              color: Colors.green, // 초록색 글씨
                              fontSize: 12, // 작은 글씨
                            ),
                          ),
                        ),
                      SizedBox(height: 25.0),
                      Row(
                        children: <Widget>[
                          Icon(Icons.local_post_office_outlined, size: 24), // 이메일 아이콘
                          SizedBox(width: 8.0), // 아이콘과 텍스트 사이의 간격
                          Text(
                            '이메일',
                            style: TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 8.0),
                      TextFormField(
                        controller: _emailController,
                        decoration: InputDecoration(
                          labelText: '이메일',
                          errorText: _emailValidationMessage == '사용 가능한 이메일입니다.' ? null : _emailValidationMessage,
                          border: OutlineInputBorder(),
                          contentPadding: EdgeInsets.symmetric(horizontal: 12.0, vertical: 10.0),
                          errorStyle: TextStyle(
                            color: Colors.red, // 에러 메시지의 색상
                            fontSize: 12, // 에러 메시지의 글자 크기
                          ),
                        ),
                        onChanged: (_) => _updateEmailValidation(), // 이메일 검증 호출
                      ),
                      if (_emailValidationMessage == '사용 가능한 이메일입니다.')
                        Padding(
                          padding: const EdgeInsets.only(top: 8.0),
                          child: Text(
                            _emailValidationMessage!,
                            style: TextStyle(
                              color: Colors.green, // 초록색 글씨
                              fontSize: 12, // 작은 글씨
                            ),
                          ),
                        ),
                      SizedBox(height: 25.0),
                    ],
                  ),
                ),
              ),
            ),
            ElevatedButton(
              onPressed: _isButtonEnabled ? () {
                if (_formKey.currentState!.validate()) {
                  setState(() {
                    // 중복된 아이디 체크
                    _isIdDuplicate = _idController.text == "wonroom";
                  });

                  if (!_isIdDuplicate) {
                    // 회원가입 처리 로직
                    _showSuccessDialog(); // 모달 창 띄우기
                  }
                }
              } : null,
              style: ElevatedButton.styleFrom(
                backgroundColor: _isButtonEnabled ? Colors.green : Colors.grey[400], // 초록색 또는 회색 배경
                minimumSize: Size(double.infinity, 48), // 버튼의 최소 너비와 높이 설정
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.zero, // 직사각형 모서리
                ),
                padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
              ),
              child: Text(
                '확인',
                style: TextStyle(
                  fontSize: 19, // 텍스트 크기
                  fontWeight: FontWeight.bold, // 텍스트 굵기
                  color: Colors.white, // 텍스트 색상 흰색
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
