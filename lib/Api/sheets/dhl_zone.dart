import 'dart:convert';

class DhlZoneList{
  static final String id = 'ID';
  static final String country = 'Country';
  static final String zone = 'Zone';

  static List<String> getDhlZones() => [id, country, zone];
}

class Dhl_zone {
  final int? id;
  final String? country;
  final int? zone;

  const Dhl_zone({
    this.id,
    this.country,
    this.zone,
  });

  static Dhl_zone fromJson(Map<String, dynamic> json) => Dhl_zone(
    id: jsonDecode(json[DhlZoneList.id]),
    country: json[DhlZoneList.country],
    zone: jsonDecode(json[DhlZoneList.zone]),
  );

  Map<String, dynamic> toJson() => {
    DhlZoneList.id: id,
    DhlZoneList.country: country,
    DhlZoneList.zone: zone,
  };
}