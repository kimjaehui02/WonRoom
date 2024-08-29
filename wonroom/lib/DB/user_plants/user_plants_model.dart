class UserPlant {
  int? _plantId;  // Private field
  String _userId;
  int _catalogNumber;
  String? _diaryTitle;
  DateTime _nextWateringDate;
  DateTime _createdAt;

  UserPlant({
    int? plantId,
    required String userId,
    required int catalogNumber,
    String? diaryTitle,
    required DateTime nextWateringDate,
    required DateTime createdAt,
  })  : _plantId = plantId,
        _userId = userId,
        _catalogNumber = catalogNumber,
        _diaryTitle = diaryTitle,
        _nextWateringDate = nextWateringDate,
        _createdAt = createdAt;

  // Getter for plantId
  int? get plantId {
    print('Getting plantId: $_plantId');
    return _plantId;
  }

  // Setter for plantId
  set plantId(int? id) {
    print('Setting plantId to: $id');
    _plantId = id;
  }

  // Getters
  String get userId => _userId;
  int get catalogNumber => _catalogNumber;
  String? get diaryTitle => _diaryTitle;
  DateTime get nextWateringDate => _nextWateringDate;
  DateTime get createdAt => _createdAt;

  // Setters
  set userId(String id) => _userId = id;
  set catalogNumber(int number) => _catalogNumber = number;
  set diaryTitle(String? title) => _diaryTitle = title;
  set nextWateringDate(DateTime date) => _nextWateringDate = date;
  set createdAt(DateTime date) => _createdAt = date;

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
      'plant_id': _plantId,
      'user_id': _userId,
      'catalog_number': _catalogNumber,
      'diary_title': _diaryTitle,
      'next_watering_date': _nextWateringDate.toIso8601String(),
      'created_at': _createdAt.toIso8601String(),
    };
  }
}
