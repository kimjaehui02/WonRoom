import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:wonroom/inqurityDetails.dart';
import 'package:dropdown_button2/dropdown_button2.dart';


class WriteInquiry extends StatefulWidget {
  const WriteInquiry({super.key});

  @override
  State<WriteInquiry> createState() => _WriteInquiryState();
}

class _WriteInquiryState extends State<WriteInquiry> {
  String? _selectedCategory;
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _contentController = TextEditingController();

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

  // ==============================================================

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('문의하기', style: TextStyle(fontWeight: FontWeight.bold)),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios,
            color: Colors.grey,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      '문의유형',
                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                    ),
                    const SizedBox(height: 8),
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
                        '문의유형을 선택해주세요.',
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.grey,
                        ),
                      ),
                      value: _selectedCategory,
                      items: [
                        '계정 및 로그인',
                        '앱 기능 및 사용 방법',
                        '문제 해결 및 기술 지원',
                        '개인정보 보호 및 보안',
                        '기타',
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
                    const SizedBox(height: 16),
                    const Text(
                      '문의제목',
                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                    ),
                    const SizedBox(height: 8),
                    TextFormField(
                      controller: _titleController,
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
                    const SizedBox(height: 16),
                    const Text(
                      '문의내용',
                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                    ),
                    const SizedBox(height: 8),
                    SizedBox(
                      height: 200,
                      child: TextFormField(
                        controller: _contentController,
                        maxLines: 10,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          contentPadding: const EdgeInsets.all(12),
                          hintText: '고객센터 > 자주 묻는 질문에서 궁금한 내용에 대한\n'
                              '답을 찾지 못하셨다면, 1:1 문의하기에 남겨주세요.\n'
                              '자세한 내용과 함께 캡쳐본을 전달해주시면 더욱\n'
                              '빠르게 답변드릴 수 있습니다.',
                          hintStyle: TextStyle(color: Colors.grey, fontSize: 14),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Color(0xff6bbe45), width: 2.0), // 포커스 시 테두리 색상 및 두께
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Color(0xffc2c2c2), width: 1.0), // 비포커스 상태에서의 테두리 색상 및 두께
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 15),

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
                    const SizedBox(height: 20),
                  ],
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 20),
            child: Row(
              children: [
                Expanded(
                  child: SizedBox(
                    height: 50,
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Color(0xffEEEEEE),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(3), // 둥근 모서리
                        ),
                        elevation: 0, // 그림자 제거
                      ),
                      child: const Text(
                        '취소',
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 16,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: SizedBox(
                    height: 50,
                    child: ElevatedButton(
                      onPressed: () {
                        // 등록 버튼 클릭 시의 동작
                        // 예를 들어, 폼 제출 로직을 여기에 추가

                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return Dialog(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 16),
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Text(
                                      '등록이 완료되었습니다.',
                                      style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold,
                                      ),
                                      textAlign: TextAlign.center,
                                    ),
                                    SizedBox(height: 5),
                                    Text(
                                      '확인버튼을 누르면\n이전 페이지로 이동합니다.',
                                      style: TextStyle(fontSize: 16, color: Colors.grey),
                                      textAlign: TextAlign.center,
                                    ),
                                    SizedBox(height: 24),
                                    Align(
                                      alignment: Alignment.center,
                                      child: ElevatedButton(
                                        style: ElevatedButton.styleFrom(
                                          backgroundColor: Colors.black,
                                          padding: EdgeInsets.symmetric(vertical: 10, horizontal: 32),
                                          shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(8),
                                          ),
                                        ),
                                        child: Container(
                                          width: MediaQuery.of(context).size.width * 0.5,
                                          child: Text(
                                            '확인',
                                            style: TextStyle(
                                              fontSize: 18,
                                              color: Colors.white,
                                            ),
                                            textAlign: TextAlign.center,
                                          ),
                                        ),

                                        onPressed: () {
                                          Navigator.pop(context);
                                          Navigator.pushReplacement(
                                            context,
                                            MaterialPageRoute(builder: (context) => InqurityDetails()),
                                          );
                                        },
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xff6bbe45),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(3),
                        ),
                        elevation: 0, // 그림자 제거
                      ),
                      child: const Text(
                        '등록',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
