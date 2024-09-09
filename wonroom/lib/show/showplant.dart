//
// import 'package:flutter/material.dart';
//
// class asdd extends StatefulWidget {
//   const asdd({super.key});
//
//   @override
//   State<asdd> createState() => _asddState();
// }
//
// class _asddState extends State<asdd> {
//   @override
//   Widget build(BuildContext context) {
//     return const Placeholder(
//       child: DraggableScrollableSheet(
//         expand: false,
//         initialChildSize: 0.85,
//         maxChildSize: 0.9,
//         minChildSize: 0.5,
//         builder: (BuildContext context, ScrollController scrollController) {
//           return StatefulBuilder(
//             builder: (BuildContext context, StateSetter setState) {
//               String _plantName = '';
//               bool _isUploading = false;
//
//               Future<void> _uploadImage(File image) async {
//                 setState(() {
//                   _isUploading = true;
//                   _plantNameController.text = "검색중입니다..."; // 검색중일 때 표시
//                 });
//
//                 try {
//                   final imageBytes = await image.readAsBytes();
//                   final base64Image = base64Encode(imageBytes);
//
//                   // 서버로 이미지를 전송하여 텍스트(식물 이름)를 받아옴
//                   final response = await http.post(
//                     Uri.parse('https://2f60-34-23-46-115.ngrok-free.app/plant_register'),
//                     headers: {'Content-Type': 'application/json'},
//                     body: json.encode({'image': base64Image}),
//                   );
//
//                   if (response.statusCode == 200) {
//                     final data = json.decode(response.body);
//                     print('서버 응답: $data');
//
//                     // 서버에서 받아온 텍스트 확인 후 적용하는 다이얼로그 호출
//                     _showConfirmationDialog(
//                         context, data['plant_name'], setState); // setState 추가
//                   } else {
//                     print('API 호출 오류: ${response.statusCode}');
//                   }
//                 } catch (e) {
//                   print('API 호출 중 오류 발생: $e');
//                 } finally {
//                   setState(() {
//                     _isUploading = false;
//                   });
//                 }
//               }
//
//               Future<void> _pickImage(ImageSource source) async {
//                 final pickedFile = await picker.pickImage(source: source);
//                 if (pickedFile != null) {
//                   final selectedImage = File(pickedFile.path);
//                   setState(() {
//                     _image = selectedImage; // 이미지를 표시하기 위해 설정
//                   });
//                   await _uploadImage(selectedImage); // 이미지를 서버로 전송
//                 }
//               }
//
//               return Column(
//                 children: [
//                   Expanded(
//                     child: SingleChildScrollView(
//                       controller: scrollController,
//                       child: Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           Center(
//                             child: Container(
//                               width: 60,
//                               height: 5,
//                               decoration: BoxDecoration(
//                                 color: Colors.grey[300],
//                                 borderRadius: BorderRadius.circular(10),
//                               ),
//                             ),
//                           ),
//                           SizedBox(height: 16),
//                           Center(
//                             child: Text(
//                               '식물 등록',
//                               style: TextStyle(
//                                 fontSize: 20,
//                                 fontWeight: FontWeight.bold,
//                               ),
//                             ),
//                           ),
//                           SizedBox(height: 20),
//                           Row(
//                             mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                             children: [
//                               _buildImageButton(
//                                 icon: Icons.camera_alt,
//                                 label: '사진촬영',
//                                 onPressed: _isUploading
//                                     ? null
//                                     : () => _pickImage(ImageSource.camera),
//                               ),
//                               _buildImageButton(
//                                 icon: Icons.photo_library,
//                                 label: '앨범에서 선택',
//                                 onPressed: _isUploading
//                                     ? null
//                                     : () => _pickImage(ImageSource.gallery),
//                               ),
//                             ],
//                           ),
//                           SizedBox(height: 20),
//                           if (_isUploading)
//                             Center(child: CircularProgressIndicator()),
//                           if (_image != null && !_isUploading) ...[
//                             Center(
//                               child: Stack(
//                                 children: [
//                                   Container(
//                                     width: 200,
//                                     height: 200,
//                                     decoration: BoxDecoration(
//                                       borderRadius: BorderRadius.circular(10),
//                                       image: DecorationImage(
//                                         image: FileImage(_image!),
//                                         fit: BoxFit.cover,
//                                       ),
//                                     ),
//                                   ),
//                                   Positioned(
//                                     right: 0,
//                                     top: 0,
//                                     child: IconButton(
//                                       icon: Icon(Icons.close, color: Colors.red),
//                                       onPressed: () {
//                                         setState(() {
//                                           _image = null;
//                                           _plantName = '';
//                                           _plantNameController.clear();
//                                           _showImageInField = false; // 이미지 표시 플래그 초기화
//                                         });
//                                       },
//                                     ),
//                                   ),
//                                 ],
//                               ),
//                             ),
//                             SizedBox(height: 20),
//                           ],
//                           Padding(
//                             padding: const EdgeInsets.symmetric(horizontal: 16.0),
//                             child: _buildTextField(
//                               controller: _plantNameController,
//                               hintText: '', // 힌트 텍스트를 제거하고 서버에서 받아온 텍스트 사용
//                               label: '식물 이름',
//                               enabled: !_isUploading,
//                             ),
//                           ),
//                           SizedBox(height: 20),
//                           Padding(
//                             padding: const EdgeInsets.symmetric(horizontal: 16.0),
//                             child: GestureDetector(
//                               onTap: () => _pickDate(context, _lastWateredController),
//                               child: AbsorbPointer(
//                                 child: _buildTextField(
//                                   controller: _lastWateredController,
//                                   hintText: '날짜를 선택하세요',
//                                   label: '마지막 물준날',
//                                   enabled: !_isUploading,
//                                 ),
//                               ),
//                             ),
//                           ),
//                           SizedBox(height: 20),
//                           Padding(
//                             padding: const EdgeInsets.symmetric(horizontal: 16.0),
//                             child: GestureDetector(
//                               onTap: () => _pickDate(context, _lastFertilizedController),
//                               child: AbsorbPointer(
//                                 child: _buildTextField(
//                                   controller: _lastFertilizedController,
//                                   hintText: '날짜를 선택하세요',
//                                   label: '마지막 영양제',
//                                   enabled: !_isUploading,
//                                 ),
//                               ),
//                             ),
//                           ),
//                           SizedBox(height: 20),
//                           Padding(
//                             padding: const EdgeInsets.symmetric(horizontal: 16.0),
//                             child: GestureDetector(
//                               onTap: () => _pickDate(context, _lastRepottedController),
//                               child: AbsorbPointer(
//                                 child: _buildTextField(
//                                   controller: _lastRepottedController,
//                                   hintText: '날짜를 선택하세요',
//                                   label: '마지막 분갈이',
//                                   enabled: !_isUploading,
//                                 ),
//                               ),
//                             ),
//                           ),
//                           SizedBox(height: 24),
//                           Padding(
//                             padding: const EdgeInsets.symmetric(horizontal: 16.0),
//                             child: GestureDetector(
//                               onTap: () => _pickDate(context, _lastPrunedController),
//                               child: AbsorbPointer(
//                                 child: _buildTextField(
//                                   controller: _lastPrunedController,
//                                   hintText: '날짜를 선택하세요',
//                                   label: '마지막 가지치기',
//                                   enabled: !_isUploading,
//                                 ),
//                               ),
//                             ),
//                           ),
//                           SizedBox(height: 24),
//                         ],
//                       ),
//                     ),
//                   ),
//                   Padding(
//                     padding: const EdgeInsets.all(16.0),
//                     child: Row(
//                       mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                       children: [
//                         Expanded(
//                           child: OutlinedButton(
//                             onPressed: () {
//                               Navigator.pop(context);
//                             },
//                             child: Text('취소', style: TextStyle(fontSize: 25)),
//                             style: OutlinedButton.styleFrom(
//                               foregroundColor: Colors.grey,
//                               backgroundColor: Colors.white,
//                               shape: RoundedRectangleBorder(
//                                 borderRadius: BorderRadius.circular(10),
//                               ),
//                               side: BorderSide(color: Colors.grey),
//                               minimumSize: Size(150, 50),
//                             ),
//                           ),
//                         ),
//                         SizedBox(width: 16),
//                         Expanded(
//                           child: ElevatedButton(
//                             onPressed: () {
//                               // 저장 또는 처리하는 코드 추가
//                             },
//                             child: Text('등록',
//                                 style: TextStyle(
//                                     fontSize: 25, color: Colors.white)),
//                             style: ElevatedButton.styleFrom(
//                               backgroundColor: Colors.green,
//                               shape: RoundedRectangleBorder(
//                                 borderRadius: BorderRadius.circular(10),
//                               ),
//                               minimumSize: Size(150, 50),
//                             ),
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                 ],
//               );
//             },
//           );
//         },
//       ),
//     );
//   }
// }
//
