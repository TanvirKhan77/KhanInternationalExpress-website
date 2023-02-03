import 'dart:convert';

class FedexRateChart{
  static final String id = 'ID';
  static final String weight = 'Weight (Kg)';
  static final String zoneA = 'Zone A';
  static final String zoneB = 'Zone B';
  static final String zoneC = 'Zone C';
  static final String zoneD = 'Zone D';
  static final String zoneE = 'Zone E';
  static final String zoneF = 'Zone F';
  static final String zoneG = 'Zone G';
  static final String zoneH = 'Zone H';
  static final String zoneI = 'Zone I';
  static final String zoneJ = 'Zone J';
  static final String zoneK = 'Zone K';
  static final String zoneL = 'Zone L';

  static List<String> getFedexRateCharts() => [id, weight, zoneA, zoneB, zoneC, zoneD, zoneE, zoneF, zoneG, zoneH, zoneI, zoneJ, zoneK, zoneL];
}

class fedex_rate {
  final double? id;
  final String? weight;
  final double? zoneA;
  final double? zoneB;
  final double? zoneC;
  final double? zoneD;
  final double? zoneE;
  final double? zoneF;
  final double? zoneG;
  final double? zoneH;
  final double? zoneI;
  final double? zoneJ;
  final double? zoneK;
  final double? zoneL;

  const fedex_rate({
    this.id,
    this.weight,
    this.zoneA,
    this.zoneB,
    this.zoneC,
    this.zoneD,
    this.zoneE,
    this.zoneF,
    this.zoneG,
    this.zoneH,
    this.zoneI,
    this.zoneJ,
    this.zoneK,
    this.zoneL,
  });

  static fedex_rate fromJson(Map<String, dynamic> json) => fedex_rate(
    id: jsonDecode(json[FedexRateChart.id]),
    weight: json[FedexRateChart.weight],
    zoneA: jsonDecode(json[FedexRateChart.zoneA]),
    zoneB: jsonDecode(json[FedexRateChart.zoneB]),
    zoneC: jsonDecode(json[FedexRateChart.zoneC]),
    zoneD: jsonDecode(json[FedexRateChart.zoneD]),
    zoneE: jsonDecode(json[FedexRateChart.zoneE]),
    zoneF: jsonDecode(json[FedexRateChart.zoneF]),
    zoneG: jsonDecode(json[FedexRateChart.zoneG]),
    zoneH: jsonDecode(json[FedexRateChart.zoneH]),
    zoneI: jsonDecode(json[FedexRateChart.zoneI]),
    zoneJ: jsonDecode(json[FedexRateChart.zoneJ]),
    zoneK: jsonDecode(json[FedexRateChart.zoneK]),
    zoneL: jsonDecode(json[FedexRateChart.zoneL]),
  );

  Map<String, dynamic> toJson() => {
    FedexRateChart.id: id,
    FedexRateChart.weight: weight,
    FedexRateChart.zoneA: zoneA,
    FedexRateChart.zoneB: zoneB,
    FedexRateChart.zoneC: zoneC,
    FedexRateChart.zoneD: zoneD,
    FedexRateChart.zoneE: zoneE,
    FedexRateChart.zoneF: zoneF,
    FedexRateChart.zoneG: zoneG,
    FedexRateChart.zoneH: zoneH,
    FedexRateChart.zoneI: zoneI,
    FedexRateChart.zoneJ: zoneJ,
    FedexRateChart.zoneK: zoneK,
    FedexRateChart.zoneL: zoneL,
  };
}