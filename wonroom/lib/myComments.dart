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
      body: ListView(
        // padding: EdgeInsets.all(16),
        children: [
          Container(
            child: PostItem(
              imagePath: 'images/아레카야자.jpg',
              category: '자유게시판',
              nickname: '원룸',
              title: '인테리어용 인기 식물 추천',
              date: '24.09.12',
              comments: '알림 기능을 어떻게 설정하나요? 식물별 알림 기능 설정하고 싶어요. 알림 기능을 어떻게 설정하나요? 식물별 알림 기능 알림 기능을 어떻게 설정하나요? 식물별 알림 기능',
            ),
          ),




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
        ],
      ),

    );
  }
}

class PostItem extends StatelessWidget {
  final String imagePath;
  final String category;
  final String nickname;
  final String title;
  final String date;
  final String comments;

  const PostItem({
    required this.imagePath,
    required this.category,
    required this.nickname,
    required this.title,
    required this.date,
    required this.comments,
  });


  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: 10,),

        Column(
          children: [
            Container(
              padding: EdgeInsets.all(16.0),
              child: Column(
                // crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        width: 60,
                        height: 60,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8.0),
                          image: DecorationImage(
                            image: AssetImage(imagePath),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      SizedBox(width: 15),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Container(
                                  padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                                  decoration: BoxDecoration(
                                    color: Color(0xffe7efe2),
                                    borderRadius: BorderRadius.circular(4.0),
                                  ),
                                  child: Text(
                                    category,
                                    style: TextStyle(
                                      color: Color(0xff739A5C),
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                                SizedBox(width: 8),
                                Expanded(
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Expanded(
                                        child: Text(
                                          title,
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 16,
                                          ),
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text(
                                  nickname,
                                  style: TextStyle(
                                    color: Color(0xffc2c2c2),
                                    fontSize: 14,
                                  ),
                                ),
                                SizedBox(width: 10.0),
                                Icon(Icons.access_time_outlined,
                                    size: 15,
                                    color: Color(0xffc2c2c2),
                                ),
                                SizedBox(width: 2),
                                Text(
                                  date,
                                  style: TextStyle(
                                    color: Color(0xffc2c2c2),
                                    fontSize: 14,
                                  ),
                                ),
                                Spacer(),
                                TextButton(
                                  onPressed: (){
                                    showModalBottomSheet(
                                      context: context,
                                      builder: (BuildContext context) {
                                        return Container(
                                          padding: EdgeInsets.symmetric(vertical: 40, horizontal: 32),
                                          child: Column(
                                            mainAxisSize: MainAxisSize.min,
                                            children: <Widget>[
                                              Text(
                                                '정말 삭제 하시겠습니까?',
                                                style: TextStyle(
                                                    fontSize: 20,
                                                    fontWeight: FontWeight.bold
                                                ),
                                              ),
                                              SizedBox(height: 10,),
                                              Text(
                                                '삭제하기를 누르시면\n해당 댓글이 삭제됩니다.',
                                                style: TextStyle(
                                                    fontSize: 16,
                                                    color: Color(0xff787878)
                                                ),
                                                textAlign: TextAlign.center,
                                              ),
                                              SizedBox(height: 30),
                                              Row(
                                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                                children: <Widget>[
                                                  Expanded(
                                                    child: Padding(
                                                      padding: EdgeInsets.only(right: 5),
                                                      child: SizedBox(
                                                        height: 45,
                                                        child: ElevatedButton(
                                                          onPressed: () {
                                                            Navigator.pop(context); // 다이얼로그를 닫음
                                                          },
                                                          child: Text('취소', style: TextStyle(
                                                              color: Colors.white
                                                          ),),
                                                          style: ElevatedButton.styleFrom(
                                                            backgroundColor: Color(0xffc2c2c2),
                                                            shape: RoundedRectangleBorder(
                                                              borderRadius: BorderRadius.circular(8), // Radius 조정
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  ),

                                                  Expanded(
                                                    child: Padding(
                                                      padding: EdgeInsets.only(left: 5),
                                                      child: SizedBox(
                                                        height: 45,
                                                        child: ElevatedButton(
                                                          onPressed: () {
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
                                                                          '삭제가 완료되었습니다',
                                                                          style: TextStyle(
                                                                            fontSize: 20,
                                                                            fontWeight: FontWeight.bold,
                                                                          ),
                                                                          textAlign: TextAlign.center,
                                                                        ),
                                                                        SizedBox(height: 5),
                                                                        Text(
                                                                          '삭제된 댓글은 복구할 수 없습니다.',
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
                                                                              // 삭제 기능

                                                                              Navigator.pop(context);
                                                                              Navigator.pop(context);
                                                                            },
                                                                          ),
                                                                        ),
                                                                      ],
                                                                    ),
                                                                  ),
                                                                );
                                                              },
                                                            );
                                                          },
                                                          child: Text(
                                                            '삭제',
                                                            style: TextStyle(color: Colors.white),
                                                          ),
                                                          style: ElevatedButton.styleFrom(
                                                            backgroundColor: Color(0xff595959),
                                                            shape: RoundedRectangleBorder(
                                                              borderRadius: BorderRadius.circular(8),
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                        );
                                      },
                                    );
                                  },
                                  // style: TextButton.styleFrom(
                                  //   padding: EdgeInsets.symmetric(vertical: 0, horizontal: 20),
                                  //   minimumSize: Size(60, 30),
                                  // ),
                                  child: Text('삭제', style: TextStyle(
                                    color: Color(0xff787878)
                                  ),),

                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                  Container(
                    padding: EdgeInsets.only(top: 20, bottom: 20, left: 10, right: 20),
                    decoration: BoxDecoration(
                      border: Border(
                        top: BorderSide(
                          color: Color(0xffeeeeee),
                          width: 1,
                        ),
                      ),
                    ),
                    child: Text(
                      comments,
                      style: TextStyle(
                        color: Color(0xff787878),
                        fontSize: 14,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),

                ],
              ),
            ),

            // 구분
            Container(
              margin: EdgeInsets.only(bottom: 20),
              width: MediaQuery.of(context).size.width,
              height: 8,
              color: Color(0xffeeeeee),
            )

          ],
        ),

        Column(
          children: [
            Container(
              padding: EdgeInsets.all(16.0),
              child: Column(
                // crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        width: 60,
                        height: 60,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8.0),
                          image: DecorationImage(
                            image: AssetImage(imagePath),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      SizedBox(width: 15),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Container(
                                  padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                                  decoration: BoxDecoration(
                                    color: Color(0xffe7efe2),
                                    borderRadius: BorderRadius.circular(4.0),
                                  ),
                                  child: Text(
                                    category,
                                    style: TextStyle(
                                      color: Color(0xff739A5C),
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                                SizedBox(width: 8),
                                Expanded(
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Expanded(
                                        child: Text(
                                          title,
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 16,
                                          ),
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text(
                                  nickname,
                                  style: TextStyle(
                                    color: Color(0xffc2c2c2),
                                    fontSize: 14,
                                  ),
                                ),
                                SizedBox(width: 10.0),
                                Icon(Icons.access_time_outlined,
                                  size: 15,
                                  color: Color(0xffc2c2c2),
                                ),
                                SizedBox(width: 2),
                                Text(
                                  date,
                                  style: TextStyle(
                                    color: Color(0xffc2c2c2),
                                    fontSize: 14,
                                  ),
                                ),
                                Spacer(), // 남은 공간을 모두 차지하게 함
                                TextButton(
                                  onPressed: (){
                                    showModalBottomSheet(
                                      context: context,
                                      builder: (BuildContext context) {
                                        return Container(
                                          padding: EdgeInsets.symmetric(vertical: 40, horizontal: 32),
                                          child: Column(
                                            mainAxisSize: MainAxisSize.min,
                                            children: <Widget>[
                                              Text(
                                                '정말 삭제 하시겠습니까?',
                                                style: TextStyle(
                                                    fontSize: 20,
                                                    fontWeight: FontWeight.bold
                                                ),
                                              ),
                                              SizedBox(height: 10,),
                                              Text(
                                                '삭제하기를 누르시면\n해당 댓글이 삭제됩니다.',
                                                style: TextStyle(
                                                    fontSize: 16,
                                                    color: Color(0xff787878)
                                                ),
                                                textAlign: TextAlign.center,
                                              ),
                                              SizedBox(height: 30),
                                              Row(
                                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                                children: <Widget>[
                                                  Expanded(
                                                    child: Padding(
                                                      padding: EdgeInsets.only(right: 5),
                                                      child: SizedBox(
                                                        height: 45,
                                                        child: ElevatedButton(
                                                          onPressed: () {
                                                            Navigator.pop(context); // 다이얼로그를 닫음
                                                          },
                                                          child: Text('취소', style: TextStyle(
                                                              color: Colors.white
                                                          ),),
                                                          style: ElevatedButton.styleFrom(
                                                            backgroundColor: Color(0xffc2c2c2),
                                                            shape: RoundedRectangleBorder(
                                                              borderRadius: BorderRadius.circular(8), // Radius 조정
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  ),

                                                  Expanded(
                                                    child: Padding(
                                                      padding: EdgeInsets.only(left: 5),
                                                      child: SizedBox(
                                                        height: 45,
                                                        child: ElevatedButton(
                                                          onPressed: () {
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
                                                                          '삭제가 완료되었습니다',
                                                                          style: TextStyle(
                                                                            fontSize: 20,
                                                                            fontWeight: FontWeight.bold,
                                                                          ),
                                                                          textAlign: TextAlign.center,
                                                                        ),
                                                                        SizedBox(height: 5),
                                                                        Text(
                                                                          '삭제된 댓글은 복구할 수 없습니다.',
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
                                                                              // 삭제 기능

                                                                              Navigator.pop(context);
                                                                              Navigator.pop(context);
                                                                            },
                                                                          ),
                                                                        ),
                                                                      ],
                                                                    ),
                                                                  ),
                                                                );
                                                              },
                                                            );
                                                          },
                                                          child: Text(
                                                            '삭제',
                                                            style: TextStyle(color: Colors.white),
                                                          ),
                                                          style: ElevatedButton.styleFrom(
                                                            backgroundColor: Color(0xff595959),
                                                            shape: RoundedRectangleBorder(
                                                              borderRadius: BorderRadius.circular(8),
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                        );
                                      },
                                    );
                                  },
                                  // style: TextButton.styleFrom(
                                  //   padding: EdgeInsets.symmetric(vertical: 0, horizontal: 20),
                                  //   minimumSize: Size(60, 30),
                                  // ),
                                  child: Text('삭제', style: TextStyle(
                                      color: Color(0xff787878)
                                  ),),

                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                  Container(
                    padding: EdgeInsets.only(top: 20, bottom: 20, left: 10, right: 20),
                    decoration: BoxDecoration(
                      border: Border(
                        top: BorderSide(
                          color: Color(0xffeeeeee),
                          width: 1,
                        ),
                      ),
                    ),
                    child: Text(
                      comments,
                      style: TextStyle(
                        color: Color(0xff787878),
                        fontSize: 14,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),

                ],
              ),
            ),

            // 구분
            Container(
              margin: EdgeInsets.only(bottom: 20),
              width: MediaQuery.of(context).size.width,
              height: 8,
              color: Color(0xffeeeeee),
            )

          ],
        ),


      ],
    );
  }

}
