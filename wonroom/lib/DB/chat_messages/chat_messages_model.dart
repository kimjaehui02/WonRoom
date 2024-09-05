
class ChatMessage {
  int? chatId;
  final String chatText;
  final bool speaker;
  final DateTime chatTime;

  ChatMessage({
    this.chatId,
    required this.chatText,
    required this.speaker,
    required this.chatTime,
  });

  // JSON 데이터를 ChatMessage 객체로 변환
  factory ChatMessage.fromJson(Map<String, dynamic> json) {
    return ChatMessage(
      chatId: json['chat_id'] as int,
      chatText: json['chat_text'] as String,
      speaker: json['speaker'] == 1, // Convert tinyint(1) to boolean
      chatTime: DateTime.parse(json['chat_time'] as String),
    );
  }

  // ChatMessage 객체를 JSON 데이터로 변환
  Map<String, dynamic> toJson() {
    return {
      'chat_id': chatId,
      'chat_text': chatText,
      'speaker': speaker ? 1 : 0, // Convert boolean to tinyint(1)
      'chat_time': chatTime.toIso8601String(),
    };
  }
}
