import 'dart:convert';

class DhlEss {
  static final String id = 'id';
  static final String ess = 'ess';
  static final String fuel = 'fuel';
  static final String dollar = 'dollar';
  static final String profit = 'profit';

  static List<String> getDhl_Ess_Fuel() => [id, ess, fuel, dollar, profit];
}

class Dhl_ess {
  final int? id;
  final double? ess;
  final double? fuel;
  final double? dollar;
  final double? profit;

  const Dhl_ess({
    this.id,
    this.ess,
    this.fuel,
    this.dollar,
    this.profit,
  });

  static Dhl_ess fromJson(Map<String, dynamic> json) => Dhl_ess(
    id: jsonDecode(json[DhlEss.id]),
    ess: jsonDecode(json[DhlEss.ess]),
    fuel: jsonDecode(json[DhlEss.fuel]),
    dollar: jsonDecode(json[DhlEss.dollar]),
    profit: jsonDecode(json[DhlEss.profit]),
  );

  Map<String, dynamic> toJson() => {
    DhlEss.id: id,
    DhlEss.ess: ess,
    DhlEss.fuel: fuel,
    DhlEss.dollar: dollar,
    DhlEss.profit: profit,
  };
}