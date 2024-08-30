import 'package:flutter/material.dart';

void showPlantRegistrationModal(BuildContext context) {
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
                        SizedBox(height: 20),
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
                              icon: Icons.camera_alt_outlined,
                              label: '사진 촬영',
                              onPressed: () {},
                            ),

                            Container(
                              width: 1,
                              height: 50,
                              color: Color(0xffc2c2c2),
                            ),

                            _buildImageButton(
                              icon: Icons.photo_library_outlined,
                              label: '앨범에서 선택',
                              onPressed: () {},
                            ),
                          ],
                        ),

                        SizedBox(height: 20),

                        Padding(
                          padding: const EdgeInsets.all(16),
                          child: _buildTextField(label: '식물 이름', hintText: '파키라'),
                        ),
                        SizedBox(height: 10),

                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16.0),
                          child: _buildDatePicker(context, label: '마지막 물준날'),
                        ),
                        SizedBox(height: 24),

                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16.0),
                          child: _buildDatePicker(context, label: '마지막 영양제'),
                        ),
                        SizedBox(height: 24),

                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16.0),
                          child: _buildDatePicker(context, label: '마지막 분갈이'),
                        ),
                        SizedBox(height: 24),

                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16.0),
                          child: _buildDatePicker(context, label: '마지막 가지치기'),
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
                      SizedBox(width: 16), // 버튼 사이의 간격
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
        ),
      );
    },
  );
}

Widget _buildImageButton({
  required IconData icon,
  required String label,
  required VoidCallback onPressed,
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
          style: TextStyle(color: Color(0xff333333)),
        ),
        style: TextButton.styleFrom(
          padding: EdgeInsets.symmetric(vertical: 10),
        ),
      ),
    ),
  );
}

Widget _buildTextField({required String label, required String hintText}) {
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
        decoration: InputDecoration(
          hintText: hintText,
          border: OutlineInputBorder(),
          contentPadding: EdgeInsets.symmetric(horizontal: 12.0, vertical: 10.0),
        ),
      ),
    ],
  );
}

Widget _buildDatePicker(BuildContext context, {required String label}) {
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
        onTap: () async {
          DateTime? pickedDate = await showDatePicker(
            context: context,
            initialDate: DateTime.now(),
            firstDate: DateTime(2000),
            lastDate: DateTime(2101),
          );
          if (pickedDate != null) {
            dateController.text = "${pickedDate.toLocal()}".split(' ')[0];
          }
        },
        child: AbsorbPointer(
          child: TextField(
            controller: dateController,
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
