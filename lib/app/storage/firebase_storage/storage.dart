import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';

/*
 * Get images and upload images to firebase cloud storage.
 */
class Storage {
  final FirebaseStorage storage = FirebaseStorage.instance;

  Future<void> uploadFile(String localFilepath, String cloudFilePath) async {
    File file = File(localFilepath);
    try {
      await storage.ref(cloudFilePath).putFile(file);
    } on FirebaseStorage catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }
  }

  // Primarily for testing
  Future<ListResult> listFiles() async {
    ListResult result = await storage.ref('test').listAll();
    return result;
  }

  Future<String> downloadURL(String imagePath) async {
    String downloadURL = await storage.ref(imagePath).getDownloadURL();
    return downloadURL;
  }
}