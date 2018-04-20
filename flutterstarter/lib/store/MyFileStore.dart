import 'dart:async';
import 'dart:io';
import 'package:path_provider/path_provider.dart';
class MyFileStore {
  static Future<File> getLocalFile() async {
    String dir = (await getApplicationDocumentsDirectory()).path;
    String filename = "$dir/FileStore.txt";
    return new File(filename);
  }

  static Future<String> readLocalFile() async {
    try {
      File file = await getLocalFile();
      String contents = await file.readAsString();
      return contents;
    } on FileSystemException {
      return null;
    }
  }
}

