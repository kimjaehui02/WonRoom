import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class CameraButton extends StatelessWidget {
  final ImagePicker _picker = ImagePicker();

  Future<void> _openCamera(BuildContext context) async {
    final XFile? image = await _picker.pickImage(source: ImageSource.camera);

    if (image != null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('사진이 촬영되었습니다: ${image.path}')),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('사진 촬영이 취소되었습니다.')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => _openCamera(context),
      child: Container(
        width: double.infinity,
        height: 250,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('images/plantCamera.png'),
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }
}

List<int> intList = List<int>.generate(6, (index) => index++, growable: false);
List<int> intList2 = List<int>.generate(100, (index) => index++, growable: false);

class PlantDictionary extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CameraButton(),

          SizedBox(height: 24),

          Container(
            padding: EdgeInsets.only(top: 24, bottom: 12, left: 10),
            child: Text(
              '반려식물 추천 식물',
              style: TextStyle(
                fontSize: 21,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Container(
            height: 200, // ListView의 높이를 고정합니다.
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: intList.length,
              itemBuilder: (context, index) {
                return Container(
                  width: MediaQuery.of(context).size.width * 0.35,
                  margin: EdgeInsets.only(right: 8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        height: 150,
                        decoration: BoxDecoration(
                          color: Colors.blueAccent,
                          borderRadius: BorderRadius.circular(8.0),
                          image: DecorationImage(
                            image: AssetImage('images/plant_${intList[index]}.jpg'),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      SizedBox(height: 8),
                      Padding(
                        padding: const EdgeInsets.only(left: 10, right: 10, top: 4),
                        child: Text(
                          '${intList[index]}번째',
                          style: TextStyle(color: Colors.black, fontSize: 16),
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),

          SizedBox(height: 24),

          Container(
            padding: EdgeInsets.only(top: 24, bottom: 12, left: 10),
            child: Text(
              '식물 사전',
              style: TextStyle(
                fontSize: 21,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),

          GridView.builder(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(), // GridView 스크롤 비활성
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2, // 그리드 항목의 최대 너비
              crossAxisSpacing: 8.0, // 항목 간의 가로 간격
              mainAxisSpacing: 8.0, // 항목 간의 세로 간격
              childAspectRatio: 1.0, // 항목의 비율
            ),
            itemCount: intList2.length,
            itemBuilder: (context, index) {
              return Container(
                child: Column(
                  children: [
                    Image.asset('images/plant_0.jpg'),
                    Container(
                      height: 50,
                      alignment: Alignment.center,
                      child: Text('$index',),
                    ),
                  ],
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
