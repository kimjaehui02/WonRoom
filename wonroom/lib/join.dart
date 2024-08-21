import 'package:flutter/material.dart';

class Join extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: SignUpScreen(),
    );
  }
}

class SignUpScreen extends StatefulWidget {
  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final _formKey = GlobalKey<FormState>();
  final _idController = TextEditingController();
  final _passwordController = TextEditingController();
  final _passwordConfirmController = TextEditingController();
  final _nicknameController = TextEditingController();
  final _emailController = TextEditingController();
  bool _isIdDuplicate = false;
  bool _isButtonEnabled = true;
  String? _emailValidationMessage;
  String? _nicknameValidationMessage;
  String? _idValidationMessage;

  @override
  void initState() {
    super.initState();
    _idController.addListener(_updateButtonState);
    _passwordController.addListener(_updateButtonState);
    _passwordConfirmController.addListener(_updateButtonState);
    _nicknameController.addListener(_updateNicknameValidation);
    _emailController.addListener(_updateEmailValidation);
    _idController.addListener(_updateIdValidation);
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
    setState(() {
      if (id.isEmpty) {
        _idValidationMessage = null;
      } else {
        _idValidationMessage = id == "wonroom" ? '중복된 아이디입니다.' : '사용 가능한 아이디입니다.';
        _isIdDuplicate = id == "wonroom";
      }
    });
  }

  void _showSuccessDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
          child: Container(
            padding: EdgeInsets.all(20.0),
            constraints: BoxConstraints(maxWidth: 400),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                ColorFiltered(
                  colorFilter: ColorFilter.mode(
                    Color(0xFF6BBE44), // 연두색
                    BlendMode.srcIn, // 색상 혼합 모드
                  ),
                  child: Image.asset(
                    'images/회원가입체크.png',
                    width: 100,
                    height: 100,
                  ),
                ),
                SizedBox(height: 0),
                Text(
                  '회원가입 완료',
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 6.0),
                Text(
                  '지금 바로 건강한 반려식물\n관리를 시작해보세요.',
                  style: TextStyle(fontSize: 18, color: Colors.grey),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 24.0),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color(0xff6bbe45),
                      padding: EdgeInsets.symmetric(vertical: 14.0),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                    ),
                    child: Text(
                      '확인',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
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
            Navigator.of(context).pop();
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
                          Icon(Icons.person_outline, size: 24),
                          SizedBox(width: 8.0),
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
                        decoration: InputDecoration(
                          labelText: '아이디',
                          errorText: _isIdDuplicate ? _idValidationMessage : null,
                          border: OutlineInputBorder(),
                          contentPadding: EdgeInsets.symmetric(horizontal: 12.0, vertical: 10.0),
                          errorStyle: TextStyle(
                            color: Colors.red,
                            fontSize: 12,
                          ),
                        ),
                        onChanged: (_) => _updateIdValidation(),
                      ),
                      if (_idValidationMessage == '사용 가능한 아이디입니다.')
                        Padding(
                          padding: const EdgeInsets.only(top: 8.0),
                          child: Text(
                            _idValidationMessage!,
                            style: TextStyle(
                              color: Colors.green,
                              fontSize: 12,
                            ),
                          ),
                        ),
                      SizedBox(height: 25.0),
                      Row(
                        children: <Widget>[
                          Icon(Icons.lock_outline, size: 24),
                          SizedBox(width: 8.0),
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
                          SizedBox(height: 4.0),
                          Text(
                            '영문, 숫자, 특수문자("제외) 포함 8자리 이상',
                            style: TextStyle(
                              fontSize: 13,
                              color: Colors.grey[700],
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 25.0),
                      Row(
                        children: <Widget>[
                          Icon(Icons.lock_outline, size: 24),
                          SizedBox(width: 8.0),
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
                          suffixIcon: Icon(Icons.visibility_off_outlined),
                        ),
                        obscureText: true,
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
                          Icon(Icons.account_circle_outlined, size: 24),
                          SizedBox(width: 8.0),
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
                        onChanged: (_) => _updateNicknameValidation(),
                      ),
                      if (_nicknameValidationMessage == '사용 가능한 닉네임입니다.')
                        Padding(
                          padding: const EdgeInsets.only(top: 8.0),
                          child: Text(
                            _nicknameValidationMessage!,
                            style: TextStyle(
                              color: Colors.green,
                              fontSize: 12,
                            ),
                          ),
                        ),
                      SizedBox(height: 25.0),
                      Row(
                        children: <Widget>[
                          Icon(Icons.local_post_office_outlined, size: 24),
                          SizedBox(width: 8.0),
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
                            color: Colors.red,
                            fontSize: 12,
                          ),
                        ),
                        onChanged: (_) => _updateEmailValidation(),
                      ),
                      if (_emailValidationMessage == '사용 가능한 이메일입니다.')
                        Padding(
                          padding: const EdgeInsets.only(top: 8.0),
                          child: Text(
                            _emailValidationMessage!,
                            style: TextStyle(
                              color: Colors.green,
                              fontSize: 12,
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
                    _isIdDuplicate = _idController.text == "wonroom";
                  });

                  if (!_isIdDuplicate) {
                    _showSuccessDialog();
                  }
                }
              } : null,
              style: ElevatedButton.styleFrom(
                backgroundColor: _isButtonEnabled ? Color(0xff6bbe45) : Colors.grey[400],
                minimumSize: Size(double.infinity, 48),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.zero,
                ),
                padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
              ),
              child: Text(
                '확인',
                style: TextStyle(
                  fontSize: 19,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
