import 'package:gsheets/gsheets.dart';
import 'package:khanintlexpress/api/sheets/dhl_ess.dart';
import 'package:khanintlexpress/api/sheets/dhl_rate_chart.dart';
import 'package:khanintlexpress/api/sheets/dhl_zone.dart';
import 'package:khanintlexpress/api/sheets/fedex_ess.dart';
import 'package:khanintlexpress/api/sheets/fedex_rate_chart.dart';
import 'package:khanintlexpress/api/sheets/fedex_zone.dart';

class UserSheetsApi {

  static const _credentials = r'''
{
  "type": "service_account",
  "project_id": "khanintlexpress-fcd9c",
  "private_key_id": "120ff60911f099b26c044c43a08a6c9264e7cace",
  "private_key": "-----BEGIN PRIVATE KEY-----\nMIIEvAIBADANBgkqhkiG9w0BAQEFAASCBKYwggSiAgEAAoIBAQDb3gZo4Y27Xh0d\nZyoLFaW7n2O6zxtuYsVrxOH3Y8ltATiWotkH5GNSR1VmVzmUB5figNf5WasLObl3\n0Y+Ac8osJ4oSKJDu+zx13SaIjA+Ok69UAOwjwecVJL9ms1jQJfzqvmKDP7Dk6pBD\nZLQohW52JcHP8f2Z46CkPPPAJASnXFvquc7ESRJWpBeRa5U934mM6ULXTfQxOymu\ne0vmI89+lLW8V4UiCEvGP5MAQtRscw4ixQomnDvX70K6tpy88ZAq9kiMIwUG/The\nHsaVTwMZ2E+oY0DzNH9wqUX/AwG6qs7UwyCzEJhSYKo1Vi0s41h/sMcea8JIoWbZ\nvRQOos8FAgMBAAECggEAJSwzULmrvQ0zJnS5+MBK8j8HPT8FUAMuhiM2Ih2yoTWW\n4+75+xnbyf4p++DM6RBkl0S53xxQLRhwGUgqtyi8en0f3KSTpnf/F51Rhb4KZkxl\nVPJH+l6u61X4b0xsvFpj2athG/ghd/6Jb/9/bydqDtsg2r+65PEFiKcOfgKI7+N/\nB1gwdrktBiGnoCbmuYsVT0ATAAvAy9td1WrJEdoqwS7AO6V1gFJyvNssdFtlrIYp\n8ni4OSdHFCM7ve+j/HHPmcgZAVGvzYrOh9OPhCNOsIJYQJUFj7ayC1D1I0BPk8Ze\nX1TT92tHyHrmooCEucfSt8kj3xpWJRfLIyMV8WWrQQKBgQD6SJaOgo9WrPJNPoXq\nzpFZHnO9SNCFxplfsi8T4eSuHSzip6iw5zBsYVmpiAN5BJUkdvC9uA1PVZn637nn\nNmycCWfblydz1OpGZGh4HzZU6QEopltH86umjO+dKMBfcPVFPk/4xyvW0ZIpexJx\nZwP9QjNKXdaAs9zH3avUDLGHQQKBgQDg45ex1r/+jcxADjsdFbHOZIzRBJBSlz4M\ntyNvOgKkJdZMkJ1zhtEUIM5uVF1Gt79bsWS/QzWFzqgE/moRln0wiOiE/LrNqOJ6\nDNccvgkK+ztxCQ9eUmXDa3Ndu2WodeWo+FflzxapeALiFErPRY/1fiCcVfm/cVbX\njortIiE6xQKBgGTlpmxFDevvRK8HKY2DQO0gbaA9HnMPoP0HJBtr0XivokytMkA+\nszK9/BtwDZZX1pggquSQsiztYWnVj2g6dIZi9E9+HBWCG//MsqDaVFjepezxQ5M6\nFFTMNDyzFPpk2zvS5wJvqKitS7MVPlYhJWaPrYWpVrQDzll0b7TIeTkBAoGASGvi\noQmoQKCHYyVyEfa3kOC+nF0c4QwFlnCvv5Tt3tC0h2mW2upSkGnUMKGIfEqWHEAv\nUoyhQtr/LsSDgfB1lliwkIsW2T4G2QkjiQUFwnyPcuJZCaX9UYZb25aKsUpuUBDR\ntZcQFDkqrIWeZctgBc29ULs7N1SXg8lKofz4uIUCgYAnrHUnjKbla6GUu97A6FzY\nI+/iOmSvOVv1HVc/+SNQuBE1upzrT3k/rgW41k8yzv8AGHN736phUmXXX1KctupM\nBUfpQYLizy3TLpupjGB+pFpL21WyYr4U72zOCsNuykcdN/VVXY5xB9QFjBhZA0cN\n3ERca3HFisFuJ2YLh0Doig==\n-----END PRIVATE KEY-----\n",
  "client_email": "gsheets@khanintlexpress-fcd9c.iam.gserviceaccount.com",
  "client_id": "101574859056692151923",
  "auth_uri": "https://accounts.google.com/o/oauth2/auth",
  "token_uri": "https://oauth2.googleapis.com/token",
  "auth_provider_x509_cert_url": "https://www.googleapis.com/oauth2/v1/certs",
  "client_x509_cert_url": "https://www.googleapis.com/robot/v1/metadata/x509/gsheets%40khanintlexpress-fcd9c.iam.gserviceaccount.com"
} 
''';

  static final _spreadsheetId = '13xZjUyUUtuvyLFa9_--vYUI0jpLXKADUhUDy3YFsx6I';
  static final _gsheets = GSheets(_credentials);
  static Worksheet? _userSheet,_dhl_zone_Sheet,_dhl_rate_Sheet,_dhl_ess_Sheet,_fedex_rate_Sheet,_fedex_zone_Sheet,_fedex_ess_Sheet;

  static Future init() async {
    try {
      final spreadsheet = await _gsheets.spreadsheet(_spreadsheetId);
      _userSheet = await _getWorkSheet(spreadsheet, title: 'Users');
      _dhl_rate_Sheet = await _getWorkSheet(spreadsheet, title: 'dhl_rate_chart');
      _dhl_zone_Sheet = await _getWorkSheet(spreadsheet, title: 'dhl_zone');
      _dhl_ess_Sheet = await _getWorkSheet(spreadsheet, title: 'dhl_ess');
      _fedex_rate_Sheet = await _getWorkSheet(spreadsheet, title: 'fedex_rate_chart');
      _fedex_zone_Sheet = await _getWorkSheet(spreadsheet, title: 'fedex_zone');
      _fedex_ess_Sheet = await _getWorkSheet(spreadsheet, title: 'fedex_ess');

      await _userSheet!.values.insertValue('Roki', column: 1, row: 1);

      final firstRow2 = DhlRateChart.getDhlRateCharts();
      _dhl_rate_Sheet!.values.insertRow(1, firstRow2);

      final firstRow3 = DhlZoneList.getDhlZones();
      _dhl_zone_Sheet!.values.insertRow(1, firstRow3);

      final firstRow4 = DhlEss.getDhl_Ess_Fuel();
      _dhl_ess_Sheet!.values.insertRow(1, firstRow4);

      final firstRow5 = FedexRateChart.getFedexRateCharts();
      _fedex_rate_Sheet!.values.insertRow(1, firstRow5);

      final firstRow6 = FedexZoneList.getFedexZones();
      _fedex_zone_Sheet!.values.insertRow(1, firstRow6);

      final firstRow7 = FedexEss.getFedex_Ess_Fuel();
      _fedex_ess_Sheet!.values.insertRow(1, firstRow7);
    }
    catch (e) {
      print('Init Error: $e');
    }


  }

  static Future<Worksheet> _getWorkSheet(
      Spreadsheet spreadsheet, {
        required String title,
      }) async {
    try{
      return await spreadsheet.addWorksheet(title);
    } catch (e) {
      return spreadsheet.worksheetByTitle(title)!;
    }
  }

  static Future<dhl_rate?> getById_Dhl_rate(double id) async {
    if(_dhl_rate_Sheet == null) return null;

    final json = await _dhl_rate_Sheet!.values.map.rowByKey(id, fromColumn: 1);
    return json == null ? null : dhl_rate.fromJson(json);
  }

  static Future<fedex_rate?> getById_Fedex_rate(double id) async {
    if(_fedex_rate_Sheet == null) return null;

    final json = await _fedex_rate_Sheet!.values.map.rowByKey(id, fromColumn: 1);
    return json == null ? null : fedex_rate.fromJson(json);
  }

  static Future<Dhl_zone?> getById_Dhl_zone(int id) async {
    if(_dhl_zone_Sheet == null){
      print('baal');
      return null;
    }


    final json = await _dhl_zone_Sheet!.values.map.rowByKey(id, fromColumn: 1);
    return json == null ? null : Dhl_zone.fromJson(json);
  }

  static Future<Fedex_zone?> getById_Fedex_zone(String id) async {
    if(_fedex_zone_Sheet == null) return null;

    final json = await _fedex_zone_Sheet!.values.map.rowByKey(id, fromColumn: 1);
    return json == null ? null : Fedex_zone.fromJson(json);
  }

  static Future<Dhl_ess?> getById_Dhl_Ess(int id) async {
    if(_dhl_ess_Sheet == null) return null;

    final json = await _dhl_ess_Sheet!.values.map.rowByKey(id, fromColumn: 1);
    return json == null ? null : Dhl_ess.fromJson(json);
  }

  static Future<Fedex_ess?> getById_Fedex_Ess(int id) async {
    if(_fedex_ess_Sheet == null) return null;

    final json = await _fedex_ess_Sheet!.values.map.rowByKey(id, fromColumn: 1);
    return json == null ? null : Fedex_ess.fromJson(json);
  }
}