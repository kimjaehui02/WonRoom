import 'package:flutter/material.dart';
import 'package:wonroom/inqurityDetails.dart';
import 'package:wonroom/writeInquiry.dart';

class CustomerService extends StatelessWidget {
  const CustomerService({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          '고객센터',
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
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text.rich(
                  TextSpan(
                    children: [
                      TextSpan(
                        text: '원룸',
                        style: TextStyle(
                          color: Colors.green,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      TextSpan(
                        text: ' 님,',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 4),
                Text(
                  '무엇을 도와드릴까요?',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 20),
                Row(
                  children: [
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () {
                          // 1:1 문의 버튼 클릭 시 동작
                          Navigator.push(context, MaterialPageRoute(
                              builder: (context) => WriteInquiry()
                            ),
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Color(0xffF7F7F7),
                          elevation: 0,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5),
                            side: BorderSide.none,
                          ),
                          padding: EdgeInsets.symmetric(vertical: 13),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.support_agent, color: Colors.black), // 수정된 부분
                            SizedBox(width: 10),
                            Text(
                              '1:1 문의',
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(width: 16),
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () {
                          // 문의 내역 버튼 클릭 시 동작
                          Navigator.push(context,
                            MaterialPageRoute(builder: (context) => InqurityDetails()),
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Color(0xffF7F7F7),
                          elevation: 0,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5),
                            side: BorderSide.none,
                          ),
                          padding: EdgeInsets.symmetric(vertical: 13),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image.asset(
                              'images/inquiry_details.png',
                              height: 24,
                              width: 24,
                            ),
                            SizedBox(width: 10),
                            Text(
                              '문의내역',
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 20),
              ],
            ),
          ),
          Divider(thickness: 10, color: Color(0xffF7F7F7)),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 20),
                Row(
                  children: [
                    Image.asset(
                      'images/question_mark.png',
                      height: 20,
                      width: 20,
                    ),
                    SizedBox(width: 8),
                    Flexible(
                      child: Text(
                        '자주 묻는 질문',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 10),
              ],
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: ListView(
                children: [
                  FAQTile(
                    question: '식물의 이름을 어떻게 식별할 수 있나요?',
                    answer: '홈의 "식물정보" 메뉴에서 사진을 업로드하면 자동으로 식물의 이름과 기본 정보를 확인할 수 있습니다.\n식물의 특성에 맞는 관리 방법도 제공됩니다.',
                  ),
                  FAQTile(
                      question: '다이어리 등록은 어떻게 하나요?',
                      answer: '하단 바의 "다이어리"에서 등록하거나 "카메라"를 클릭해 등록하실 수 있습니다.'
                  ),
                  FAQTile(
                    question: '챗봇(AI) 사용법은 어떻게 되나요?',
                    answer: '하단 바의 "챗봇(AI)"를 클릭하거나 카메라에서 "식물 병해충 검색하기"를 클릭해 사용하실 수 있으며 gpt를 활용해 병충해 또는 기타 질문들에 대해 상세히 설명해 드립니다.',
                  ),
                  FAQTile(
                    question: '병충해를 발견했을 때 어떻게 대처해야 하나요?',
                    answer: '병충해를 발견했을 때는 빠르게 적절한 방제 조치를 취하는 것이 중요합니다. 식물에 맞는 방제제를 사용하거나, 필요한 경우 전문가의 도움을 받는 것이 좋습니다.',
                  ),
                  FAQTile(
                    question: '커뮤니티에서는 어떤 활동을 할 수 있나요?',
                    answer: '사람들이 다양한 활동을 통해 서로 소통하고, 식물을 키우는 즐거움을 나눕니다. 예를 들어, 식물을 키우면서 얻은 경험을 공유하거나, 식물 관리에 대한 질문을 올리고 다른 사람들의 도움을 받습니다. 또한 잘 자란 식물의 사진을 자랑하거나, 특정 식물에 대한 정보나 리뷰를 공유하며 새로운 지식을 얻을 수 있는 기회가 제공됩니다.',
                  ),
                  FAQTile(
                    question: '반려 식물의 상태를 어떻게 추적하나요?',
                    answer: '다이어리를 통해 성장을 기록하고 정기적으로 잎과 뿌리 상태를 확인하세요. 또한 온도와 습도 같은 환경 조건도 체크하는 것이 중요합니다.',
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

class FAQTile extends StatefulWidget {
  final String question;
  final String answer;

  const FAQTile({
    required this.question,
    required this.answer,
    super.key,
  });

  @override
  _FAQTileState createState() => _FAQTileState();
}

class _FAQTileState extends State<FAQTile> {
  bool _expanded = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          decoration: BoxDecoration(
            border: Border(
              bottom: _expanded
                  ? BorderSide.none
                  : BorderSide(
                color: Colors.grey.shade300,
                width: 0.7, // 밑줄을 더 얇게 설정
              ),
            ),
          ),
          child: ListTile(
            title: Row(
              children: [
                Text(
                  'Q ',
                  style: TextStyle(
                    color: Colors.green,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(width: 3),
                Expanded(
                  child: Text(
                    widget.question,
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                IconButton(
                  icon: Icon(
                    _expanded ? Icons.expand_less : Icons.expand_more,
                    color: Colors.grey,
                  ),
                  onPressed: () {
                    setState(() {
                      _expanded = !_expanded;
                    });
                  },
                ),
              ],
            ),
            onTap: () {
              setState(() {
                _expanded = !_expanded;
              });
            },
            tileColor: Colors.transparent,
            contentPadding: EdgeInsets.symmetric(vertical: 8, horizontal: 0), // 위로 올리기 위해 여백 줄이기
          ),
        ),
        if (_expanded)
          Container(
            padding: EdgeInsets.all(15),
            decoration: BoxDecoration(
              color: Color(0xffF7F7F7),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Text(
              widget.answer,
              style: TextStyle(fontSize: 16),
            ),
          ),
      ],
    );
  }
}
