import 'dart:convert';

// 관리 유형 Enum 정의
enum ManagementType { Watering, Pruning, Repotting, Fertilizing }

// PlantManagementRecord 모델 클래스
class PlantManagementRecord {
  int? recordId;
  final int catalogNumber;
  final DateTime managementDate;
  final ManagementType managementType;
  final String details;
  final int plantId;

  // 생성자
  PlantManagementRecord({
    this.recordId,
    required this.catalogNumber,
    required this.managementDate,
    required this.managementType,
    required this.details,
    required this.plantId,
  });

  // JSON에서 PlantManagementRecord 객체로 변환
  factory PlantManagementRecord.fromJson(Map<String, dynamic> json) {
    return PlantManagementRecord(
      recordId: json['record_id'],
      catalogNumber: json['catalog_number'],
      managementDate: DateTime.parse(json['management_date']),
      managementType: _parseManagementType(json['management_type']),
      details: json['details'],
      plantId: json['plant_id'],
    );
  }

  // PlantManagementRecord 객체를 JSON으로 변환
  Map<String, dynamic> toJson() {
    return {
      'record_id': recordId,
      'catalog_number': catalogNumber,
      'management_date': managementDate.toIso8601String(),
      'management_type': _managementTypeToString(managementType),
      'details': details,
      'plant_id': plantId,
    };
  }

  // 관리 유형 문자열을 열거형으로 변환
  static ManagementType _parseManagementType(String type) {
    switch (type) {
      case 'Watering':
        return ManagementType.Watering;
      case 'Pruning':
        return ManagementType.Pruning;
      case 'Repotting':
        return ManagementType.Repotting;
      case 'Fertilizing':
        return ManagementType.Fertilizing;
      default:
        throw ArgumentError('Unknown management type: $type');
    }
  }

  // 관리 유형 열거형을 문자열로 변환
  static String _managementTypeToString(ManagementType type) {
    switch (type) {
      case ManagementType.Watering:
        return 'Watering';
      case ManagementType.Pruning:
        return 'Pruning';
      case ManagementType.Repotting:
        return 'Repotting';
      case ManagementType.Fertilizing:
        return 'Fertilizing';
      default:
        throw ArgumentError('Unknown management type: $type');
    }
  }
}
