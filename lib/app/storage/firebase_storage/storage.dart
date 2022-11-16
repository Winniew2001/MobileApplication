import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';

class Storage {
  final FirebaseStorage storage = FirebaseStorage.instance;

  Future<void> uploadFile(String filepath, String filename) async {
    File file = File(filepath);
    try {
      await storage.ref('test/$filename').putFile(file);
    } on FirebaseStorage catch (e) {
      print(e);
    }
  }

  Future<ListResult> listFiles() async {
    ListResult result = await storage.ref('test').listAll();
    return result;
  }

  Future<String> downloadURL(String imageName) async {
    String downloadURL = await storage.ref('test/$imageName').getDownloadURL();
    return downloadURL;
  }
}