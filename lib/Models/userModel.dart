

import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel
{
  String? uid;
  String? name;
  String? address;
  String? phone;
  String? email;
  String? status;

  UserModel({this.uid, this.name, this.address, this.phone, this.email, this.status});

  UserModel.fromSnapshot(DocumentSnapshot<Map<String,dynamic>> documentSnapshot){
    //print("Document from user model: ${documentSnapshot.data()!["name"]}");
    uid = documentSnapshot.data()!["uid"];
    name = documentSnapshot.data()!["name"];
    address = documentSnapshot.data()!["address"];
    phone = documentSnapshot.data()!["phone"];
    email = documentSnapshot.data()!["email"];
    status = documentSnapshot.data()!["status"];
    //print("Address: $address");
  }
}