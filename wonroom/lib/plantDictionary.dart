import 'package:flutter/material.dart';
import 'package:wonroom/PlantDetailPage.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:io';
class PlantDictionary extends StatefulWidget {
  @override
  State<PlantDictionary> createState() => _PlantDictionaryState();
}

// void _scrollToTop() {
//   _scrollController.animateTo(
//     0,
//     duration: Duration(milliseconds: 500),
//     curve: Curves.easeInOut,
//   );
// }

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
          controller: _scrollController,
          slivers: [
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Text(
                  '식물 사전',
                  style: TextStyle(
                    fontSize: 21,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            SliverGrid(
              delegate: SliverChildBuilderDelegate(
                    (context, index) {
                  if (index == _items.length && _isLoading) {
                    return Center(child: CircularProgressIndicator());
                  }
                  return GestureDetector(
                    onTap: () async {
                      final String plantName = "식물이름";
                      String analysisResult = await sendNameToServer(plantName, 'plant_name');


                      // Navigator.push(
                      //   context,
                      //   MaterialPageRoute(
                      //     builder: (context) => PlantDetailPage(),
                      //   ),
                      // );
                      // Navigator.push(
                      //   context,
                      //   MaterialPageRoute(
                      //     builder: (context) => PlantDetailPage(
                      //       // plantName: _items[index]["name"]!,
                      //       // plantImage: _items[index]["image"]!,
                      //     ),
                      //   ),
                      // );
                    },
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Expanded(
                          child: Container(
                            decoration: BoxDecoration(
                              color: Colors.grey.shade300,
                              borderRadius: BorderRadius.circular(10),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black26,
                                  blurRadius: 4, // 그림자의 흐림 정도
                                  offset: Offset(2, 2),
                                ),
                              ],
                            ),
                            child: ClipRRect(
                              // ClipRRect의 괄호 시작
                              borderRadius: BorderRadius.circular(10),
                              child: Image.network(
                                _items[index]["image"]!,
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: 8),

                        // padding: const EdgeInsets.only(left: 10, right: 10, top: 4),
                        Text(
                          _items[index]["name"]!,
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  );
                },
                childCount: _items.length + (_isLoading ? 1 : 0),
              ),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2, // 한 행에 2개의 항목
                crossAxisSpacing: 12, // 항목 간의 수평 간격
                mainAxisSpacing: 24, // 항목 간의 수직 간격
                childAspectRatio: 1, // 1:1 비율 설정
              ),
            ),
          ],
        ),
      );
  }
}

// class PlantDetailPage extends StatelessWidget {
//   final String plantName;
//   final String plantImage;
//
//   PlantDetailPage({required this.plantName, required this.plantImage});
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text(plantName),
//       ),
//     );
//   }
// }
Future<String> sendNameToServer(String plantName, String category) async {
  var response = await http.post(
    Uri.parse('https://your-server-url/plantDetail'),
    headers: {'Content-Type': 'application/json'},
    body: jsonEncode({'name': plantName, 'category': category}),
  );

  if (response.statusCode == 200) {
    return jsonDecode(response.body)['result'];
  } else {
    throw Exception('이미지 분석 실패: ${response.statusCode}');
  }
}