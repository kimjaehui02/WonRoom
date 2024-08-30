import 'package:dio/dio.dart';
import 'chat_messages_model.dart'; // JSON 변환을 위해 import

final Dio dio = Dio();
final String baseUrl = "http://192.168.219.81:8087/";

class ChatMessagesService {
  // 채팅 메시지 추가 요청
  Future<void> addChatMessage(ChatMessage chatMessage) async {
    final String url = "$baseUrl/chat_messages/insert";

    try {
      Response response = await dio.post(
        url,
        data: chatMessage.toJson(),  // ChatMessage 모델을 JSON으로 변환하여 전송
      );

      print('Status Code: ${response.statusCode}');
      print('Response URL: ${response.realUri}');
      print('Response Data: ${response.data}');
    } catch (e) {
      print("Error: $e");
    }
  }

  // 채팅 메시지 조회 요청
  Future<List<ChatMessage>?> getChatMessages(DateTime start, DateTime end) async {
    final String url = "$baseUrl/chat_messages/select";

    try {
      Response response = await dio.post(
        url,
        data: {
          "chat_time_start": start.toIso8601String(),
          "chat_time_end": end.toIso8601String(),
        },
      );

      print('Status Code: ${response.statusCode}');
      print('Response URL: ${response.realUri}');
      print('Response Data: ${response.data}');

      if (response.statusCode == 200) {
        final responseData = response.data;
        if (responseData['status'] == 'success') {
          List<dynamic> messagesJson = responseData['data'];
          List<ChatMessage> chatMessagesList = messagesJson.map((json) => ChatMessage.fromJson(json)).toList();
          print('Chat messages retrieved successfully.');
          return chatMessagesList;
        } else {
          print('Chat message retrieval failed: ${responseData['message']}');
        }
      } else {
        print('Unexpected status code: ${response.statusCode}');
      }
    } catch (e) {
      print("Error: $e");
    }

    return null;
  }

  // 채팅 메시지 수정 요청
  Future<void> updateChatMessage(ChatMessage chatMessage) async {
    final String url = "$baseUrl/chat_messages/update";

    try {
      Response response = await dio.post(
        url,
        data: chatMessage.toJson(),  // ChatMessage 모델을 JSON으로 변환하여 전송
      );

      print('Status Code: ${response.statusCode}');
      print('Response URL: ${response.realUri}');
      print('Response Data: ${response.data}');
    } catch (e) {
      print("Error: $e");
    }
  }

  // 채팅 메시지 삭제 요청
  Future<void> deleteChatMessage(int chatId) async {
    final String url = "$baseUrl/chat_messages/delete";

    try {
      Response response = await dio.post(
        url,
        data: {
          "chat_id": chatId,
        },
      );

      print('Status Code: ${response.statusCode}');
      print('Response URL: ${response.realUri}');
      print('Response Data: ${response.data}');
    } catch (e) {
      print("Error: $e");
    }
  }
}
