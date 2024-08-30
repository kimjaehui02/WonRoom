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
        padding: EdgeInsets.all(16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ListTile(
              leading: Icon(Icons.camera_alt),
              title: Text('식물 정보 검색하기'),
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
            ),
            Divider(),
            ListTile(
              leading: Icon(Icons.local_florist),
              title: Text('식물 병해충 검색하기'),
              onTap: () async {
                Navigator.pop(context);
                final XFile? image = await _picker.pickImage(source: ImageSource.camera);
                if (image != null) {
                  File imageFile = File(image.path);
                  String base64Image = base64Encode(imageFile.readAsBytesSync());

                  await sendImageToServer(base64Image, 'plant_pest');
                }
              },
            ),
            Divider(),
            ListTile(
              leading: Icon(Icons.grass),
              title: Text('도감 등록하기'),
              onTap: () async {
                Navigator.pop(context);
                showPlantRegistrationModal(context);
              },
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
