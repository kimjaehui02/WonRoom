import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:io';

void showPlantRegistrationModal(BuildContext context) {
  final picker = ImagePicker();
  final TextEditingController _plantNameController = TextEditingController();
  File? _image;
  bool _showImageInField = false; // 네 버튼을 눌렀을 때 이미지를 표시할지 여부

  Future<void> _showConfirmationDialog(
      BuildContext context,
      String plantName,
      void Function(void Function()) setState,
      ) async {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('식물 이름 확인'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              if (_image != null) Image.file(_image!), // 모달창에 이미지 미리보기
              SizedBox(height: 10),
              Text('받아온 식물 이름 "$plantName"이(가) 맞나요?'),
            ],
          ),
          actions: <Widget>[
            TextButton(
              child: Text('아니요'),
              onPressed: () {
                setState(() {
                  _plantNameController.clear(); // 텍스트 필드 초기화
                  _showImageInField = false; // 이미지 표시 제거
                });
                Navigator.of(context).pop(); // 다이얼로그 닫기
              },
            ),
            TextButton(
              child: Text('네'),
              onPressed: () {
                setState(() {
                  // 텍스트 필드에 값 반영 및 이미지를 표시하지 않음
                  _plantNameController.text = plantName;
                  _showImageInField = false; // 이미지를 표시하지 않도록 설정
                });
                Navigator.of(context).pop(); // 다이얼로그 닫기
              },
            ),
          ],
        );
      },
    );
  }

  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
    ),
    builder: (BuildContext context) {
      return Padding(
        padding: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewInsets.bottom,
        ),
        child: DraggableScrollableSheet(
          expand: false,
          initialChildSize: 0.85,
          maxChildSize: 0.9,
          minChildSize: 0.5,
          builder: (BuildContext context, ScrollController scrollController) {
            return StatefulBuilder(
              builder: (BuildContext context, StateSetter setState) {
                String _plantName = '';
                bool _isUploading = false;

                Future<void> _uploadImage(File image) async {
                  setState(() {
                    _isUploading = true;
                    _plantNameController.text = "검색중입니다..."; // 검색중일 때 표시
                  });

                  try {
                    final imageBytes = await image.readAsBytes();
                    final base64Image = base64Encode(imageBytes);

                    // 서버로 이미지를 전송하여 텍스트(식물 이름)를 받아옴
                    final response = await http.post(
                      Uri.parse(
                          'https://375c-34-75-121-152.ngrok-free.app/plant_register'),
                      headers: {'Content-Type': 'application/json'},
                      body: json.encode({'image': base64Image}),
                    );

                    if (response.statusCode == 200) {
                      final data = json.decode(response.body);
                      print('서버 응답: $data');

                      // 서버에서 받아온 텍스트 확인 후 적용하는 다이얼로그 호출
                      _showConfirmationDialog(
                          context, data['plant_name'], setState); // setState 추가
                    } else {
                      print('API 호출 오류: ${response.statusCode}');
                    }
                  } catch (e) {
                    print('API 호출 중 오류 발생: $e');
                  } finally {
                    setState(() {
                      _isUploading = false;
                    });
                  }
                }

                Future<void> _pickImage(ImageSource source) async {
                  final pickedFile = await picker.pickImage(source: source);
                  if (pickedFile != null) {
                    final selectedImage = File(pickedFile.path);
                    setState(() {
                      _image = selectedImage; // 이미지를 표시하기 위해 설정
                    });
                    await _uploadImage(selectedImage); // 이미지를 서버로 전송
                  }
                }

                return Column(
                  children: [
                    Expanded(
                      child: SingleChildScrollView(
                        controller: scrollController,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Center(
                              child: Container(
                                width: 60,
                                height: 5,
                                decoration: BoxDecoration(
                                  color: Colors.grey[300],
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              ),
                            ),
                            SizedBox(height: 16),
                            Center(
                              child: Text(
                                '식물 등록',
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            SizedBox(height: 20),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                _buildImageButton(
                                  icon: Icons.camera_alt,
                                  label: '사진촬영',
                                  onPressed: _isUploading
                                      ? null
                                      : () => _pickImage(ImageSource.camera),
                                ),
                                _buildImageButton(
                                  icon: Icons.photo_library,
                                  label: '앨범에서 선택',
                                  onPressed: _isUploading
                                      ? null
                                      : () => _pickImage(ImageSource.gallery),
                                ),
                              ],
                            ),
                            SizedBox(height: 20),
                            if (_isUploading)
                              Center(child: CircularProgressIndicator()),
                            if (_image != null && !_isUploading) ...[
                              Center(
                                child: Stack(
                                  children: [
                                    Container(
                                      width: 200,
                                      height: 200,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        image: DecorationImage(
                                          image: FileImage(_image!),
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                    ),
                                    Positioned(
                                      right: 0,
                                      top: 0,
                                      child: IconButton(
                                        icon: Icon(Icons.close,
                                            color: Colors.red),
                                        onPressed: () {
                                          setState(() {
                                            _image = null;
                                            _plantName = '';
                                            _plantNameController.clear();
                                            _showImageInField =
                                            false; // 이미지 표시 플래그 초기화
                                          });
                                        },
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(height: 20),
                            ],
                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 16.0),
                              child: _buildTextField(
                                controller: _plantNameController,
                                hintText: '', // 힌트 텍스트를 제거하고 서버에서 받아온 텍스트 사용
                                label: '식물 이름',
                                enabled: !_isUploading,
                              ),
                            ),
                            SizedBox(height: 20),
                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 16.0),
                              child: _buildDatePicker(
                                context,
                                label: '마지막 물준날',
                                enabled: !_isUploading,
                              ),
                            ),
                            SizedBox(height: 20),
                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 16.0),
                              child: _buildDatePicker(
                                context,
                                label: '마지막 영양제',
                                enabled: !_isUploading,
                              ),
                            ),
                            SizedBox(height: 20),
                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 16.0),
                              child: _buildDatePicker(
                                context,
                                label: '마지막 분갈이',
                                enabled: !_isUploading,
                              ),
                            ),
                            SizedBox(height: 24),
                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 16.0),
                              child: _buildDatePicker(
                                context,
                                label: '마지막 가지치기',
                                enabled: !_isUploading,
                              ),
                            ),
                            SizedBox(height: 24),
                          ],
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Expanded(
                            child: OutlinedButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              child: Text('취소', style: TextStyle(fontSize: 25)),
                              style: OutlinedButton.styleFrom(
                                foregroundColor: Colors.grey,
                                backgroundColor: Colors.white,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                side: BorderSide(color: Colors.grey),
                                minimumSize: Size(150, 50),
                              ),
                            ),
                          ),
                          SizedBox(width: 16),
                          Expanded(
                            child: ElevatedButton(
                              onPressed: () {
                                // 저장 또는 처리하는 코드 추가
                              },
                              child: Text('등록',
                                  style: TextStyle(
                                      fontSize: 25, color: Colors.white)),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.green,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                minimumSize: Size(150, 50),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                );
              },
            );
          },
        ),
      );
    },
  );
}

Widget _buildImageButton({
  required IconData icon,
  required String label,
  required VoidCallback? onPressed,
}) {
  return Expanded(
    child: Container(
      decoration: BoxDecoration(
        border: Border(
          top: BorderSide(color: Color(0xffc2c2c2)),
          bottom: BorderSide(color: Color(0xffc2c2c2)),
        ),
      ),
      child: TextButton.icon(
        onPressed: onPressed,
        icon: Icon(icon, color: Color(0xff787878)),
        label: Text(
          label,
          style: TextStyle(
            color: Color(0xff333333),
            fontSize: 16,
          ),
        ),
        style: TextButton.styleFrom(
          padding: EdgeInsets.symmetric(vertical: 10),
        ),
      ),
    ),
  );
}

Widget _buildTextField({
  required String label,
  required String hintText,
  required TextEditingController controller,
  required bool enabled,
}) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Padding(
        padding: const EdgeInsets.only(left: 6),
        child: Text(
          label,
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
      ),
      SizedBox(height: 10),
      TextField(
        controller: controller,
        enabled: enabled,
        decoration: InputDecoration(
          hintText: hintText,
          border: OutlineInputBorder(),
          contentPadding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        ),
      ),
    ],
  );
}

Widget _buildDatePicker(BuildContext context,
    {required String label, required bool enabled}) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Padding(
        padding: const EdgeInsets.only(left: 6),
        child: Text(
          label,
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
      ),
      SizedBox(height: 10),
      GestureDetector(
        onTap: enabled
            ? () async {
          final DateTime? selectedDate = await showDatePicker(
            context: context,
            initialDate: DateTime.now(),
            firstDate: DateTime(2000),
            lastDate: DateTime(2101),
          );
          if (selectedDate != null && selectedDate != DateTime.now()) {
            // Handle date selection
          }
        }
            : null,
        child: AbsorbPointer(
          child: TextField(
            decoration: InputDecoration(
              suffixIcon: Icon(Icons.calendar_today),
              border: OutlineInputBorder(),
              contentPadding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
            ),
            enabled: false,
          ),
        ),
      ),
    ],
  );
}
