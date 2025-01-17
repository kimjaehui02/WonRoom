import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'Join/validators.dart';
import 'Join/controllers.dart';

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

  String? idCheck;
  String? nicknameCheck;
  String? emailCheck;

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
    _formControllers.emailFocusNode.addListener(_updateEmailValidation); // FocusNode에 리스너 추가
    _formControllers.nicknameFocusNode.addListener(_updateNicknameValidation); // FocusNode에 리스너 추가
  }

  bool _updateButtonState() {
    // final idValid = _formControllers.idController.text.isNotEmpty;
    final idValid = _idValidationMessage == '사용 가능한 아이디 입니다.';
    final passwordNotEmpty = _formControllers.passwordController.text.isNotEmpty;
    // _emailValidationMessage
    final passwordConfirmNotEmpty = _formControllers.passwordConfirmController.text.isNotEmpty;
    // final nicknameValid = _formControllers.nicknameController.text.isNotEmpty;
    final nicknameValid = _nicknameValidationMessage == '사용 가능한 닉네임 입니다.';
    // final emailValid = _formControllers.emailController.text.isNotEmpty;
    final emailValid = _emailValidationMessage == '사용 가능한 이메일 입니다.';
    final passwordsMatch = _formControllers.passwordController.text == _formControllers.passwordConfirmController.text;

    final ids = _formControllers.idController.text;
    final ems = _formControllers.emailController.text;
    final nis = _formControllers.nicknameController.text;

    // 각 조건을 콘솔에 출력
    print('ID Valid: $ids');
    print('Password Not Empty: $ems');
    print('Password Confirm Not Empty: $nis');
    print('Nickname Valid: $nicknameValid');
    print('Email Valid: $emailValid');
    print('Passwords Match: $passwordsMatch');

    setState(() {
      _formControllers.isButtonEnabled = idValid &&
          passwordNotEmpty &&
          passwordConfirmNotEmpty &&
          nicknameValid &&
          emailValid &&
          passwordsMatch;
    });

    idCheck = ids;
    nicknameCheck = nis;
    emailCheck = ems;

    // 최종 버튼 활성화 상태를 콘솔에 출력
    print('Button Enabled: ${_formControllers.isButtonEnabled}');
    return _formControllers.isButtonEnabled;
  }

  // void _updateEmailValidation() {
  //
  //   if (!_formControllers.emailFocusNode.hasFocus) { // 포커스를 잃을 때만 검사
  //     setState(() {
  //       _emailValidationMessage = Validators.validateEmail(_formControllers.emailController.text);
  //     });
  //   }
  // }
  void _updateEmailValidation() async {
    if (!_formControllers.emailFocusNode.hasFocus) {
      final validationMessage = await Validators.validateEmail(_formControllers.emailController.text);

      // 상태가 변경될 때만 setState를 호출합니다.
      if (_emailValidationMessage != validationMessage) {
        setState(() {
          _emailValidationMessage = validationMessage;
        });
      }
    }
    _updateButtonState();
  }

  void _updateNicknameValidation() async {
    if (!_formControllers.nicknameFocusNode.hasFocus) {
      final validationMessage = await Validators.validateNickname(_formControllers.nicknameController.text);

      // 상태가 변경될 때만 setState를 호출합니다.
      if (_nicknameValidationMessage != validationMessage) {
        setState(() {
          _nicknameValidationMessage = validationMessage;
        });
      }
    }
    _updateButtonState();
  }

  void _updateIdValidation() async {
    if (!_formControllers.idFocusNode.hasFocus) {
      final validationMessage = await Validators.validateId(_formControllers.idController.text);

      // 상태가 변경될 때만 setState를 호출합니다.
      if (_idValidationMessage != validationMessage) {
        setState(() {
          _idValidationMessage = validationMessage;
        });
      }
    }
    _updateButtonState();
  }



  // void _updateIdValidation() {
  //   final id = _formControllers.idController.text;
  //   if (!_formControllers.idFocusNode.hasFocus) { // 포커스를 잃을 때만 검사
  //     setState(() {
  //       final validationMessage = Validators.validateId(id);
  //       _formControllers.isIdDuplicate = id == "wonroom";
  //       _idValidationMessage = validationMessage;
  //     });
  //   }
  // }




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
          icon: Icon(
            Icons.arrow_back_ios,
            color: Colors.grey,
          ),
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
            Container(
              width: double.infinity,
              margin: EdgeInsets.only(bottom: 20),
              child: ElevatedButton(
                onPressed: _formControllers.isButtonEnabled ? () async {
                  bool test = await Validators.validateAll(_formControllers.idController.text,
                      _formControllers.nicknameController.text,
                      _formControllers.emailController.text);
                  if(test)
                    {
                      // 회원가입 처리 로직
                      Validators.showSuccessDialog(context, _formControllers);
                    }
                  else
                  {
                    Validators.showErrorDialog(context, '입력 양식이 채워졌는지\n확인해주세요.');

                  }

                } : null,
                style: ElevatedButton.styleFrom(
                  backgroundColor: _formControllers.isButtonEnabled ? Color(0xff6bbe45) : Colors.grey[400],
                  minimumSize: Size(double.infinity, 48),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(3)
                  ),
                  padding: const EdgeInsets.symmetric(vertical: 12),
                ),
                child: Text(
                  '확인',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold
                  ),
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
        Padding(
          padding: const EdgeInsets.only(left: 6),
          child: Row(
            children: [
              Icon(Icons.person_outline, size: 24),
              SizedBox(width: 8.0),
              Text(
                '아이디',
                style: TextStyle(
                  fontSize: 21,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: 10),
        TextFormField(
          controller: _formControllers.idController,
          focusNode: _formControllers.idFocusNode,
          decoration: InputDecoration(
            // labelText: '아이디',
            hintText: 'ex. wonroom',
            errorText: _formControllers.isIdDuplicate ? _idValidationMessage ?? '' : null,
            // border: OutlineInputBorder(),
            contentPadding: EdgeInsets.symmetric(horizontal: 12.0, vertical: 10.0),
            errorStyle: TextStyle(
              color: Colors.red,
              fontSize: 12,
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Color(0xff6bbe45), width: 2.0), // 포커스 시 테두리 색상 및 두께
            ),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Color(0xffc2c2c2), width: 1.0), // 비포커스 상태에서의 테두리 색상 및 두께
            ),
            // errorBorder: OutlineInputBorder(
            //   borderSide: BorderSide(color: Colors.red, width: 2.0), // 에러 발생 시 테두리 색상 및 두께
            // ),
            // focusedErrorBorder: OutlineInputBorder(
            //   borderSide: BorderSide(color: Color(0xff6bbe45), width: 2.0), // 포커스 및 에러 발생 시 테두리 색상 및 두께
            // ),
          ),
          // onChanged: (_) => _updateIdValidation(),
        ),
        if (_idValidationMessage != null)
          Padding(
            padding: const EdgeInsets.only(top: 8.0, left: 10),
            child: Text(
              _idValidationMessage!,
              style: TextStyle(
                color: _idValidationMessage == '사용 가능한 아이디 입니다.' ? Colors.green : Colors.red,
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
        Padding(
          padding: const EdgeInsets.only(left: 6),
          child: Row(
            children: [
              Icon(Icons.lock_outline, size: 24),
              SizedBox(width: 8.0),
              Text(
                '비밀번호',
                style: TextStyle(
                  fontSize: 21,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),

        SizedBox(height: 10),
        TextFormField(
          controller: _formControllers.passwordController,
          decoration: InputDecoration(
            hintText: 'ex. won01room%',
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Color(0xff6bbe45), width: 2.0), // 포커스 시 테두리 색상 및 두께
            ),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Color(0xffc2c2c2), width: 1.0), // 비포커스 상태에서의 테두리 색상 및 두께
            ),
            // errorBorder: OutlineInputBorder(
            //   borderSide: BorderSide(color: Colors.red, width: 2.0), // 에러 발생 시 테두리 색상 및 두께
            // ),
            // focusedErrorBorder: OutlineInputBorder(
            //   borderSide: BorderSide(color: Color(0xff6bbe45), width: 2.0), // 포커스 및 에러 발생 시 테두리 색상 및 두께
            // ),
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
          onChanged: (_)=>_updateButtonState(),
          validator: (value) => Validators.validatePassword(value),
        ),
        SizedBox(height: 4.0),
        Padding(
          padding: const EdgeInsets.only(top: 4, left: 10),
          child: Text(
            '영문, 숫자, 특수문자("제외) 포함 8자리 이상',
            style: TextStyle(
              fontSize: 13,
              color: Colors.grey[700],
            ),
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
        Padding(
          padding: const EdgeInsets.only(left: 6),
          child: Row(
            children: [
              Icon(Icons.lock_outline, size: 24),
              SizedBox(width: 8), // 아이콘과 텍스트 사이 간격 조절
              Text(
                '비밀번호 확인',
                style: TextStyle(
                  fontSize: 21,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),

        SizedBox(height: 10),
        TextFormField(
          controller: _formControllers.passwordConfirmController,
          decoration: InputDecoration(
            hintText: 'ex. won01room%',
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Color(0xff6bbe45), width: 2.0), // 포커스 시 테두리 색상 및 두께
            ),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Color(0xffc2c2c2), width: 1.0), // 비포커스 상태에서의 테두리 색상 및 두께
            ),
            // errorBorder: OutlineInputBorder(
            //   borderSide: BorderSide(color: Colors.red, width: 2.0), // 에러 발생 시 테두리 색상 및 두께
            // ),
            // focusedErrorBorder: OutlineInputBorder(
            //   borderSide: BorderSide(color: Color(0xff6bbe45), width: 2.0), // 포커스 및 에러 발생 시 테두리 색상 및 두께
            // ),
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
          ),
          obscureText: _obscureConfirmPassword,
          onChanged: (_)=>_updateButtonState(),
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
        Padding(
          padding: const EdgeInsets.only(left: 6),
          child: Row(
            children: [
              Icon(Icons.account_circle_outlined, size: 24),
              SizedBox(width: 8.0),
              Text(
                '닉네임',
                style: TextStyle(
                  fontSize: 21,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: 10),
        TextFormField(
          controller: _formControllers.nicknameController,
          focusNode: _formControllers.nicknameFocusNode,
          decoration: InputDecoration(
            hintText: 'ex. 원룸',
            contentPadding: EdgeInsets.symmetric(horizontal: 12.0, vertical: 10.0),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Color(0xff6bbe45), width: 2.0),
            ),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Color(0xffc2c2c2), width: 1.0),
            ),
            // errorBorder: OutlineInputBorder(
            //   borderSide: BorderSide(color: Colors.red, width: 2.0), // 에러 발생 시 테두리 색상 및 두께
            // ),
            // focusedErrorBorder: OutlineInputBorder(
            //   borderSide: BorderSide(color: Color(0xff6bbe45), width: 2.0), // 포커스 및 에러 발생 시 테두리 색상 및 두께
            // ),
          ),
          // onChanged: (_) => _updateNicknameValidation(),
        ),
        if (_nicknameValidationMessage == '사용 가능한 닉네임 입니다.')
          Padding(
            padding: const EdgeInsets.only(top: 8.0, left: 10),
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
            padding: const EdgeInsets.only(top: 8.0, left: 10),
            child: Text(
              _nicknameValidationMessage ?? '', // 기본값을 설정하거나 빈 문자열을 사용
              style: TextStyle(
                color: Colors.red,
                fontSize: 12,
              ),
            ),
          ),

        // SizedBox(height: 25.0),
      ],
    );
  }

  Widget _buildEmailField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.only(left: 6),
          child: Row(
            children: [
              Icon(Icons.local_post_office_outlined, size: 24),
              SizedBox(width: 8.0),
              Text(
                '이메일',
                style: TextStyle(
                  fontSize: 21,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: 8.0),

        TextFormField(
          controller: _formControllers.emailController,
          focusNode: _formControllers.emailFocusNode,
          decoration: InputDecoration(
            // labelText: '이메일',
            hintText: 'ex. wonroom@naver.com',
            errorText: _emailValidationMessage == '사용 가능한 이메일 입니다.' ? null : _emailValidationMessage,

            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Color(0xff6bbe45), width: 2.0), // 포커스 시 테두리 색상 및 두께
            ),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Color(0xffc2c2c2), width: 1.0), // 비포커스 상태에서의 테두리 색상 및 두께
            ),
            errorBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.red, width: 2.0), // 에러 발생 시 테두리 색상 및 두께
            ),
            focusedErrorBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Color(0xff6bbe45), width: 2.0), // 포커스 및 에러 발생 시 테두리 색상 및 두께
            ),

            contentPadding: EdgeInsets.symmetric(horizontal: 12.0, vertical: 10.0),
            errorStyle: TextStyle(
              color: Colors.red,
              fontSize: 12,
            ),
          ),
          onChanged: (_) => _updateEmailValidation(),
        ),
        if (_emailValidationMessage == '사용 가능한 이메일 입니다.')
          Padding(
            padding: const EdgeInsets.only(top: 8.0, left: 10),
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
