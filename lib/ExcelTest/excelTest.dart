import 'dart:convert';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:khanintlexpress/AdminScreens/adminMakeBill.dart';
import 'package:khanintlexpress/AppBar/customAppBar.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_xlsio/xlsio.dart' hide Column,Row;
import 'dart:html' as html;

import '../AdminScreens/Components/adminSideMenu.dart';
import '../AdminScreens/Components/menuController.dart';
import '../Global/responsive.dart';

final Workbook workbook = Workbook();

final Worksheet sheet = workbook.worksheets[0];

var num = 0;
int counter = 0;
int j = 0;

DateTime date = DateTime.now();
Timestamp timestamp = Timestamp.now();

class ExcelTest extends StatefulWidget {
  String clients;
  DateTime startDate = DateTime.now();
  DateTime endDate = DateTime.now();

  ExcelTest(
    this.clients,
    this.startDate,
    this.endDate,
  );

  @override
  State<ExcelTest> createState() => _ExcelTestState();
}

class _ExcelTestState extends State<ExcelTest> {

  Future<void> workSheet() async {

    // Enable calculation for worksheet.
    sheet.enableSheetCalculations();

    //set data in the worksheet
    sheet.getRangeByName('A1').columnWidth = 2;

    final Range range = sheet.getRangeByName('B1:L1');
    range.merge();
    range.cellStyle.hAlign = HAlignType.center;

    sheet.getRangeByName('B1').setText('Bill');
    sheet.getRangeByName('B1').cellStyle.fontSize = 20;

    sheet.getRangeByName('B6').setText('SL_No');
    sheet.getRangeByName('B6').cellStyle.bold = true;
    sheet.getRangeByName('B6').cellStyle.borders.all.lineStyle = LineStyle.thin;


    sheet.getRangeByName('C6').setText('Date');
    sheet.getRangeByName('C6').cellStyle.bold = true;
    sheet.getRangeByName('C6').cellStyle.borders.all.lineStyle = LineStyle.thin;

    sheet.getRangeByName('D6').setText('ShipT');
    sheet.getRangeByName('D6').cellStyle.bold = true;
    sheet.getRangeByName('D6').cellStyle.borders.all.lineStyle = LineStyle.thin;

    sheet.getRangeByName('E6').setText('Airwaybill No.');
    sheet.getRangeByName('E6').cellStyle.bold = true;
    sheet.getRangeByName('E1').columnWidth = 12;
    sheet.getRangeByName('E6').cellStyle.borders.all.lineStyle = LineStyle.thin;

    sheet.getRangeByName('F6').setText('Country');
    sheet.getRangeByName('F6').cellStyle.bold = true;
    sheet.getRangeByName('F6').cellStyle.borders.all.lineStyle = LineStyle.thin;

    sheet.getRangeByName('G6').setText('Weight');
    sheet.getRangeByName('G6').cellStyle.bold = true;
    sheet.getRangeByName('G6').cellStyle.borders.all.lineStyle = LineStyle.thin;

    sheet.getRangeByName('H6').setText('Amount');
    sheet.getRangeByName('H6').cellStyle.bold = true;
    sheet.getRangeByName('H6').cellStyle.borders.all.lineStyle = LineStyle.thin;

    sheet.getRangeByName('I6').setText('ESS');
    sheet.getRangeByName('I6').cellStyle.bold = true;
    sheet.getRangeByName('I6').cellStyle.borders.all.lineStyle = LineStyle.thin;

    sheet.getRangeByName('J6').setText('ADD.COR.');
    sheet.getRangeByName('J6').cellStyle.bold = true;
    sheet.getRangeByName('J6').cellStyle.borders.all.lineStyle = LineStyle.thin;

    sheet.getRangeByName('K6').setText('Total');
    sheet.getRangeByName('K6').cellStyle.bold = true;
    sheet.getRangeByName('K6').cellStyle.borders.all.lineStyle = LineStyle.thin;

    sheet.getRangeByName('L6').setText('Service');
    sheet.getRangeByName('L6').cellStyle.bold = true;
    sheet.getRangeByName('L6').cellStyle.borders.all.lineStyle = LineStyle.thin;
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    workSheet();
    print("Timestamp: ${timestamp.seconds}");
    print("Datetime: ${Timestamp.fromDate(date).seconds}");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: context.read<MenuController>().scaffoldKey,
      appBar: CustomAppBar(),
      drawer: AdminSideMenu(),
      body: Center(
        child: Column(
          children: [

            Padding(
              padding: EdgeInsets.fromLTRB(20, 20, 20, 0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      // if(!Responsive.isDesktop(context))
                      IconButton(
                        onPressed: context.read<MenuController>().controlMenu,
                        icon: Icon(Icons.menu),
                      ),

                      // if(!Responsive.isMobile(context))
                      Text(
                        "Print Excel",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 30,
                        ),
                      ),
                    ],
                  ),

                  Container(
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                    ),
                    child: Icon(Icons.notifications),
                  ),

                ],
              ),
            ),

            SizedBox(height: 40,),

            StreamBuilder(
              stream: FirebaseFirestore.instance.collection('shipment').snapshots(),
              builder: (context, AsyncSnapshot snapshot){
                if(!snapshot.hasData){
                  return Text('loading Data');
                }else {
                  DocumentSnapshot<Map<String, dynamic>> snap;
                  num = snapshot.data.docs.length;
                  for(int i = 0;i<num; i++){
                    snap = snapshot.data.docs[i];
                    timestamp = snap.data()!['date'];
                    if(snap.data()!["clients"] == clientsDropdownvalue
                        && timestamp.seconds >= Timestamp.fromDate(startDate).seconds
                        && timestamp.seconds <= Timestamp.fromDate(endDate).seconds
                        && snap.data()!['amount_status'] == 'Due'
                    ){
                      sheet.getRangeByName('B${j+7}').setNumber(j+1);
                      sheet.getRangeByName('C${j+7}').setText('${DateFormat('dd/MM/yyyy').format(DateTime.parse((snap.data()!['date'] as Timestamp).toDate().toString()))}');
                      sheet.getRangeByName('D${j+7}').setText(snap.data()!['shipmentType']);
                      sheet.getRangeByName('E${j+7}').setValue(snap.data()!['airwaybill_no']);
                      sheet.getRangeByName('F${j+7}').setText(snap.data()!['country']);
                      sheet.getRangeByName('G${j+7}').setValue(snap.data()!['weight']);
                      sheet.getRangeByName('H${j+7}').setValue(snap.data()!['amount']);
                      sheet.getRangeByName('K${j+7}').setFormula('=H${j+7}+I${j+7}+J${j+7}');
                      sheet.getRangeByName('L${j+7}').setText(snap.data()!['service']);
                      counter++;
                      j++;
                    }
                  };
                }
                return Text('Done');
              },
            ),

            SizedBox(height: 20,),

            ElevatedButton(
              onPressed: () async {
                createShipment(context);
              },
              child: Text('Create Excel'),
            ),
          ],
        )
      ),
    );
  }

  Future<void> createShipment(BuildContext context) async {

    print(startDate);
    print(endDate);
    print(clientsDropdownvalue);

    sheet.getRangeByName('K${6+counter+1}').setFormula('=SUM(K${6+counter}:K${7})');

    final List<int> bytes = workbook.saveAsStream();
    workbook.dispose();

    if(kIsWeb){
      html.AnchorElement(href: 'data:application/octet-stream;charset=utf-16le;base64,${base64.encode(bytes)}')
        ..setAttribute('download', '"$clientsDropdownvalue ${DateFormat("dd/MM/yyyy").format(startDate)}-${DateFormat("dd/MM/yyyy").format(endDate)}".xlsx')
        ..click();
      Future.delayed(Duration(milliseconds: 500), () {
        Navigator.push(context, MaterialPageRoute(builder: (c) =>
            MultiProvider(
              providers: [
                ChangeNotifierProvider(
                  create: (context) => MenuController(),
                ),
              ],
              child: AdminMakeBillScreen(),
            ),
        ));
      });
      //Navigator.push(context, MaterialPageRoute(builder: (c) => AdminMakeBillScreen()));
    }else {
      final String path = (await getApplicationSupportDirectory()).path;
      final String fileName = Platform.isWindows ? '$path\\"$clientsDropdownvalue $startDate $endDate".xlsx' : '$path/"$clientsDropdownvalue $startDate $endDate".xlsx';
      final File file = File(fileName);
      await file.writeAsBytes(bytes, flush: true);
      //OpenFile.open(fileName);
      //await FileSaver.instance.saveAs(fileName, bytes, ext, mimeType);
      Navigator.push(context, MaterialPageRoute(builder: (c) => AdminMakeBillScreen()));
    }
  }
}
