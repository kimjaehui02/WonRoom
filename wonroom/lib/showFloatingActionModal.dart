import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:io';

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
                Navigator.pop(context);
                final XFile? image = await _picker.pickImage(source: ImageSource.camera);
                if (image != null) {
                  File imageFile = File(image.path);
                  String base64Image = base64Encode(imageFile.readAsBytesSync());
                  String analysisResult = await sendImageToServer(base64Image, 'plant_info');

                  if (analysisResult != null && analysisResult.isNotEmpty) {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => PlantDetailPage(analysisResult: analysisResult),
                      ),
                    );
                  } else {
                    // 에러 처리
                    print("Analysis result is null or empty");
                  };
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
                Navigator.pop(context);
                final XFile? image = await _picker.pickImage(source: ImageSource.camera);
                if (image != null) {
                  File imageFile = File(image.path);
                  String base64Image = base64Encode(imageFile.readAsBytesSync());

                  await sendImageToServer(base64Image, 'plant_pest');
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
                    SizedBox(width: 16), // 텍스트와 아이콘 사이 간격
                    Text('다이어리 등록하기', style: TextStyle(
                        fontSize: 16,
                        color: Color(0xff333333)
                    ),),
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

Future<String> sendImageToServer(String base64Image, String category) async {
  var response = await http.post(
    Uri.parse('https://3454-34-90-188-73.ngrok-free.app/analyze'),
    headers: {'Content-Type': 'application/json'},
    body: jsonEncode({'image': base64Image, 'category': category}),
  );

  if (response.statusCode == 200) {
    return jsonDecode(response.body)['result'];
  } else {
    throw Exception('이미지 분석 실패: ${response.statusCode}');
  }
}
