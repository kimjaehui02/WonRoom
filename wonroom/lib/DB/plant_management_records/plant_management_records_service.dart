import 'package:dio/dio.dart';
import 'package:wonroom/Flask/storage_manager.dart';

final Dio dio = Dio();
final String baseUrl = "http://192.168.219.81:8087/";

// 식물 관리 기록 추가 요청
Future<void> addPlantManagementRecord({
  required int catalogNumber,          // catalogNumber는 int형
  required String managementDate,     // 관리 날짜
  required String managementType,     // 관리 유형
  String? details,                    // 선택적 필드
  required int plantId                // 필수 필드: 식물 ID
}) async {
  final String url = "$baseUrl/plant_management_records/insert";

  try {
    Response response = await dio.post(
      url,
      data: {
        "catalog_number": catalogNumber,  // catalogNumber는 int형으로 전송
        "management_date": managementDate, // 날짜를 ISO8601 문자열로 전송
        "management_type": managementType, // 관리 유형 (예: 'Watering', 'Pruning')
        "details": details ?? '',          // details가 없을 경우 빈 문자열로 대체
        "plant_id": plantId,               // 식물 ID 추가
      },
    );

    print('Status Code: ${response.statusCode}');
    print('Response URL: ${response.realUri}');
    print('Response Data: ${response.data}');
  } catch (e) {
    print("Error: $e");
  }
}
