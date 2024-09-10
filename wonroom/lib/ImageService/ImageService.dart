import 'dart:io';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as p;
import 'package:permission_handler/permission_handler.dart';

class ImageService {
  // 권한 요청 함수
  Future<void> requestPermissions() async {
    if (await Permission.storage.isDenied) {
      // 권한이 거부된 경우 요청
      await Permission.storage.request();
    }
  }

  // 권한 상태 확인 함수
  Future<bool> hasStoragePermission() async {
    final status = await Permission.storage.status;
    return status.isGranted;
  }

  // 이미지 저장 경로를 반환하는 함수 (하위 폴더 포함)
  Future<String> _getLocalPath(String tableName) async {
    if (!await hasStoragePermission()) {
      await requestPermissions();
    }

    final directory = await getApplicationDocumentsDirectory();
    final imagePath = p.join(directory.path, 'images', tableName);
    final dir = Directory(imagePath);

    if (!(await dir.exists())) {
      await dir.create(recursive: true);
      print('Created directory: $imagePath');
    } else {
      print('Directory already exists: $imagePath');
    }

    return imagePath;
  }


  // 파일 이름을 생성하는 함수
  Future<String> _generateFileName(String postID, String tableName) async {
    final path = await _getLocalPath(tableName);
    final files = Directory(path).listSync();

    int imageID = 1;
    final regex = RegExp(r'^${RegExp.escape(tableName)}_${RegExp.escape(postID)}_(\d+)\.');
    for (var file in files) {
      if (file is File) {
        final fileName = p.basenameWithoutExtension(file.path);
        final match = regex.firstMatch(fileName);
        if (match != null && match.group(1) != null) {
          final id = int.tryParse(match.group(1)!) ?? 0;
          if (id >= imageID) {
            imageID = id + 1;
          }
        }
      }
    }

    final fileExtension = p.extension(files.isEmpty ? 'dummy.png' : files.first.path);
    final fileName = '${tableName}_${postID}_$imageID$fileExtension';
    print('Generated file name: $fileName');
    return fileName;
  }




  Future<File> saveImage(File image, String postID, String tableName) async {
    if (image == null) {
      print('No image file provided');
      print('No image file provided');
      print('No image file provided');
      print('No image file provided');
      print('No image file provided');
      print('No image file provided');
      print('No image file provided');
      print('No image file provided');
      print('No image file provided');
      print('No image file provided');
      print('No image file provided');
      print('No image file provided');
      print('No image file provided');

    }

    final fileName = await _generateFileName(postID, tableName);
    final path = await _getLocalPath(tableName);
    final filePath = p.join(path, fileName);
    final file = File(filePath);

    print('Saving image to: $filePath');
    final savedFile = await image.copy(filePath);
    print('Saved file path: ${savedFile.path}');
    return savedFile;
  }


// 로컬 저장소에서 이미지 파일을 불러오는 함수
  Future<List<File>> loadImagesForPost(String postID, String tableName) async {
    final path = await _getLocalPath(tableName);
    final directory = Directory(path);

    if (!await directory.exists()) {
      print('Directory does not exist: $path');
      return [];
    }

    print('Directory exists: $path');
    final files = directory.listSync();
    print('Files in directory: ${files.map((file) => file.path).toList()}');

    final imageFiles = files
        .where((file) => file is File)
        .map((file) => File(file.path))
        .where((file) => p.basename(file.path).startsWith('${tableName}_${postID}_'))
        .toList();

    print('Filtered image files: ${imageFiles.map((file) => file.path).toList()}');
    return imageFiles;
  }


  Future<int> countImagesForPost(String postID, String tableName) async {
    final images = await loadImagesForPost(postID, tableName);
    final count = images.length;
    print('Number of images for post $postID: $count');
    return count;
  }

  Future<String> getImagePathForPost(String tableName, String postID) async {
    if (postID.isEmpty || tableName.isEmpty) {
      throw ArgumentError('postID and tableName cannot be empty');
    }

    final imageFiles = await loadImagesForPost(postID, tableName);

    if (imageFiles.isNotEmpty) {
      final imagePath = imageFiles.first.path;
      print('Image path for post $postID: $imagePath'); // 로그 추가
      return imagePath;
    } else {
      final defaultPath = 'images/img01.jpg';
      print('No images found for post $postID. Returning default image path: $defaultPath'); // 로그 추가
      return defaultPath;
    }
  }

  Future<ImageProvider> loadImageProvider(String tableName, String postID) async {
    final imagePath = await _getLocalPath(tableName); // tableName에 따른 경로
    final fileName = await _generateFileName(postID, tableName); // 파일 이름 생성
    final fullImagePath = p.join(imagePath, fileName); // 전체 경로 생성
    final imageFile = File(fullImagePath);

    print('Requested image path: $fullImagePath');
    List<File> AI = await getImagesFromPost(postID, tableName);
    File AI2 = AI[0];

    print(postID);
    print(postID);
    print(postID);
    print(postID);
    print(postID);
    print(postID);
    print(postID);
    print(postID);
    print(postID);
    print(postID);
    print(postID);
    print(postID);
    print(postID);
    print(postID);
    print(postID);

    if (await imageFile.exists()) {
      print('Image provider created with file: $fullImagePath');
      return FileImage(imageFile);
    }
    else if (await AI2.exists()) {
      print('AI2 created with file: $fullImagePath');
      return FileImage(AI2);
    } else {
      print('Image file does not exist. Returning default image provider');
      return AssetImage('images/img01.jpg');
    }
  }

  // 모든 이미지의 총 갯수를 반환하는 함수
  Future<int> countAllImages() async {
    final path = await getApplicationDocumentsDirectory();
    final directories = Directory(p.join(path.path, 'images')).listSync();
    int totalCount = 0;

    for (var dir in directories) {
      if (dir is Directory) {
        final files = Directory(dir.path).listSync();
        totalCount += files.where((file) => file is File).length;
      }
    }
    print('Total count of images: $totalCount');
    return totalCount;
  }

  // 모든 이미지 삭제하는 함수
  Future<void> deleteAllImages() async {
    final path = await getApplicationDocumentsDirectory();
    final imageDir = Directory(p.join(path.path, 'images'));

    if (await imageDir.exists()) {
      final directories = imageDir.listSync();

      for (var dir in directories) {
        if (dir is Directory) {
          final files = Directory(dir.path).listSync();
          for (var file in files) {
            if (file is File) {
              await file.delete();
              print('Deleted image: ${file.path}');
            }
          }
          // 각 테이블 디렉토리 삭제
          await dir.delete();
          print('Deleted directory: ${dir.path}');
        }
      }
    }
  }






  Future<List<File>> getAllImages() async {
    final path = await getApplicationDocumentsDirectory();
    final imagesDir = Directory(p.join(path.path, 'images'));

    // 디렉토리가 존재하는지 확인
    if (!imagesDir.existsSync()) {
      print('Images directory does not exist');
      return [];
    }

    final directories = imagesDir.listSync();
    List<File> imageFiles = [];

    for (var dir in directories) {
      if (dir is Directory) {
        final files = Directory(dir.path).listSync();
        imageFiles.addAll(files.where((file) => file is File && _isImageFile(file)).cast<File>());
      }
    }

    print('Total count of images: ${imageFiles.length}');
    return imageFiles;
  }

  Future<List<File>> getImagesFromPost(String postID, String tableName) async {
    final path = await getApplicationDocumentsDirectory();
    final imagesDir = Directory(p.join(path.path, 'images'));

    // 디렉토리가 존재하는지 확인
    if (!imagesDir.existsSync()) {
      print('Images directory does not exist');
      return [];
    }

    final directories = imagesDir.listSync();
    List<File> imageFiles = [];

    for (var dir in directories) {
      if (dir is Directory) {
        final files = Directory(dir.path).listSync();
        imageFiles.addAll(
            files.where((file) =>
            file is File &&
                _isImageFile(file) &&
                p.basename(file.path).contains('${tableName}_$postID')
            ).cast<File>()
        );
      }
    }

    print('Total count of images for post $postID in table $tableName: ${imageFiles.length}');
    return imageFiles;
  }


  bool _isImageFile(File file) {
    // 이미지 파일의 확장자를 확인하는 간단한 예제
    final extensions = ['.png', '.jpg', '.jpeg', '.gif'];
    return extensions.any((ext) => file.path.endsWith(ext));
  }


}
