import 'package:flutter/material.dart';
import 'package:wonroom/DB/plant_management_records/plant_management_model.dart';
import 'package:wonroom/DB/plant_management_records/plant_management_records_service.dart';
import 'package:wonroom/DB/user_plants/user_plants_model.dart';
import 'package:wonroom/DB/user_plants/user_plants_service.dart';
import 'package:wonroom/Flask/storage_manager.dart';
import 'package:wonroom/MyPlant/myPlant_functions.dart';
import 'package:wonroom/PlantDetailPage.dart';
import 'package:wonroom/PostDetailPage.dart';
import 'package:wonroom/community.dart';
import 'package:wonroom/customerService.dart';
import 'package:wonroom/inqurityDetails.dart';
import 'package:wonroom/myPage.dart';
import 'package:wonroom/myPlantNull.dart';
import 'package:wonroom/myPlant.dart';
import 'package:wonroom/myPlantRegistration.dart';
import 'package:wonroom/notificationPage.dart';
import 'package:wonroom/plantClinicChat.dart';
import 'package:wonroom/search.dart';
import 'package:wonroom/showFloatingActionModal.dart';
import 'plantDictionary.dart';

class Index extends StatefulWidget
{
  const Index({super.key});
  @override
  _IndexState createState() => _IndexState();
}

// 인기글 데이터
final List<Map<String, String>> data = [
  {
    'image': 'images/plant_0.jpg',
    'boardName': '자유게시판',
    'title': 'Title 1',
    'description': 'Description 1  DescriptionDescriptionDescriptionDescriptionDescriptionDescriptionDescriptionDescriptionDescriptionDescriptionDescriptionDescriptionDescription',
  },
  {
    'image': 'images/산세베리아.jpg',
    'boardName': '질문하기',
    'title': 'Title 2',
    'description': 'Description 2',
  },
  {
    'image': 'images/파키라.png',
    'boardName': '자유게시판',
    'title': 'Title 3',
    'description': 'Description 3',
  },
];

class _IndexState extends State<Index> with SingleTickerProviderStateMixin {
  late TabController _tabController;
  int _selectedIndex = 0;
  final ScrollController _scrollController = ScrollController();
  bool _isFabVisible = false;

  bool _1 = true;
  bool _2 = true;
  bool _3 = true;
  bool _4 = true;

  // 다이어리 이동 페이지의 화면을 표시하기위해
  // 식물인덱스의0번째나 즐겨찾기꺼를 담습니다
  UserPlant? indexPlant = null;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 4, vsync: this);
    _scrollController.addListener(_scrollListener);

    // 비동기 작업을 위해 별도의 메서드 호출
    _initializeIndexPlant();



    //   추가
    // Tab change listener
    _tabController.addListener(() {
      if (_tabController.index == 3) { // 고객센터 탭이 선택되었을 때
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) =>
              CustomerService()), // customerService.dart로 이동
        ).then((_) {
          _tabController.index = 0; // 홈 탭으로 되돌아가도록 설정
        });
      }
    });
  }


  Future<void> _initializeIndexPlant() async {
    // 비동기 작업을 수행하고 결과를 상태에 반영
    UserPlant? plant = await _getPlants();
    setState(() {
      indexPlant = plant;
      initializeBooleans(indexPlant?.plantId ?? -1);
    });

    // initializeBooleans(indexPlant?.plantId ?? -1);
    setState(() {

    });
  }

  // 식물값을 얻어오는 함수
  Future<UserPlant?> _getPlants() async {
    UserPlantService ups = UserPlantService();
    StorageManager _sm = new StorageManager();

    final _data = await _sm.readUserData();
    List<UserPlant>? _plants = await ups.getPlants(_data?["user_id"]);

    // _plants가 null이거나 비어있으면 null 반환
    if (_plants == null || _plants.isEmpty) {
      return null;
    }

    // 첫 번째 플랜트를 반환
    return _plants[0];
  }

  // 4개의 온프레스트
  void button4(input) async
  {
    print(input);
    print(input);
    print(input);
    print(input);
    print(input);

    // 얘네가 db에 데이터를 업데이트하거나 하는 역할을 하였으니
    // 다음엔 db에서 값을 가져오는 역할을 해야합니다
    int indexPlantId = indexPlant?.plantId ?? -1;

    diagnosis _dg = new diagnosis("");
    await plants(input, indexPlantId, null, _dg);


    setState(() {
      initializeBooleans(indexPlantId);
    });

  }


  // 4개의 불값을 조절
  Future<void> initializeBooleans(int plantId) async {
    // 각각의 일정에 대한 중복 여부를 저장할 불리언 변수들
    // _1 = false; // 물주기
    // _2 = false; // 영양제
    // _3 = false; // 가지치기
    // _4 = false; // 분갈이

    // PlantManagementService 초기화
    PlantManagementService _pms = PlantManagementService();

    // 비동기 작업을 수행
    // print(ManagementType.Watering);
    // print(ManagementType.Watering);
    // print(ManagementType.Watering);
    // print(ManagementType.Watering);
    // print(ManagementType.Watering);

    bool isDateDuplicate1 = await isDateDuplicate(plantId, ManagementType.Watering, _pms);

    bool isDateDuplicate2 = await isDateDuplicate(plantId, ManagementType.Fertilizing, _pms);

    bool isDateDuplicate3 = await isDateDuplicate(plantId, ManagementType.Pruning, _pms);

    bool isDateDuplicate4 = await isDateDuplicate(plantId, ManagementType.Repotting, _pms);

    // 비동기 작업이 완료된 후 상태 업데이트
    if (mounted) {
      setState(() {
        _1 = isDateDuplicate1;
        _2 = isDateDuplicate2;
        _3 = isDateDuplicate3;
        _4 = isDateDuplicate4;
      });
    }

    // 결과 출력 (디버깅용)
    print('물주기 중복 여부: $_1');
    print('영양제 중복 여부: $_2');
    print('가지치기 중복 여부: $_3');
    print('분갈이 중복 여부: $_4');

  }

  // 식물버튼 불값
  Future<bool> isDateDuplicate(int plantId, ManagementType type, PlantManagementService pms) async {
    // 해당 식물의 일정 기록을 가져옴
    List<PlantManagementRecord> records = await pms.getRecords(plantId);
    print("입력받은 타입은");
    print(type);
    // 오늘 날짜와 같은 일정이 있는지 확인
    for (var record in records) {
      if (pms.isDateToday(record.managementDate) && record.managementType == type) {
        print("중복된게 있네요");
        return true; // 중복된 날짜가 있는 경우
      }
    }
    print("중복된게 없네요");

    return false; // 중복된 날짜가 없는 경우
  }


  @override
  void dispose() {
    _scrollController.removeListener(_scrollListener);
    _scrollController.dispose();
    _tabController.dispose();
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

  // 다이어리 이동하기로 화면을 이동시킵니다
  void _moveDiary()
  {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => MyplantNull()), // MyPage로 이동
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset : false,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        leading: IconButton(
          icon: const Icon(Icons.search),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => Search()),
            );
          },
        ),
        title: RichText(
          text: TextSpan(
            children: [
              TextSpan(
                text: 'Won',
                style: TextStyle(
                  color: Color(0xff779d60),
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
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications_none_outlined),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => NotificationPage()),
              );
            },
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
        centerTitle: true,
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
          tabAlignment: TabAlignment.center,
          labelPadding: EdgeInsets.symmetric(horizontal: 20.0),
          tabs: const
          [
            Tab(text: '홈'),
            Tab(text: '식물사전'),
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
              Community(),
              // 추가
              Container(),
              // CustomerService(),
              // _buildPlantDictionaryPage(),
              // PlantDictionary(),
              // _buildPlantClinicPage('식물클리닉 페이지'),
              // _buildCommunityPage('커뮤니티 페이지'),
              // _buildCustomerServicePage('고객센터 페이지'),
            ],
          ),
          if (_isFabVisible)
            Positioned(
              right: 16,
              bottom: 30,
              child: FloatingActionButton(
                onPressed: _scrollToTop,
                child: Icon(Icons.arrow_upward, color: Colors.white,),
                backgroundColor: Colors.black.withOpacity(0.6),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(50),
                ),
                elevation: 0,
              ),
            ),
        ],
      ),

      // bottom app bar
      // extendBody: true, // Body를 appBar와 bottomNavigationBar 위로 확장
      floatingActionButton: Container(
        width: 70,
        height: 70,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: Color(0xff6bbe45), // 연두색
        ),
        child: FloatingActionButton(
          onPressed: () {
            showFloatingActionModal(context, _initializeIndexPlant);
          },
          backgroundColor: Colors.transparent,
          elevation: 0,
          child: const Icon(Icons.camera_alt_outlined,
            color: Colors.white,
            size: 32,
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Colors.black12.withOpacity(0.1),
              spreadRadius: 0,
              blurRadius: 4,
              // offset: Offset(0, 0), // 그림자를 위쪽으로 이동
            ),
          ],
        ),
        child: BottomAppBar(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          height: 70,
          color: Colors.white,
          shape: const CircularNotchedRectangle(),
          notchMargin: 5,
          child: Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              _buildBottomNavBarItem(
                icon: ColorFiltered(
                  colorFilter: ColorFilter.mode(Colors.grey, BlendMode.srcIn),
                  child: Image.asset(
                    'images/diary.png',
                    width: 26,
                    height: 26,
                  ),
                ),
                label: '다이어리',
                index: 0,
              ),
              SizedBox(width: 40),
              _buildBottomNavBarItem(
                icon: ColorFiltered(
                  colorFilter: ColorFilter.mode(Colors.grey, BlendMode.srcIn),
                  child: Image.asset(
                    'images/chat-bot.png',
                    width: 30,
                    height: 30,
                  ),
                ),
                label: '챗(AI)',
                index: 1,
              ),
            ],
          ),
        ),
      ),


    );
  }
  Widget _buildBottomNavBarItem({
    required Widget icon,
    // required dynamic icon,
    required String label,
    required int index,
  }) {
    return Expanded(
      child: InkWell(
        onTap: () {
          // _onBottomNavBarItemTapped(index);
          if (index == 0) {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => MyplantNull()),
            );
          } else if (index == 1) {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => PlantClinicChat()),
            );
          }
        },
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            icon,
            Text(
              label,
              style: TextStyle(
                // color: _selectedIndex == index ? Color(0xff6bbe45) : Colors.grey,
                color: Colors.grey,
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
          // 다이어리 빈곳 유무를 교체할 때 쓰는곳
          // if (false)
            indexPlant != null ?_buildMyPlantsSection():
            _buildMyPlantsSectionNull(),


          const SizedBox(height: 30),
          _buildWeatherWidget(),
          const SizedBox(height: 30),
          _buildRecommendedPlantsSection(),
          const SizedBox(height: 30),
          _buildPopularPostsSection(),
          const SizedBox(height: 40),
        ],
      ),
    );
  }

  // 날씨
  Widget _buildWeatherWidget() {
    const double iconSize = 100; // 아이콘 사이즈
    const double temperatureFontSize = 48; // 온도 텍스트 폰트 사이즈
    const double infoFontSize = 14; // 정보 텍스트 폰트 사이즈

    return Center(
      child: Container(
        padding: EdgeInsets.all(24),
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
                      Icons.location_searching,
                      color: Colors.blue,
                      size: 16,
                    ),
                    SizedBox(width: 3),
                    Text(
                      '현위치',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: Colors.grey[700],
                      ),
                    ),
                  ],
                ),
              ],
            ),
            SizedBox(height: 15),
            // 날씨 정보
            Row(
              crossAxisAlignment: CrossAxisAlignment.start, // 텍스트 상단 정렬
              children: [
                SizedBox(width: 45),
                Icon(
                  Icons.wb_sunny,
                  color: Colors.orange,
                  size: iconSize,
                ),
                SizedBox(width: 25), // 아이콘과 텍스트 사이의 간격 조정
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '맑음',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                        height: 2, // 줄 높이를 2로 설정
                      ),
                    ),
                    Text(
                      '30.9',
                      style: TextStyle(
                        fontSize: temperatureFontSize,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                        height: 1, // 줄 높이를 1로 설정
                      ),
                    ),
                  ],
                ),
              ],
            ),
            SizedBox(height: 10),
            // 메시지
            Center(
              child: Text(
                '" 오늘은 광합성하기 좋은 날씨입니다 "',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            SizedBox(height: 16),
            // 하단 추가 정보
            Center(
              child: RichText(
                text: TextSpan(
                  style: TextStyle(
                    fontSize: infoFontSize,
                    color: Colors.grey[700],
                  ),
                  children: [
                    TextSpan(
                      text: '습도 ',
                    ),
                    TextSpan(
                      text: '66% ',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    TextSpan(
                      text: ' |  ', // 구분 기호
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.grey[700],
                      ),
                    ),
                    TextSpan(
                      text: '체감 ',
                    ),
                    TextSpan(
                      text: '31.9° ',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    TextSpan(
                      text: ' |  ',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.grey[700],
                      ),
                    ),
                    TextSpan(
                      text: '서풍 ',
                    ),
                    TextSpan(
                      text: '1.9m/s ',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    TextSpan(
                      text: ' |  ',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.grey[700],
                      ),
                    ),
                    TextSpan(
                      text: '미세 ',
                    ),
                    TextSpan(
                      text: '좋음',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // 다이어리 있을 때 코드
  Widget _buildMyPlantsSection() {
    return Container(
      padding: const EdgeInsets.all(24),
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
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => MyplantNull()),
                  );
                },
                style: ButtonStyle(
                  padding: MaterialStateProperty.all<EdgeInsetsGeometry>(EdgeInsets.zero),
                  minimumSize: MaterialStateProperty.all<Size>(Size.zero),
                ),
                child: const Text(
                  '다이어리 이동하기 >',
                  style: TextStyle(color: Color(0xff787878)),
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
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
                      style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 10),
                    Wrap(
                      spacing: 8, // 각 버튼 사이의 가로 간격
                      runSpacing: 2, // 줄 바꿈 시의 세로 간격
                      children: [
                        // OutlinedButton.icon(
                        //   onPressed: ()
                        //   {
                        //     button4("물주기");
                        //   },
                        //   icon: Icon(
                        //     Icons.water_drop,
                        //     size: 16,
                        //     color: Colors.lightBlueAccent,
                        //   ),
                        //   label: Text(
                        //     "물주기",
                        //     style: TextStyle(
                        //       fontSize: 14,
                        //       color: Color(0xff787878),
                        //     ),
                        //   ),
                        //   style: OutlinedButton.styleFrom(
                        //     padding: EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                        //     side: BorderSide(color: Color(0xffc2c2c2)),
                        //   ),
                        // ),
                        OutlinedButton.icon(
                          onPressed: () {
                            button4("물주기");
                          },
                          icon: Icon(
                            Icons.water_drop,
                            size: 16,
                            color: _1 ? Colors.grey[300] : Colors.lightBlueAccent, // _1이 true일 때 색상 변경
                          ),
                          label: Text(
                            "물주기",
                            style: TextStyle(
                              fontSize: 14,
                              color: _1 ? Colors.grey[300] : Color(0xff787878), // _1이 true일 때 색상 변경
                            ),
                          ),
                          style: OutlinedButton.styleFrom(
                            padding: EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                            side: BorderSide(color: _1 ? Colors.grey[300]! : Color(0xffc2c2c2)),
                          ),
                        ),
                        OutlinedButton.icon(
                          onPressed: () {
                            button4("영양제");
                          },
                          icon: Image.asset(
                            'images/potion.png',
                            width: 16,
                            height: 16,
                            color: _2 ? Colors.grey[300] : null, // _1이 true일 때 색상 변경
                          ),
                          label: Text(
                            "영양제",
                            style: TextStyle(
                              fontSize: 14,
                              color: _2 ? Colors.grey[300] : Color(0xff787878), // _2가 true일 때 색상 변경
                            ),
                          ),
                          style: OutlinedButton.styleFrom(
                            padding: EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                            side: BorderSide(color: _2 ? Colors.grey[300]! : Color(0xffc2c2c2)),
                          ),
                        ),
                        OutlinedButton.icon(
                          onPressed: () {
                            button4("가지치기");
                          },
                          icon: Image.asset(
                            'images/scissor.png',
                            width: 16,
                            height: 16,
                            color: _3 ? Colors.grey[300] : null, // _2가 true일 때 색상 변경

                          ),
                          label: Text(
                            "가지치기",
                            style: TextStyle(
                              fontSize: 14,
                              color: _3 ? Colors.grey[300] : Color(0xff787878), // _3가 true일 때 색상 변경
                            ),
                          ),
                          style: OutlinedButton.styleFrom(
                            padding: EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                            side: BorderSide(color: _3 ? Colors.grey[300]! : Color(0xffc2c2c2)),
                          ),
                        ),
                        OutlinedButton.icon(
                          onPressed: () {
                            button4("분갈이");
                          },
                          icon: Image.asset(
                            'images/soil.png',
                            width: 16,
                            height: 16,
                            color: _4 ? Colors.grey[300] : null, // _2가 true일 때 색상 변경

                          ),
                          label: Text(
                            "분갈이2",
                            style: TextStyle(
                              fontSize: 14,
                              color: _4 ? Colors.grey[300] : Color(0xff787878), // _4가 true일 때 색상 변경
                            ),
                          ),
                          style: OutlinedButton.styleFrom(
                            padding: EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                            side: BorderSide(color: _4 ? Colors.grey[300]! : Color(0xffc2c2c2)),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
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
                icon: Icons.water_drop,
                text: 'Next D-6',
              ),
              _buildStatusRow(
                icon: 'images/potion.png',
                text: 'Next D-3',
              ),
              _buildStatusRow(
                icon: 'images/scissor.png',
                text: 'Next D-1',
              ),
              _buildStatusRow(
                icon: 'images/soil.png',
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
    required dynamic icon, // IconData 또는 String (이미지 경로)
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
          ColorFiltered(
            colorFilter: ColorFilter.mode(Colors.grey, BlendMode.srcIn),
            child: Image.asset(
              icon,
              width: 12,
              height: 12,
            ),
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
  Widget _buildMyPlantsSectionNull() {
    return Container(
      padding: const EdgeInsets.all(24),
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
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                '다이어리',
                style: TextStyle(fontSize: 21, fontWeight: FontWeight.bold),
              ),
              TextButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => MyplantNull()),
                  );
                },
                child: Row(
                  children: const [
                    Text(
                      '다이어리 이동하기 >',
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
          const SizedBox(height: 20),
          const Text(
            '등록된 식물이 없습니다.\n나의 반려식물을 등록해 보세요.',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 16),
          ),
          const SizedBox(height: 20),
          SizedBox(
            width: double.infinity,
            height: 50,
            child: ElevatedButton(
              onPressed: ()
              {
                // 새로운 페이지로 이동
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => MyplantNull()),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Color(0xff6bbe45),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              child: const Text(
                '다이어리 등록하기',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

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
                _tabController.index = 1;
              },
              child: Row(
                children: const [
                  Text(
                    '더보기 >',
                    style: TextStyle(
                      color: Color(0xff787878),
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
                _tabController.index = 2;
              },
              child: Row(
                children: const [
                  Text(
                    '더보기 >',
                    style: TextStyle(
                      color: Color(0xff787878),
                    ),
                  ),
                  SizedBox(width: 5),
                ],
              ),
            ),
          ],
        ),

        // SizedBox(height: 10,),
        SizedBox(
          height: 140,
          child: PageView.builder(
            itemCount: data.length,
            controller: PageController(
              viewportFraction: 0.9, // 카드 너비를 설정하여 페이지 간의 여백 조정
              initialPage: 0,
            ),
            itemBuilder: (context, index) {
              final item = data[index];
              return GestureDetector(
                onTap: () {
                  // 상세 페이지로 이동
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      // 임시로 디테일 페이지로 이동
                      builder: (context) => PostDetailPage(post: {}),
                    ),
                  );
                },
                child: Container(
                  margin: EdgeInsets.symmetric(horizontal: 6), // 카드 사이의 여백
                  padding: EdgeInsets.only(top: 8, bottom: 8),
                  child: AspectRatio(
                    aspectRatio: 1.0,
                    child: Container(
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        color: Colors.white,
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
                            width: MediaQuery.of(context).size.width * 0.25,
                            height: MediaQuery.of(context).size.width * 0.25,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8),
                              image: DecorationImage(
                                image: AssetImage(item['image']!),
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          const SizedBox(width: 10),
                          Flexible(
                            child: Padding(
                              padding: const EdgeInsets.symmetric(vertical: 12),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    item['boardName']!,
                                    style: const TextStyle(
                                      color: Colors.grey,
                                      fontSize: 12,
                                    ),
                                  ),
                                  const SizedBox(height: 2),
                                  Text(
                                    item['title']!,
                                    style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 14,
                                    ),
                                  ),
                                  Text(
                                    item['description']!,
                                    style: const TextStyle(
                                      fontSize: 12,
                                      color: Colors.grey,
                                    ),
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              );
            },
            padEnds: false, // 페이지 끝에 패딩 적용 안 함
          ),
        )




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

}
