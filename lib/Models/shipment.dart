import 'package:flutter/material.dart';

class Shipment {
  int? id;
  String? clients;
  String? date;
  String? shipment_type;
  String? airwaybill_no;
  String? country;
  String? weight;
  String? service;
  String? amount;
  String? amount_status;
  String? note;

  Shipment({
    required this.id,
    required this.clients,
    required this.date,
    required this.shipment_type,
    required this.airwaybill_no,
    required this.country,
    required this.weight,
    required this.service,
    required this.amount,
    required this.amount_status,
    required this.note,
  });
}