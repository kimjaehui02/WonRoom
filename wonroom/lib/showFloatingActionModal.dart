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
                  // 여기에서 이미지를 사용할 수 있습니다.
                  print('식물 정보 검색 이미지 경로: ${image.path}');
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
                  // 여기에서 이미지를 사용할 수 있습니다.
                  print('식물 병해충 검색 이미지 경로: ${image.path}');
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
                Navigator.pop(context); // 현재 모달창을 닫고
                showPlantRegistrationModal(context); // 도감 등록 모달창을 엽니다.
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
