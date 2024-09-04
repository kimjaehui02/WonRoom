import 'package:flutter/material.dart';

class MyCommunityManage extends StatefulWidget {
  @override
  _MyCommunityManageState createState() => _MyCommunityManageState();
}

class _MyCommunityManageState extends State<MyCommunityManage> {
  bool showReplyField1 = false; // 사용자1에 대한 대댓글 작성 필드
  bool showReplyField2 = false; // 사용자2에 대한 대댓글 작성 필드
  bool showReplyField3 = false; // 사용자3에 대한 대댓글 작성 필드

  @override
  Widget build(BuildContext context) {
    // 예시로 사용될 댓글 목록, 실제 데이터로 대체 가능
    List<Map<String, String>> comments = []; // 빈 리스트로 초기화

    return Scaffold(
      appBar: AppBar(
        title: Text('자유게시판', style: TextStyle(fontWeight: FontWeight.bold)),
        centerTitle: true,
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Post Header
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CircleAvatar(
                          radius: 20,
                          backgroundImage: AssetImage('assets/profile_image.png'), // 프로필 이미지 경로
                        ),
                        SizedBox(width: 10),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('원룸',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 16)),
                            Text('24.08.05 09:18',
                                style: TextStyle(color: Colors.grey)),
                          ],
                        ),
                        Spacer(),
                        IconButton(
                          icon: Icon(Icons.more_vert),
                          onPressed: () {
                            _showBottomSheet(context); // 바텀 시트를 표시하는 함수 호출
                          },
                        ),
                      ],
                    ),
                    SizedBox(height: 10),
                    // Post Stats
                    Row(
                      children: [
                        Row(
                          children: [
                            Icon(Icons.visibility_outlined, size: 16),
                            SizedBox(width: 4),
                            Text('40,398'),
                          ],
                        ),
                        SizedBox(width: 7,),
                        Row(
                          children: [
                            Icon(Icons.favorite, size: 16),
                            SizedBox(width: 4),
                            Text('22,310'),
                          ],
                        ),
                        SizedBox(width: 7,),
                        Row(
                          children: [
                            Icon(Icons.comment, size: 16),
                            SizedBox(width: 4),
                            Text('20,320'),
                          ],
                        ),
                      ],
                    ),
                    Divider(height: 32, thickness: 1.5, color: Colors.grey[300]),
                    SizedBox(height: 16),
                    // Post Content
                    Text(
                      '인테리어용 인기 식물 추천',
                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                    ),
                    SizedBox(height: 10),
                    Image.asset(
                      'images/산세베리아.jpg',
                      width: double.infinity, // Make image width full screen
                      height: 300,
                      fit: BoxFit.cover, // Ensure the image fits within its container
                    ),
                    SizedBox(height: 15),
                    Text(
                      '특징: 몬스테라는 큰 잎과 독특한 구멍이 있는 열대 식물로, 실내에서 쉽게 키울 수 있어 인기가 많습니다. 공기 정화 능력도 뛰어나며, 인테리어에 포인트를 주기 좋습니다.',
                      style: TextStyle(fontSize: 16),
                    ),
                    SizedBox(height: 10),
                    Text(
                      '관리 방법:\n\n- 일: 간접적인 빛이 많은 곳을 선호하지만, 약간 어두운 곳에서도 잘 자랍니다.\n\n- 물 주기: 화분 건조한 표면을 볼 때 물을 줍니다.',
                      style: TextStyle(fontSize: 16),
                    ),
                    SizedBox(height: 16),
                    Divider(height: 32, thickness: 1.5, color: Colors.grey[300]),
                    SizedBox(height: 16),

                    Text(
                      '댓글 3',  // 댓글 수를 3으로 수정
                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                    ),
                    // Comment Section
                    ListTile(
                      leading: CircleAvatar(
                        backgroundImage: AssetImage('assets/profile_image.png'), // 댓글 프로필 이미지 경로
                      ),
                      title: Row(
                        children: [
                          Text('사용자1', style: TextStyle(fontWeight: FontWeight.bold)),
                          SizedBox(width: 8),  // 이름과 시간 간격
                          Text('10분 전', style: TextStyle(fontSize: 12, color: Colors.grey)),
                        ],
                      ),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('도감 메뉴에서 자신의 반려식물을 등록할 수 있습니다.'),
                          GestureDetector(
                            onTap: () {
                              setState(() {
                                showReplyField1 = !showReplyField1;  // 댓글 달기 버튼을 클릭하면 대댓글 작성 필드 표시 여부 변경
                              });
                            },
                            child: Text('답글 달기', style: TextStyle(color: Colors.grey, fontSize: 14)),
                          ),
                        ],
                      ),
                      trailing: Icon(Icons.favorite_border),
                      contentPadding: EdgeInsets.symmetric(vertical: 0), // 세로 패딩 0으로 설정
                      minLeadingWidth: 40, // 이미지와 텍스트 간 간격 설정
                    ),
                    if (showReplyField1)  // 대댓글 작성 필드 표시 여부에 따라 TextField 표시
                      Padding(
                        padding: const EdgeInsets.only(left: 58.0, bottom: 2.0),
                        child: SizedBox(
                          height: 40, // 대댓글 박스의 높이 조정
                          child: Row(
                            children: [
                              Expanded(
                                child: TextField(
                                  decoration: InputDecoration(
                                    hintText: '대댓글을 입력하세요...',
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.zero,
                                    ),
                                    contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 8), // 패딩 조정
                                  ),
                                ),
                              ),
                              SizedBox(width: 8), // TextField와 아이콘 사이의 간격 조정
                              Align(
                                alignment: Alignment.centerRight,
                                child: IconButton(
                                  icon: Icon(Icons.telegram, color: Colors.grey, size: 40), // 아이콘 크기 조정
                                  // 입력 시 아이콘 초록으로 변경
                                  // icon: Icon(Icons.telegram, color: Color(0xff6bbe45), size: 40), // 아이콘 크기 조정
                                  onPressed: () {
                                    // 대댓글 전송 기능 추가
                                  },
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    Padding(
                      padding: const EdgeInsets.only(left: 55.0, top: 0.0, bottom: 8.0), // 댓글과 대댓글 간격 줄이기
                      child: ListTile(
                        leading: CircleAvatar(
                          backgroundImage: AssetImage('assets/profile_image.png'), // 대댓글 프로필 이미지 경로
                        ),
                        title: Row(
                          children: [
                            Text('사용자2', style: TextStyle(fontWeight: FontWeight.bold)),
                            SizedBox(width: 8),
                            Text('5분 전', style: TextStyle(fontSize: 12, color: Colors.grey)),
                          ],
                        ),
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('도감 메뉴에서 자신의 반려식물을 등록할 수 있습니다.'),
                            GestureDetector(
                              onTap: () {
                                setState(() {
                                  showReplyField2 = !showReplyField2;  // 대댓글의 대댓글 작성 필드 표시 여부 변경
                                });
                              },
                              child: Text('답글 달기', style: TextStyle(color: Colors.grey, fontSize: 14)),
                            ),
                          ],
                        ),
                        trailing: Icon(Icons.favorite_border),
                        contentPadding: EdgeInsets.symmetric(vertical: 0), // 세로 패딩 0으로 설정
                        minLeadingWidth: 40, // 이미지와 텍스트 간 간격 설정
                      ),
                    ),
                    if (showReplyField2)  // 대댓글의 대댓글 작성 필드 표시 여부에 따라 TextField 표시
                      Padding(
                        padding: const EdgeInsets.only(left: 80.0, bottom: 8.0),
                        child: SizedBox(
                          height: 40, // 대댓글 박스의 높이 조정
                          child: Row(
                            children: [
                              Expanded(
                                child: TextField(
                                  minLines: 1, // 최소 줄 수
                                  maxLines: 1, // 최대 줄 수
                                  decoration: InputDecoration(
                                    hintText: '대댓글을 입력하세요...',
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.zero,
                                    ),
                                    contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 8), // 패딩 조정
                                  ),
                                ),
                              ),
                              SizedBox(width: 8), // TextField와 아이콘 사이의 간격 조정
                              Align(
                                alignment: Alignment.centerRight,
                                child: IconButton(
                                  icon: Icon(Icons.telegram, color: Colors.grey, size: 30), // 아이콘 크기 조정
                                  onPressed: () {
                                    // 대댓글의 대댓글 전송 기능 추가
                                  },
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ListTile(
                      leading: CircleAvatar(
                        backgroundImage: AssetImage('assets/profile_image.png'), // 댓글 프로필 이미지 경로
                      ),
                      title: Row(
                        children: [
                          Text('사용자3', style: TextStyle(fontWeight: FontWeight.bold)), // 새로운 댓글 작성자
                          SizedBox(width: 8),
                          Text('방금 전', style: TextStyle(fontSize: 12, color: Colors.grey)),
                        ],
                      ),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('이 식물 정말 예쁘네요! 저도 키워보고 싶어요.'),
                          GestureDetector(
                            onTap: () {
                              setState(() {
                                showReplyField3 = !showReplyField3;  // 댓글 달기 버튼을 클릭하면 대댓글 작성 필드 표시 여부 변경
                              });
                            },
                            child: Text('답글 달기', style: TextStyle(color: Colors.grey, fontSize: 14)),
                          ),
                        ],
                      ),
                      trailing: Icon(Icons.favorite_border),
                      contentPadding: EdgeInsets.symmetric(vertical: 2), // 세로 패딩 줄이기
                      minLeadingWidth: 40, // 이미지와 텍스트 간 간격 설정
                    ),
                    if (showReplyField3)  // 사용자3에 대한 대댓글 작성 필드 표시 여부에 따라 TextField 표시
                      Padding(
                        padding: const EdgeInsets.only(left: 60.0, bottom: 8.0),
                        child: SizedBox(
                          height: 40, // 대댓글 박스의 높이 조정
                          child: Row(
                            children: [
                              Expanded(
                                child: TextField(
                                  minLines: 1, // 최소 줄 수
                                  maxLines: 1, // 최대 줄 수
                                  decoration: InputDecoration(
                                    hintText: '대댓글을 입력하세요...',
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.zero,
                                    ),
                                    contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 8), // 패딩 조정
                                  ),
                                ),
                              ),
                              SizedBox(width: 8), // TextField와 아이콘 사이의 간격 조정
                              Align(
                                alignment: Alignment.centerRight,
                                child: IconButton(
                                  icon: Icon(Icons.telegram, color: Colors.grey, size: 40), // 아이콘 크기 조정
                                  onPressed: () {
                                    // 대댓글 전송 기능 추가
                                  },
                                ),
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

          // Add Comment Section
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                SizedBox(width: 4,),
                Icon(Icons.favorite_border_outlined, size: 27,),
                SizedBox(width: 10,),
                Expanded(
                  child: TextField(
                    decoration: InputDecoration(
                      hintText: '댓글을 입력하세요...',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.zero,
                      ),
                      contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 4),
                    ),
                  ),
                ),
                SizedBox(width: 3),
                IconButton(
                  icon: Icon(Icons.telegram, color: Colors.grey, size: 50,),
                  onPressed: () {
                    // 댓글 전송 기능 추가
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // 수정, 삭제 팝업
  void _showBottomSheet(BuildContext context) {
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
              ListTile(
                leading: Icon(Icons.edit_outlined),
                title: Text('수정하기'),
                onTap: () {
                  // 수정하기 기능 추가
                  Navigator.pop(context);
                },
              ),
              Divider(),
              ListTile(
                leading: Icon(Icons.delete_outline_outlined),
                title: Text('삭제하기'),
                onTap: () {
                  Navigator.pop(context); // 기존 바텀 시트를 닫습니다.
                  _showDeleteConfirmationSheet(context); // 삭제 확인 바텀 시트를 호출합니다.
                },
              ),
            ],
          ),
        );
      },
    );
  }

  // 삭제버튼 클릭 시 팝업
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
              SizedBox(height: 10),
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
      // 사용자가 팝업 외부를 클릭해도 다이얼로그가 닫히지 않도록 설정
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









}