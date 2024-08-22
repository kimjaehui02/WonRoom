import 'package:flutter/material.dart';

class PlantDictionary extends StatefulWidget {
  @override
  State<PlantDictionary> createState() => _PlantDictionaryState();
}

class _PlantDictionaryState extends State<PlantDictionary> {
  List<Map<String, String>> _items = [];
  ScrollController _scrollController = ScrollController();
  bool _isLoading = false;
  int _currentPage = 0;

  @override
  void initState() {
    super.initState();
    _loadInitialItems(); // 초기 데이터 로드
    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        _loadMoreItems(); // 스크롤이 끝에 도달했을 때 더 많은 항목을 로드
      }
    });
  }

  // 초기 데이터를 로드하는 함수
  void _loadInitialItems() {
    List<Map<String, String>> initialItems = List.generate(10, (index) {
      return {
        "image": "https://via.placeholder.com/150", // Placeholder 이미지
        "name": "Plant $index",
      };
    });

    setState(() {
      _items = initialItems;
    });
  }

  // 추가 데이터를 로드하는 함수
  Future<void> _loadMoreItems() async {
    if (_isLoading) return;
    setState(() {
      _isLoading = true;
    });

    // 서버 또는 데이터베이스에서 데이터를 가져오는 것을 시뮬레이션
    await Future.delayed(Duration(milliseconds: 500)); // 로딩 시간 단축

    List<Map<String, String>> newItems = List.generate(10, (index) {
      int itemIndex = _currentPage * 10 + index;
      return {
        "image": "https://via.placeholder.com/150", // Placeholder 이미지
        "name": "Plant $itemIndex",
      };
    });

    setState(() {
      _currentPage++;
      _items.addAll(newItems);
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.all(16),
        child: CustomScrollView(
          // CustomScrollView의 괄호 시작
          controller: _scrollController, // CustomScrollView의 controller 속성
          slivers: [
            // CustomScrollView의 slivers 속성 (리스트 형태로 여러 Sliver를 포함할 수 있음)
            SliverToBoxAdapter(
              // SliverToBoxAdapter의 괄호 시작
              child: Padding(
                // Padding의 괄호 시작
                padding: const EdgeInsets.all(16),
                child: Text(
                  '식물 사전',
                  style: TextStyle(
                    fontSize: 21,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ), // Padding의 괄호 끝
            ), // SliverToBoxAdapter의 괄호 끝
            SliverGrid(
              // SliverGrid의 괄호 시작
              delegate: SliverChildBuilderDelegate(
                // SliverChildBuilderDelegate의 괄호 시작
                    (context, index) {
                  // itemBuilder의 괄호 시작
                  if (index == _items.length && _isLoading) {
                    return Center(child: CircularProgressIndicator()); // 로딩 인디케이터
                  }
                  return GestureDetector(
                    // GestureDetector의 괄호 시작
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => PlantDetailPage(
                            plantName: _items[index]["name"]!,
                            plantImage: _items[index]["image"]!,
                          ),
                        ),
                      );
                    },
                    child: Column(
                      // Column의 괄호 시작
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Expanded(
                          // Expanded의 괄호 시작
                          child: Container(
                            // Container의 괄호 시작
                            decoration: BoxDecoration(
                              color: Colors.grey.shade300, // 임시 배경 색상
                              borderRadius: BorderRadius.circular(10), // 라운드 처리
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black26, // 그림자 색상
                                  blurRadius: 4, // 그림자의 흐림 정도
                                  offset: Offset(2, 2), // 그림자의 위치
                                ),
                              ],
                            ),
                            child: ClipRRect(
                              // ClipRRect의 괄호 시작
                              borderRadius: BorderRadius.circular(10),
                              child: Image.network(
                                _items[index]["image"]!,
                                fit: BoxFit.cover, // 이미지 비율에 맞게 자르기
                              ),
                            ), // ClipRRect의 괄호 끝
                          ), // Container의 괄호 끝
                        ), // Expanded의 괄호 끝
                        SizedBox(height: 8), // 이미지와 텍스트 사이의 간격
                        Text(
                          _items[index]["name"]!,
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ], // Column의 children 목록 끝
                    ), // GestureDetector의 괄호 끝
                  ); // itemBuilder의 괄호 끝
                },
                childCount: _items.length + (_isLoading ? 1 : 0),
              ), // SliverChildBuilderDelegate의 괄호 끝
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                // SliverGridDelegateWithFixedCrossAxisCount의 괄호 시작
                crossAxisCount: 2, // 한 행에 2개의 항목
                crossAxisSpacing: 12, // 항목 간의 수평 간격
                mainAxisSpacing: 24, // 항목 간의 수직 간격
                childAspectRatio: 1, // 1:1 비율 설정
              ), // SliverGridDelegateWithFixedCrossAxisCount의 괄호 끝
            ), // SliverGrid의 괄호 끝
          ], // CustomScrollView의 slivers 목록 끝
        ), // CustomScrollView의 괄호 끝
      );
  }
}

class PlantDetailPage extends StatelessWidget {
  final String plantName;
  final String plantImage;

  PlantDetailPage({required this.plantName, required this.plantImage});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(plantName),
      ),
    );
  }
}
