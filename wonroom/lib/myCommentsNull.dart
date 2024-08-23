import 'package:flutter/material.dart';

class MyCommentsNull extends StatelessWidget {
  const MyCommentsNull({super.key});

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
        color: Colors.white,
        child: Expanded(
          child: Center(
            child: Column(
              // mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(height: 250,),
                // SizedBox(height: 200,),
                ImageIcon(AssetImage('images/info.png'),
                  size: 50,
                  color: Color(0xffc2c2c2),
                ),
                SizedBox(height: 10,),
                Text(
                  '댓글 내용이 없습니다.\n다른 식집사분들과 소통하여\n정보를 얻어보세요.',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Color(0xff787878),
                    fontSize: 14,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}