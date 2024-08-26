import 'package:flutter/material.dart';
import 'package:wonroom/Flask/storage_manager.dart';




Future<void> checkLoginStatus(BuildContext context) async {
  String? isLoggedIn = await readData('userData'); // 로그인 상태 읽기

  if (isLoggedIn != 'true') {
    // 로그인이 안된 상태라면 팝업을 띄움
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('로그인이 필요합니다'),
          content: Text('로그인 화면으로 이동하시겠습니까?'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // 팝업 닫기
              },
              child: Text('아니요'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // 팝업 닫기
                Navigator.pushNamed(context, '/login'); // 로그인 화면으로 이동
              },
              child: Text('예'),
            ),
          ],
        );
      },
    );
  } else {
    print('사용자가 로그인되어 있습니다.');
  }
}
