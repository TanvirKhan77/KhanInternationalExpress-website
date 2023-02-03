import 'dart:convert';

class FedexZoneList{
  static final String id = 'ID';
  static final String country = 'Country';
  static final String zone = 'Zone';

  static List<String> getFedexZones() => [id, country, zone];
}

class Fedex_zone {
  final int? id;
  final String? country;
  final String? zone;

  const Fedex_zone({
    this.id,
    this.country,
    this.zone,
  });

  static Fedex_zone fromJson(Map<String, dynamic> json) => Fedex_zone(
    id: jsonDecode(json[FedexZoneList.id]),
    country: json[FedexZoneList.country],
    zone: json[FedexZoneList.zone],
  );

  Map<String, dynamic> toJson() => {
    FedexZoneList.id: id,
    FedexZoneList.country: country,
    FedexZoneList.zone: zone,
  };
}