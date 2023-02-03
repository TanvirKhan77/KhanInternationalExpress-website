import 'dart:convert';

class DhlRateChart{
  static final String id = 'ID';
  static final String weight = 'Weight (Kg)';
  static final String zone1 = 'Zone 1';
  static final String zone2 = 'Zone 2';
  static final String zone3 = 'Zone 3';
  static final String zone4 = 'Zone 4';
  static final String zone5 = 'Zone 5';
  static final String zone6 = 'Zone 6';
  static final String zone7 = 'Zone 7';

  static List<String> getDhlRateCharts() => [id, weight, zone1, zone2, zone3, zone4, zone5, zone6, zone7];
}

class dhl_rate {
  final double? id;
  final String? weight;
  final double? zone1;
  final double? zone2;
  final double? zone3;
  final double? zone4;
  final double? zone5;
  final double? zone6;
  final double? zone7;

  const dhl_rate({
    this.id,
    this.weight,
    this.zone1,
    this.zone2,
    this.zone3,
    this.zone4,
    this.zone5,
    this.zone6,
    this.zone7,
  });

  static dhl_rate fromJson(Map<String, dynamic> json) => dhl_rate(
    id: jsonDecode(json[DhlRateChart.id]),
    weight: json[DhlRateChart.weight],
    zone1: jsonDecode(json[DhlRateChart.zone1]),
    zone2: jsonDecode(json[DhlRateChart.zone2]),
    zone3: jsonDecode(json[DhlRateChart.zone3]),
    zone4: jsonDecode(json[DhlRateChart.zone4]),
    zone5: jsonDecode(json[DhlRateChart.zone5]),
    zone6: jsonDecode(json[DhlRateChart.zone6]),
    zone7: jsonDecode(json[DhlRateChart.zone7]),
  );

  Map<String, dynamic> toJson() => {
    DhlRateChart.id: id,
    DhlRateChart.weight: weight,
    DhlRateChart.zone1: zone1,
    DhlRateChart.zone2: zone2,
    DhlRateChart.zone3: zone3,
    DhlRateChart.zone4: zone4,
    DhlRateChart.zone5: zone5,
    DhlRateChart.zone6: zone6,
    DhlRateChart.zone7: zone7,
  };
}