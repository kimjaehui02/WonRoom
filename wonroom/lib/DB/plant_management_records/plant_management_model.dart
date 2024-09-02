import 'dart:convert';
import 'package:intl/intl.dart';

// 관리 유형 Enum 정의
enum ManagementType { Watering, Pruning, Repotting, Fertilizing, Diagnosis }



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
      'management_date':  _formatDateForDb(managementDate),
      'management_type': _managementTypeToString(managementType),
      'details': details,
      'plant_id': plantId,
    };
  }

  // 관리 날짜를 'YYYY-MM-DD' 형식으로 포맷팅
  String _formatDateForDb(DateTime date) {
    return DateFormat('yyyy-MM-dd').format(date);
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
      case 'Diagnosis':
        return ManagementType.Diagnosis;  // 추가된 부분
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
      case ManagementType.Diagnosis:
        return 'Diagnosis';  // 추가된 부분
      default:
        throw ArgumentError('Unknown management type: $type');
    }
  }


  // managementDate를 'MM.dd' 형식으로 포맷팅
  String getFormattedDate() {
    final DateFormat formatter = DateFormat('MM.dd');
    return formatter.format(managementDate);
  }
}


// 리스트를 관리 유형에 따라 분류하고 날짜를 최신 순으로 정렬하는 함수
Map<ManagementType, List<PlantManagementRecord>> sortAndGroupRecords(
    List<PlantManagementRecord>? records) {
  // records가 null인 경우 빈 맵을 반환
  if (records == null) {
    return {};
  }

  // 관리 유형에 따라 그룹화
  final Map<ManagementType, List<PlantManagementRecord>> groupedRecords = {};

  for (var record in records) {
    if (!groupedRecords.containsKey(record.managementType)) {
      groupedRecords[record.managementType] = [];
    }
    groupedRecords[record.managementType]!.add(record);
  }

  // 각 그룹 내에서 날짜를 최신 순으로 정렬
  for (var key in groupedRecords.keys) {
    groupedRecords[key]!.sort((a, b) => b.managementDate.compareTo(a.managementDate));
  }

  return groupedRecords;
}

