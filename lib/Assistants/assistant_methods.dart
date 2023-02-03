import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:khanintlexpress/Global/global.dart';

import '../models/userModel.dart';

class AssistantMethods{

  static void readCurrentOnlineUserInfo() async {

    currentUser = fAuth.currentUser;

    // print('Current user uid: ${currentUser!.uid}');

    FirebaseFirestore.instance
        .collection("users")
        .doc(currentUser!.uid)
        .get()
        .then((documentSnapshot)
    {
      if(documentSnapshot.exists){
        //print("Document data: ${documentSnapshot.data()!['name']}");
        userModelCurrentInfo = UserModel.fromSnapshot(documentSnapshot);
      } else {
        print('Document does not exist on the database');
      }
    });



  }


}