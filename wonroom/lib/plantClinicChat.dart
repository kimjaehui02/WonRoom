import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;

class PlantClinicChat extends StatefulWidget {
  final Map<String, dynamic>? jsonData;
  final String? imagePath;

  const PlantClinicChat({
    Key? key,
    this.jsonData,
    this.imagePath,
  }) : super(key: key);

  @override
  _PlantClinicChatState createState() => _PlantClinicChatState();
}

class _PlantClinicChatState extends State<PlantClinicChat> {
  final TextEditingController _messageController = TextEditingController();
  final List<Map<String, dynamic>> _messages = [];
  final ImagePicker _picker = ImagePicker();
  bool _isSending = false; // 요청 중 여부를 확인할 변수

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios,
            color: Colors.grey,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text('챗(AI)'),
        centerTitle: true,
      ),
      body: Stack(
        children: [
          Column(
            children: [
              // 메시지 리스트
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      ListView.builder(
                        padding: EdgeInsets.all(16.0),
                        itemCount: _messages.length,
                        itemBuilder: (context, index) {
                          final message = _messages[index];
                          return _buildMessageBubble(
                            message: message['text'],
                            image: message['image'],
                            isUser: message['isUser'],
                            isLoading: _isSending && !message['isUser'],
                          );
                        },
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                      ),
                    ],
                  ),
                ),
              ),

              // 입력 필드 및 버튼
              Container(
                padding: const EdgeInsets.symmetric(
                    horizontal: 16, vertical: 20),
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
                      width: 30,
                      decoration: BoxDecoration(
                        shape: BoxShape.rectangle,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: IconButton(
                        onPressed: () {
                          _showImagePickerOptions(context);
                        },
                        icon: Image.asset(
                          'images/file_upload.png',
                          height: 28,
                          width: 28,
                          fit: BoxFit.cover,
                          color: Color(0xff595959),
                        ),
                        iconSize: 24,
                        padding: EdgeInsets.all(4),
                      ),
                    ),
                    SizedBox(width: 4),
                    Expanded(
                      child: TextField(
                        controller: _messageController,
                        decoration: InputDecoration(
                          hintText: '메시지를 입력하세요',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                          contentPadding: EdgeInsets.symmetric(horizontal: 16),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: Color(0xffc2c2c2), width: 1.0),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: Color(0xffc2c2c2), width: 1.0),
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        onSubmitted: (text) {
                          _sendMessage(text: text, isUser: true);
                        },
                      ),
                    ),
                    SizedBox(width: 2),
                    ElevatedButton(
                      onPressed: () {
                        _sendMessage(
                          text: _messageController.text,
                          isUser: true,
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        shape: CircleBorder(),
                        padding: EdgeInsets.all(0),
                        fixedSize: Size(50, 50),
                        elevation: 0,
                        backgroundColor: Colors.transparent,
                      ),
                      child: Icon(
                        Icons.telegram,
                        size: 50,
                        color: Color(0xff999999),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          // 로딩 인디케이터
          if (_isSending)
            Center(
              child: CircularProgressIndicator(),
            ),
        ],
      ),
    );
  }

  void _showImagePickerOptions(BuildContext context) {
    showModalBottomSheet(
      context: context,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20.0)),
      ),
      backgroundColor: Colors.white,
      builder: (BuildContext context) {
        return Container(
          padding: EdgeInsets.only(left: 40, right: 40, top: 32, bottom: 16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.vertical(top: Radius.circular(20.0)),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '이미지 선택',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
              SizedBox(height: 10),
              GestureDetector(
                onTap: () async {
                  Navigator.pop(context);
                  final pickedFile = await _picker.pickImage(
                      source: ImageSource.gallery);
                  if (pickedFile != null) {
                    _sendMessage(image: pickedFile.path, isUser: true);
                  }
                },
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  child: Row(
                    children: [
                      Icon(Icons.photo_library_outlined,
                          color: Color(0xff787878)),
                      SizedBox(width: 16), // 텍스트와 아이콘 사이 간격
                      Text('갤러리에서 선택', style: TextStyle(
                        fontSize: 16,
                        color: Color(0xff333333),
                      ),),
                    ],
                  ),
                ),
              ),
              GestureDetector(
                onTap: () async {
                  Navigator.pop(context);
                  final pickedFile = await _picker.pickImage(
                      source: ImageSource.camera);
                  if (pickedFile != null) {
                    _sendMessage(image: pickedFile.path, isUser: true);
                  }
                },
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  child: Row(
                    children: [
                      Icon(Icons.camera_alt_outlined, color: Color(0xff787878)),
                      SizedBox(width: 16), // 텍스트와 아이콘 사이 간격
                      Text('카메라로 촬영', style: TextStyle(
                        fontSize: 16,
                        color: Color(0xff333333),
                      ),),
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  void _sendMessage({String? text, String? image, required bool isUser}) {
    if (_isSending) return; // 요청 중일 때는 처리하지 않음

    setState(() {
      if (text != null && text.isNotEmpty) {
        _messages.add({
          'text': text,
          'image': null,
          'isUser': isUser,
        });
      } else if (image != null) {
        _messages.add({
          'text': null,
          'image': image,
          'isUser': isUser,
        });
      }
      if (text != null && text.isNotEmpty || image != null) {
        _isSending = true; // 요청 시작
      }
    });

    _sendMessageToServer(text: text, image: image); // 서버로 메시지 전송
  }

  Future<void> _sendMessageToServer({String? text, String? image}) async {
    try {
      final Uri apiUrl = Uri.parse(
          'https://16b5-34-91-150-31.ngrok-free.app/plant_pest'); // 수정된 URL

      final requestBody = <String, dynamic>{
        if (text != null && text.isNotEmpty) 'text': text,
        if (image != null) 'image': base64Encode(File(image).readAsBytesSync()),
      };

      print('Request URL: $apiUrl');
      print('Request Body: $requestBody');

      final response = await http.post(
        apiUrl,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(requestBody),
      );

      print('Response Status: ${response.statusCode}');
      print('Response Body: ${response.body}');

      if (response.statusCode == 200) {
        final responseData = jsonDecode(response.body);
        setState(() {
          _messages.add({
            'text': responseData['pest_info'] ?? '서버 응답이 없습니다.',
            'image': null,
            'isUser': false,
          });
          _isSending = false; // 요청 완료
        });
      } else {
        print('서버 요청 실패: ${response.statusCode}');
        setState(() {
          _messages.add({
            'text': '서버 요청 실패: 다시시도해주세요',
            'image': null,
            'isUser': false,
          });
          _isSending = false; // 요청 완료
        });
      }
    } catch (e) {
      print('서버 통신 실패: $e');
      setState(() {
        _messages.add({
          'text': '서버 통신 실패: 다시시도해주세요',
          'image': null,
          'isUser': false,
        });
        _isSending = false; // 요청 완료
      });
    }
  }

  Widget _buildMessageBubble({
    String? message,
    String? image,
    required bool isUser,
    bool isLoading = false, // 추가된 로딩 인디케이터 상태
  }) {
    final isUserMessage = isUser;
    final alignment = isUserMessage ? Alignment.centerRight : Alignment.centerLeft;
    final backgroundColor = isUserMessage ? Colors.blueAccent : Colors.grey[300];
    final textColor = isUserMessage ? Colors.white : Colors.black;

    return Align(
      alignment: alignment,
      child: Container(
        constraints: BoxConstraints(
          maxWidth: MediaQuery.of(context).size.width * 0.75, // 최대 너비를 75%로 설정
        ),
        margin: EdgeInsets.symmetric(vertical: 8),
        padding: EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (!isUser && isLoading)
              Center(child: CircularProgressIndicator()), // AI 메시지에만 로딩 인디케이터 추가
            if (message != null)
              Text(
                message,
                style: TextStyle(color: textColor),
              ),
            if (image != null)
              Image.file(
                File(image),
                width: 200,
                height: 200,
                fit: BoxFit.cover,
              ),
          ],
        ),
      ),
    );
  }


}