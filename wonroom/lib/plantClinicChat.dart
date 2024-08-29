import 'dart:io'; // Add this import for File class
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart'; // Add this import for image picking

class PlantClinicChat extends StatefulWidget {
  const PlantClinicChat({super.key});

  @override
  _PlantClinicChatState createState() => _PlantClinicChatState();
}

class _PlantClinicChatState extends State<PlantClinicChat> {
  final TextEditingController _messageController = TextEditingController();
  final List<Map<String, dynamic>> _messages = [];
  final ImagePicker _picker = ImagePicker();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text('식물 클리닉'),
        centerTitle: true,
      ),
      body: Column(
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
                      );
                    },
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(), // Prevent ListView from scrolling independently
                  ),
                ],
              ),
            ),
          ),
          // 입력 필드 및 버튼
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
            child: Row(
              children: [

                Container(
                  width: 30,
                  decoration: BoxDecoration(
                    shape: BoxShape.rectangle,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: IconButton(
                    onPressed: () async {
                      final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
                      if (pickedFile != null) {
                        _sendMessage(image: pickedFile.path, isUser: true);
                      }
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

                SizedBox(width: 4,),

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
                        borderSide: BorderSide(color: Color(0xffc2c2c2), width: 1.0),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Color(0xffc2c2c2), width: 1.0),
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    onSubmitted: (text) {
                      _sendMessage(text: text, isUser: true);
                    },
                  ),
                ),

                SizedBox(width: 2,),

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
                )









              ],
            ),
          ),
        ],
      ),
    );
  }

  void _sendMessage({String? text, String? image, required bool isUser}) {
    setState(() {
      if (text != null && text.isNotEmpty) {
        _messages.add({
          'text': text,
          'image': null,
          'isUser': isUser,
        });
        // Simulate GPT response
        if (isUser) {
          Future.delayed(Duration(seconds: 1), () {
            _sendMessage(
              text: 'GPT의 응답입니다. 실제 API와 연동될 부분입니다.',
              isUser: false,
            );
          });
        }
      } else if (image != null) {
        _messages.add({
          'text': null,
          'image': image,
          'isUser': isUser,
        });
      }
    });
    _messageController.clear();
  }

  Widget _buildMessageBubble({String? message, String? image, required bool isUser}) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 4.0),
      child: Align(
        alignment: isUser ? Alignment.topRight : Alignment.centerLeft,
        child: ConstrainedBox(
          constraints: BoxConstraints(
            maxWidth: MediaQuery.of(context).size.width * 0.75,
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (!isUser)
                Container(
                  width: 50,
                  height: 50,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: Color(0xffeeeeee),
                      width: 1,
                    ),
                    color: Colors.white,
                  ),
                  child: Center(
                    child: Image.asset(
                      'images/chat-bot.png',
                      width: 25,
                      height: 25,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              SizedBox(width: 8),
              if (image != null)
                Container(
                  constraints: BoxConstraints(
                    maxWidth: MediaQuery.of(context).size.width * 0.5,
                    // maxHeight: MediaQuery.of(context).size.width * 0.5,
                  ), // 이미지의 최대 너비 설정
                  child: Image.file(
                    File(image),
                    fit: BoxFit.cover,
                  ),
                )
              else if (message != null)
                Flexible(
                  child: Container(
                    padding: EdgeInsets.symmetric(vertical: 10, horizontal: 16),
                    decoration: BoxDecoration(
                      color: isUser ? Color(0xff86b26a) : Color(0xffeeeeee),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text(
                      message,
                      style: TextStyle(
                        color: isUser ? Colors.white : Colors.black,
                      ),
                    ),
                  ),
                ),
              // SizedBox(width: 8),
            ],
          ),
        ),
      ),
    );
  }
}
