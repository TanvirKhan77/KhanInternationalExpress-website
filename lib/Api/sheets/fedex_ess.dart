import 'dart:convert';

class FedexEss {
  static final String id = 'id';
  static final String ess = 'ess';
  static final String fuel = 'fuel';
  static final String dollar = 'dollar';
  static final String profit = 'profit';

  static List<String> getFedex_Ess_Fuel() => [id, ess, fuel, dollar, profit];
}

class Fedex_ess {
  final int? id;
  final double? ess;
  final double? fuel;
  final double? dollar;
  final double? profit;

  const Fedex_ess({
    this.id,
    this.ess,
    this.fuel,
    this.dollar,
    this.profit,
  });

  static Fedex_ess fromJson(Map<String, dynamic> json) => Fedex_ess(
    id: jsonDecode(json[FedexEss.id]),
    ess: jsonDecode(json[FedexEss.ess]),
    fuel: jsonDecode(json[FedexEss.fuel]),
    dollar: jsonDecode(json[FedexEss.dollar]),
    profit: jsonDecode(json[FedexEss.profit]),
  );

  Map<String, dynamic> toJson() => {
    FedexEss.id: id,
    FedexEss.ess: ess,
    FedexEss.fuel: fuel,
    FedexEss.dollar: dollar,
    FedexEss.profit: profit,
  };
}