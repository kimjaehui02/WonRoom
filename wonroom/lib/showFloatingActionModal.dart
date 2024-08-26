import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:wonroom/myPlantRegistration.dart';

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
                  // 여기에서 이미지를 사용할 수 있습니다.
                  print('식물 정보 검색 이미지 경로: ${image.path}');
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
                  // 여기에서 이미지를 사용할 수 있습니다.
                  print('식물 병해충 검색 이미지 경로: ${image.path}');
                }
              },
            ),
            Divider(),
            ListTile(
              leading: Icon(Icons.grass),
              title: Text('도감 등록하기'),
              onTap: () async {
                Navigator.pop(context); // 현재 모달창을 닫고
                showPlantRegistrationModal(context); // 도감 등록 모달창을 엽니다.
              },
            ),
          ],
        ),
      );
    },
  );
}
