// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:wonroom/plantClinicChat.dart';
//
// class MyPlantClinic extends StatelessWidget {
//   const MyPlantClinic({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         centerTitle: true,
//         title: Text('진단 기록', style: TextStyle(color: Colors.black)),
//         backgroundColor: Colors.white,
//         elevation: 0,
//         leading: IconButton(
//           icon: Icon(
//             Icons.arrow_back_ios,
//             color: Colors.grey,
//           ),
//           onPressed: () {
//             Navigator.pop(context);
//           },
//         ),
//       ),
//       body: Column(
//         children: [
//           SizedBox(
//             height: 3,
//           ),
//           Container(
//             padding: EdgeInsets.all(16),
//             width: MediaQuery.of(context).size.width,
//             decoration: BoxDecoration(
//               color: Colors.white,
//               boxShadow: [
//                 BoxShadow(
//                   color: Colors.black.withOpacity(0.08), // 더 연한 그림자
//                   blurRadius: 10,
//                 ),
//               ],
//             ),
//             child: RichText(
//               text: TextSpan(
//                 text: '내역은 최신순으로 정렬됩니다.\n',
//                 style: TextStyle(
//                   color: Color(0xffc2c2c2),
//                   height: 1.5,
//                   fontSize: 14,
//                 ),
//                 children: [
//                   TextSpan(
//                       text: '치료 완료 시 \'치료요망\'을 눌러주세요.',
//                       style: TextStyle(
//                         color: Color(0xff787878),
//                       )),
//                 ],
//               ),
//             ),
//           ),
//
//           SizedBox(
//             height: 10,
//           ),
//
//           Container(
//             child: Padding(
//               padding: const EdgeInsets.all(16),
//               child: Row(
//                 children: [
//                   Container(
//                     width: MediaQuery.of(context).size.width * 0.2,
//                     height: MediaQuery.of(context).size.width * 0.2,
//                     decoration: BoxDecoration(
//                       borderRadius: BorderRadius.circular(10),
//                       image: DecorationImage(
//                         fit: BoxFit.fill,
//                         image: AssetImage('images/img01.jpg'),
//                       ),
//                     ),
//                   ),
//
//                   SizedBox(
//                     width: 24,
//                   ),
//
//                   Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       Padding(
//                         padding: const EdgeInsets.only(left: 3),
//                         child: Text('24.08.12',
//                             style: TextStyle(
//                                 fontSize: 14, color: Color(0xff787878))),
//                       ),
//                       Text(
//                         '시들음병',
//                         style: TextStyle(
//                             fontSize: 20,
//                             color: Color(0xff595959),
//                             fontWeight: FontWeight.bold),
//                       ),
//                     ],
//                   ),
//
//                   Spacer(),
//
//                   // ElevatedButton(onPressed: (){},
//                   //     child: Text('치료요망', style: TextStyle(
//                   //         color: Colors.white,
//                   //         fontSize: 14,
//                   //       fontWeight: FontWeight.bold
//                   //     ),),
//                   //   style: ElevatedButton.styleFrom(
//                   //     backgroundColor: Color(0xfffc5230),
//                   //     elevation: 0,
//                   //     // minimumSize: Size(80, 32),
//                   //   ),
//                   // ),
//
//                   // 치료 완료 -> 치료요망 버튼 눌렀을 시
//                   ElevatedButton(
//                     onPressed: null,
//                     child: Text(
//                       '치료완료',
//                       style: TextStyle(
//                           color: Colors.white,
//                           fontSize: 14,
//                           fontWeight: FontWeight.bold),
//                     ),
//                     style: ElevatedButton.styleFrom(
//                       // backgroundColor: Color(0xff6fb348),
//                       // elevation: 0
//                       disabledBackgroundColor: Color(0xff6fb348),
//                       disabledForegroundColor: Colors.white,
//                       // minimumSize: Size(80, 32),
//                     ),
//                   )
//                 ],
//               ),
//             ),
//             // padding: EdgeInsets.only(bottom: 10),
//             decoration: BoxDecoration(
//               border: Border(
//                 bottom: BorderSide(
//                   color: Color(0xffeeeeee),
//                   width: 1,
//                 ),
//               ),
//             ),
//           ),
//
//           Container(
//             child: Padding(
//               padding: const EdgeInsets.all(16),
//               child: Row(
//                 children: [
//                   Container(
//                     width: MediaQuery.of(context).size.width * 0.2,
//                     height: MediaQuery.of(context).size.width * 0.2,
//                     decoration: BoxDecoration(
//                       borderRadius: BorderRadius.circular(10),
//                       image: DecorationImage(
//                         fit: BoxFit.fill,
//                         image: AssetImage('images/img01.jpg'),
//                       ),
//                     ),
//                   ),
//
//                   SizedBox(
//                     width: 24,
//                   ),
//
//                   Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       Padding(
//                         padding: const EdgeInsets.only(left: 3),
//                         child: Text(
//                           '24.08.12',
//                           style: TextStyle(
//                             fontSize: 14,
//                             color: Color(0xff787878),
//                           ),
//                         ),
//                       ),
//                       // GestureDetector로 감싸서 클릭 가능하게 만듦
//                       GestureDetector(
//                         onTap: () {
//                           // 클릭 시 PlantClinicChat 페이지로 이동하면서 병 이름 전달
//                           Navigator.push(
//                             context,
//                             MaterialPageRoute(
//                               builder: (context) => PlantClinicChat(
//                                 diseaseName: '시들음병', // 넘길 병 이름
//                               ),
//                             ),
//                           );
//                         },
//                         child: Text(
//                           '시들들음병',
//                           style: TextStyle(
//                             fontSize: 20,
//                             color: Color(0xff595959),
//                             fontWeight: FontWeight.bold,
//                           ),
//                         ),
//                       ),
//                     ],
//                   ),
//
//                   Spacer(),
//
//                   // ElevatedButton(onPressed: (){},
//                   //     child: Text('치료요망', style: TextStyle(
//                   //         color: Colors.white,
//                   //         fontSize: 14,
//                   //       fontWeight: FontWeight.bold
//                   //     ),),
//                   //   style: ElevatedButton.styleFrom(
//                   //     backgroundColor: Color(0xfffc5230),
//                   //     elevation: 0,
//                   //     // minimumSize: Size(80, 32),
//                   //   ),
//                   // ),
//
//                   // 치료 완료 -> 치료요망 버튼 눌렀을 시
//                   ElevatedButton(
//                     onPressed: null,
//                     child: Text(
//                       '치료완료',
//                       style: TextStyle(
//                           color: Colors.white,
//                           fontSize: 14,
//                           fontWeight: FontWeight.bold),
//                     ),
//                     style: ElevatedButton.styleFrom(
//                       // backgroundColor: Color(0xff6fb348),
//                       // elevation: 0
//                       disabledBackgroundColor: Color(0xff6fb348),
//                       disabledForegroundColor: Colors.white,
//                       // minimumSize: Size(80, 32),
//                     ),
//                   )
//                 ],
//               ),
//             ),
//             // padding: EdgeInsets.only(bottom: 10),
//             decoration: BoxDecoration(
//               border: Border(
//                 bottom: BorderSide(
//                   color: Color(0xffeeeeee),
//                   width: 1,
//                 ),
//               ),
//             ),
//           ),
//
//           Container(
//             child: Padding(
//               padding: const EdgeInsets.all(16),
//               child: Row(
//                 children: [
//                   Container(
//                     width: MediaQuery.of(context).size.width * 0.2,
//                     height: MediaQuery.of(context).size.width * 0.2,
//                     decoration: BoxDecoration(
//                       borderRadius: BorderRadius.circular(10),
//                       image: DecorationImage(
//                         fit: BoxFit.fill,
//                         image: AssetImage('images/img01.jpg'),
//                       ),
//                     ),
//                   ),
//
//                   SizedBox(
//                     width: 24,
//                   ),
//
//                   Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       Padding(
//                         padding: const EdgeInsets.only(left: 3),
//                         child: Text('24.08.12',
//                             style: TextStyle(
//                                 fontSize: 14, color: Color(0xff787878))),
//                       ),
//                       Text(
//                         '시들음병',
//                         style: TextStyle(
//                             fontSize: 20,
//                             color: Color(0xff595959),
//                             fontWeight: FontWeight.bold),
//                       ),
//                     ],
//                   ),
//
//                   Spacer(),
//
//                   ElevatedButton(
//                     onPressed: () {},
//                     child: Text(
//                       '치료요망',
//                       style: TextStyle(
//                           color: Colors.white,
//                           fontSize: 14,
//                           fontWeight: FontWeight.bold),
//                     ),
//                     style: ElevatedButton.styleFrom(
//                       backgroundColor: Color(0xfffc5230),
//                       elevation: 0,
//                       // minimumSize: Size(80, 32),
//                     ),
//                   ),
//
//                   // 치료 완료 -> 치료요망 버튼 눌렀을 시
//                   // ElevatedButton(onPressed: null,
//                   //   child: Text('치료완료', style: TextStyle(
//                   //       color: Colors.white,
//                   //       fontSize: 14,
//                   //       fontWeight: FontWeight.bold
//                   //   ),),
//                   //   style: ElevatedButton.styleFrom(
//                   //     // backgroundColor: Color(0xff6fb348),
//                   //     // elevation: 0
//                   //     disabledBackgroundColor: Color(0xff6fb348),
//                   //     disabledForegroundColor: Colors.white,
//                   //     // minimumSize: Size(80, 32),
//                   //   ),
//                   // )
//                 ],
//               ),
//             ),
//             decoration: BoxDecoration(
//               border: Border(
//                 bottom: BorderSide(
//                   color: Color(0xffeeeeee),
//                   width: 1,
//                 ),
//               ),
//             ),
//           ),
//
//           // 내역이 없는 경우 안내 메시지
//           // Expanded(
//           //   child: Center(
//           //     child: Column(
//           //       // mainAxisAlignment: MainAxisAlignment.center,
//           //       children: [
//           //         SizedBox(height: 250,),
//           //         ImageIcon(AssetImage('images/info.png'),
//           //           size: 50,
//           //           color: Color(0xffeeeeee),
//           //         ),
//           //         SizedBox(height: 10,),
//           //         Text(
//           //           '진단 내역이 없습니다.\n식물을 찰영하여 식물의 건강을 확인해보세요.',
//           //           textAlign: TextAlign.center,
//           //           style: TextStyle(
//           //             color: Color(0xffc2c2c2),
//           //             fontSize: 14,
//           //           ),
//           //         ),
//           //       ],
//           //     ),
//           //   ),
//           // ),
//         ],
//       ),
//
//       // body: Padding(
//       //   padding: const EdgeInsets.all(16),
//       //   child: Column(
//       //     children: [
//       //       Container(
//       //         child: Row(
//       //           children: [
//       //             Container(
//       //               width: MediaQuery.of(context).size.width * 0.2,
//       //               height: MediaQuery.of(context).size.width * 0.2,
//       //               decoration: BoxDecoration(
//       //                 borderRadius: BorderRadius.circular(10),
//       //                 image: DecorationImage(
//       //                   fit: BoxFit.fill,
//       //                   image: AssetImage('images/img01.jpg'),
//       //                 ),
//       //               ),
//       //             ),
//       //
//       //             SizedBox(width: 24,),
//       //
//       //             Column(
//       //               crossAxisAlignment: CrossAxisAlignment.start,
//       //               children: [
//       //                 Padding(
//       //                   padding: const EdgeInsets.only(left: 3),
//       //                   child: Text('24.08.12',
//       //                       style: TextStyle(fontSize: 14, color: Color(0xff787878)
//       //                       )
//       //                   ),
//       //                 ),
//       //
//       //                 Text('시들음병',
//       //                     style: TextStyle(
//       //                         fontSize: 20,
//       //                         color: Color(0xff595959),
//       //                         fontWeight: FontWeight.bold
//       //                     ),
//       //                 ),
//       //               ],
//       //             ),
//       //
//       //             Spacer(),
//       //
//       //             ElevatedButton(onPressed: (){},
//       //                 child: Text('치료요망', style: TextStyle(
//       //                     color: Colors.white,
//       //                     fontSize: 14,
//       //                   fontWeight: FontWeight.bold
//       //                 ),),
//       //               style: ElevatedButton.styleFrom(
//       //                 backgroundColor: Color(0xfffc5230),
//       //                 elevation: 0,
//       //                 // minimumSize: Size(80, 32),
//       //               ),
//       //             ),
//       //
//       //             // 치료 완료 -> 치료요망 버튼 눌렀을 시
//       //             // ElevatedButton(onPressed: null,
//       //             //   child: Text('치료완료', style: TextStyle(
//       //             //       color: Colors.white,
//       //             //       fontSize: 14,
//       //             //       fontWeight: FontWeight.bold
//       //             //   ),),
//       //             //   style: ElevatedButton.styleFrom(
//       //             //     // backgroundColor: Color(0xff6fb348),
//       //             //     // elevation: 0
//       //             //     disabledBackgroundColor: Color(0xff6fb348),
//       //             //     disabledForegroundColor: Colors.white,
//       //             //     // minimumSize: Size(80, 32),
//       //             //   ),
//       //             // )
//       //           ],
//       //         ),
//       //         padding: EdgeInsets.only(bottom: 10),
//       //         decoration: BoxDecoration(
//       //           border: Border(
//       //             bottom: BorderSide(
//       //               color: Color(0xffeeeeee),
//       //               width: 1,
//       //             ),
//       //           ),
//       //         ),
//       //       ),
//       //
//       //     ],
//       //   ),
//       // ),
//     );
//   }
// }
//
//
// class DiseaseRecord extends StatelessWidget {
//   final String imagePath;
//   final String date;
//   final String diseaseName;
//   final bool isTreatmentCompleted;
//   final VoidCallback onTreatmentRequest;
//   final VoidCallback onTreatmentComplete;
//
//   const DiseaseRecord({
//     required this.imagePath,
//     required this.date,
//     required this.diseaseName,
//     required this.isTreatmentCompleted,
//     required this.onTreatmentRequest,
//     required this.onTreatmentComplete,
//     super.key,
//   });
//
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       child: Padding(
//         padding: const EdgeInsets.all(16),
//         child: Row(
//           children: [
//             Container(
//               width: MediaQuery.of(context).size.width * 0.2,
//               height: MediaQuery.of(context).size.width * 0.2,
//               decoration: BoxDecoration(
//                 borderRadius: BorderRadius.circular(10),
//                 image: DecorationImage(
//                   fit: BoxFit.fill,
//                   image: AssetImage(imagePath),
//                 ),
//               ),
//             ),
//             SizedBox(width: 24),
//             Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Padding(
//                   padding: const EdgeInsets.only(left: 3),
//                   child: Text(date,
//                       style: TextStyle(
//                           fontSize: 14, color: Color(0xff787878))),
//                 ),
//                 GestureDetector(
//                   onTap: () {
//                     // 클릭 시 PlantClinicChat 페이지로 이동하면서 병 이름 전달
//                     Navigator.push(
//                       context,
//                       MaterialPageRoute(
//                         builder: (context) => PlantClinicChat(
//                           diseaseName: diseaseName, // 넘길 병 이름
//                         ),
//                       ),
//                     );
//                   },
//                   child: Text(
//                     diseaseName,
//                     style: TextStyle(
//                       fontSize: 20,
//                       color: Color(0xff595959),
//                       fontWeight: FontWeight.bold,
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//             Spacer(),
//             ElevatedButton(
//               onPressed: isTreatmentCompleted ? null : onTreatmentRequest,
//               child: Text(
//                 '치료요망',
//                 style: TextStyle(
//                     color: Colors.white,
//                     fontSize: 14,
//                     fontWeight: FontWeight.bold),
//               ),
//               style: ElevatedButton.styleFrom(
//                 backgroundColor: Color(0xfffc5230),
//                 elevation: 0,
//               ),
//             ),
//             SizedBox(width: 8),
//             ElevatedButton(
//               onPressed: isTreatmentCompleted ? null : onTreatmentComplete,
//               child: Text(
//                 '치료완료',
//                 style: TextStyle(
//                     color: Colors.white,
//                     fontSize: 14,
//                     fontWeight: FontWeight.bold),
//               ),
//               style: ElevatedButton.styleFrom(
//                 disabledBackgroundColor: Color(0xff6fb348),
//                 disabledForegroundColor: Colors.white,
//               ),
//             ),
//           ],
//         ),
//       ),
//       decoration: BoxDecoration(
//         border: Border(
//           bottom: BorderSide(
//             color: Color(0xffeeeeee),
//             width: 1,
//           ),
//         ),
//       ),
//     );
//   }
// }


import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:wonroom/plantClinicChat.dart';

class MyPlantClinic extends StatelessWidget {
  const MyPlantClinic({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('진단 기록', style: TextStyle(color: Colors.black)),
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
      body: Column(
        children: [
          SizedBox(
            height: 3,
          ),
          Container(
            padding: EdgeInsets.all(16),
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.08), // 더 연한 그림자
                  blurRadius: 10,
                ),
              ],
            ),
            child: RichText(
              text: TextSpan(
                text: '내역은 최신순으로 정렬됩니다.\n',
                style: TextStyle(
                  color: Color(0xffc2c2c2),
                  height: 1.5,
                  fontSize: 14,
                ),
                children: [
                  TextSpan(
                      text: '치료 완료 시 \'치료요망\'을 눌러주세요.',
                      style: TextStyle(
                        color: Color(0xff787878),
                      )),
                ],
              ),
            ),
          ),
          SizedBox(
            height: 10,
          ),
          // 데이터 리스트 예시
          Expanded(
            child: ListView(
              children: [
                _buildRecordItem(context, '24.08.12', '시들음병', 'images/img01.jpg', true), // 예시: 치료 완료
                _buildRecordItem(context, '24.08.12', '시들음병', 'images/img01.jpg', false), // 예시: 치료 요망
                _buildRecordItem(context, '24.08.12', '시들음병', 'images/img01.jpg', false), // 예시: 치료 요망
                _buildRecordItem(context, '24.08.12', '시들음병', 'images/img01.jpg', false), // 예시: 치료 요망
                // 데이터가 없다면, 안내 메시지 표시
                // _buildNoDataMessage(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRecordItem(BuildContext context, String date, String disease, String imagePath, bool isTreatmentCompleted) {
    return Container(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            Container(
              width: MediaQuery.of(context).size.width * 0.2,
              height: MediaQuery.of(context).size.width * 0.2,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                image: DecorationImage(
                  fit: BoxFit.fill,
                  image: AssetImage(imagePath),
                ),
              ),
            ),
            SizedBox(
              width: 24,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 3),
                  child: Text(
                    date,
                    style: TextStyle(fontSize: 14, color: Color(0xff787878)),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => PlantClinicChat(
                          diseaseName: disease,
                        ),
                      ),
                    );
                  },
                  child: Text(
                    disease,
                    style: TextStyle(
                      fontSize: 20,
                      color: Color(0xff595959),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
            Spacer(),
            // 버튼을 조건에 따라 하나만 표시
            isTreatmentCompleted
                ? _buildActionButton('치료완료', Color(0xff6fb348), null)
                : _buildActionButton('치료요망', Color(0xfffc5230), () {}),
          ],
        ),
      ),
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: Color(0xffeeeeee),
            width: 1,
          ),
        ),
      ),
    );
  }

  Widget _buildActionButton(String text, Color color, VoidCallback? onPressed) {
    return ElevatedButton(
      onPressed: onPressed,
      child: Text(
        text,
        style: TextStyle(
          color: Colors.white,
          fontSize: 14,
          fontWeight: FontWeight.bold,
        ),
      ),
      style: ElevatedButton.styleFrom(
        backgroundColor: color,
        elevation: 0,
        minimumSize: Size(80, 32),
      ),
    );
  }

  Widget _buildNoDataMessage() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(height: 250),
          ImageIcon(
            AssetImage('images/info.png'),
            size: 50,
            color: Color(0xffeeeeee),
          ),
          SizedBox(height: 10),
          Text(
            '진단 내역이 없습니다.\n식물을 찰영하여 식물의 건강을 확인해보세요.',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Color(0xffc2c2c2),
              fontSize: 14,
            ),
          ),
        ],
      ),
    );
  }
}
