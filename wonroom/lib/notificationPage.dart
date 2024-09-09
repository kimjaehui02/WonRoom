// import 'package:flutter/material.dart';
//
//
// class NotificationPage extends StatelessWidget {
//   const NotificationPage({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         centerTitle: true,
//         title: Text('알림 목록', style: TextStyle(color: Colors.black)),
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
//       body: Container(
//         child: Column(
//           children: [
//             SizedBox(height: 3,),
//             Container(
//               padding: EdgeInsets.all(16),
//               width: MediaQuery.of(context).size.width,
//               decoration: BoxDecoration(
//                 color: Colors.white,
//                 boxShadow: [
//                   BoxShadow(
//                     color: Colors.black.withOpacity(0.08), // 더 연한 그림자
//                     blurRadius: 10,
//                   ),
//                 ],
//               ),
//               child: RichText(
//                 text: TextSpan(
//                   text: '수신거부  |  마이페이지  >  내 정보 수정 \n',
//                   style: TextStyle(
//                     color: Color(0xffc2c2c2),
//                     height: 1.5,
//                     fontSize: 14,
//                   ),
//                   children: [
//                     TextSpan(text: '알림은 최대 30일 까지만 보여집니다.',
//                         style: TextStyle(color: Color(0xff787878),)
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//
//             SizedBox(height: 10,),
//
//             // 내역
//             Padding(
//               padding: const EdgeInsets.all(16),
//               child: Column(
//                 children: [
//                   Container(
//                     padding: EdgeInsets.all(16),
//                     margin: EdgeInsets.only(bottom: 10),
//                     width: double.infinity,
//                     decoration: BoxDecoration(
//                       borderRadius: BorderRadius.circular(8),
//                       color: Color(0xfff7f7f7),
//                     ),
//                     child: Row(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         Container(
//                           width: MediaQuery.of(context).size.width * 0.12,
//                           height: MediaQuery.of(context).size.width * 0.12,
//                           decoration: BoxDecoration(
//                             color: Colors.blueAccent,
//                             borderRadius: BorderRadius.circular(50),
//                             border: Border.all(
//                               color: Color(0xffc2c2c2),
//                               width: 1,
//                             ),
//                             image: DecorationImage(
//                               image: AssetImage('images/plant_0.jpg'),
//                               fit: BoxFit.cover,
//                             ),
//                           ),
//                         ),
//
//                         SizedBox(width: 10),
//
//                         Expanded(
//                           child: Column(
//                             crossAxisAlignment: CrossAxisAlignment.start,
//                             children: [
//                               Row(
//                                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                                 children: [
//                                   Text(
//                                     '커뮤니티',
//                                     style: TextStyle(
//                                       color: Color(0xff86b26a),
//                                       fontSize: 14,
//                                       fontWeight: FontWeight.bold,
//                                     ),
//                                   ),
//                                   Text(
//                                     '2일전',
//                                     style: TextStyle(
//                                       color: Colors.grey,
//                                       fontSize: 14,
//                                     ),
//                                   ),
//                                 ],
//                               ),
//
//                               SizedBox(height: 2),
//
//                               Text(
//                                 '치코님이 원룸님 게시글에 댓글을 남겼어요.',
//                                 style: TextStyle(
//                                   color: Color(0xff595959),
//                                   fontSize: 14,
//                                 ),
//                               ),
//                             ],
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//
//             // 비어있는 경우 안내 메시지
//             // Expanded(
//             //   child: Center(
//             //     child: Column(
//             //       // mainAxisAlignment: MainAxisAlignment.center,
//             //       children: [
//             //         SizedBox(height: 250,),
//             //         ImageIcon(AssetImage('images/info.png'),
//             //           size: 50,
//             //           color: Color(0xffeeeeee),
//             //         ),
//             //         SizedBox(height: 10,),
//             //         Text(
//             //           '알림 내역이 없습니다. \n곧 좋은 소식 정보 알려드릴게요!',
//             //           textAlign: TextAlign.center,
//             //           style: TextStyle(
//             //             color: Color(0xffc2c2c2),
//             //             fontSize: 14,
//             //           ),
//             //         ),
//             //       ],
//             //     ),
//             //   ),
//             // ),
//           ],
//         ),
//       ),
//     );
//   }
// }


import 'package:flutter/material.dart';
import 'package:wonroom/NotificationItem/NotificationItem.dart';
import 'package:wonroom/Flask/Notifications.dart';
import 'package:wonroom/Flask/storage_manager.dart';
import 'package:wonroom/notificationNulll.dart';

class NotificationPage extends StatefulWidget {
  const NotificationPage({super.key});

  @override
  _NotificationPageState createState() => _NotificationPageState();
}

class _NotificationPageState extends State<NotificationPage> {
  Future<List<Notifications>>? _notificationsFuture;

  @override
  void initState() {
    super.initState();
    _notificationsFuture = _fetchNotifications();
  }

  Future<List<Notifications>> _fetchNotifications() async {
    final storageManager = StorageManager();
    final notifications = await storageManager.readNotifications();
    return notifications ?? []; // null일 경우 빈 리스트 반환
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const NotificationAppBar(),
      body: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(16),
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.08),
                  blurRadius: 10,
                ),
              ],
            ),
            child: RichText(
              text: const TextSpan(
                text: '수신거부  |  마이페이지  >  내 정보 수정 \n',
                style: TextStyle(
                  color: Color(0xffc2c2c2),
                  height: 1.5,
                  fontSize: 14,
                ),
                children: [
                  TextSpan(
                    text: '알림은 최대 30일 까지만 보여집니다.',
                    style: TextStyle(color: Color(0xff787878)),
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            child: FutureBuilder<List<Notifications>>(
              future: _notificationsFuture,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Center(child: Text('알림을 불러오는 중 오류가 발생했습니다.'));
                } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                  return const NotificationNull();
                } else {
                  final notifications = snapshot.data!;
                  return ListView.builder(
                    padding: const EdgeInsets.all(16),
                    itemCount: notifications.length,
                    itemBuilder: (context, index) {
                      final notification = notifications[index];
                      return NotificationItem(
                        category: notification.category,
                        timeAgo: notification.timeAgo,
                        message: notification.message,
                        imagePath: notification.imagePath,
                      );
                    },
                  );
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}

