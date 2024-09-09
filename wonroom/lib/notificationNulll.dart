import 'package:flutter/material.dart';
import 'package:wonroom/Flask/Notifications.dart';
import 'package:wonroom/Flask/storage_manager.dart';
import 'package:wonroom/notificationPage.dart';
import 'package:flutter/material.dart';
import 'package:wonroom/NotificationItem/NotificationItem.dart';

class NotificationAppBar extends StatelessWidget implements PreferredSizeWidget {
  const NotificationAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      centerTitle: true,
      title: const Text('알림 목록', style: TextStyle(color: Colors.black)),
      backgroundColor: Colors.white,
      elevation: 0,
      leading: IconButton(
        icon: const Icon(Icons.arrow_back_ios, color: Colors.grey),
        onPressed: () {
          Navigator.pop(context);
        },
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

class EmptyNotificationMessage extends StatelessWidget {
  const EmptyNotificationMessage({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: const [
        SizedBox(height: 250),
        ImageIcon(
          AssetImage('images/info.png'),
          size: 50,
          color: Color(0xffeeeeee),
        ),
        SizedBox(height: 10),
        Text(
          '알림 내역이 없습니다. \n곧 좋은 소식 정보 알려드릴게요!',
          textAlign: TextAlign.center,
          style: TextStyle(
            color: Color(0xffc2c2c2),
            fontSize: 14,
          ),
        ),
      ],
    );
  }
}



//
// class NotificationWrapper extends StatelessWidget {
//   final bool hasNotifications; // 알림이 있는지 여부를 결정하는 bool 값
//
//   const NotificationWrapper({super.key, required this.hasNotifications});
//
//   @override
//   Widget build(BuildContext context) {
//     return hasNotifications
//         ? const NotificationPage() // 알림이 있으면 NotificationPage를 띄움
//         : const NotificationNull(); // 알림이 없으면 NotificationNull을 띄움
//   }
// }
//

//
// class NotificationNull extends StatelessWidget {
//   const NotificationNull({super.key});
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
//                     style: TextStyle(color: Color(0xff787878),)
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//
//             // 안내 메시지
//             Expanded(
//               child: Center(
//                 child: Column(
//                   // mainAxisAlignment: MainAxisAlignment.center,
//                   children: [
//                     SizedBox(height: 250,),
//                     ImageIcon(AssetImage('images/info.png'),
//                       size: 50,
//                       color: Color(0xffeeeeee),
//                     ),
//                     SizedBox(height: 10,),
//                     Text(
//                       '알림 내역이 없습니다. \n곧 좋은 소식 정보 알려드릴게요!',
//                       textAlign: TextAlign.center,
//                       style: TextStyle(
//                         color: Color(0xffc2c2c2),
//                         fontSize: 14,
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
//
//
//
// }
//


class NotificationWrapper extends StatefulWidget {
  const NotificationWrapper({super.key});

  @override
  _NotificationWrapperState createState() => _NotificationWrapperState();
}



class _NotificationWrapperState extends State<NotificationWrapper> {
  Future<bool>? _hasNotificationsFuture;



  @override
  void initState() {
    super.initState();
    // 알림 유무를 확인하는 Future를 초기화합니다.
    // 비동기 메서드를 호출하여 알림을 저장합니다.
    _saveNotificationsAndCheck();
  }



  Future<void> _saveNotificationsAndCheck() async {
    final _storageManager = StorageManager();

    // 1. 서버 또는 다른 소스에서 알림 데이터를 가져오는 메서드 호출
    List<Notifications> notifications = await _fetchNotificationsFromServer(); // 실제 구현 필요

    // 2. 알림 데이터를 저장합니다.
    await _storageManager.writeNotifications(notifications);

    // 3. 알림 유무를 확인합니다.
    _hasNotificationsFuture = _checkForNotifications();
  }

  Future<List<Notifications>> _fetchNotificationsFromServer() async {
    // 서버에서 알림 데이터를 가져오는 로직을 구현합니다.
    // 예를 들어, HTTP 요청을 통해 데이터를 가져오는 코드입니다.

    // 아래는 예시로 임시 데이터 반환
    await Future.delayed(Duration(seconds: 1)); // 네트워크 지연을 모방합니다.

    // 실제 데이터가 아닌 예시 데이터
    return [
      Notifications(
        category: '커뮤니티',
        timeAgo: '2일 전',
        message: '치코님이 원룸님 게시글에 댓글을 남겼어요.',
        imagePath: 'images/plant_0.jpg',
      ),
      // 추가적인 알림 데이터
    ];
  }



  Future<bool> _checkForNotifications() async {
    final _storageManager = StorageManager();
    final notifications = await _storageManager.readNotifications();
    // 알림이 있으면 true, 없으면 false 반환
    return notifications != null && notifications.isNotEmpty;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<bool>(
      future: _hasNotificationsFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          // 로딩 중일 때 스피너나 로딩 인디케이터 표시
          return const Scaffold(body: Center(child: CircularProgressIndicator()));
        } else if (snapshot.hasError) {
          // 에러 발생 시 에러 메시지 표시
          return const Scaffold(body: Center(child: Text('알림을 불러오는 중 오류가 발생했습니다.')));
        } else if (snapshot.hasData) {
          final hasNotifications = snapshot.data ?? false;
          // 알림 유무에 따라 페이지를 선택
          return hasNotifications ? const NotificationPage() : const NotificationNull();
        } else {
          // 예상치 못한 상태일 때
          return const Scaffold(body: Center(child: Text('알림 정보를 가져올 수 없습니다.')));
        }
      },
    );
  }
}



class NotificationNull extends StatelessWidget {
  const NotificationNull({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const NotificationAppBar(),  // 모듈화한 AppBar 사용
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
          // 안내 메시지 사용
          const Expanded(
            child: EmptyNotificationMessage(),
          ),
        ],
      ),
    );
  }
}

