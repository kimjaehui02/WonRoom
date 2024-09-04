import 'dart:io';

import 'package:flutter/material.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:image_picker/image_picker.dart'; // 추가된 패키지

class CreatePost extends StatefulWidget {
  const CreatePost({super.key});

  @override
  State<CreatePost> createState() => _CreatePostState();
}

class _CreatePostState extends State<CreatePost> {
  String? _selectedCategory;

  // 이미지 선택에 필요한 코드
  List<XFile?> _images = [];
  final ImagePicker _picker = ImagePicker();

  Future<void> _pickImage() async {
    if (_images.length >= 3) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('이미지는 최대 3개까지 선택할 수 있습니다.')),
      );
      return;
    }

    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      setState(() {
        _images.add(image);
      });
    }
  }

  Widget _buildImageContainer(XFile? imageFile) {
    return Container(
      width: 80,
      height: 80,
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey),
        borderRadius: BorderRadius.circular(8),
        image: imageFile == null
            ? null
            : DecorationImage(
          image: FileImage(File(imageFile.path)),
          fit: BoxFit.cover,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          '게시글 작성',
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
            fontSize: 20, // 앱바 제목 텍스트 크기 조정
          ),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios,
            color: Colors.grey,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: SingleChildScrollView( // 스크롤 가능하도록 래핑
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // 게시글 유형 선택
              Text(
                '게시글 유형',
                style: TextStyle(
                  fontSize: 18, // 텍스트 크기 조정
                  fontWeight: FontWeight.bold,
                ),

              ),
              SizedBox(height: 8),
              // 드롭다운 버튼
              DropdownButtonFormField2<String>(
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  contentPadding: EdgeInsets.fromLTRB(-4, 0, 10, 0), // 오른쪽 패딩을 조정하여 아이콘을 왼쪽으로 이동
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Color(0xff6bbe45), width: 2.0), // 포커스 시 테두리 색상 및 두께
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Color(0xffc2c2c2), width: 1.0), // 비포커스 상태에서의 테두리 색상 및 두께
                  ),
                ),
                hint: Text(
                  '게시글 유형을 선택해주세요.',
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.grey, // 힌트 텍스트 색상 설정
                  ),
                ),
                value: _selectedCategory,
                items: [
                  '질문하기',
                  '자랑하기',
                  '자유게시판',
                ].map((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),

                onChanged: (newValue) {
                  setState(() {
                    _selectedCategory = newValue;
                  });
                },
                style: const TextStyle(fontSize: 14, color: Colors.black),
                dropdownStyleData: DropdownStyleData(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  maxHeight: 300,
                ),
                buttonStyleData: ButtonStyleData(
                  padding: EdgeInsets.zero,
                ),
                iconStyleData: IconStyleData(
                  iconSize: 24,
                  icon: Icon(Icons.expand_more, color: Colors.grey),
                ),
              ),
              SizedBox(height: 20),
              // 게시글 제목 입력
              Text(
                '게시글 제목',
                style: TextStyle(
                  fontSize: 18, // 텍스트 크기 조정
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 8),
              TextField(
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  contentPadding: EdgeInsets.all(12),
                  hintText: '제목을 입력하세요',
                  hintStyle: TextStyle(color: Colors.grey, fontSize: 14),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Color(0xff6bbe45), width: 2.0), // 포커스 시 테두리 색상 및 두께
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Color(0xffc2c2c2), width: 1.0), // 비포커스 상태에서의 테두리 색상 및 두께
                  ),
                ),
              ),
              SizedBox(height: 20),
              // 게시글 내용 입력
              Text(
                '게시글 내용',
                style: TextStyle(
                  fontSize: 18, // 텍스트 크기 조정
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 8),
              // 이미지 선택에 필요한 코드
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  GestureDetector(
                    onTap: _pickImage,
                    child: Container(
                      width: 80,
                      height: 80,
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.camera_alt_outlined, color: Colors.grey, size: 32),
                          Text(
                            '${_images.length}/3',
                            style: TextStyle(fontSize: 14, color: Colors.grey),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(width: 30),
                  Expanded(
                    child: Wrap(
                      spacing: 8.0, // 이미지 간 간격
                      runSpacing: 8.0, // 이미지 간 행 간격 (세로)
                      alignment: WrapAlignment.start,
                      children: _images
                          .take(3)
                          .map((image) => _buildImageContainer(image))
                          .toList(),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 20),
              TextField(
                maxLines: 10,
                decoration: InputDecoration(
                  hintText: '게시할 내용을 작성해주세요.',
                  border: OutlineInputBorder(),
                  contentPadding: EdgeInsets.all(12),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Color(0xff6bbe45), width: 2.0), // 포커스 시 테두리 색상 및 두께
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Color(0xffc2c2c2), width: 1.0), // 비포커스 상태에서의 테두리 색상 및 두께
                  ),
                ),
              ),
              SizedBox(height: 110), // 여백 추가

              // 하단 버튼들
              Row(
                children: [
                  Expanded(
                    child: OutlinedButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: Text(
                        '취소',
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      style: OutlinedButton.styleFrom(
                        backgroundColor: Color(0xffEEEEEE),
                        padding: EdgeInsets.symmetric(vertical: 16), // 버튼의 세로 패딩
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(3),
                        ),
                        side: BorderSide.none, // 모서리 색을 없애는 설정
                      ),
                    ),
                  ),
                  SizedBox(width: 8), // 버튼들 사이의 간격
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {
                        _showSuccessDialog(context); // 등록 버튼 클릭 시 다이얼로그 표시
                      },
                      child: Text(
                        '등록',
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Color(0xff6bbe45),
                        padding: EdgeInsets.symmetric(vertical: 16), // 버튼의 세로 패딩
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(3),
                        ),
                        side: BorderSide.none,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  // 등록 버튼 클릭 시 팝업창
  void _showSuccessDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(5),
          ),
          content: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  '등록이 완료되었습니다.',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center, // 텍스트 가운데 정렬
                ),
                SizedBox(height: 5),
                Text(
                  '확인 버튼을 누르면\n 이전 페이지로 이동합니다.',
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.grey,
                  ),
                  textAlign: TextAlign.center, // 텍스트 가운데 정렬
                ),
                SizedBox(height: 16),
                SizedBox(
                  width: double.infinity, // 버튼을 화면 너비에 맞게 확장
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context); // 다이얼로그 닫기
                      Navigator.pop(context); // 이전 페이지로 이동
                    },
                    child: Text(
                      '확인',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.black, // 검정색 배경
                      padding: EdgeInsets.symmetric(vertical: 16), // 버튼의 세로 패딩
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(3), // 직사각형 모양
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
