import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:khanintlexpress/EmployeeScreens/Components/employeeSideMenu.dart';
import 'package:provider/provider.dart';

import '../AdminScreens/Components/menuController.dart';
import '../AppBar/customAppBar.dart';
import '../Global/global.dart';
import '../Models/shipment.dart';
import 'employeeUpdateTableScreen.dart';

List<Shipment> myShipment = [];

void onEditShipment(
    BuildContext context,
    String clients,
    DateTime date,
    String shipment_type,
    String airwaybill_no,
    String country,
    String weight,
    String service,
    String amount,
    String amount_status,
    String note
    ) {
  // FirebaseFirestore.instance.collection("shipment").doc(airwaybill_no).delete();
  //Navigator.push(context, MaterialPageRoute(builder: (c) => AdminUpdateTableScreen()));
  Future.delayed(Duration(milliseconds: 500), () {
    Navigator.push(context, MaterialPageRoute(builder: (c) =>
        MultiProvider(
          providers: [
            ChangeNotifierProvider(
              create: (context) => MenuController(),
            ),
          ],
          child: EmployeeUpdateTableScreen(
            clients: clients,
            date: date,
            shipment_type: shipment_type,
            airwaybill_no: airwaybill_no,
            country: country,
            weight: weight,
            service: service,
            amount: amount,
            amount_status: amount_status,
            note: note,
          ),
        ),
    ));
  });
}

void onDeleteShipment(String airwaybill_no) {
  FirebaseFirestore.instance.collection("shipment").doc(airwaybill_no).delete();
}

class EmployeeTableScreen extends StatefulWidget {
  const EmployeeTableScreen({Key? key}) : super(key: key);

  @override
  State<EmployeeTableScreen> createState() => _EmployeeTableScreenState();
}

class _EmployeeTableScreenState extends State<EmployeeTableScreen> {

  bool _isLoading = true;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    Future.delayed(Duration(seconds: 2), () {
      setState(() {
        _isLoading = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: context.read<MenuController>().scaffoldKey,
      appBar: CustomAppBar(),
      drawer: EmployeeSideMenu(),
      body: ListView(
        children: [
          LayoutBuilder(
            builder: (context, constraints) {
              if (constraints.maxWidth < 600) {
                return const EmployeeTableMobile();
              } else if (constraints.maxWidth > 600 && constraints.maxWidth < 900) {
                return const EmployeeTableMobile();
              } else {
                return const EmployeeTableMobile();
              }
            },
          )
        ],
      ),
    );
  }
}

class EmployeeTableMobile extends StatefulWidget {
  const EmployeeTableMobile({Key? key}) : super(key: key);

  @override
  State<EmployeeTableMobile> createState() => _EmployeeTableMobileState();
}

class _EmployeeTableMobileState extends State<EmployeeTableMobile> {

  bool sort = true;
  List<Shipment>? filterDataShipment;
  bool _isLoading = true;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    Future.delayed(Duration(seconds: 2), () {
      setState(() {
        _isLoading = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {

    bool darkTheme = MediaQuery.of(context).platformBrightness == Brightness.dark;

    onsortColumnShipment(int columnIndex, bool ascending) {
      if (columnIndex == 0) {
        if (ascending) {
          filterDataShipment!.sort((a, b) => a.id!.compareTo(b.id!));
        } else {
          filterDataShipment!.sort((a, b) => b.id!.compareTo(a.id!));
        }
      }
    }

    return Center(
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.fromLTRB(20, 20, 20, 0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    IconButton(
                      onPressed: context.read<MenuController>().controlMenu,
                      icon: Icon(Icons.menu),
                    ),

                    // if(!Responsive.isMobile(context))
                    Text(
                      "Table",
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

          Container(
            margin: EdgeInsets.all(20),
            padding: EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: darkTheme ? Colors.black : Colors.grey.shade200,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Column(
              children: [

                Text(
                  'Shipment',
                  style: TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                    color: darkTheme ? Colors.white: Colors.black,
                  ),
                ),

                StreamBuilder(
                  stream: FirebaseFirestore.instance.collection('shipment').snapshots(),
                  //initialData: myNum,
                  //stream: onVariableChanged,
                  builder: (context, AsyncSnapshot snapshot){
                    if(!snapshot.hasData){
                      return Text('');
                    }
                    else {
                      myShipment = [
                        for(int i = 0;i < snapshot.data.docs.length;i++)
                        //Data(name: snapshot.data.docs[i].data()['clients'], phone: snapshot.data.docs[i].data()['country'], Age: snapshot.data.docs[i].data()['weight'])
                          Shipment(
                              id: i+1,
                              clients: snapshot.data.docs[i].data()['clients'],
                              date: DateFormat('dd/MM/yyyy').format(DateTime.parse(((snapshot.data.docs[i].data()['date'] as Timestamp).toDate()).toString())),
                              shipment_type: snapshot.data.docs[i].data()['shipmentType'],
                              airwaybill_no: snapshot.data.docs[i].data()['airwaybill_no'],
                              country: snapshot.data.docs[i].data()['country'],
                              weight: snapshot.data.docs[i].data()['weight'],
                              service: snapshot.data.docs[i].data()['service'],
                              amount: snapshot.data.docs[i].data()['amount'],
                              amount_status: snapshot.data.docs[i].data()['amount_status'],
                              note: snapshot.data.docs[i].data()['note']
                          )
                      ];
                      filterDataShipment = myShipment;
                      return Text('');
                    }
                  },
                ),

                if(_isLoading) ...[
                  CircularProgressIndicator(),
                ] else ...[
                  ConstrainedBox(
                    constraints: BoxConstraints(
                      minHeight: 200,
                      maxHeight: 1150,
                      maxWidth: double.infinity,
                    ),
                    child: Theme(
                      data: Theme.of(context).copyWith(
                          cardColor: darkTheme ? Colors.transparent : Colors.grey.shade200,
                          dividerColor: Colors.transparent
                      ),
                      child: PaginatedDataTable(
                        sortColumnIndex: 0,
                        sortAscending: sort,
                        rowsPerPage: 20,
                        columnSpacing: 20,
                        horizontalMargin: 0,
                        header: TextField(
                          decoration: InputDecoration(
                            hintText: "Search Airwaybill No.",
                            fillColor: darkTheme ? Colors.black45 : Colors.grey.shade100,
                            filled: true,
                            border: OutlineInputBorder(
                              borderSide: BorderSide.none,
                              borderRadius: BorderRadius.all(Radius.circular(10)),
                            ),
                            suffixIcon: InkWell(
                              onTap: () {},
                              child: Container(
                                padding: EdgeInsets.all(16 * 0.75),
                                margin: EdgeInsets.symmetric(horizontal: 16/2),
                                decoration: BoxDecoration(
                                  color: primaryColor,
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                // child: SvgPicture.asset('assets/icons/Search.svg'),
                                child: Icon(Icons.search,color: Colors.white,size: 15,),
                              ),
                            ),
                          ),
                          onChanged: (value) {
                            setState(() {
                              myShipment = filterDataShipment!.where((element) => element.airwaybill_no!.contains(value)).toList();
                            });
                          },
                        ),
                        columns: [
                          DataColumn(
                              label: const Text(
                                "ID",
                                style: TextStyle(
                                    fontWeight: FontWeight.w600, fontSize: 14),
                              ),
                              onSort: (columnIndex, ascending) {
                                setState(() {
                                  sort = !sort;
                                });

                                onsortColumnShipment(columnIndex, ascending);
                              }
                          ),
                          DataColumn(label: Text("Clients",),),
                          DataColumn(label: Text("Date",),),
                          DataColumn(label: Text("Shipment Type",),),
                          DataColumn(label: Text("Airwaybill No.",),),
                          DataColumn(label: Text("Country",),),
                          DataColumn(label: Text("Weight",),),
                          DataColumn(label: Text("Service",),),
                          DataColumn(label: Text("Amount",),),
                          DataColumn(label: Text("Amount Status",),),
                          DataColumn(label: Text("Note",),),
                          DataColumn(label: Text("Edit",),),
                          // DataColumn(label: Text("Delete",),),
                        ],
                        source: RowSourceShipment(
                          myData: myShipment,
                          count: myShipment.length,
                        ),
                      ),
                    ),
                  ),
                ]
              ],
            ),
          )
        ],
      ),
    );
  }
}

class RowSourceShipment extends DataTableSource {
  var myData;
  final count;
  RowSourceShipment({
    required this.myData,
    required this.count,
  });

  @override
  DataRow? getRow(int index) {
    if (index < rowCount) {
      return recentFileDataRowShipment(myData![index]);
    } else
      return null;
  }

  @override
  bool get isRowCountApproximate => false;

  @override
  int get rowCount => count;

  @override
  int get selectedRowCount => 0;
}

DataRow recentFileDataRowShipment(var data) {
  return DataRow(
    cells: [
      DataCell(Text(data.id.toString())),
      DataCell(Text(data.clients.toString())),
      DataCell(Text(data.date.toString())),
      DataCell(Text(data.shipment_type.toString())),
      DataCell(Text(data.airwaybill_no.toString())),
      DataCell(Text(data.country.toString())),
      DataCell(Text(data.weight.toString())),
      DataCell(Text(data.service.toString())),
      DataCell(Text(data.amount.toString())),
      DataCell(Text(data.amount_status.toString())),
      DataCell(Text(data.note.toString())),
      DataCell(Builder(builder: (context) {
        return ElevatedButton(
          style: ElevatedButton.styleFrom(
            primary: Colors.green,
            onPrimary: Colors.white,
            elevation: 0, //////// HERE
          ),
          onPressed: () {
            print("Date: ${DateFormat('dd/MM/yyyy').parse(data.date)}");
            onEditShipment(
                context,
                data.clients.toString(),
                DateFormat('dd/MM/yyyy').parse(data.date),
                data.shipment_type.toString(),
                data.airwaybill_no.toString(),
                data.country.toString(),
                data.weight.toString(),
                data.service.toString(),
                data.amount.toString(),
                data.amount_status.toString(),
                data.note.toString()
            );
          },
          child: Text(
            'Edit',
          ),
        );
      })),
      // DataCell(
      //   ElevatedButton(
      //     style: ElevatedButton.styleFrom(
      //       primary: Colors.red,
      //       onPrimary: Colors.white,
      //       elevation: 0, //////// HERE
      //     ),
      //     onPressed: () {
      //       onDeleteShipment(data.airwaybill_no.toString());
      //     },
      //     child: Text(
      //       'Delete',
      //     ),
      //   ),
      // ),
    ],
  );
}