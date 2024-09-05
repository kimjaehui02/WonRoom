import 'package:flutter/material.dart';
import 'package:wonroom/CreatePost.dart';
import 'package:wonroom/myPlant.dart';
import 'package:wonroom/plantClinicChat.dart';
import 'package:wonroom/postDetailPage.dart';
import 'package:dropdown_button2/dropdown_button2.dart';

class Community extends StatefulWidget {
  const Community({super.key});

  @override
  _CommunityState createState() => _CommunityState();
}

class _CommunityState extends State<Community> {
  final ScrollController _scrollController = ScrollController();
  String _sortOption = '인기글';

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _scrollToTop() {
    _scrollController.animateTo(
      0,
      duration: Duration(milliseconds: 500),
      curve: Curves.easeInOut,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        controller: _scrollController,
        child: Column(
          children: [
            // 버튼 컨테이너
            Container(
              padding: EdgeInsets.symmetric(vertical: 5, horizontal: 14),
              color: Color(0xffeeeeee),
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Color(0xff595959),
                        padding: EdgeInsets.symmetric(
                            vertical: 5, horizontal: 20),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                      ),
                      onPressed: () {
                        // Button click action
                      },
                      child: Text(
                        '전체',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                    SizedBox(width: 10),
                    OutlinedButton(
                      style: OutlinedButton.styleFrom(
                        backgroundColor: Colors.white,
                        padding: EdgeInsets.symmetric(
                            vertical: 5, horizontal: 20),
                        side: BorderSide(
                          color: Color(0xffc2c2c2),
                          width: 1,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                      ),
                      onPressed: () {
                        // Button click action
                      },
                      child: Text(
                        '질문하기',
                        style: TextStyle(color: Color(0xff787878)),
                      ),
                    ),
                    SizedBox(width: 10),
                    OutlinedButton(
                      style: OutlinedButton.styleFrom(
                        backgroundColor: Colors.white,
                        padding: EdgeInsets.symmetric(
                            vertical: 5, horizontal: 20),
                        side: BorderSide(
                          color: Color(0xffc2c2c2),
                          width: 1,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                      ),
                      onPressed: () {
                        // Button click action
                      },
                      child: Text(
                        '자랑하기',
                        style: TextStyle(color: Color(0xff787878)),
                      ),
                    ),
                    SizedBox(width: 10),
                    OutlinedButton(
                      style: OutlinedButton.styleFrom(
                        backgroundColor: Colors.white,
                        padding: EdgeInsets.symmetric(
                            vertical: 5, horizontal: 20),
                        side: BorderSide(
                          color: Color(0xffc2c2c2),
                          width: 1,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                      ),
                      onPressed: () {
                        // Button click action
                      },
                      child: Text(
                        '자유게시판',
                        style: TextStyle(color: Color(0xff787878)),
                      ),
                    ),
                    SizedBox(width: 10),
                  ],
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 25, vertical: 15),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    '전체글',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Row(
                    children: [
                      DropdownButtonHideUnderline(
                        child: DropdownButton2<String>(
                          value: _sortOption,
                          customButton: Row(
                            children: [
                              Icon(Icons.import_export, size: 20),
                              Text(
                                _sortOption,
                                style: const TextStyle(
                                  fontSize: 16,
                                  color: Colors.black,
                                ),
                              ),
                            ],
                          ),
                          dropdownStyleData: DropdownStyleData(
                            maxHeight: 170, // 드롭다운 최대 높이 설정
                            width: 80, // 드롭다운 너비 설정
                            offset: const Offset(-10, 0), // 드롭다운 위치 조정
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                          items: <String>['인기글', '최신글', '리뷰순']
                              .map<DropdownMenuItem<String>>((String value) {
                            return DropdownMenuItem<String>(
                              alignment: Alignment.center,
                              value: value,
                              child: Text(
                                value,
                                style: const TextStyle(
                                    fontSize: 14, color: Colors.black),
                              ),
                            );
                          }).toList(),
                          onChanged: (String? newValue) {
                            setState(() {
                              _sortOption = newValue!;
                            });
                          },
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            // 게시물 목록
            _buildPostList(),
          ],
        ),
      ),

      // 글 작성 버튼 (오른쪽 하단)
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => CreatePost()),
          );
        },
        child: Container(
          padding: EdgeInsets.only(left: 8),
          child: Image.asset(
            'images/write.png',
            width: 43,
            height: 43,
            color: Colors.white,
          ),
        ),
        backgroundColor: Color(0xff595959), // 버튼 배경색
        shape: CircleBorder(), // 원형 버튼
      ),
    );
  }

  Widget _buildPostList() {
    List<Map<String, dynamic>> posts = [
      {
        'imageUrl': 'images/아레카야자.jpg',
        'title': '제목 1',
        'username': '사용자1',
        'time': '2시간 전',
        'views': 100,
        'likes': 50,
        'comments': 5,
      },
      {
        'imageUrl': 'images/필로덴드론 호프셀렘.jpg',
        'title': '제목 2',
        'username': '사용자2',
        'time': '30분 전',
        'views': 150,
        'likes': 75,
        'comments': 10,
      },
      {
        'imageUrl': 'images/홍콩야자.jpeg',
        'title': '제목 3',
        'username': '사용자3',
        'time': '1시간 전',
        'views': 200,
        'likes': 100,
        'comments': 15,
      },
    ];

    return ListView.builder(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      itemCount: posts.length,
      itemBuilder: (context, index) {
        // 마지막 항목 여부를 판단하여 전달
        return _buildPostItem(posts[index], index == posts.length - 1);
      },
    );
  }

  Widget _buildPostItem(Map<String, dynamic> post, bool isLast) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => PostDetailPage(post: post)),
        );
      },
      child: Container(
        padding: EdgeInsets.all(10),
        margin: EdgeInsets.symmetric(horizontal: 16.0), // 좌우에 padding 추가
        decoration: BoxDecoration(
          border: Border(
            bottom: isLast
                ? BorderSide.none
                : BorderSide(
              color: Colors.grey.shade300,
              width: 1,
            ),
          ),
        ),
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Text(
                            '${post['username']}',
                            style: TextStyle(
                              color: Colors.grey,
                              fontSize: 14,
                            ),
                          ),
                          SizedBox(width: 10),
                          Icon(Icons.access_time, size: 14, color: Colors.grey),
                          SizedBox(width: 2),
                          Text(
                            '${post['time']}',
                            style: TextStyle(
                              color: Colors.grey,
                              fontSize: 14,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 5),
                      Row(
                        children: [
                          Container(
                            padding: EdgeInsets.symmetric(
                                horizontal: 8, vertical: 4),
                            color: Color(0xffe7efe2),
                            child: Text(
                              '자유게시판',
                              style: TextStyle(
                                color: Color(0xff739A5C),
                                fontSize: 12,
                              ),
                            ),
                          ),
                          SizedBox(width: 8),
                          Text(
                            post['title'],
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 5),
                      Row(
                        children: [
                          Icon(Icons.remove_red_eye_outlined,
                              size: 14, color: Colors.grey),
                          SizedBox(width: 3),
                          Text('${post['views']}'),
                          SizedBox(width: 7),
                          Icon(Icons.favorite,
                              size: 14, color: Colors.grey),
                          SizedBox(width: 3),
                          Text('${post['likes']}'),
                          SizedBox(width: 7),
                          Icon(Icons.comment,
                              size: 14, color: Colors.grey),
                          SizedBox(width: 3),
                          Text('${post['comments']}'),
                        ],
                      ),
                    ],
                  ),
                ),
                SizedBox(width: 10),
                Image.asset(
                  post['imageUrl'],
                  width: 80,
                  height: 80,
                  fit: BoxFit.cover,
                ),
              ],
            ),
            if (!isLast) SizedBox(height: 10),
          ],
        ),
      ),
    );
  }
}
