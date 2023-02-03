import 'dart:convert';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:firebase_core/firebase_core.dart' as firebase_core;
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:image_picker/image_picker.dart';

import '../global/global.dart';
import 'package:path/path.dart' as Path;

class Storage {

  final firebase_storage.FirebaseStorage storage = firebase_storage.FirebaseStorage.instance;

  Future<void> uploadFileForWeb(User currentUser, PickedFile? pickedFile) async {

    storage.ref()
        .child('users/${currentUser.uid}/pro-pic.png')
        .putData(await pickedFile!.readAsBytes(),
      SettableMetadata(contentType: 'image/jpeg'),);
  }

  Future<void> uploadFile(User currentUser, String filePath, String fileName) async {
    File file = File(filePath);

    try{
      await storage.ref('users/${currentUser.uid}/pro-pic.png').putFile(file);
      //FirebaseDatabase.instance.ref().child("drivers").child(currentFirebaseUser!.uid).child("pro-pic").set("pro-pic.png");
    } on firebase_core.FirebaseException catch (e){
      print(e);
    }

  }

  Future<firebase_storage.ListResult> listFiles() async {
    firebase_storage.ListResult results = await storage.ref('users/${userModelCurrentInfo!.uid}').listAll();

    results.items.forEach((firebase_storage.Reference ref) {
      print('Found file: $ref');
    });
    return results;
  }

  Future<String> downloadURL(String imageName) async {
    String downloadURL = await storage.ref('users/${userModelCurrentInfo!.uid}/$imageName').getDownloadURL();

    String url = downloadURL.toString();
    print("This is url");
    print(url);

    print(downloadURL);

    return downloadURL;
  }


}