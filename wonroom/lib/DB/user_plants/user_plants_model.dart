class UserPlant {
  final int? plantId;  // Public getter
  final String userId;
  final int catalogNumber;
  final String? diaryTitle;
  final DateTime nextWateringDate;
  final DateTime createdAt;

  UserPlant({
    this.plantId,
    required this.userId,
    required this.catalogNumber,
    this.diaryTitle,
    required this.nextWateringDate,
    required this.createdAt,
  });



  // JSON to UserPlant conversion
  factory UserPlant.fromJson(Map<String, dynamic> json) {
    return UserPlant(
      plantId: json['plant_id'] as int?,
      userId: json['user_id'] as String,
      catalogNumber: json['catalog_number'] as int,
      diaryTitle: json['diary_title'] as String?,
      nextWateringDate: DateTime.parse(json['next_watering_date'] as String),
      createdAt: DateTime.parse(json['created_at'] as String),
    );
  }

  // UserPlant to JSON conversion
  Map<String, dynamic> toJson() {
    return {
      'plant_id': plantId,
      'user_id': userId,
      'catalog_number': catalogNumber,
      'diary_title': diaryTitle,
      'next_watering_date': nextWateringDate.toIso8601String(),
      'created_at': createdAt.toIso8601String(),
    };
  }
}
