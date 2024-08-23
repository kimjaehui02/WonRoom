import 'package:flutter/material.dart';
import 'package:wonroom/index.dart';
import 'package:wonroom/postDetailPage.dart';
import 'package:wonroom/writePage.dart';

class Community extends StatefulWidget {
  const Community({super.key});

  @override
  _CommunityState createState() => _CommunityState();
}

class _CommunityState extends State<Community> with SingleTickerProviderStateMixin {
  late TabController _tabController;
  int _selectedIndex = 0;
  final ScrollController _scrollController = ScrollController();
  bool _isFabVisible = false;
  String _sortOption = '인기글';

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 5, vsync: this);
    _tabController.index = 3; // 커뮤니티 탭을 기본으로 설정
    _scrollController.addListener(_scrollListener);
  }

  @override
  void dispose() {
    _scrollController.removeListener(_scrollListener);
    _scrollController.dispose();
    super.dispose();
  }

  void _scrollListener() {
    if (_scrollController.offset >= 200 && !_isFabVisible) {
      setState(() {
        _isFabVisible = true;
      });
    } else if (_scrollController.offset < 200 && _isFabVisible) {
      setState(() {
        _isFabVisible = false;
      });
    }
  }

  void _onBottomNavBarItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
    if (index == 2) {
      _tabController.index = 2;
    }
  }

  void _scrollToTop() {
    _scrollController.animateTo(
      0,
      duration: Duration(milliseconds: 500),
      curve: Curves.easeInOut,
    );
  }

  // 글작성
  void _showWritePostDialog(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => WritePage()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Row(
          children: [
            IconButton(
              icon: const Icon(Icons.search),
              onPressed: () {},
            ),
            SizedBox(width: 40),
            Expanded(
              child: Center(
                child: RichText(
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text: 'Won',
                        style: TextStyle(
                          color: Colors.green,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'DMSerifDisplay',
                          letterSpacing: 2,
                          fontSize: 28,
                        ),
                      ),
                      TextSpan(
                        text: '-Room',
                        style: TextStyle(
                          color: Color(0xff595959),
                          fontWeight: FontWeight.bold,
                          fontFamily: 'DMSerifDisplay',
                          letterSpacing: 1,
                          fontSize: 28,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            IconButton(
              icon: const Icon(Icons.notifications_none_outlined),
              onPressed: () {},
            ),
            IconButton(
              icon: const Icon(Icons.person_outline),
              onPressed: () {},
            ),
          ],
        ),
        bottom: TabBar(
          controller: _tabController,
          isScrollable: true,
          labelColor: Colors.green,
          labelStyle: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
          indicatorColor: Colors.green,
          indicatorPadding: EdgeInsets.zero,
          indicatorWeight: 3.0,
          tabAlignment: TabAlignment.start,
          labelPadding: EdgeInsets.symmetric(horizontal: 20.0),
          tabs: const [
            Tab(text: '홈'),
            Tab(text: '식물사전'),
            Tab(text: '식물클리닉'),
            Tab(text: '커뮤니티'),
            Tab(text: '고객센터'),
          ],
        ),
      ),
      body: Stack(
        children: [
          TabBarView(
            controller: _tabController,
            children: [
              _buildHomePage(),
              _buildPlantDictionaryPage(),
              _buildPlantClinicPage('식물클리닉 페이지'),
              _buildCommunityPage(),
              _buildCustomerServicePage('고객센터 페이지'),
            ],
          ),

          // "Write Post" Floating Action Button
          Positioned(
            right: 16,
            bottom: 16,
            child: FloatingActionButton(
              onPressed: () {
                _showWritePostDialog(context);
              },
              child: Container(
                padding: EdgeInsets.only(left: 8), // 왼쪽에만 패딩을 줍니다.
                child: Image.asset(
                  'images/write.png', // 이미지 경로를 지정하세요.
                  width: 43, // 이미지의 너비
                  height: 43, // 이미지의 높이
                  color: Colors.white, // 이미지 색상 조정 (필요시)
                ),
              ),
              backgroundColor: Color(0xff595959), // 버튼 배경색
              shape: CircleBorder(), // 원형 버튼
            ),
          ),

        ],
      ),
      bottomNavigationBar: BottomAppBar(
        shape: CircularNotchedRectangle(),
        notchMargin: 6.0,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            _buildBottomNavBarItem(
              icon: Icons.home_outlined,
              label: '홈',
              index: 0,
            ),
            SizedBox(width: 40),
            _buildBottomNavBarItem(
              icon: Icons.book_outlined,
              label: '다이어리',
              index: 2,
            ),
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: Stack(
        alignment: Alignment.center,
        children: [
          Container(
            width: 70,
            height: 70,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Color(0xff6bbe45),
            ),
            child: FloatingActionButton(
              onPressed: () {},
              backgroundColor: Colors.transparent,
              elevation: 0,
              child: Icon(
                  Icons.camera_alt_outlined, color: Colors.white, size: 30),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBottomNavBarItem({
    required IconData icon,
    required String label,
    required int index,
  }) {
    return Expanded(
      child: InkWell(
        onTap: () {
          _onBottomNavBarItemTapped(index);
        },
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              icon,
              size: 30,
              color: _selectedIndex == index ? Color(0xff6bbe45) : Colors.grey,
            ),
            Text(
              label,
              style: TextStyle(
                color: _selectedIndex == index ? Color(0xff6bbe45) : Colors
                    .grey,
                fontSize: 12,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHomePage() {
    return Container();
  }

  Widget _buildPlantDictionaryPage() {
    return Center(
      child: Text('식물사전 페이지'),
    );
  }

  Widget _buildPlantClinicPage(String text) {
    return Center(
      child: Text(text),
    );
  }

  Widget _buildCommunityPage() {
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      controller: _scrollController,
      child: Column(
        children: [
          // 버튼 컨테이너
          Container(
            padding: EdgeInsets.symmetric(vertical: 5, horizontal: 14),
            color: Color(0xffeeeeee),
            child: Row(
              children: [
                Expanded(
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
              ],
            ),
          ),
          // 탭바와 목록 사이에 "전체글" 제목 및 정렬 옵션 추가
          Padding(
            padding: const EdgeInsets.symmetric(
                horizontal: 16.0, vertical: 10.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  '전체글',
                  style: TextStyle(
                    fontSize: 21,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Row(
                  children: [
                    DropdownButton<String>(
                      value: _sortOption,
                      icon: const Icon(Icons.import_export),
                      iconSize: 20,
                      elevation: 16,
                      style: const TextStyle(color: Colors.black),
                      underline: Container(
                        height: 0,
                      ),
                      onChanged: (String? newValue) {
                        setState(() {
                          _sortOption = newValue!;
                          // 정렬 로직 추가 가능
                        });
                      },
                      items: <String>['인기글', '최신글', '리뷰순']
                          .map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
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
    );
  }

  Widget _buildCustomerServicePage(String text) {
    return Center(
      child: Text(text),
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
          MaterialPageRoute(builder: (context) => Postdetailpage(post: post)),
        );
      },
      child: Container(
        padding: EdgeInsets.all(10),
        margin: EdgeInsets.symmetric(horizontal: 16.0), // 좌우에 padding 추가
        decoration: BoxDecoration(
          border: Border(
            bottom: isLast ? BorderSide.none : BorderSide(
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
                            padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
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
                          Icon(Icons.remove_red_eye_outlined, size: 14, color: Colors.grey),
                          SizedBox(width: 3),
                          Text('${post['views']}'),
                          SizedBox(width: 7),
                          Icon(Icons.favorite, size: 14, color: Colors.grey),
                          SizedBox(width: 3),
                          Text('${post['likes']}'),
                          SizedBox(width: 7),
                          Icon(Icons.comment, size: 14, color: Colors.grey),
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