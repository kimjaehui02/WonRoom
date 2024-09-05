import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:io';

void showPlantRegistrationModal(BuildContext context) {
  final picker = ImagePicker();

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
                File? _image;
                String _plantName = '';
                bool _isUploading = false;
                TextEditingController _plantNameController = TextEditingController();

                Future<void> _uploadImage(File image, StateSetter setState) async {
                  setState(() {
                    _isUploading = true;
                  });

                  try {
                    final imageBytes = await image.readAsBytes();
                    final base64Image = base64Encode(imageBytes);

                    final response = await http.post(
                      Uri.parse('https://16b5-34-91-150-31.ngrok-free.app/plant_register'),
                      headers: {'Content-Type': 'application/json'},
                      body: json.encode({'image': base64Image}),
                    );

                    if (response.statusCode == 200) {
                      final data = json.decode(response.body);
                      setState(() {
                        _plantName = data['name'] ?? '알 수 없음';
                        _plantNameController.text = _plantName; // 텍스트 필드 업데이트
                      });
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
                      _image = selectedImage;
                    });
                    await _uploadImage(selectedImage, setState);
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
                                  onPressed: _isUploading ? null : () => _pickImage(ImageSource.camera),
                                ),
                                _buildImageButton(
                                  icon: Icons.photo_library,
                                  label: '앨범에서 선택',
                                  onPressed: _isUploading ? null : () => _pickImage(ImageSource.gallery),
                                ),
                              ],
                            ),
                            SizedBox(height: 20),
                            if (_image != null) ...[
                              Center(
                                child: Stack(
                                  children: [
                                    Image.file(_image!),
                                    Positioned(
                                      right: 0,
                                      top: 0,
                                      child: IconButton(
                                        icon: Icon(Icons.close, color: Colors.red),
                                        onPressed: () {
                                          setState(() {
                                            _image = null;
                                            _plantName = '';
                                            _plantNameController.clear(); // 텍스트 필드 초기화
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
                                label: '식물 이름',
                                hintText: '파키라',
                                enabled: !_isUploading,
                              ),
                            ),
                            SizedBox(height: 20),
                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 16.0),
                              child: _buildDatePicker(context, label: '마지막 물준날', enabled: !_isUploading),
                            ),
                            SizedBox(height: 20),
                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 16.0),
                              child: _buildDatePicker(context, label: '마지막 영양제', enabled: !_isUploading),
                            ),
                            SizedBox(height: 20),
                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 16.0),
                              child: _buildDatePicker(context, label: '마지막 분갈이', enabled: !_isUploading),
                            ),
                            SizedBox(height: 24),
                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 16.0),
                              child: _buildDatePicker(context, label: '마지막 가지치기', enabled: !_isUploading),
                            ),
                            SizedBox(height: 24),
                            if (_isUploading)
                              Center(
                                child: CircularProgressIndicator(),
                              ),
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
                              onPressed: () {},
                              child: Text('등록', style: TextStyle(fontSize: 25, color: Colors.white)),
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
          // left: BorderSide(color: Colors.grey),
          // right: BorderSide(color: Colors.grey),
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
          contentPadding: EdgeInsets.symmetric(horizontal: 12.0, vertical: 10.0),
        ),
      ),
    ],
  );
}

Widget _buildDatePicker(BuildContext context, {required String label, required bool enabled}) {
  TextEditingController dateController = TextEditingController();

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
          DateTime? pickedDate = await showDatePicker(
            context: context,
            initialDate: DateTime.now(),
            firstDate: DateTime(2000),
            lastDate: DateTime(2101),
          );
          if (pickedDate != null) {
            dateController.text = "${pickedDate.toLocal()}".split(' ')[0];
          }
        }
            : null,
        child: AbsorbPointer(
          child: TextField(
            controller: dateController,
            enabled: enabled,
            decoration: InputDecoration(
              hintText: '날짜 선택',
              border: OutlineInputBorder(),
              contentPadding: EdgeInsets.symmetric(horizontal: 12.0, vertical: 10.0),
            ),
          ),
        ),
      ),
    ],
  );
}
