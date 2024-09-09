import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as p;

class ImageService {
  // 이미지 저장 경로를 반환하는 함수
  Future<String> _getLocalPath() async {
    final directory = await getApplicationDocumentsDirectory();
    return directory.path;
  }

  // 이미지 파일을 로컬 저장소에 저장하는 함수
  Future<File> saveImage(File image, String fileName) async {
    final path = await _getLocalPath();
    final file = File(p.join(path, fileName));
    return await image.copy(file.path);
  }

  // 로컬 저장소에서 이미지 파일을 불러오는 함수
  Future<File?> loadImage(String fileName) async {
    try {
      final path = await _getLocalPath();
      final file = File(p.join(path, fileName));
      if (await file.exists()) {
        return file;
      }
      return null;
    } catch (e) {
      print('Error loading image: $e');
      return null;
    }
  }

  // 로컬 저장소에서 이미지 파일을 삭제하는 함수
  Future<void> deleteImage(String fileName) async {
    try {
      final path = await _getLocalPath();
      final file = File(p.join(path, fileName));
      if (await file.exists()) {
        await file.delete();
      }
    } catch (e) {
      print('Error deleting image: $e');
    }
  }

  // 저장된 이미지 목록을 반환하는 함수
  Future<List<String>> listImages() async {
    final path = await _getLocalPath();
    final directory = Directory(path);
    final files = directory.listSync();
    return files
        .where((file) => file is File)
        .map((file) => p.basename(file.path))
        .toList();
  }
}
