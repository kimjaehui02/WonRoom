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


import 'dart:async'; // Future 사용을 위해 추가
import 'dart:developer';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:wonroom/DB/plant_management_records/plant_management_model.dart';
import 'package:wonroom/DB/plant_management_records/plant_management_records_service.dart';
import 'package:wonroom/DB/user_plants/user_plants_model.dart';
import 'package:wonroom/DB/user_plants/user_plants_service.dart';
import 'package:wonroom/DB/users/user_service.dart';
import 'package:wonroom/plantClinicChat.dart';
import 'package:wonroom/Flask/storage_manager.dart'; // 경로에 맞게 수정

class MyPlantClinic extends StatefulWidget {
  const MyPlantClinic({super.key});

  @override
  _MyPlantClinicState createState() => _MyPlantClinicState();
}

class _MyPlantClinicState extends State<MyPlantClinic> {

  // 1. 유저정보를스토리지에서 받아오는 부분
  final StorageManager _SM = new StorageManager();

  // 2. 1번에서 받아온 유저id로 식물들의 정보를 받아오는 부분
  final UserPlantService _UPS = new UserPlantService();

  // 3. 2번에서 받아온 식물들의 식물id로 식물 일정들을 받아오는 부분이 필요해
  final PlantManagementService _PMS = new PlantManagementService();


  // 1. 유저정보를 저장하는 변수
  String UserId = "";

  // 2. 식물들의 리스트를 저장하는 변수
  List<UserPlant> ListOfUserPlant = [];

  // 3. 식물일정들의 리스트를 저장하는 변수
  List<List<PlantManagementRecord>> ListOfPlantManagementRecord = [];


  // 로딩중 여부를체크합니다
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadData();
  }


  Future<void> _loadData() async {
    setState(() {
      _isLoading = true; // 로딩 시작
    });

    final String? subid = await _SM.getUserId();
    setState(() {
      UserId = subid ?? "";
    });

    final List<UserPlant>? subUserPlant = await _UPS.getPlants(UserId);
    setState(() {
      ListOfUserPlant = subUserPlant ?? [];
      // ListOfPlantManagementRecord를 업데이트하기 위해 초기화
      ListOfPlantManagementRecord = List.generate(ListOfUserPlant.length, (index) => []);
    });

    for (int i = 0; i < ListOfUserPlant.length; i++) {
      final List<PlantManagementRecord>? subPlantManagementRecord =
      await _PMS.getRecords(ListOfUserPlant[i].plantId ?? -1);

      // 조건에 맞는 항목만 필터링하여 저장할 리스트
      final List<PlantManagementRecord> filteredRecords = subPlantManagementRecord?.where(
              (record) => record.managementType == 'Diagnosis' && record.details != '건강'
      ).toList() ?? [];

      // 필터링된 항목을 출력
      for (var record in filteredRecords) {
        print(record.details);
      }

      // 필터링된 항목으로 리스트 업데이트
      ListOfPlantManagementRecord[i] = filteredRecords;
    }


    setState(() {
      _isLoading = false; // 로딩 종료
    });
  }



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
      body: _isLoading
          ? Center(child: CircularProgressIndicator())
          : ListOfPlantManagementRecord.isEmpty
          ? _buildNoDataMessage()
          : ListView.builder(
        itemCount: ListOfPlantManagementRecord.length,
        itemBuilder: (context, index) {
          // final PlantManagementRecord record = ListOfPlantManagementRecord[index];
          // return _buildRecordItem(
          //   context,
            // record.getFormattedDate(),
            // record.details,
            // 'images/img01.jpg', // 예시 이미지 경로
            // false, // 예시 치료 완료 여부
          // );
        },
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
