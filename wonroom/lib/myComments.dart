import 'package:flutter/material.dart';

class MyComments extends StatelessWidget {
  const MyComments({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('내 댓글', style: TextStyle(color: Colors.black)),
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios,
            color: Colors.grey,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Container(

        // 빈 화면
        // child: Expanded(
        //   child: Center(
        //     child: Column(
        //       children: [
        //         SizedBox(height: 250,),
        //         ImageIcon(AssetImage('images/info.png'),
        //           size: 50,
        //           color: Color(0xffc2c2c2),
        //         ),
        //         SizedBox(height: 10,),
        //         Text(
        //           '댓글 내용이 없습니다.\n다른 식집사분들과 소통하여\n정보를 얻어보세요.',
        //           textAlign: TextAlign.center,
        //           style: TextStyle(
        //             color: Color(0xff787878),
        //             fontSize: 14,
        //           ),
        //         ),
        //       ],
        //     ),
        //   ),
        // ),
      ),
    );
  }
}
