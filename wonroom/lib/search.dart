import 'package:flutter/material.dart';

class Search extends StatefulWidget {
  const Search({super.key});

  @override
  _SearchState createState() => _SearchState();
}

class _SearchState extends State<Search> {
  final TextEditingController _searchController = TextEditingController();

  void _performSearch() {
    String query = _searchController.text;
    if (query.isNotEmpty) {
      // 여기에 검색 로직을 추가하세요.
      print('검색어: $query');
      // 실제 검색 로직을 여기에 추가합니다.
    }
  }

  void _clearText() {
    _searchController.clear();
    // _performSearch(); // 텍스트를 지운 후 자동으로 검색을 수행하려면 주석 제거
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('식물 검색', style: TextStyle(fontWeight: FontWeight.bold)),
        centerTitle: true,
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
      body: Column(
        children: [
          // 구분
          Container(
            margin: EdgeInsets.only(top: 10, bottom: 24),
            width: MediaQuery.of(context).size.width,
            height: 8,
            color: Color(0xffeeeeee),
          ),

          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: TextField(
              controller: _searchController,
              decoration: InputDecoration(
                hintText: '검색어를 입력하세요',
                border: OutlineInputBorder(),
                prefixIcon: IconButton(
                  icon: Icon(Icons.search),
                  onPressed: _performSearch,
                ),
                suffixIcon: _searchController.text.isNotEmpty
                    ? IconButton(
                  icon: Icon(Icons.clear),
                  onPressed: _clearText,
                )
                    : null,
                contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 16),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Color(0xffc2c2c2), width: 2.0),
                  borderRadius: BorderRadius.circular(8),
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Color(0xffc2c2c2), width: 1.0),
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              onSubmitted: (String query) {
                _performSearch();
              },
              onChanged: (String text) {
                setState(() {});
              },
            ),
          ),

          SizedBox(height: 20,),

          // 검색 결과
          Container(
            margin: EdgeInsets.symmetric(horizontal: 16),
            padding: EdgeInsets.all(8),
            decoration: BoxDecoration(
              border: Border(
                top: BorderSide(
                  color: Color(0xffeeeeee),
                  width: 1,
                ),
              ),
            ),
            child: Row(
              children: [
                Container(
                  width: MediaQuery.of(context).size.width * 0.2,
                  height: MediaQuery.of(context).size.width * 0.2,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    image: DecorationImage(
                      fit: BoxFit.fill,
                      image: AssetImage('images/img01.jpg'),
                    ),
                  ),
                ),


                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('몬스테라',
                          style: TextStyle(
                              fontSize: 18,
                              color: Color(0xff595959),
                              fontWeight: FontWeight.bold
                          ),
                          overflow: TextOverflow.ellipsis,
                          maxLines: 1,
                        ),

                        SizedBox(height: 5,),

                        Text('큰 잎과 독특한 구멍이 있는 열대 식물입니다. 천남성과의 여러해살이 덩굴성 식물. 관엽식물로 길이는',
                          style: TextStyle(
                            fontSize: 14,
                            color: Color(0xff787878),
                          ),
                          overflow: TextOverflow.ellipsis,
                          maxLines: 2,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
