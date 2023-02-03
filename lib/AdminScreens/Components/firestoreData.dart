import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Data {
  String? name;
  String? phone;
  String? Age;

  Data({required this.name, required this.phone, required this.Age});
}



// List<Data> myData = [
//   Data(name: "Chamar", phone: "Chamar", Age: "28"),
//   Data(name: "Khaliq", phone: "Chamar", Age: "28"),
//   Data(name: "David", phone: "Chamar", Age: "30"),
//   Data(name: "Kamal", phone: "Chamar", Age: "32"),
//   Data(name: "Ali", phone: "Chamar", Age: "33"),
//   Data(name: "Muzal", phone: "Chamar", Age: "23"),
//   Data(name: "Taimu", phone: "Chamar", Age: "24"),
//   Data(name: "Mehdi", phone: "Chamar", Age: "36"),
//   Data(name: "Rex", phone: "Chamar", Age: "38"),
//   Data(name: "Alex", phone: "Chamar", Age: "29"),
// ];