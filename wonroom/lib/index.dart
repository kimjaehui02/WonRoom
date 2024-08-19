import 'package:flutter/material.dart';

class Index extends StatefulWidget {
  const Index({super.key});

  @override
  _IndexState createState() => _IndexState();
}

class _IndexState extends State<Index> with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 5, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              child: Align(
                alignment: Alignment.centerLeft,
                child: IconButton(
                  icon: const Icon(Icons.search),
                  onPressed: () {
                    // 검색 아이콘 클릭 시 실행될 코드
                  },
                ),
              ),
            ),
            const Text('Won-Room'),
            Expanded(
              child: Align(
                alignment: Alignment.centerRight,
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    IconButton(
                      icon: const Icon(Icons.notifications),
                      onPressed: () {
                        // 알람 아이콘 클릭 시 실행될 코드
                      },
                    ),
                    IconButton(
                      icon: const Icon(Icons.person),
                      onPressed: () {
                        // 마이페이지 아이콘 클릭 시 실행될 코드
                      },
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
        bottom: TabBar(
          controller: _tabController,
          tabs: const [
            Tab(text: '홈'),
            Tab(text: '식물사전'),
            Tab(text: '식물클리닉'),
            Tab(text: '커뮤니티'),
            Tab(text: '고객센터'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          _buildHomePage(),
          _buildPlaceholderPage('식물사전 페이지'),
          _buildPlaceholderPage('식물클리닉 페이지'),
          _buildPlaceholderPage('커뮤니티 페이지'),
          _buildPlaceholderPage('고객센터 페이지'),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: '홈'),
          BottomNavigationBarItem(icon: Icon(Icons.camera_alt), label: '이미지 검색'),
          BottomNavigationBarItem(icon: Icon(Icons.grass), label: '도감'),
        ],
        onTap: (index) {
          // 하단 네비게이션바 클릭 시 실행될 코드
        },
      ),
    );
  }

  Widget _buildHomePage() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildMyPlantsSection(),
          const SizedBox(height: 20),
          _buildRecommendedPlantsSection(),
        ],
      ),
    );
  }

  Widget _buildMyPlantsSection() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.grey[200],
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            '마이 도감',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 10),
          const Text('등록된 식물이 없습니다.\n나의 반려식물을 등록해 보세요.'),
          const SizedBox(height: 10),
          ElevatedButton(
            onPressed: () {
              // 도감 등록하기 클릭 시 실행될 코드
            },
            child: const Text('도감 등록하기'),
            style: ElevatedButton.styleFrom(backgroundColor: Colors.green),
          ),
        ],
      ),
    );
  }

  Widget _buildRecommendedPlantsSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          '추천 식물',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 10),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: [
              // _buildPlantCard('Images/plant1.png', '벤자민나무'),
              // _buildPlantCard('Images/plant2.png', '알로카시아'),
              // _buildPlantCard('Images/plant3.png', '다육식물'),
              // 다른 추천 식물 카드 추가 가능
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildPlantCard(String imagePath, String plantName) {
    return Container(
      margin: const EdgeInsets.only(right: 10),
      width: 120,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Image.asset(imagePath, fit: BoxFit.cover),
          const SizedBox(height: 5),
          Text(plantName),
        ],
      ),
    );
  }

  Widget _buildPlaceholderPage(String text) {
    return Center(
      child: Text(text),
    );
  }
}
