import 'package:flutter/material.dart';

class PwChange extends StatefulWidget {
  const PwChange({super.key});

  @override
  State<PwChange> createState() => _PwChangeState();
}

class _PwChangeState extends State<PwChange> {
  // 컨트롤러 추가
  final TextEditingController _oldPasswordController = TextEditingController();
  final TextEditingController _newPasswordController = TextEditingController();
  final TextEditingController _confirmPasswordController = TextEditingController();

  bool _obscureOldPassword = true;
  bool _obscureNewPassword = true;
  bool _obscureConfirmPassword = true;

  // 비밀번호 검증 함수
  bool _validatePassword(String oldPassword, String newPassword, String confirmPassword) {
    String correctOldPassword = "old_password"; // 기존 비밀번호 (임시)

    // 신규 비밀번호 검증 (8자리 이상, 영문, 숫자, 특수문자 포함)
    bool isNewPasswordValid = newPassword.length >= 8 &&
        newPassword.contains(RegExp(r'[A-Za-z]')) &&
        newPassword.contains(RegExp(r'[0-9]')) &&
        newPassword.contains(RegExp(r'[!@#$%^&*(),.?":{}|<>]'));

    // 비밀번호 검증 로직
    if (oldPassword != correctOldPassword) {
      return false;
    } else if (!isNewPasswordValid) {
      return false;
    } else if (newPassword != confirmPassword) {
      return false;
    }
    return true;
  }

  void _showDialog(String title, String subtitle, bool isSuccess) {
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
                  title,
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 10),
                Text(
                  subtitle,
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.grey,
                  ),
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
                      Navigator.pop(context); // 다이얼로그 닫기
                      if (isSuccess) {
                        Navigator.pop(context); // 이전 페이지로 이동
                      }
                    },
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
    _oldPasswordController.dispose();
    _newPasswordController.dispose();
    _confirmPasswordController.dispose();
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
            Navigator.of(context).pop(); // 뒤로 가기
          },
        ),
        title: const Text('비밀번호 변경'),
        centerTitle: true,
      ),
      body: Stack(
        children: [
          Padding(
            padding: EdgeInsets.all(16),
            child: Column(
              children: [
                // Old Password Field
                Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 6),
                      child: Row(
                        children: const <Widget>[
                          Icon(Icons.lock_outline, size: 24),
                          SizedBox(width: 8.0),
                          Text(
                            '기존 비밀번호',
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
                      controller: _oldPasswordController, // 컨트롤러 설정
                      decoration: InputDecoration(
                        hintText: 'ex. won01room%',
                        border: OutlineInputBorder(),
                        contentPadding: EdgeInsets.symmetric(horizontal: 12.0, vertical: 10.0),
                        suffixIcon: IconButton(
                          icon: Icon(
                            _obscureOldPassword ? Icons.visibility_off_outlined : Icons.visibility_outlined,
                            color: Color(0xffc2c2c2),
                          ),
                          onPressed: () {
                            setState(() {
                              _obscureOldPassword = !_obscureOldPassword;
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
                      obscureText: _obscureOldPassword,
                    ),
                    const SizedBox(height: 4.0),
                  ],
                ),

                SizedBox(height: 30),

                // New Password Field
                Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 6),
                      child: Row(
                        children: const <Widget>[
                          Icon(Icons.lock_outline, size: 24),
                          SizedBox(width: 8.0),
                          Text(
                            '신규 비밀번호',
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
                      controller: _newPasswordController, // 컨트롤러 설정
                      decoration: InputDecoration(
                        hintText: 'ex. won01room%',
                        border: OutlineInputBorder(),
                        contentPadding: EdgeInsets.symmetric(horizontal: 12.0, vertical: 10.0),
                        suffixIcon: IconButton(
                          icon: Icon(
                            _obscureNewPassword ? Icons.visibility_off_outlined : Icons.visibility_outlined,
                            color: Color(0xffc2c2c2),
                          ),
                          onPressed: () {
                            setState(() {
                              _obscureNewPassword = !_obscureNewPassword;
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
                      obscureText: _obscureNewPassword,
                    ),
                    const SizedBox(height: 4.0),
                    Padding(
                      padding: const EdgeInsets.only(left: 10),
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          "영문, 숫자, 특수문자(제외) 포함 8자리 이상",
                          style: TextStyle(
                            fontSize: 13,
                            color: Colors.grey[700],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),

                SizedBox(height: 30),

                // Confirm Password Field
                Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 6),
                      child: Row(
                        children: const <Widget>[
                          Icon(Icons.lock_outline, size: 24),
                          SizedBox(width: 8.0),
                          Text(
                            '신규 비밀번호 확인',
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
                        hintText: 'ex. won01room%',
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
                    const SizedBox(height: 4.0),
                    Padding(
                      padding: const EdgeInsets.only(left: 10),
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          "비밀번호를 다시 확인해주세요.",
                          style: TextStyle(
                            fontSize: 13,
                            color: Colors.grey[700],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Positioned(
            bottom: 16,
            left: 0,
            right: 0,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: ElevatedButton(
                onPressed: () {
                  String oldPassword = _oldPasswordController.text;
                  String newPassword = _newPasswordController.text;
                  String confirmPassword = _confirmPasswordController.text;

                  bool isValid = _validatePassword(oldPassword, newPassword, confirmPassword);

                  if (isValid) {
                    _showDialog(
                        '변경이 완료되었습니다.',
                        '확인 버튼을 누르면 \n이전 페이지로 이동합니다.',
                        true
                    );
                  } else {
                    _showDialog(
                        '변경에 실패했습니다.',
                        '기존 비밀번호 또는\n신규 비밀번호를 확인해주세요.',
                        false
                    );
                  }

                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xff6bbe45),
                  elevation: 0,
                  padding: EdgeInsets.symmetric(vertical: 16), // 버튼 높이 조절
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: Text(
                  '변경하기',
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
