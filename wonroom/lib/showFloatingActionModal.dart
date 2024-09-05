import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'dart:io';
import 'package:archive/archive.dart';
import 'package:path_provider/path_provider.dart';
import 'package:wonroom/plantClinicChat.dart';
import 'PlantDetailPage.dart';
import 'myPlantRegistration.dart';

final ImagePicker _picker = ImagePicker();

void showFloatingActionModal(BuildContext context) {
  showModalBottomSheet(
    context: context,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
    ),
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
            GestureDetector(
              onTap: () async {
                final XFile? image = await _picker.pickImage(source: ImageSource.camera);
                if (image != null) {
                  File imageFile = File(image.path);
                  try {
                    // 이미지 압축
                    final compressedImage = await FlutterImageCompress.compressWithFile(
                      imageFile.path,
                      quality: 80,
                    );

                    // 로딩 인디케이터 표시
                    showDialog(
                      context: context,
                      barrierDismissible: false,
                      builder: (BuildContext context) {
                        return Center(child: CircularProgressIndicator());
                      },
                    );

                    // 서버로 이미지 전송
                    final analysisResult = await sendImageToServer(
                      base64Encode(compressedImage!),
                      'plant_info',
                    );

                    // 로딩 인디케이터 숨기기
                    Navigator.pop(context);

                    // 결과 페이지로 이동
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => PlantDetailPage(
                          data: analysisResult['json'] ?? {},
                        ),
                      ),
                    );
                  } catch (e) {
                    // 로딩 인디케이터 숨기기
                    Navigator.pop(context);
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => PlantDetailPage(
                          data: {},
                        ),
                      ),
                    );
                    print('Error: $e');
                  }
                }
              },
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 16),
                child: Row(
                  children: [
                    Icon(Icons.camera_alt_outlined,color: Color(0xff787878)),
                    SizedBox(width: 16), // 텍스트와 아이콘 사이 간격
                    Text('식물 정보 검색하기', style: TextStyle(
                        fontSize: 16,
                        color: Color(0xff333333)
                    ),),
                  ],
                ),
              ),
            ),
            GestureDetector(
              onTap: () async {
                final XFile? image = await _picker.pickImage(source: ImageSource.camera);
                if (image != null) {
                  File imageFile = File(image.path);
                  try {
                    // 이미지 압축
                    final compressedImage = await FlutterImageCompress.compressWithFile(
                      imageFile.path,
                      quality: 80,
                    );

                    // 로딩 인디케이터 표시
                    showDialog(
                      context: context,
                      barrierDismissible: false,
                      builder: (BuildContext context) {
                        return Center(child: CircularProgressIndicator());
                      },
                    );

                    // 서버로 이미지 전송
                    final analysisResult = await sendImageToServer(
                      base64Encode(compressedImage!),
                      'plant_pest',
                    );

                    // 로딩 인디케이터 숨기기
                    Navigator.pop(context);

                    // 병해충 페이지로 이동
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => PlantClinicChat(
                          jsonData: analysisResult['json'] ?? {},
                          imagePath: analysisResult['imagePath'],
                        ),
                      ),
                    );
                  } catch (e) {
                    // 로딩 인디케이터 숨기기
                    Navigator.pop(context);
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => PlantClinicChat(
                          jsonData: {},
                          imagePath: null,
                        ),
                      ),
                    );
                    print('Error: $e');
                  }
                }
              },
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 16),
                child: Row(
                  children: [
                    Icon(Icons.eco_outlined,color: Color(0xff787878)),
                    SizedBox(width: 16), // 텍스트와 아이콘 사이 간격
                    Text('식물 병해충 검색하기', style: TextStyle(
                        fontSize: 16,
                        color: Color(0xff333333)
                    ),),
                  ],
                ),
              ),
            ),
            GestureDetector(
              onTap: () async {
                Navigator.pop(context);
                showPlantRegistrationModal(context);
              },
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 16),
                child: Row(
                  children: [
                    Image.asset('images/diary.png',
                        width: 22,
                        height: 22,
                        color: Color(0xff787878)
                    ),
                    SizedBox(width: 16),
                    Text(
                      '다이어리 등록하기',
                      style: TextStyle(fontSize: 16, color: Color(0xff333333)),
                    ),
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

Future<Map<String, dynamic>> sendImageToServer(String base64Image, String category) async {
  final String url = category == 'plant_info'
      ? 'https://09e7-34-91-150-31.ngrok-free.app/plant_info'
      : 'https://09e7-34-91-150-31.ngrok-free.app/plant_pest';

  try {
    final response = await http.post(
      Uri.parse(url),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'image': base64Image}),
    );

    if (response.statusCode == 200) {
      return await handleServerResponse(response, category);
    } else {
      print('이미지 분석 실패: ${response.statusCode}');
      throw Exception('이미지 분석 실패: ${response.statusCode}');
    }
  } catch (e) {
    print('서버 요청 실패: $e');
    throw Exception('서버 요청 실패: $e');
  }
}

Future<Map<String, dynamic>> handleServerResponse(http.Response response, String category) async {
  final Map<String, dynamic> result = {};

  try {
    // 서버가 ZIP 파일을 반환할 때
    if (response.headers['content-type']?.contains('application/zip') ?? false) {
      final bytes = response.bodyBytes;
      final archive = ZipDecoder().decodeBytes(bytes);

      for (final file in archive) {
        final filename = file.name;
        final data = file.content as List<int>;

        if (category == 'plant_pest' && filename == 'pest_info.json') {
          // JSON 파일 처리
          final jsonString = utf8.decode(data);
          final jsonData = jsonDecode(jsonString);
          result['json'] = jsonData;
        } else if (category == 'plant_pest' && filename == 'pest_image.png') {
          // 이미지 파일 처리
          final tempDir = await getTemporaryDirectory();
          final filePath = '${tempDir.path}/pest_image.png';
          final file = File(filePath);
          await file.writeAsBytes(data);
          result['imagePath'] = filePath;
        } else if (category == 'plant_info' && filename == 'plant_info.json') {
          // JSON 파일 처리
          final jsonString = utf8.decode(data);
          final jsonData = jsonDecode(jsonString);
          result['json'] = jsonData;
        }
      }
    } else {
      // 비정상적인 응답 처리
      final jsonData = jsonDecode(response.body);
      result['json'] = jsonData;
    }
  } catch (e) {
    print('ZIP 파일 처리 중 오류 발생: $e');
    throw Exception('ZIP 파일 처리 중 오류 발생');
  }

  return result;
}
