
import 'package:wonroom/DB/user_plants/user_plants_service.dart';
import 'package:wonroom/Flask/storage_manager.dart';

void diaryUpdate() async
{
  Map<String, dynamic>? userData = await readUserData('userData');

  // user_id가 null이거나 존재하지 않을 경우 기본값을 설정합니다.
  String userId = userData?['user_id'] ?? 'default_user_id'; // 'default_user_id'는 적절한 기본값으로 설정

  print(userId);
  print(userId);
  print(userId);

  addPlant(userId, 1, '제목', DateTime.now().toIso8601String());
}
