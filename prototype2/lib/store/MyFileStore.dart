import 'dart:async';
import 'dart:io';

import 'package:path_provider/path_provider.dart';

class MyFileStore {
  static Future<File> getLoginFile() async {
    String dir = (await getApplicationDocumentsDirectory()).path;
    String filename = "$dir/Login.txt";
    return new File(filename);
  }

  static Future<bool> readLoginFile() async {
    try {
      File file = await getLoginFile();
      String contents = await file.readAsString();
      if (contents.length > 0) {
        return true;
      }
      return false;
    } on FileSystemException {
      return false;
    }
  }

  static bool isLoggedIn() {
    readLoginFile().then((bool value) {
      return value;
    });
    return false;
  }

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
