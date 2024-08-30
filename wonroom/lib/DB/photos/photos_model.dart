import 'dart:convert';

// Photo 모델 클래스 정의
class Photo {
  int? photoId;
  final int postId;
  final int category;
  final bool isPrimary;
  final String fileName;
  final String serverPath;
  final String fileType;
  final DateTime createdAt;

  // 생성자
  Photo({
    this.photoId,
    required this.postId,
    required this.category,
    required this.isPrimary,
    required this.fileName,
    required this.serverPath,
    required this.fileType,
    required this.createdAt,
  });

  // JSON에서 Photo 객체로 변환
  factory Photo.fromJson(Map<String, dynamic> json) {
    return Photo(
      photoId: json['photo_id'],
      postId: json['post_id'],
      category: json['category'],
      isPrimary: json['is_primary'] == 1, // Convert tinyint(1) to boolean
      fileName: json['file_name'],
      serverPath: json['server_path'],
      fileType: json['file_type'],
      createdAt: DateTime.parse(json['created_at']),
    );
  }

  // Photo 객체에서 JSON으로 변환
  Map<String, dynamic> toJson() {
    return {
      'photo_id': photoId,
      'post_id': postId,
      'category': category,
      'is_primary': isPrimary ? 1 : 0, // Convert boolean to tinyint(1)
      'file_name': fileName,
      'server_path': serverPath,
      'file_type': fileType,
      'created_at': createdAt.toIso8601String(),
    };
  }
}

// JSON 리스트에서 Photo 객체 리스트로 변환
List<Photo> photosFromJson(String str) {
  final jsonData = json.decode(str);
  return List<Photo>.from(jsonData['data'].map((item) => Photo.fromJson(item)));
}

// Photo 객체 리스트를 JSON 리스트로 변환
String photosToJson(List<Photo> data) {
  final jsonData = List<dynamic>.from(data.map((item) => item.toJson()));
  return json.encode({'data': jsonData});
}
