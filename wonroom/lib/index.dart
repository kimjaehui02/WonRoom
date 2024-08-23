import 'package:flutter/material.dart';
import 'package:wonroom/myPage.dart';
import 'package:wonroom/myPlantRegistration.dart';
import 'package:wonroom/showFloatingActionModal.dart';
import 'plantDictionary.dart';

class Index extends StatefulWidget {
  const Index({super.key});
  @override
  _IndexState createState() => _IndexState();
}
class _IndexState extends State<Index> with SingleTickerProviderStateMixin {
  late TabController _tabController;
  int _selectedIndex = 0;
  final ScrollController _scrollController = ScrollController();
  bool _isFabVisible = false;
  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 5, vsync: this);
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
    if (index == 0) {
      _tabController.index = 0;
    }
    _tabController.index = index;
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
      resizeToAvoidBottomInset : false,
      appBar: AppBar(
        automaticallyImplyLeading: false,  // 뒤로가기 버튼 숨기기
        title: Row(
          children: [
            IconButton(
              icon: const Icon(Icons.search),
              onPressed: () {},
            ),
            SizedBox(width: 40,),
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
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => MyPage()), // MyPage로 이동
                );
              },
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
              PlantDictionary(),
              _buildPlantDictionaryPage(),
              _buildPlantClinicPage('식물클리닉 페이지'),
              _buildCommunityPage('커뮤니티 페이지'),
              _buildCustomerServicePage('고객센터 페이지'),
            ],
          ),
          if (_isFabVisible)
            Positioned(
              right: 16,
              bottom: 100,
              child: FloatingActionButton(
                onPressed: _scrollToTop,
                child: Icon(Icons.arrow_upward),
                backgroundColor: Color(0xff6bbe45),
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
            SizedBox(width: 40), // 공간을 추가하여 중앙의 FloatingActionButton과 겹치지 않도록 함
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
            width: 70, // 버튼의 가로 크기
            height: 70, // 버튼의 세로 크기
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Color(0xff6bbe45), // 연두색
            ),
            child: FloatingActionButton(
              onPressed: () {
                showFloatingActionModal(context);
              },
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
              color: _selectedIndex == index ? Color(0xff6bbe45) : Colors
                  .grey,
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
    return SingleChildScrollView(
      controller: _scrollController,
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildMyPlantsSection(),
          const SizedBox(height: 50),
          _buildWeatherWidget(),
          const SizedBox(height: 50),
          _buildRecommendedPlantsSection(),
          const SizedBox(height: 50),
          _buildPopularPostsSection(),
          const SizedBox(height: 40),
        ],
      ),
    );
  }

  Widget _buildWeatherWidget() {
    return Center(
      child: Container(
        width: 300,
        padding: EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              color: Colors.blue.withOpacity(0.2),
              blurRadius: 8,
              offset: Offset(0, 2),
            ),
          ],
          border: Border.all(
            color: Colors.lightBlue,
            width: 2,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 위치와 현위치
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  '중구 을지로 1가',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Row(
                  children: [
                    Icon(
                      Icons.location_on,
                      color: Colors.blue,
                      size: 16,
                    ),
                    SizedBox(width: 4),
                    Text(
                      '현위치',
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.grey[700],
                      ),
                    ),
                  ],
                ),
              ],
            ),
            SizedBox(height: 16),
            // 날씨 정보
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  children: [
                    Icon(
                      Icons.wb_sunny,
                      color: Colors.orange,
                      size: 48,
                    ),
                    SizedBox(height: 8),
                    Text(
                      '맑음',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                  ],
                ),
                Text(
                  '30.9',
                  style: TextStyle(
                    fontSize: 48,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
              ],
            ),
            SizedBox(height: 8),
            // 메시지
            Center(
              child: Text(
                '오늘은 광합성하기 좋은 날씨입니다',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            SizedBox(height: 16),
            // 하단 추가 정보
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text(
                  '습도 66%',
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.grey[700],
                  ),
                ),
                Text(
                  '체감 31.9°',
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.grey[700],
                  ),
                ),
                Text(
                  '서풍 1.9m/s',
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.grey[700],
                  ),
                ),
                Text(
                  '미세 좋음',
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.grey[700],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMyPlantsSection() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: Colors.white.withOpacity(0.8),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.13),
            spreadRadius: 2,
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                '다이어리',
                style: TextStyle(fontSize: 21, fontWeight: FontWeight.bold),
              ),
              TextButton(
                onPressed: () {},
                child: const Text(
                  '다이어리 이동하기 >',
                  style: TextStyle(color: Colors.grey),
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 120,
                height: 120,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  image: const DecorationImage(
                    image: AssetImage('images/백량금.jpg'),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              const SizedBox(width: 20),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      '몬스테라',
                      style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 15),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            _buildActionContainer(
                              icon: Icons.water_drop, // 변경
                              text: '물주기',
                              iconColor: Colors.lightBlueAccent,
                              iconSize: 20,
                            ),
                            const SizedBox(width: 15),
                            _buildActionContainer(
                              icon: 'images/potion.png',
                              text: '영양제',
                              iconSize: 20,
                            ),
                          ],
                        ),
                        const SizedBox(height: 5),
                        Row(
                          children: [
                            _buildActionContainer(
                              icon: 'images/scissor.png',
                              text: '가지치기',
                              iconSize: 20,
                            ),
                            const SizedBox(width: 10),
                            _buildActionContainer(
                              icon: 'images/soil.png',
                              text: '분갈이',
                              iconSize: 20,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              // IconButton(
              //   icon: const Icon(Icons.more_vert),
              //   onPressed: () {},
              // ),
            ],
          ),
          const SizedBox(height: 20),
          Container(
            color: Colors.grey[300],
            height: 1,
            width: double.infinity,
          ),
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _buildStatusRow(
                icon: Icons.water_drop, // 변경
                text: 'Next D-6',
              ),
              _buildStatusRow(
                icon: Icons.pest_control, // 다른 아이콘 예시
                text: 'Next D-3',
              ),
              _buildStatusRow(
                icon: Icons.science, // 다른 아이콘 예시
                text: 'Next D-1',
              ),
              _buildStatusRow(
                icon: Icons.grass, // 다른 아이콘 예시
                text: 'Next D-5',
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildActionContainer({
    required dynamic icon, // 변경: dynamic으로 변경하여 IconData와 String 모두 허용
    required String text,
    Color? iconColor,
    double iconSize = 24,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.grey[400]!),
      ),
      child: Row(
        children: [
          if (icon is IconData)
            Icon(
              icon,
              size: iconSize,
              color: iconColor ?? Colors.grey,
            )
          else if (icon is String && icon.endsWith('.png'))
            Image.asset(
              icon,
              width: iconSize,
              height: iconSize,
            ),
          const SizedBox(width: 4),
          Text(
            text,
            style: const TextStyle(fontSize: 16, color: Colors.grey),
          ),
        ],
      ),
    );
  }
  Widget _buildStatusRow({
    required dynamic icon, // 변경: dynamic으로 변경하여 IconData와 String 모두 허용
    required String text,
  }) {
    return Row(
      children: [
        if (icon is IconData)
          Icon(
            icon,
            size: 12,
            color: Colors.grey,
          )
        else if (icon is String && icon.endsWith('.png'))
          Image.asset(
            icon,
            width: 12,
            height: 12,
          ),
        const SizedBox(width: 5),
        Text(
          text,
          style: const TextStyle(fontSize: 12, color: Colors.grey),
        ),
      ],
    );
  }

  // 다이어리 비어있을 때 코드
  // Widget _buildMyPlantsSection() {
  //   return Container(
  //     padding: const EdgeInsets.all(24),
  //     decoration: BoxDecoration(
  //       borderRadius: BorderRadius.circular(8),
  //       color: Colors.white.withOpacity(0.8),
  //       boxShadow: [
  //         BoxShadow(
  //           color: Colors.black.withOpacity(0.13),
  //           spreadRadius: 2,
  //           blurRadius: 8,
  //           offset: const Offset(0, 2),
  //         ),
  //       ],
  //     ),
  //     child: Column(
  //       crossAxisAlignment: CrossAxisAlignment.center,
  //       children: [
  //         Row(
  //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //           children: [
  //             const Text(
  //               '다이어리',
  //               style: TextStyle(fontSize: 21, fontWeight: FontWeight.bold),
  //             ),
  //             TextButton(
  //               onPressed: () {},
  //               child: Row(
  //                 children: const [
  //                   Text(
  //                     '다이어리 이동하기 >',
  //                     style: TextStyle(
  //                       color: Colors.grey,
  //                     ),
  //                   ),
  //                   SizedBox(width: 5),
  //                 ],
  //               ),
  //             ),
  //           ],
  //         ),
  //         const SizedBox(height: 20),
  //         const Text(
  //           '등록된 식물이 없습니다.\n나의 반려식물을 등록해 보세요.',
  //           textAlign: TextAlign.center,
  //           style: TextStyle(fontSize: 16),
  //         ),
  //         const SizedBox(height: 20),
  //         SizedBox(
  //           width: double.infinity,
  //           height: 50,
  //           child: ElevatedButton(
  //             onPressed: () {},
  //             style: ElevatedButton.styleFrom(
  //               backgroundColor: Color(0xff6bbe45),
  //               shape: RoundedRectangleBorder(
  //                 borderRadius: BorderRadius.circular(10),
  //               ),
  //             ),
  //             child: const Text(
  //               '다이어리 등록하기',
  //               style: TextStyle(
  //                 fontSize: 16,
  //                 color: Colors.white,
  //               ),
  //             ),
  //           ),
  //         ),
  //       ],
  //     ),
  //   );
  // }

  Widget _buildRecommendedPlantsSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              '추천 식물',
              style: TextStyle(fontSize: 21, fontWeight: FontWeight.bold),
            ),
            TextButton(
              onPressed: () {
                // 더보기 버튼 클릭 시 동작할 코드 작성
              },
              child: Row(
                children: const [
                  Text(
                    '더보기 >',
                    style: TextStyle(
                      color: Colors.grey,
                    ),
                  ),
                  SizedBox(width: 5),
                ],
              ),
            ),
          ],
        ),
        const SizedBox(height: 10),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: [
              _buildPlantCard('images/산세베리아.jpg', '산세베리아'),
              _buildPlantCard('images/파키라.png', '파키라'),
              _buildPlantCard('images/홍콩야자.jpeg', '홍콩야자'),
            ],
          ),
        ),
      ],
    );
  }
  Widget _buildPopularPostsSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              '인기글',
              style: TextStyle(fontSize: 21, fontWeight: FontWeight.bold),
            ),
            TextButton(
              onPressed: () {
                // 더보기 버튼 클릭 시 동작할 코드 작성
              },
              child: Row(
                children: const [
                  Text(
                    '더보기 >',
                    style: TextStyle(
                      color: Colors.grey,
                    ),
                  ),
                  SizedBox(width: 5),
                ],
              ),
            ),
          ],
        ),
        const SizedBox(height: 10),
        SizedBox(
          height: 140,
          child: PageView(
            controller: PageController(viewportFraction: 0.85),
            children: [
              _buildPopularPostCard(
                imagePath: 'images/멕시코소철.jpg',
                boardName: '자유게시판',
                title: '멕시코소철 키우기 팁',
                description: '햇빛과 물 관리만 잘하면 쉽게 키울 수 있어요.',
                isFirstCard: true,
              ),
              _buildPopularPostCard(
                imagePath: 'images/백량금.jpg',
                boardName: '자유게시판',
                title: '백량금은 어떤 식물인가요?',
                description: '공기 정화에 좋은 산세베리아 소개',
                isFirstCard: false,
              ),
              _buildPopularPostCard(
                imagePath: 'images/율마.jpg',
                boardName: '자유게시판',
                title: '율마가 시들었어요.',
                description: '잎이 누렇게 변했는데 이유가 뭘까요?',
                isFirstCard: false,
              ),
            ],
          ),
        ),
      ],
    );
  }
  Widget _buildPopularPostCard({
    required String imagePath,
    required String boardName,
    required String title,
    required String description,
    required bool isFirstCard,
  }) {
    return Container(
      margin: EdgeInsets.only(
        left: isFirstCard ? 0 : 10,
        right: 10,
      ),
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: Colors.white.withOpacity(0.8),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.13),
            spreadRadius: 2,
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 120,
            height: 120,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              image: DecorationImage(
                image: AssetImage(imagePath),
                fit: BoxFit.cover,
              ),
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  boardName,
                  style: const TextStyle(
                    color: Colors.grey,
                    fontSize: 12,
                  ),
                ),
                const SizedBox(height: 5),
                Text(
                  title,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                  ),
                ),
                const SizedBox(height: 5),
                Text(
                  description,
                  style: const TextStyle(
                    fontSize: 12,
                    color: Colors.grey,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
  Widget _buildPlantCard(String imagePath, String plantName) {
    return Container(
      margin: const EdgeInsets.only(right: 10),
      width: 120,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 120,
            height: 120,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              image: DecorationImage(
                image: AssetImage(imagePath),
                fit: BoxFit.cover,
              ),
            ),
          ),
          const SizedBox(height: 5),
          Text(plantName),
        ],
      ),
    );
  }

  // Widget _buildPlantDictionaryPage() {
  //   return SingleChildScrollView(
  //     controller: _scrollController,
  //     padding: const EdgeInsets.all(16),
  //     child: Column(
  //       crossAxisAlignment: CrossAxisAlignment.start,
  //       children: [
  //         // _buildPlantCamera(),
  //         const SizedBox(height: 50),
  //         // _buildRecommendedPlantsSection(),
  //         const SizedBox(height: 50),
  //         // _buildPopularPostsSection(),
  //         const SizedBox(height: 40),
  //       ],
  //     ),
  //   );
  // }
  Widget _buildPlantDictionaryPage() {
    return SingleChildScrollView(
      controller: _scrollController,
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 50),
          const SizedBox(height: 50),
          const SizedBox(height: 40),
        ],
      ),
    );
  }
  Widget _buildPlantClinicPage(String text) {
    return Center(
      child: Text(text),
    );
  }
  Widget _buildCommunityPage(String text) {
    return Center(
      child: Text(text),
    );
  }
  Widget _buildCustomerServicePage(String text) {
    return Center(
      child: Text(text),
    );
  }
}
