import 'dart:io';

import 'package:path_provider/path_provider.dart';

class FileUtils {
  static Future<String> get getFilePath async {
    final directory = await getApplicationDocumentsDirectory();
    return directory.path;
  }

  static Future<File> get getFile async {
    final path = await getFilePath;
    return File('$path/newFile.txt');
  }

  static Future<File> get getUsers async {
    final path = await getFilePath;
    return File('$path/userData.txt');
  }

  static Future<File> saveToFile(String data, Future<File> fileName) async {
    final file = await fileName;
    return file.writeAsString(data);
  }

  static Future<String> readFromFile(Future<File> fileName) async {
    try {
      final file = await fileName;
      String fileContents = await file.readAsString();
      return fileContents;
    } catch (e) {
      return "";
    }
  }
}
