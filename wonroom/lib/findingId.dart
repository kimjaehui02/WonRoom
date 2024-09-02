import 'package:flutter/material.dart';

class FindingId extends StatelessWidget {
  const FindingId({super.key});

  void _showErrorDialog(BuildContext context) {
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
                  '일치하는 정보가 없습니다.',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 5),
                Text(
                  '닉네임 또는 이메일을 확인해주세요.',
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
                      foregroundColor: Colors.white,
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
                      // 로그아웃 기능

                      Navigator.of(context).pop();
                    },
                  ),
                ),
              ],
            ),
          ),
        );


        // return AlertDialog(
        //   shape: RoundedRectangleBorder(
        //     borderRadius: BorderRadius.circular(10),
        //   ),
        //   title: const Text(
        //     '일치하는 정보가 있습니다.',
        //     style: TextStyle(
        //       fontSize: 20,
        //       fontWeight: FontWeight.bold,
        //     ),
        //     textAlign: TextAlign.center,
        //   ),
        //   content: Padding(
        //     padding: const EdgeInsets.symmetric(vertical: 2.0), // 내용 상하 여백
        //     child: SizedBox(
        //       child: Column(
        //         mainAxisSize: MainAxisSize.min,
        //         children: <Widget>[
        //           Text(
        //             '닉네임 또는 이메일을 확인해주세요.',
        //             style: TextStyle(
        //                 fontSize: 16, // 내용 텍스트 크기
        //                 color: Colors.grey
        //             ),
        //             textAlign: TextAlign.center, // 내용 텍스트 가운데 정렬
        //           ),
        //         ],
        //       ),
        //     ),
        //   ),
        //   actions: <Widget>[
        //     Padding(
        //       padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 4.0), // 버튼의 패딩 조절
        //       child: SizedBox(
        //         width: double.infinity,
        //         child: TextButton(
        //           onPressed: () {
        //             Navigator.of(context).pop(); // 다이얼로그 닫기
        //           },
        //           style: TextButton.styleFrom(
        //             backgroundColor: Colors.black, // 버튼 배경색
        //             padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 24.0), // 버튼 여백 조정
        //             foregroundColor: Colors.white, // 버튼 텍스트 색상
        //             shape: RoundedRectangleBorder(
        //               borderRadius: BorderRadius.zero, // 버튼 직사각형 모서리
        //             ),
        //             textStyle: const TextStyle(
        //               fontSize: 22.0, // 버튼 텍스트 크기
        //               fontWeight: FontWeight.bold, // 버튼 텍스트 굵기
        //             ),
        //           ),
        //           child: const Text('확인'),
        //         ),
        //       ),
        //     ),
        //   ],
        // );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('아이디 찾기', style: TextStyle(fontWeight: FontWeight.bold)),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios,
            color: Colors.grey,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(16.0),
              child: Form(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.only(left: 6),
                      child: Row(
                        children: const <Widget>[
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
                    const SizedBox(height: 10),
                    TextFormField(
                      decoration: const InputDecoration(
                        hintText: 'ex. 원룸',
                        // border: OutlineInputBorder(),
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

                    const SizedBox(height: 25.0),

                    Padding(
                      padding: const EdgeInsets.only(left: 6),
                      child: Row(
                        children: const <Widget>[
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
                    const SizedBox(height: 10),
                    TextFormField(
                      decoration: const InputDecoration(
                        hintText: 'ex. wonroom@naver.com',
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Color(0xff6bbe45), width: 2.0), // 포커스 시 테두리 색상 및 두께
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Color(0xffc2c2c2), width: 1.0), // 비포커스 상태에서의 테두리 색상 및 두께
                        ),
                        contentPadding: EdgeInsets.symmetric(horizontal: 12.0, vertical: 10.0),
                      ),
                    ),
                    const SizedBox(height: 30.0), // 필드와 버튼 사이의 간격
                  ],
                ),
              ),
            ),
          ),
          Container(
            padding: const EdgeInsets.all(16.0),
            margin: EdgeInsets.only(bottom: 20),
            child: SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  _showErrorDialog(context); // 아이디 찾기 버튼 클릭 시 다이얼로그 표시, 오류 시
                  // Navigator.push(
                  //   context,
                  //   MaterialPageRoute(builder: (context) => FindingPwTemporarily()),
                  // );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xff6FB348), // 버튼 배경색
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(3)
                  ),
                ),
                child: const Text(
                  '아이디 확인',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold
                  ), // 버튼 텍스트 색상과 크기
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
