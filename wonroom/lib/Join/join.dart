import 'package:flutter/material.dart';
import 'validators.dart';
import 'controllers.dart';

class Join extends StatefulWidget {
  @override
  _JoinState createState() => _JoinState();
}

class _JoinState extends State<Join> {
  final _formControllers = FormControllers();
  final _formKey = GlobalKey<FormState>();
  bool _obscurePassword = true;
  bool _obscureConfirmPassword = true;
  String? _idValidationMessage;
  String? _nicknameValidationMessage;
  String? _emailValidationMessage;

  @override
  void initState() {
    super.initState();

    _formControllers.idController.addListener(_updateButtonState);
    _formControllers.passwordController.addListener(_updateButtonState);
    _formControllers.passwordConfirmController.addListener(_updateButtonState);
    _formControllers.nicknameController.addListener(_updateNicknameValidation);
    _formControllers.emailController.addListener(_updateEmailValidation);
    _formControllers.idController.addListener(_updateIdValidation); // 아이디 검증 호출
    _formControllers.idFocusNode.addListener(_updateIdValidation); // FocusNode에 리스너 추가
  }

  void _updateButtonState() {
    setState(() {
      _formControllers.isButtonEnabled = _formControllers.idController.text.isNotEmpty &&
          _formControllers.passwordController.text.isNotEmpty &&
          _formControllers.passwordConfirmController.text.isNotEmpty &&
          _formControllers.nicknameController.text.isNotEmpty &&
          _formControllers.emailController.text.isNotEmpty &&
          _formControllers.passwordController.text == _formControllers.passwordConfirmController.text;
    });
  }

  void _updateEmailValidation() {
    setState(() {
      _emailValidationMessage = Validators.validateEmail(_formControllers.emailController.text);
    });
  }

  void _updateNicknameValidation() {
    setState(() {
      _nicknameValidationMessage = Validators.validateNickname(_formControllers.nicknameController.text);
    });
  }

  void _updateIdValidation() {
    final id = _formControllers.idController.text;
    if (!_formControllers.idFocusNode.hasFocus) { // 포커스를 잃을 때만 검사
      setState(() {
        final validationMessage = Validators.validateId(id);
        _formControllers.isIdDuplicate = id == "wonroom";
        _idValidationMessage = validationMessage;
      });
    }
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
                Text(
                  '회원가입 완료',
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 16.0),
                Text(
                  '지금 바로 건강한 반려식물\n관리를 시작해보세요.',
                  style: TextStyle(fontSize: 18),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 24.0),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).pop(); // 모달 닫기
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green,
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
    _formControllers.dispose(); // 모든 컨트롤러 및 FocusNode 리소스 해제
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
                      _buildIdField(),
                      _buildPasswordField(),
                      _buildConfirmPasswordField(),
                      _buildNicknameField(),
                      _buildEmailField(),
                    ],
                  ),
                ),
              ),
            ),
            ElevatedButton(
              onPressed: _formControllers.isButtonEnabled ? () {
                if (_formKey.currentState!.validate()) {
                  setState(() {
                    // 중복된 아이디 체크
                    _formControllers.isIdDuplicate = _formControllers.idController.text == "wonroom";
                  });

                  if (!_formControllers.isIdDuplicate) {
                    // 회원가입 처리 로직
                    _showSuccessDialog(); // 모달 창 띄우기
                  }
                }
              } : null,
              style: ElevatedButton.styleFrom(
                backgroundColor: _formControllers.isButtonEnabled ? Colors.green : Colors.grey[400],
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

  Widget _buildIdField() {
    return Column(
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
          controller: _formControllers.idController,
          focusNode: _formControllers.idFocusNode,
          decoration: InputDecoration(
            labelText: '아이디',
            errorText: _formControllers.isIdDuplicate ? _idValidationMessage : null,
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
      ],
    );
  }

  Widget _buildPasswordField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
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
        TextFormField(
          controller: _formControllers.passwordController,
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
          validator: (value) => Validators.validatePassword(value),
        ),
        SizedBox(height: 4.0),
        Text(
          '영문, 숫자, 특수문자("제외) 포함 8자리 이상',
          style: TextStyle(
            fontSize: 13,
            color: Colors.grey[700],
          ),
        ),
        SizedBox(height: 25.0),
      ],
    );
  }

  Widget _buildConfirmPasswordField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
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
          controller: _formControllers.passwordConfirmController,
          decoration: InputDecoration(
            hintText: 'ex. won01room%',
            border: OutlineInputBorder(),
            contentPadding: EdgeInsets.symmetric(horizontal: 12.0, vertical: 10.0),
            suffixIcon: IconButton(
              icon: Icon(
                _obscureConfirmPassword ? Icons.visibility_off_outlined : Icons.visibility_outlined,
              ),
              onPressed: () {
                setState(() {
                  _obscureConfirmPassword = !_obscureConfirmPassword;
                });
              },
            ),
          ),
          obscureText: _obscureConfirmPassword,
          validator: (value) => Validators.validateConfirmPassword(value, _formControllers.passwordController.text),
        ),
        SizedBox(height: 25.0),
      ],
    );
  }

  Widget _buildNicknameField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
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
          controller: _formControllers.nicknameController,
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
          )
        else
          Padding(
            padding: const EdgeInsets.only(top: 8.0),
            child: Text(
              _nicknameValidationMessage ?? '', // 기본값을 설정하거나 빈 문자열을 사용
              style: TextStyle(
                color: Colors.red,
                fontSize: 12,
              ),
            ),
          ),

        SizedBox(height: 25.0),
      ],
    );
  }

  Widget _buildEmailField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
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
          controller: _formControllers.emailController,
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
    );
  }
}
