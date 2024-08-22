import 'package:dio/dio.dart';
void testConnection() async {
  String url = "http://192.168.219.81:8087/";  // Flask 서버의 /test 엔드포인트

  Dio dio = Dio();  // Dio 인스턴스 생성

  Response response = await dio.get(url);  // GET 요청 보내기

  if (response.statusCode == 200) {
    // 서버가 성공적으로 응답했을 때
    print('Response data: ${response.data}');
  } else {
    // 서버가 에러를 응답했을 때
    print('Failed to get data. Status code: ${response.statusCode}');
  }
}