import 'package:flutter/material.dart';
import 'package:wonroom/PlantDetailPage.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter/services.dart' show rootBundle;
import 'package:csv/csv.dart';

class PlantDictionary extends StatefulWidget {
  @override
  State<PlantDictionary> createState() => _PlantDictionaryState();
}

class _PlantDictionaryState extends State<PlantDictionary> {
  List<List<dynamic>> rows = [];
  List<Map<String, String>> _items = [];
  ScrollController _scrollController = ScrollController();
  bool _isLoading = false;
  int _currentPage = 0;
  bool _isFabVisible = false;

  @override
  void initState() {
    super.initState();

    _loadInitialItems(); // 초기 데이터 로드

    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        _loadMoreItems(); // 스크롤이 끝에 도달했을 때 더 많은 항목을 로드
      }

      // FAB 가시성 제어
      setState(() {
        _isFabVisible = _scrollController.offset > 100;
      });
    });
  }

  // 초기 데이터를 로드하는 함수
  void _loadInitialItems() async {
    // 비동기적으로 데이터를 로드
    List<Map<String, String>> initialItems = await Future.wait(
        List.generate(10, (index) => _addItems(index))
    );

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

    // 비동기적으로 데이터를 로드
    List<Map<String, String>> newItems = await Future.wait(
        List.generate(10, (index) async {
          int itemIndex = _currentPage * 10 + index + 1; // 첫 번째 인덱스 제외
          return await _addItems(itemIndex);
        })
    );

    setState(() {
      _currentPage++;
      _items.addAll(newItems);
      _isLoading = false;
    });
  }

  void _scrollToTop() {
    _scrollController.animateTo(
      0,
      duration: Duration(milliseconds: 500),
      curve: Curves.easeInOut,
    );
  }

  Future<Map<String, String>> loadCSV(int index) async {
    // CSV 파일을 읽어오기
    final csvData = await rootBundle.loadString('images/plant2.csv');

    // CSV 데이터를 파싱하기
    List<List<dynamic>> rows = const CsvToListConverter().convert(csvData);

    // 첫 번째 행은 제목일 수 있으므로 무시
    if (index < 0 || index >= rows.length) {
      throw Exception('Index out of bounds');
    }

    // 이미지 URL과 이름을 리스트에서 추출
    final row = rows[index + 1]; // 첫 번째 행을 무시하므로 +1
    final imageUrl = row[0] as String;
    final name = row[1] as String;

    return {
      'image': imageUrl,
      'name': name,
    };
  }

  Future<Map<String, String>> _addItems(int itemIndex) async {
    try {
      return await loadCSV(itemIndex);
    } catch (e) {
      return {
        "image": "http://www.nongsaro.go.kr/cms_contents/301/12938_MF_REPR_ATTACH_01_TMB.jpg", // Placeholder 이미지
        "name": "Plant $itemIndex",
      };
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Padding(
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
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => PlantDetailPage(data: {}),
                            ),
                          );
                        },
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            Container(
                              height: 150, // 고정된 높이
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
                                borderRadius: BorderRadius.circular(10),
                                child: Image.network(
                                  _items[index]["image"]!,
                                  fit: BoxFit.cover, // 이미지 크기를 컨테이너에 맞게 조정
                                ),
                              ),
                            ),
                            SizedBox(height: 8),
                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 16),
                              child: Text(
                                _items[index]["name"]!,
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                ),
                                textAlign: TextAlign.center, // 텍스트 중앙 정렬
                                overflow: TextOverflow.ellipsis, // 텍스트가 넘칠 경우 줄임표로 표시
                                maxLines: 1, // 최대 2줄까지 표시
                              ),
                            ),

                          ],
                        ),
                      );
                    },
                    childCount: _items.length + (_isLoading ? 1 : 0),
                  ),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 12,
                    mainAxisSpacing: 24,
                    childAspectRatio: 1, // 비율을 1:1로 설정
                  ),
                ),
              ],
            ),
          ),
          if (_isFabVisible)
            Positioned(
              right: 16,
              bottom: 30,
              child: FloatingActionButton(
                onPressed: _scrollToTop,
                child: Icon(Icons.arrow_upward, color: Colors.white),
                backgroundColor: Colors.black.withOpacity(0.6),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(50),
                ),
                elevation: 0,
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
