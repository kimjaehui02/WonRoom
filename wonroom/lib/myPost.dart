import 'package:flutter/material.dart';

class MyPost extends StatelessWidget {
  const MyPost({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          '내 게시글',
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
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
      body: ListView(
        padding: EdgeInsets.zero,
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: PostItem(
              imagePath: 'images/아레카야자.jpg',
              category: '자유게시판',
              nickname: '원룸',
              title: '인테리어용 인기 식물 추천',
              date: '24.09.12',
              content: '알림 기능을 어떻게 설정하나요? 식물별 알림 기능 설정하고 싶어요.',
            ),
          ),
          Divider(
            thickness: 8,
            color: Color(0xffe7e7e7),
            height: 30,
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: PostItem(
              imagePath: 'images/산세베리아.jpg',
              category: '자유게시판',
              nickname: '원룸',
              title: '인테리어용 인기 식물 추천입니다',
              date: '24.09.12',
              content: '알림 기능을 어떻게 설정하나요???? 식물별 알림 기능 설정하고 싶어요.',
            ),
          ),
        ],
      ),
    );
  }
}

class PostItem extends StatelessWidget {
  final String imagePath;
  final String category;
  final String nickname;
  final String title;
  final String date;
  final String content;

  const PostItem({
    required this.imagePath,
    required this.category,
    required this.nickname,
    required this.title,
    required this.date,
    required this.content,
  });

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


  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Container(
              width: 60,
              height: 60,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8.0),
                image: DecorationImage(
                  image: AssetImage(imagePath),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            SizedBox(width: 15),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                        decoration: BoxDecoration(
                          color: Color(0xffe7efe2),
                          borderRadius: BorderRadius.circular(4.0),
                        ),
                        child: Text(
                          category,
                          style: TextStyle(
                            color: Color(0xff739A5C),
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      SizedBox(width: 8.0),
                      Expanded(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: Text(
                                title,
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                ),
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                            IconButton(
                              icon: Icon(Icons.more_vert),
                              onPressed: () => _showBottomSheet(context),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        nickname,
                        style: TextStyle(
                          color: Colors.grey,
                          fontSize: 14,
                        ),
                      ),
                      SizedBox(width: 10.0),
                      Icon(Icons.access_time_outlined, size: 15),
                      SizedBox(width: 2),
                      Text(
                        date,
                        style: TextStyle(
                          color: Colors.grey,
                          fontSize: 14,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
        SizedBox(height: 10), // 이미지와 내용 사이의 간격 조정
        Divider(),  // 내용 위에 Divider 추가
        SizedBox(height: 10),
        Text(
          content,
          style: TextStyle(
            color: Color(0xff787878),
            fontSize: 14,
          ),
          overflow: TextOverflow.ellipsis,
        ),
      ],
    );
  }

}
