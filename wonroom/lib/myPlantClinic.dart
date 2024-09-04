import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

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
          SizedBox(height: 3,),
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
                text: '수신거부  |  마이페이지  >  내 정보 수정 \n',
                style: TextStyle(
                  color: Color(0xffc2c2c2),
                  height: 1.5,
                  fontSize: 14,
                ),
                children: [
                  TextSpan(text: '알림은 최대 30일 까지만 보여집니다.',
                      style: TextStyle(color: Color(0xff787878),)
                  ),
                ],
              ),
            ),
          ),

          SizedBox(height: 10,),

          Container(
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
                        image: AssetImage('images/img01.jpg'),
                      ),
                    ),
                  ),

                  SizedBox(width: 24,),

                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 3),
                        child: Text('24.08.12',
                            style: TextStyle(fontSize: 14, color: Color(0xff787878)
                            )
                        ),
                      ),

                      Text('시들음병',
                        style: TextStyle(
                            fontSize: 20,
                            color: Color(0xff595959),
                            fontWeight: FontWeight.bold
                        ),
                      ),
                    ],
                  ),

                  Spacer(),

                  // ElevatedButton(onPressed: (){},
                  //     child: Text('치료요망', style: TextStyle(
                  //         color: Colors.white,
                  //         fontSize: 14,
                  //       fontWeight: FontWeight.bold
                  //     ),),
                  //   style: ElevatedButton.styleFrom(
                  //     backgroundColor: Color(0xfffc5230),
                  //     elevation: 0,
                  //     // minimumSize: Size(80, 32),
                  //   ),
                  // ),

                  // 치료 완료 -> 치료요망 버튼 눌렀을 시
                  ElevatedButton(onPressed: null,
                    child: Text('치료완료', style: TextStyle(
                        color: Colors.white,
                        fontSize: 14,
                        fontWeight: FontWeight.bold
                    ),),
                    style: ElevatedButton.styleFrom(
                      // backgroundColor: Color(0xff6fb348),
                      // elevation: 0
                      disabledBackgroundColor: Color(0xff6fb348),
                      disabledForegroundColor: Colors.white,
                      // minimumSize: Size(80, 32),
                    ),
                  )
                ],
              ),
            ),
            // padding: EdgeInsets.only(bottom: 10),
            decoration: BoxDecoration(
              border: Border(
                bottom: BorderSide(
                  color: Color(0xffeeeeee),
                  width: 1,
                ),
              ),
            ),
          ),

          Container(
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
                        image: AssetImage('images/img01.jpg'),
                      ),
                    ),
                  ),

                  SizedBox(width: 24,),

                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 3),
                        child: Text('24.08.12',
                            style: TextStyle(fontSize: 14, color: Color(0xff787878)
                            )
                        ),
                      ),

                      Text('시들음병',
                        style: TextStyle(
                            fontSize: 20,
                            color: Color(0xff595959),
                            fontWeight: FontWeight.bold
                        ),
                      ),
                    ],
                  ),

                  Spacer(),

                  ElevatedButton(onPressed: (){},
                    child: Text('치료요망', style: TextStyle(
                        color: Colors.white,
                        fontSize: 14,
                        fontWeight: FontWeight.bold
                    ),),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color(0xfffc5230),
                      elevation: 0,
                      // minimumSize: Size(80, 32),
                    ),
                  ),

                  // 치료 완료 -> 치료요망 버튼 눌렀을 시
                  // ElevatedButton(onPressed: null,
                  //   child: Text('치료완료', style: TextStyle(
                  //       color: Colors.white,
                  //       fontSize: 14,
                  //       fontWeight: FontWeight.bold
                  //   ),),
                  //   style: ElevatedButton.styleFrom(
                  //     // backgroundColor: Color(0xff6fb348),
                  //     // elevation: 0
                  //     disabledBackgroundColor: Color(0xff6fb348),
                  //     disabledForegroundColor: Colors.white,
                  //     // minimumSize: Size(80, 32),
                  //   ),
                  // )
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
          ),



        ],
      ),


      // body: Padding(
      //   padding: const EdgeInsets.all(16),
      //   child: Column(
      //     children: [
      //       Container(
      //         child: Row(
      //           children: [
      //             Container(
      //               width: MediaQuery.of(context).size.width * 0.2,
      //               height: MediaQuery.of(context).size.width * 0.2,
      //               decoration: BoxDecoration(
      //                 borderRadius: BorderRadius.circular(10),
      //                 image: DecorationImage(
      //                   fit: BoxFit.fill,
      //                   image: AssetImage('images/img01.jpg'),
      //                 ),
      //               ),
      //             ),
      //
      //             SizedBox(width: 24,),
      //
      //             Column(
      //               crossAxisAlignment: CrossAxisAlignment.start,
      //               children: [
      //                 Padding(
      //                   padding: const EdgeInsets.only(left: 3),
      //                   child: Text('24.08.12',
      //                       style: TextStyle(fontSize: 14, color: Color(0xff787878)
      //                       )
      //                   ),
      //                 ),
      //
      //                 Text('시들음병',
      //                     style: TextStyle(
      //                         fontSize: 20,
      //                         color: Color(0xff595959),
      //                         fontWeight: FontWeight.bold
      //                     ),
      //                 ),
      //               ],
      //             ),
      //
      //             Spacer(),
      //
      //             ElevatedButton(onPressed: (){},
      //                 child: Text('치료요망', style: TextStyle(
      //                     color: Colors.white,
      //                     fontSize: 14,
      //                   fontWeight: FontWeight.bold
      //                 ),),
      //               style: ElevatedButton.styleFrom(
      //                 backgroundColor: Color(0xfffc5230),
      //                 elevation: 0,
      //                 // minimumSize: Size(80, 32),
      //               ),
      //             ),
      //
      //             // 치료 완료 -> 치료요망 버튼 눌렀을 시
      //             // ElevatedButton(onPressed: null,
      //             //   child: Text('치료완료', style: TextStyle(
      //             //       color: Colors.white,
      //             //       fontSize: 14,
      //             //       fontWeight: FontWeight.bold
      //             //   ),),
      //             //   style: ElevatedButton.styleFrom(
      //             //     // backgroundColor: Color(0xff6fb348),
      //             //     // elevation: 0
      //             //     disabledBackgroundColor: Color(0xff6fb348),
      //             //     disabledForegroundColor: Colors.white,
      //             //     // minimumSize: Size(80, 32),
      //             //   ),
      //             // )
      //           ],
      //         ),
      //         padding: EdgeInsets.only(bottom: 10),
      //         decoration: BoxDecoration(
      //           border: Border(
      //             bottom: BorderSide(
      //               color: Color(0xffeeeeee),
      //               width: 1,
      //             ),
      //           ),
      //         ),
      //       ),
      //
      //     ],
      //   ),
      // ),
    );
  }
}