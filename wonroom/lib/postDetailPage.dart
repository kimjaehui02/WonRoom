import 'package:flutter/material.dart';

class PostDetailPage extends StatefulWidget {
  final Map<String, dynamic> post;

  const PostDetailPage({Key? key, required this.post}) : super(key: key);

  @override
  _PostDetailPageState createState() => _PostDetailPageState();
}

class _PostDetailPageState extends State<PostDetailPage> {
  bool showReplyField1 = false; // 사용자1에 대한 대댓글 작성 필드
  bool showReplyField2 = false; // 사용자2에 대한 대댓글 작성 필드
  bool showReplyField3 = false; // 사용자3에 대한 대댓글 작성 필드
  bool isFavorite1 = false; // 첫 번째 댓글의 좋아요 상태
  bool isFavorite2 = false; // 두 번째 댓글의 좋아요 상태
  bool isFavorite3 = false; // 세 번째 댓글의 좋아요 상태
  bool isFavoriteInput = false; // 입력 필드 옆 하트 아이콘의 좋아요 상태

  // TextEditingController 추가
  final TextEditingController _commentController = TextEditingController();
  final TextEditingController _replyController1 = TextEditingController();
  final TextEditingController _replyController2 = TextEditingController();
  final TextEditingController _replyController3 = TextEditingController();
  bool _isCommentNotEmpty = false; // 댓글 입력 여부 상태 변수
  bool _isReply1NotEmpty = false; // 사용자1 대댓글 입력 여부
  bool _isReply2NotEmpty = false; // 사용자2 대댓글 입력 여부
  bool _isReply3NotEmpty = false; // 사용자3 대댓글 입력 여부

  @override
  void initState() {
    super.initState();
    _commentController.addListener(() {
      setState(() {
        _isCommentNotEmpty = _commentController.text.isNotEmpty;
      });
    });
    _replyController1.addListener(() {
      setState(() {
        _isReply1NotEmpty = _replyController1.text.isNotEmpty;
      });
    });
    _replyController2.addListener(() {
      setState(() {
        _isReply2NotEmpty = _replyController2.text.isNotEmpty;
      });
    });
    _replyController3.addListener(() {
      setState(() {
        _isReply3NotEmpty = _replyController3.text.isNotEmpty;
      });
    });
  }

  @override
  void dispose() {
    _commentController.dispose();
    _replyController1.dispose();
    _replyController2.dispose();
    _replyController3.dispose();
    super.dispose();
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
                          backgroundColor: Colors.transparent,
                          child: ClipOval(
                            child: Image.asset(
                              'images/멕시코소철.jpg',
                              fit: BoxFit.cover,
                              width: 100,
                              height: 100,
                            ),
                          ),
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
                          onPressed: () => _showBottomSheet(context),
                        ),
                        // 다른사람
                        // Icon(Icons.share)
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
                      width: double.infinity,
                      height: 300,
                      fit: BoxFit.cover,
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
                      '댓글 3',
                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                    ),
                    // Comment Section
                    ListTile(
                      leading: CircleAvatar(
                        backgroundColor: Colors.transparent,
                        child: ClipOval(
                          child: Image.asset(
                            'images/멕시코소철.jpg',
                            fit: BoxFit.cover,
                            width: 100,
                            height: 100,
                          ),
                        ),
                      ),
                      title: Row(
                        children: [
                          Text('사용자1', style: TextStyle(fontWeight: FontWeight.bold)),
                          SizedBox(width: 8),
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
                                showReplyField1 = !showReplyField1;
                              });
                            },
                            child: Text('답글 달기', style: TextStyle(color: Colors.grey, fontSize: 14)),
                          ),
                        ],
                      ),
                      trailing: GestureDetector(
                        onTap: () {
                          setState(() {
                            isFavorite1 = !isFavorite1;
                          });
                        },
                        child: Container(
                          padding: EdgeInsets.all(8),
                          child: Icon(
                            isFavorite1 ? Icons.favorite : Icons.favorite_border,
                            color: isFavorite1 ? Colors.red : Colors.grey,
                            size: 24,
                          ),
                        ),
                      ),
                      contentPadding: EdgeInsets.symmetric(vertical: 0),
                      minLeadingWidth: 40,
                    ),
                    if (showReplyField1)
                      Padding(
                        padding: const EdgeInsets.only(left: 58.0, bottom: 2.0),
                        child: SizedBox(
                          height: 60,
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center, // 추가된 부분
                            children: [
                              Expanded(
                                child: TextField(
                                  controller: _replyController1,
                                  decoration: InputDecoration(
                                    hintText: '대댓글을 입력하세요...',
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.zero,
                                    ),
                                    contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                                    focusedBorder: OutlineInputBorder(
                                      borderSide: BorderSide(color: Color(0xff6bbe45), width: 2.0),
                                    ),
                                    enabledBorder: OutlineInputBorder(
                                      borderSide: BorderSide(color: Color(0xffc2c2c2), width: 1.0),
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(width: 2),
                              Align(
                                alignment: Alignment.centerRight,
                                child: IconButton(
                                  icon: Icon(
                                    Icons.telegram,
                                    color: _isReply1NotEmpty ? Color(0xff6bbe45) : Colors.grey,
                                    size: 45,
                                  ),
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
                      padding: const EdgeInsets.only(left: 55.0, top: 0.0, bottom: 8.0),
                      child: ListTile(
                        leading: CircleAvatar(
                          backgroundColor: Colors.transparent,
                          child: ClipOval(
                            child: Image.asset(
                              'images/멕시코소철.jpg',
                              fit: BoxFit.cover,
                              width: 100,
                              height: 100,
                            ),
                          ),
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
                                  showReplyField2 = !showReplyField2;
                                });
                              },
                              child: Text('답글 달기', style: TextStyle(color: Colors.grey, fontSize: 14)),
                            ),
                          ],
                        ),
                        trailing: GestureDetector(
                          onTap: () {
                            setState(() {
                              isFavorite2 = !isFavorite2;
                            });
                          },
                          child: Container(
                            padding: EdgeInsets.all(8),
                            child: Icon(
                              isFavorite2 ? Icons.favorite : Icons.favorite_border,
                              color: isFavorite2 ? Colors.red : Colors.grey,
                              size: 24,
                            ),
                          ),
                        ),
                        contentPadding: EdgeInsets.symmetric(vertical: 0),
                        minLeadingWidth: 40,
                      ),
                    ),
                    if (showReplyField2)
                      Padding(
                        padding: const EdgeInsets.only(left: 80.0, bottom: 8.0),
                        child: SizedBox(
                          height: 60,
                          child: Row(
                            children: [
                              Expanded(
                                child: TextField(
                                  controller: _replyController2,
                                  minLines: 1,
                                  maxLines: 1,
                                  decoration: InputDecoration(
                                    hintText: '대댓글을 입력하세요...',
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.zero,
                                    ),
                                    contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                                    focusedBorder: OutlineInputBorder(
                                      borderSide: BorderSide(color: Color(0xff6bbe45), width: 2.0),
                                    ),
                                    enabledBorder: OutlineInputBorder(
                                      borderSide: BorderSide(color: Color(0xffc2c2c2), width: 1.0),
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(width: 2),
                              Align(
                                alignment: Alignment.centerRight,
                                child: IconButton(
                                  icon: Icon(
                                    Icons.telegram,
                                    color: _isReply2NotEmpty ? Color(0xff6bbe45) : Colors.grey,
                                    size: 45,
                                  ),
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
                        backgroundColor: Colors.transparent,
                        child: ClipOval(
                          child: Image.asset(
                            'images/멕시코소철.jpg',
                            fit: BoxFit.cover,
                            width: 100,
                            height: 100,
                          ),
                        ),
                      ),
                      title: Row(
                        children: [
                          Text('사용자3', style: TextStyle(fontWeight: FontWeight.bold)),
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
                                showReplyField3 = !showReplyField3;
                              });
                            },
                            child: Text('답글 달기', style: TextStyle(color: Colors.grey, fontSize: 14)),
                          ),
                        ],
                      ),
                      trailing: GestureDetector(
                        onTap: () {
                          setState(() {
                            isFavorite3 = !isFavorite3;
                          });
                        },
                        child: Container(
                          padding: EdgeInsets.all(8),
                          child: Icon(
                            isFavorite3 ? Icons.favorite : Icons.favorite_border,
                            color: isFavorite3 ? Colors.red : Colors.grey,
                            size: 24,
                          ),
                        ),
                      ),
                      contentPadding: EdgeInsets.symmetric(vertical: 2),
                      minLeadingWidth: 40,
                    ),
                    if (showReplyField3)
                      Padding(
                        padding: const EdgeInsets.only(left: 60.0, bottom: 8.0),
                        child: SizedBox(
                          height: 60,
                          child: Row(
                            children: [
                              Expanded(
                                child: TextField(
                                  controller: _replyController3,
                                  minLines: 1,
                                  maxLines: 1,
                                  decoration: InputDecoration(
                                    hintText: '대댓글을 입력하세요...',
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.zero,
                                    ),
                                    contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                                    focusedBorder: OutlineInputBorder(
                                      borderSide: BorderSide(color: Color(0xff6bbe45), width: 2.0),
                                    ),
                                    enabledBorder: OutlineInputBorder(
                                      borderSide: BorderSide(color: Color(0xffc2c2c2), width: 1.0),
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(width: 2),
                              Align(
                                alignment: Alignment.centerRight,
                                child: IconButton(
                                  icon: Icon(
                                    Icons.telegram,
                                    color: _isReply3NotEmpty ? Color(0xff6bbe45) : Colors.grey,
                                    size: 45,
                                  ),
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
          Container(
            decoration: BoxDecoration(
              border: Border(
                top: BorderSide(
                  color: Color(0xffeeeeee),
                  width: 1,
                ),
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(left: 10),
                      child: TextField(
                        controller: _commentController,
                        decoration: InputDecoration(
                          hintText: '댓글을 입력하세요...',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.zero,
                          ),
                          contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 4),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Color(0xff6bbe45), width: 2.0),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Color(0xffc2c2c2), width: 1.0),
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: 2),
                  IconButton(
                    icon: Icon(
                      Icons.telegram,
                      color: _isCommentNotEmpty ? Color(0xff6bbe45) : Colors.grey,
                      size: 47,
                    ),
                    onPressed: () {
                      // 댓글 전송 기능 추가
                    },
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
