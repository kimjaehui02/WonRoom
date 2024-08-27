import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:wonroom/Login/LoginValidators.dart';

class PwChange extends StatefulWidget {
  const PwChange({super.key});

  @override
  State<PwChange> createState() => _PwChangeState();
}

class _PwChangeState extends State<PwChange> {
  final TextEditingController _oldPasswordController = TextEditingController();
  final TextEditingController _newPasswordController = TextEditingController();
  final TextEditingController _confirmPasswordController = TextEditingController();

  // Separate obscurePassword flags for each field
  bool _obscureOldPassword = true;
  bool _obscureNewPassword = true;
  bool _obscureConfirmPassword = true;

  String _passwordHint = '영문, 숫자, 특수문자("제외) 포함 8자리 이상';

  @override
  void dispose() {
    // 컨트롤러 해제
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
          icon: const Icon(Icons.chevron_left),
          onPressed: () {
            Navigator.of(context).pop(); // 뒤로 가기
          },
        ),
        title: const Text('비밀번호 변경'),
        centerTitle: true,
      ),
      body: Container(
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
                  controller: _oldPasswordController,
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
                  controller: _newPasswordController,
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
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    _passwordHint,
                    style: TextStyle(
                      fontSize: 13,
                      color: Colors.grey[700],
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
                  controller: _confirmPasswordController,
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
              ],
            ),
          ],
        ),
      ),
    );
  }
}
