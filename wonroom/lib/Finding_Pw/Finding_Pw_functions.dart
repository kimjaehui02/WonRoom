
import 'package:wonroom/DB/users/user_service.dart';

void findUserId(String nick, String email) async {
  UserService userService = new UserService();
  try {
    final response = await userService.findIdByNickEmail(nick, email);
    if (response['status'] == 'success') {
      print('Found user ID: ${response['user_id']}');
    } else {
      print('Failed to find user ID: ${response['message']}');
    }
  } catch (e) {
    print('Error occurred: $e');
  }
}