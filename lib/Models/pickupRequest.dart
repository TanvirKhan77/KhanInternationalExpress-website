import 'package:flutter/material.dart';

class PickupRequest{
  int? id;
  String? date;
  String? sender_uid;
  String? sender_name;
  String? sender_address;
  String? sender_phone;
  String? sender_email;
  String? uid;
  String? receiver_name;
  String? receiver_address;
  String? number_of_days;
  String? country;
  String? weight;
  String? amount;

  PickupRequest({
    required this.id,
    required this.date,
    required this.sender_uid,
    required this.sender_name,
    required this.sender_address,
    required this.sender_phone,
    required this.sender_email,
    required this.uid,
    required this.receiver_name,
    required this.receiver_address,
    required this.number_of_days,
    required this.country,
    required this.weight,
    required this.amount,
  });
}