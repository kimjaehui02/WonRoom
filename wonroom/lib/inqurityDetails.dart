import 'package:flutter/material.dart';

class InqurityDetails extends StatefulWidget {
  const InqurityDetails({super.key});

  @override
  _InqurityDetailsState createState() => _InqurityDetailsState();
}

class _InqurityDetailsState extends State<InqurityDetails> {
  int _selectedIndex = 0;
  List<bool> _expandedList = [false, false]; // 각 항목의 펼침 상태를 관리하기 위한 리스트

  ButtonStyle _buttonStyle(bool isSelected) {
    return ElevatedButton.styleFrom(
      backgroundColor: isSelected ? Color(0xff595959) : Colors.white,
      padding: EdgeInsets.symmetric(vertical: 8, horizontal: 20),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
        side: BorderSide(color: Color(0xffcccccc), width: 1),
      ),
      elevation: 0,
    );
  }

  TextStyle _buttonTextStyle(bool isSelected) {
    return TextStyle(
      color: isSelected ? Colors.white : Colors.grey,
      fontSize: 16,
    );
  }

  void _showDeleteConfirmationSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        return Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(height: 20),
              Text(
                '정말 삭제하시겠습니까?',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 3),
              Text(
                '삭제하기를 누르시면\n해당 게시글이 삭제됩니다.',
                style: TextStyle(color: Colors.grey, fontSize: 16),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 24),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  TextButton(
                    onPressed: () {
                      Navigator.pop(context); // 바텀 시트 닫기
                    },
                    style: TextButton.styleFrom(
                      backgroundColor: Colors.grey[300], // 회색 배경
                      minimumSize: Size(170, 50), // 네모 모양의 버튼 크기
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(3), // 네모 모양
                      ),
                      elevation: 0,
                    ),
                    child: Text(
                      '취소',
                      style: TextStyle(
                          color: Color(0xff787878),
                          fontSize: 16,
                          fontWeight: FontWeight.bold
                      ),
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context); // 삭제 확인 팝업 닫기
                      _showDeletionSuccessDialog(context); // 삭제 완료 팝업 열기
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color(0xff595959),
                      minimumSize: Size(170, 50), // 네모 모양의 버튼 크기
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(3), // 네모 모양
                      ),
                    ),
                    child: Text(
                      '삭제',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.bold
                      ), // 흰색 글씨
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }

  void _showDeletionSuccessDialog(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return AlertDialog(
          contentPadding: EdgeInsets.symmetric(horizontal: 24.0, vertical: 20.0), // 패딩 조정으로 크기 키우기
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10), // 다이얼로그 모서리 둥글게 설정
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(height: 10,),
              Text(
                '삭제되었습니다.',
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                    color: Colors.black),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 3),
              Text(
                '확인 버튼을 누르면 \n 이전 페이지로 이동합니다.',
                style: TextStyle(color: Colors.grey, fontSize: 16),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 15),
              Center(
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context); // 삭제 완료 다이얼로그 닫기
                    Navigator.pop(context); // 이전 페이지로 돌아가기
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.black,
                    minimumSize: Size(200, 45), // 네모 모양의 버튼 크기
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(3), // 네모 모양의 버튼
                    ),
                  ),
                  child: Text(
                    '확인',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.bold
                    ), // 흰색 글씨
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('문의내역', style: TextStyle(color: Colors.black)),
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
      body: Column(
        children: [
          Container(
            padding: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Container(
                      margin: EdgeInsets.only(right: 5),
                      child: ElevatedButton(
                        style: _buttonStyle(_selectedIndex == 0),
                        onPressed: () {
                          setState(() {
                            _selectedIndex = 0;
                          });
                        },
                        child: Text(
                          '전체',
                          style: _buttonTextStyle(_selectedIndex == 0),
                        ),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(right: 5),
                      child: ElevatedButton(
                        style: _buttonStyle(_selectedIndex == 1),
                        onPressed: () {
                          setState(() {
                            _selectedIndex = 1;
                          });
                        },
                        child: Text(
                          '답변완료',
                          style: _buttonTextStyle(_selectedIndex == 1),
                        ),
                      ),
                    ),
                    ElevatedButton(
                      style: _buttonStyle(_selectedIndex == 2),
                      onPressed: () {
                        setState(() {
                          _selectedIndex = 2;
                        });
                      },
                      child: Text(
                        '답변대기',
                        style: _buttonTextStyle(_selectedIndex == 2),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Divider(
            color: Colors.grey[300],
            thickness: 1,
          ),
          Expanded(
            child: ListView(
              children: [
                // 첫 번째 문의
                _buildInquiryItem(
                    index: 0,
                    category: '[앱 기능 및 사용 방법]',
                    title: '식물의 상태를 어떻게 추적하나요?',
                    description: '식물의 상태를 추적할 수 있는 방법에 대한 정보입니다.',
                    status: '답변완료',
                    date: '2024.03.26',
                    answer: '도감 메뉴에서 자신의 반려식물을 등록할 수 있습니다. 사진과 함께 이름, 관리 방법을 입력하면 앱에서 자동으로 성장일지를 제공합니다.',
                    nickname: '원룸',
                    answerDate: '2024.03.27'
                ),
                // 두 번째 문의
                _buildInquiryItem(
                    index: 1,
                    category: '[앱 기능 및 사용 방법]',
                    title: '알림 기능 설정',
                    description: '알림 기능 설정 방법에 대한 정보입니다.',
                    status: '답변대기',
                    date: '2024.03.26',
                    answer: '알림 기능을 설정하려면 메뉴에서 설정으로 이동한 후 알림 항목을 활성화하세요.',
                    nickname: '원룸',
                    answerDate: '2024.03.27'
                ),
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.all(16),
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () {
                // 문의하기 버튼 동작
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Color(0xff787878),
                padding: EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                elevation: 0,
              ),
              child: Text('문의하기', style: TextStyle(color: Colors.white, fontSize: 16)),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInquiryItem({
    required int index,
    required String category,
    required String title,
    required String description,
    required String status,
    required String date,
    required String answer,
    required String nickname,
    required String answerDate,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                category, // 카테고리 추가
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(width: 8), // 카테고리와 타이틀 사이의 간격 조정
              Expanded(
                child: Text(
                  title,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                ),
              ),
            ],
          ),
        ),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 16),
          child: Divider(
            color: Colors.grey[300],
            thickness: 1,
          ),
        ),
        Container(
          padding: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                description,
                style: TextStyle(
                  fontSize: 14,
                  color: Color(0xff797979),
                ),
              ),
              SizedBox(height: 8),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    status,
                    style: TextStyle(
                      fontSize: 14,
                      color: Color(0xff595959),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(width: 5),
                  Text(
                    '|',
                    style: TextStyle(
                      color: Colors.grey[300],
                      fontSize: 12,
                    ),
                  ),
                  SizedBox(width: 10),
                  Text(
                    date,
                    style: TextStyle(
                      color: Colors.grey,
                      fontSize: 12,
                    ),
                  ),
                  SizedBox(width: 5),
                  Text(
                    '|',
                    style: TextStyle(
                      color: Colors.grey[300],
                      fontSize: 12,
                    ),
                  ),
                  SizedBox(width: 5),
                  GestureDetector(
                    onTap: () => _showDeleteConfirmationSheet(context),
                    child: Text(
                      '삭제',
                      style: TextStyle(
                        color: Colors.grey,
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Spacer(),
                  IconButton(
                    icon: Icon(
                      _expandedList[index] ? Icons.expand_less : Icons.expand_more,
                      color: Colors.grey,
                    ),
                    onPressed: () {
                      setState(() {
                        _expandedList[index] = !_expandedList[index];
                      });
                    },
                  ),
                ],
              ),
              SizedBox(height: 8),
              if (_expandedList[index]) // _expandedList 상태에 따라 세부 정보 표시
                Container(
                  padding: EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: Color(0xffF7F7F7),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        answer,
                        style: TextStyle(
                            fontSize: 14,
                            color: Color(0xff595959)),
                      ),
                      SizedBox(height: 8),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                            '$nickname',
                            style: TextStyle(
                                color: Color(0xff595959),
                                fontSize: 12,
                                fontWeight: FontWeight.bold
                            ),
                          ),
                          SizedBox(width: 5,),
                          Text(
                            '|',
                            style: TextStyle(
                              color: Colors.grey[300],
                              fontSize: 12,
                            ),
                          ),
                          SizedBox(width: 5,),
                          Text(
                            '$answerDate',
                            style: TextStyle(
                              color: Colors.grey,
                              fontSize: 12,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
            ],
          ),
        ),
        Divider(
          color: Color(0xffF7F7F7),
          thickness: 10,
        ),
      ],
    );
  }
}
