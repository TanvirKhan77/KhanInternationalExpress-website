import 'package:flutter/material.dart';
import 'dart:convert';
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:syncfusion_flutter_xlsio/xlsio.dart';
import 'dart:html' as html;
import 'package:path_provider/path_provider.dart';

class ExcelTest3 extends StatefulWidget {
  const ExcelTest3({Key? key}) : super(key: key);

  @override
  State<ExcelTest3> createState() => _ExcelTest3State();
}

class _ExcelTest3State extends State<ExcelTest3> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            createExcel();
          },
          child: Text('Create Excel 3'),
        ),
      ),
    );
  }

  Future<void> createExcel() async {
    //Creating a workbook.
    final Workbook workbook = Workbook();
    //Accessing via index
    final Worksheet sheet = workbook.worksheets[0];
    //sheet.showGridLines = false;

    // Enable calculation for worksheet.
    sheet.enableSheetCalculations();

    //Set data in the worksheet.
    sheet.getRangeByName('A1').columnWidth = 4.82;
    sheet.getRangeByName('B1:C1').columnWidth = 13.82;
    sheet.getRangeByName('D1').columnWidth = 13.20;
    sheet.getRangeByName('E1').columnWidth = 7.50;
    sheet.getRangeByName('F1').columnWidth = 9.73;
    sheet.getRangeByName('G1').columnWidth = 8.82;
    sheet.getRangeByName('H1').columnWidth = 4.46;

    sheet.getRangeByName('A1:H1').cellStyle.backColor = '#333F4F';
    sheet.getRangeByName('A1:H1').merge();
    sheet.getRangeByName('B4:D6').merge();

    sheet.getRangeByName('B4').setText('Invoice');
    sheet.getRangeByName('B4').cellStyle.fontSize = 32;

    sheet.getRangeByName('B8').setText('BILL TO:');
    sheet.getRangeByName('B8').cellStyle.fontSize = 9;
    sheet.getRangeByName('B8').cellStyle.bold = true;

    sheet.getRangeByName('B9').setText('Abraham Swearegin');
    sheet.getRangeByName('B9').cellStyle.fontSize = 12;

    sheet
        .getRangeByName('B10')
        .setText('United States, California, San Mateo,');
    sheet.getRangeByName('B10').cellStyle.fontSize = 9;

    sheet.getRangeByName('B11').setText('9920 BridgePointe Parkway,');
    sheet.getRangeByName('B11').cellStyle.fontSize = 9;

    sheet.getRangeByName('B12').setNumber(9365550136);
    sheet.getRangeByName('B12').cellStyle.fontSize = 9;
    sheet.getRangeByName('B12').cellStyle.hAlign = HAlignType.left;

    final Range range1 = sheet.getRangeByName('F8:G8');
    final Range range2 = sheet.getRangeByName('F9:G9');
    final Range range3 = sheet.getRangeByName('F10:G10');
    final Range range4 = sheet.getRangeByName('F11:G11');
    final Range range5 = sheet.getRangeByName('F12:G12');

    range1.merge();
    range2.merge();
    range3.merge();
    range4.merge();
    range5.merge();

    sheet.getRangeByName('F8').setText('INVOICE#');
    range1.cellStyle.fontSize = 8;
    range1.cellStyle.bold = true;
    range1.cellStyle.hAlign = HAlignType.right;

    sheet.getRangeByName('F9').setNumber(2058557939);
    range2.cellStyle.fontSize = 9;
    range2.cellStyle.hAlign = HAlignType.right;

    sheet.getRangeByName('F10').setText('DATE');
    range3.cellStyle.fontSize = 8;
    range3.cellStyle.bold = true;
    range3.cellStyle.hAlign = HAlignType.right;

    sheet.getRangeByName('F11').dateTime = DateTime(2020, 08, 31);
    sheet.getRangeByName('F11').numberFormat =
    '[\$-x-sysdate]dddd, mmmm dd, yyyy';
    range4.cellStyle.fontSize = 9;
    range4.cellStyle.hAlign = HAlignType.right;

    range5.cellStyle.fontSize = 8;
    range5.cellStyle.bold = true;
    range5.cellStyle.hAlign = HAlignType.right;

    final Range range6 = sheet.getRangeByName('B15:G15');
    range6.cellStyle.fontSize = 10;
    range6.cellStyle.bold = true;

    sheet.getRangeByIndex(15, 2).setText('Code');
    sheet.getRangeByIndex(16, 2).setText('CA-1098');
    sheet.getRangeByIndex(17, 2).setText('LJ-0192');
    sheet.getRangeByIndex(18, 2).setText('So-B909-M');
    sheet.getRangeByIndex(19, 2).setText('FK-5136');
    sheet.getRangeByIndex(20, 2).setText('HL-U509');

    sheet.getRangeByIndex(15, 3).setText('Description');
    sheet.getRangeByIndex(16, 3).setText('AWC Logo Cap');
    sheet.getRangeByIndex(17, 3).setText('Long-Sleeve Logo Jersey, M');
    sheet.getRangeByIndex(18, 3).setText('Mountain Bike Socks, M');
    sheet.getRangeByIndex(19, 3).setText('ML Fork');
    sheet.getRangeByIndex(20, 3).setText('Sports-100 Helmet, Black');

    sheet.getRangeByIndex(15, 3, 15, 4).merge();
    sheet.getRangeByIndex(16, 3, 16, 4).merge();
    sheet.getRangeByIndex(17, 3, 17, 4).merge();
    sheet.getRangeByIndex(18, 3, 18, 4).merge();
    sheet.getRangeByIndex(19, 3, 19, 4).merge();
    sheet.getRangeByIndex(20, 3, 20, 4).merge();

    sheet.getRangeByIndex(15, 5).setText('Quantity');
    sheet.getRangeByIndex(16, 5).setNumber(2);
    sheet.getRangeByIndex(17, 5).setNumber(3);
    sheet.getRangeByIndex(18, 5).setNumber(2);
    sheet.getRangeByIndex(19, 5).setNumber(6);
    sheet.getRangeByIndex(20, 5).setNumber(1);

    sheet.getRangeByIndex(15, 6).setText('Price');
    sheet.getRangeByIndex(16, 6).setNumber(8.99);
    sheet.getRangeByIndex(17, 6).setNumber(49.99);
    sheet.getRangeByIndex(18, 6).setNumber(9.50);
    sheet.getRangeByIndex(19, 6).setNumber(175.49);
    sheet.getRangeByIndex(20, 6).setNumber(34.99);

    sheet.getRangeByIndex(15, 7).setText('Total');
    sheet.getRangeByIndex(16, 7).setFormula('=E16*F16+(E16*F16)');
    sheet.getRangeByIndex(17, 7).setFormula('=E17*F17+(E17*F17)');
    sheet.getRangeByIndex(18, 7).setFormula('=E18*F18+(E18*F18)');
    sheet.getRangeByIndex(19, 7).setFormula('=E19*F19+(E19*F19)');
    sheet.getRangeByIndex(20, 7).setFormula('=E20*F20+(E20*F20)');
    sheet.getRangeByIndex(15, 6, 20, 7).numberFormat = '\$#,##0.00';

    sheet.getRangeByName('E15:G15').cellStyle.hAlign = HAlignType.right;
    sheet.getRangeByName('B15:G15').cellStyle.fontSize = 10;
    sheet.getRangeByName('B15:G15').cellStyle.bold = true;
    sheet.getRangeByName('B16:G20').cellStyle.fontSize = 9;

    sheet.getRangeByName('E22:G22').merge();
    sheet.getRangeByName('E22:G22').cellStyle.hAlign = HAlignType.right;
    sheet.getRangeByName('E23:G24').merge();

    final Range range7 = sheet.getRangeByName('E22');
    final Range range8 = sheet.getRangeByName('E23');
    range7.setText('TOTAL');
    range7.cellStyle.fontSize = 8;
    range8.setFormula('=SUM(G16:G20)');
    range8.numberFormat = '\$#,##0.00';
    range8.cellStyle.fontSize = 24;
    range8.cellStyle.hAlign = HAlignType.right;
    range8.cellStyle.bold = true;

    sheet.getRangeByIndex(26, 1).text =
    '800 Interchange Blvd, Suite 2501, Austin, TX 78721 | support@adventure-works.com';
    sheet.getRangeByIndex(26, 1).cellStyle.fontSize = 8;

    final Range range9 = sheet.getRangeByName('A26:H27');
    range9.cellStyle.backColor = '#ACB9CA';
    range9.merge();
    range9.cellStyle.hAlign = HAlignType.center;
    range9.cellStyle.vAlign = VAlignType.center;

    // final Picture picture = sheet.pictures.addBase64(3, 4, _invoicejpeg);
    // picture.lastRow = 7;
    // picture.lastColumn = 8;

    //Save and launch the excel.
    final List<int> bytes = workbook.saveAsStream();
    //Dispose the document.
    workbook.dispose();

    if(kIsWeb){
      html.AnchorElement(href: 'data:application/octet-stream;charset=utf-16le;base64,${base64.encode(bytes)}')
        ..setAttribute('download', 'Output.xlsx')
        ..click();
    }else {
      final String path = (await getApplicationSupportDirectory()).path;
      final String fileName = Platform.isWindows ? '$path\\Output.xlsx' : '$path/Output.xlsx';
      final File file = File(fileName);
      await file.writeAsBytes(bytes, flush: true);
      //OpenFile.open(fileName);
      //await FileSaver.instance.saveAs(fileName, bytes, ext, mimeType);
    }
  }
}
