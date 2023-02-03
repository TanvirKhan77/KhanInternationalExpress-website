import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:image_network/image_network.dart';
import 'package:intl/intl.dart';
import 'package:khanintlexpress/EmployeeScreens/Components/header.dart';

import '../../AdminScreens/Components/firestoreData.dart';
import '../../Global/global.dart';
import '../../Models/pickupRequest.dart';
import '../../Models/shipment.dart';

int myNum = 0;

List<Data> myData = [];
List<PickupRequest> myPickupRequest = [];
List<Shipment> myShipment = [];

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({Key? key}) : super(key: key);

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

void onDelete(String uid) {
  FirebaseFirestore.instance.collection("contacted").doc(uid).delete();
}

void onDeletePickupRequest(String uid) {
  FirebaseFirestore.instance.collection("pickupRequest").doc(uid).delete();
}

void onDeleteShipment(String airwaybill_no) {
  FirebaseFirestore.instance.collection("shipment").doc(airwaybill_no).delete();
}

class _DashboardScreenState extends State<DashboardScreen> {

  bool sort = true;
  List<Data>? filterData;
  List<PickupRequest>? filterDataPickupRequest;
  List<Shipment>? filterDataShipment;

  bool _isLoading = true;

  @override
  void initState() {
    //filterData = myData;
    super.initState();

    Future.delayed(Duration(seconds: 2), () {
      setState(() {
        _isLoading = false;
      });
    });
  }

  @override
  void dispose() {
    //_myStreamCtrl.close();
    super.dispose();
  }

  TextEditingController controller = TextEditingController();


  @override
  Widget build(BuildContext context) {

    bool darkTheme = MediaQuery.of(context).platformBrightness == Brightness.dark;

    onsortColumn(int columnIndex, bool ascending) {
      if (columnIndex == 0) {
        if (ascending) {
          filterData!.sort((a, b) => a.name!.compareTo(b.name!));
        } else {
          filterData!.sort((a, b) => b.name!.compareTo(a.name!));
        }
      }
    }

    onsortColumnPickupRequest(int columnIndex, bool ascending) {
      if (columnIndex == 0) {
        if (ascending) {
          filterDataPickupRequest!.sort((a, b) => a.id!.compareTo(b.id!));
        } else {
          filterDataPickupRequest!.sort((a, b) => b.id!.compareTo(a.id!));
        }
      }
    }

    onsortColumnShipment(int columnIndex, bool ascending) {
      if (columnIndex == 0) {
        if (ascending) {
          filterDataShipment!.sort((a, b) => a.id!.compareTo(b.id!));
        } else {
          filterDataShipment!.sort((a, b) => b.id!.compareTo(a.id!));
        }
      }
    }

    return SafeArea(
      child: SingleChildScrollView(
        padding: EdgeInsets.all(20),
        child: Column(
          children: [
            Header(),

            SizedBox(height: 20,),

            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Container(
                      //   padding: EdgeInsets.all(20),
                      //   decoration: BoxDecoration(
                      //     color: Colors.black,
                      //     borderRadius: BorderRadius.circular(10),
                      //   ),
                      //   child: Column(
                      //     children: [
                      //       Text(
                      //         'Contacted',
                      //       ),
                      //
                      //       ConstrainedBox(
                      //         constraints: BoxConstraints(
                      //           minHeight: 200,
                      //           maxHeight: 400,
                      //           maxWidth: 550,
                      //         ),
                      //         child: ListView(
                      //           shrinkWrap: true,
                      //           children: [
                      //             SingleChildScrollView(
                      //               scrollDirection: Axis.horizontal,
                      //               child: DataTable(
                      //                 horizontalMargin: 0,
                      //                 columnSpacing: 20,
                      //                 columns: [
                      //                   DataColumn(label: Text('Name'),),
                      //                   DataColumn(label: Text('Date'),),
                      //                   DataColumn(label: Text('Phone'),),
                      //                   DataColumn(label: Text('Email'),),
                      //                   DataColumn(label: Text('Message'),),
                      //                   DataColumn(label: Text('Status'),),
                      //                 ],
                      //                 rows: List.generate(demoRecentFiles.length, (index) => recentFileDataRow(demoRecentFiles[index])),
                      //               ),
                      //             ),
                      //
                      //
                      //           ],
                      //         ),
                      //       ),
                      //
                      //       // SizedBox(height: 20,),
                      //
                      //     ],
                      //   ),
                      // ),
                      //
                      // SizedBox(height: 20,),

                      Container(
                        padding: EdgeInsets.all(20),
                        decoration: BoxDecoration(
                          color: darkTheme ? Colors.black : Colors.grey.shade200,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Column(
                          children: [

                            Text(
                              'Pickup Request',
                              style: TextStyle(
                                fontSize: 25,
                                fontWeight: FontWeight.bold,
                                color: darkTheme ? Colors.white: Colors.black,
                              ),
                            ),

                            StreamBuilder(
                              stream: FirebaseFirestore.instance.collection('pickupRequest').snapshots(),
                              initialData: myNum,
                              // stream: onVariableChanged,
                              builder: (context, AsyncSnapshot snapshot){
                                if(!snapshot.hasData){
                                  return Text('');
                                }
                                else {
                                  myPickupRequest = [
                                    for(int i = 0;i < snapshot.data.docs.length;i++)
                                      PickupRequest(
                                          id: i+1,
                                          date: DateFormat('dd/MM/yyyy').format(DateTime.parse(((snapshot.data.docs[i].data()['date'] as Timestamp).toDate()).toString())),
                                          sender_uid: snapshot.data.docs[i].data()['sender_uid'],
                                          sender_name: snapshot.data.docs[i].data()['sender_name'],
                                          sender_address: snapshot.data.docs[i].data()['sender_address'],
                                          sender_phone: snapshot.data.docs[i].data()['sender_phone'],
                                          sender_email: snapshot.data.docs[i].data()['sender_email'],
                                          uid: snapshot.data.docs[i].data()['uid'],
                                          receiver_name: snapshot.data.docs[i].data()['receiver_name'],
                                          receiver_address: snapshot.data.docs[i].data()['receiver_address'],
                                          number_of_days: snapshot.data.docs[i].data()['number_of_days'],
                                          country: snapshot.data.docs[i].data()['country'],
                                          weight: snapshot.data.docs[i].data()['weight'],
                                          amount: snapshot.data.docs[i].data()['amount']
                                      )
                                  ];
                                  filterDataPickupRequest = myPickupRequest;
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
                                  maxHeight: 700,
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
                                    rowsPerPage: 10,
                                    columnSpacing: 20,
                                    horizontalMargin: 0,
                                    header: TextField(
                                      decoration: InputDecoration(
                                        hintText: "Search Name",
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
                                          myPickupRequest = filterDataPickupRequest!.where((element) => element.sender_name!.contains(value)).toList();
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

                                            onsortColumnPickupRequest(columnIndex, ascending);
                                          }
                                      ),
                                      DataColumn(label: Text("Photo"),),
                                      DataColumn(label: Text("Date",),),
                                      DataColumn(label: Text("Sender Name",),),
                                      DataColumn(label: Text("Sender Address",),),
                                      DataColumn(label: Text("Sender Phone",),),
                                      DataColumn(label: Text("Sender Email",),),
                                      DataColumn(label: Text("Receiver Name",),),
                                      DataColumn(label: Text("Receiver Address",),),
                                      DataColumn(label: Text("Number of Days Selected",),),
                                      DataColumn(label: Text("Country",),),
                                      DataColumn(label: Text("Weight",),),
                                      DataColumn(label: Text("Amount",),),
                                      DataColumn(label: Text("Edit",),),
                                      // DataColumn(label: Text("Delete",),),
                                    ],
                                    source: RowSourcePickupRequest(
                                      myData: myPickupRequest,
                                      count: myPickupRequest.length,
                                    ),
                                  ),
                                ),
                              ),
                            ]
                          ],
                        ),
                      ),

                      SizedBox(height: 20,),

                      // Container(
                      //   padding: EdgeInsets.all(20),
                      //   decoration: BoxDecoration(
                      //     color: darkTheme ? Colors.black : Colors.grey.shade200,
                      //     borderRadius: BorderRadius.circular(10),
                      //   ),
                      //   child: Column(
                      //     children: [
                      //
                      //       Text(
                      //         'Shipment',
                      //         style: TextStyle(
                      //           fontSize: 25,
                      //           fontWeight: FontWeight.bold,
                      //           color: darkTheme ? Colors.white: Colors.black,
                      //         ),
                      //       ),
                      //
                      //       StreamBuilder(
                      //         stream: FirebaseFirestore.instance.collection('shipment').snapshots(),
                      //         initialData: myNum,
                      //         //stream: onVariableChanged,
                      //         builder: (context, AsyncSnapshot snapshot){
                      //           if(!snapshot.hasData){
                      //             return Text('');
                      //           }
                      //           else {
                      //             myShipment = [
                      //               for(int i = 0;i < snapshot.data.docs.length;i++)
                      //                 //Data(name: snapshot.data.docs[i].data()['clients'], phone: snapshot.data.docs[i].data()['country'], Age: snapshot.data.docs[i].data()['weight'])
                      //                 Shipment(
                      //                     id: i+1,
                      //                     clients: snapshot.data.docs[i].data()['clients'],
                      //                     date: DateFormat('dd/MM/yyyy').format(DateTime.parse(((snapshot.data.docs[i].data()['date'] as Timestamp).toDate()).toString())),
                      //                     shipment_type: snapshot.data.docs[i].data()['shipmentType'],
                      //                     airwaybill_no: snapshot.data.docs[i].data()['airwaybill_no'],
                      //                     country: snapshot.data.docs[i].data()['country'],
                      //                     weight: snapshot.data.docs[i].data()['weight'],
                      //                     service: snapshot.data.docs[i].data()['service'],
                      //                     amount: snapshot.data.docs[i].data()['amount'],
                      //                     amount_status: snapshot.data.docs[i].data()['amount_status'],
                      //                     note: snapshot.data.docs[i].data()['note']
                      //                 )
                      //             ];
                      //             filterDataShipment = myShipment;
                      //             return Text('');
                      //           }
                      //         },
                      //       ),
                      //
                      //       if(_isLoading) ...[
                      //         CircularProgressIndicator(),
                      //       ] else ...[
                      //         ConstrainedBox(
                      //           constraints: BoxConstraints(
                      //             minHeight: 200,
                      //             maxHeight: 700,
                      //             maxWidth: double.infinity,
                      //           ),
                      //           child: Theme(
                      //             data: Theme.of(context).copyWith(cardColor: Colors.transparent, dividerColor: Colors.transparent),
                      //             child: PaginatedDataTable(
                      //               sortColumnIndex: 0,
                      //               sortAscending: sort,
                      //               rowsPerPage: 10,
                      //               columnSpacing: 20,
                      //               horizontalMargin: 0,
                      //               header: TextField(
                      //                 decoration: InputDecoration(
                      //                   hintText: "Search Airwaybill No.",
                      //                   fillColor: Colors.black54,
                      //                   filled: true,
                      //                   border: OutlineInputBorder(
                      //                     borderSide: BorderSide.none,
                      //                     borderRadius: BorderRadius.all(Radius.circular(10)),
                      //                   ),
                      //                   suffixIcon: InkWell(
                      //                     onTap: () {},
                      //                     child: Container(
                      //                       padding: EdgeInsets.all(16 * 0.75),
                      //                       margin: EdgeInsets.symmetric(horizontal: 16/2),
                      //                       decoration: BoxDecoration(
                      //                         color: primaryColor,
                      //                         borderRadius: BorderRadius.circular(10),
                      //                       ),
                      //                       // child: SvgPicture.asset('assets/icons/Search.svg'),
                      //                       child: Icon(Icons.search,color: Colors.white,size: 15,),
                      //                     ),
                      //                   ),
                      //                 ),
                      //                 onChanged: (value) {
                      //                   setState(() {
                      //                     myShipment = filterDataShipment!.where((element) => element.airwaybill_no!.contains(value)).toList();
                      //                   });
                      //                 },
                      //               ),
                      //               columns: [
                      //                 DataColumn(
                      //                     label: const Text(
                      //                       "ID",
                      //                       style: TextStyle(
                      //                           fontWeight: FontWeight.w600, fontSize: 14),
                      //                     ),
                      //                     onSort: (columnIndex, ascending) {
                      //                       setState(() {
                      //                         sort = !sort;
                      //                       });
                      //
                      //                       onsortColumnShipment(columnIndex, ascending);
                      //                     }
                      //                 ),
                      //                 DataColumn(label: Text("Clients",),),
                      //                 DataColumn(label: Text("Date",),),
                      //                 DataColumn(label: Text("Shipment Type",),),
                      //                 DataColumn(label: Text("Airwaybill No.",),),
                      //                 DataColumn(label: Text("Country",),),
                      //                 DataColumn(label: Text("Weight",),),
                      //                 DataColumn(label: Text("Service",),),
                      //                 DataColumn(label: Text("Amount",),),
                      //                 DataColumn(label: Text("Amount Status",),),
                      //                 DataColumn(label: Text("Note",),),
                      //                 DataColumn(label: Text("Edit",),),
                      //                 DataColumn(label: Text("Delete",),),
                      //               ],
                      //               source: RowSourceShipment(
                      //                 myData: myShipment,
                      //                 count: myShipment.length,
                      //               ),
                      //             ),
                      //           ),
                      //         ),
                      //       ]
                      //     ],
                      //   ),
                      // ),
                      //
                      // SizedBox(height: 20,),

                      Container(
                        padding: EdgeInsets.all(20),
                        decoration: BoxDecoration(
                          color: darkTheme ? Colors.black : Colors.grey.shade200,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Column(
                          children: [

                            Text(
                              'Contacted',
                              style: TextStyle(
                                fontSize: 25,
                                fontWeight: FontWeight.bold,
                                color: darkTheme ? Colors.white: Colors.black,
                              ),
                            ),

                            if(_isLoading) ...[
                              CircularProgressIndicator(),
                            ] else ...[
                              ConstrainedBox(
                                constraints: BoxConstraints(
                                  minHeight: 200,
                                  maxHeight: 620,
                                  maxWidth: double.infinity,
                                ),
                                child: Theme(
                                  data: Theme.of(context).copyWith(
                                      cardColor: darkTheme ? Colors.transparent : Colors.grey.shade200,
                                      dividerColor: Colors.transparent
                                  ),
                                  child: StreamBuilder(
                                    stream: FirebaseFirestore.instance.collection("contacted").snapshots(),
                                    builder: (context, AsyncSnapshot snapshot) {
                                      return PaginatedDataTable(
                                        sortColumnIndex: 0,
                                        sortAscending: sort,
                                        rowsPerPage: 10,
                                        columnSpacing: 20,
                                        horizontalMargin: 0,
                                        columns: [
                                          DataColumn(label: Text('Name',style: TextStyle(fontWeight: FontWeight.bold),),),
                                          DataColumn(label: Text('Date',style: TextStyle(fontWeight: FontWeight.bold),),),
                                          DataColumn(label: Text('Phone',style: TextStyle(fontWeight: FontWeight.bold),),),
                                          DataColumn(label: Text('Email',style: TextStyle(fontWeight: FontWeight.bold),),),
                                          DataColumn(label: Text('Message',style: TextStyle(fontWeight: FontWeight.bold),),),
                                          DataColumn(label: Text('Status',style: TextStyle(fontWeight: FontWeight.bold),),),
                                          //DataColumn(label: Text('Delete',style: TextStyle(fontWeight: FontWeight.bold),),),
                                        ],
                                        source: Contacted(snapshot.data.docs),
                                      );
                                    },
                                  ),
                                ),
                              ),
                            ]
                          ],
                        ),
                      ),

                    ],
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}

class RowSource extends DataTableSource {
  var myData;
  final count;
  RowSource({
    required this.myData,
    required this.count,
  });

  @override
  DataRow? getRow(int index) {
    if (index < rowCount) {
      return recentFileDataRow(myData![index]);
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

DataRow recentFileDataRow(var data) {
  return DataRow(
    cells: [
      DataCell(Text(data.name.toString())),
      DataCell(Text(data.phone.toString())),
      DataCell(Text(data.Age.toString())),
      DataCell(Text(data.phone.toString())),
      DataCell(Text(data.Age.toString())),
      DataCell(Text(data.phone.toString())),
    ],
  );
}

class RowSourcePickupRequest extends DataTableSource {
  var myData;
  final count;
  RowSourcePickupRequest({
    required this.myData,
    required this.count,
  });

  @override
  DataRow? getRow(int index) {
    if (index < rowCount) {
      return recentFileDataRowPickupRequest(myData![index]);
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

DataRow recentFileDataRowPickupRequest(var data) {
  return DataRow(
    cells: [
      DataCell(Text(data.id.toString())),
      DataCell(
        ImageNetwork(
            image: "https://firebasestorage.googleapis.com/v0/b/khanintlexpress-fcd9c.appspot.com/o/users%2F${data.sender_uid.toString()}%2Fpro-pic.png?alt=media&token=0f442e20-dfb2-47ab-85e1-0642520dedd0",
            height: 30,
            width: 30
        ),
      ),
      DataCell(Text(data.date.toString())),
      DataCell(Text(data.sender_name.toString())),
      DataCell(Text(data.sender_address.toString())),
      DataCell(Text(data.sender_phone.toString())),
      DataCell(Text(data.sender_email.toString())),
      DataCell(Text(data.receiver_name.toString())),
      DataCell(Text(data.receiver_address.toString())),
      DataCell(Text(data.number_of_days.toString())),
      DataCell(Text(data.country.toString())),
      DataCell(Text(data.weight.toString())),
      DataCell(Text(data.amount.toString())),
      DataCell(
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            primary: Colors.green,
            onPrimary: Colors.white,
            elevation: 0, //////// HERE
          ),
          onPressed: () {

          },
          child: Text(
            'Edit',
          ),
        ),
      ),
      // DataCell(
      //   ElevatedButton(
      //     style: ElevatedButton.styleFrom(
      //       primary: Colors.red,
      //       onPrimary: Colors.white,
      //       elevation: 0, //////// HERE
      //     ),
      //     onPressed: () {
      //       // onDeleteShipment(data.airwaybill_no.toString());
      //       onDeletePickupRequest(data.uid.toString());
      //     },
      //     child: Text(
      //       'Delete',
      //     ),
      //   ),
      // ),
    ],
  );
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
      DataCell(
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            primary: Colors.green,
            onPrimary: Colors.white,
            elevation: 0, //////// HERE
          ),
          onPressed: () {

          },
          child: Text(
            'Edit',
          ),
        ),
      ),
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

// The "soruce" of the table
class Contacted extends DataTableSource {
  Contacted(this._data);
  final List<dynamic> _data;

  @override
  bool get isRowCountApproximate => false;
  @override
  int get rowCount => _data.length;
  @override
  int get selectedRowCount => 0;
  @override
  DataRow getRow(int index) {
    return DataRow(cells: [
      DataCell(
        Row(
          children: [
            //Image.asset("assets/images/user.png",height: 30, width: 30,),
            ImageNetwork(
                image: _data[index].data()["status"] != "Guest"
                    ? "https://firebasestorage.googleapis.com/v0/b/khanintlexpress-fcd9c.appspot.com/o/users%2F${_data[index].data()["uid"]}%2Fpro-pic.png?alt=media&token=0f442e20-dfb2-47ab-85e1-0642520dedd0"
                    : "https://firebasestorage.googleapis.com/v0/b/khanintlexpress-fcd9c.appspot.com/o/user.png?alt=media&token=e93ff366-00bf-4333-9a36-48588614b3ff",
                height: 30,
                width: 30
            ),
            SizedBox(width: 15,),
            Text(_data[index].data()['name']),
          ],
        ),
      ),
      //DataCell(Text(((_data[index].data()["date"] as Timestamp).toDate()).toString())),
      //DataCell(Text(DateFormat('dd-MM-yyyy h:mm a').format(DateTime.parse(((_data[index].data()["date"] as Timestamp).toDate()).toString())))),
      DataCell(Text(DateFormat('dd/MM/yyyy').format(DateTime.parse(((_data[index].data()["date"] as Timestamp).toDate()).toString())))),
      DataCell(Text(_data[index].data()['phone'])),
      DataCell(Text(_data[index].data()["email"])),
      DataCell(Text(_data[index].data()['message'])),
      DataCell(Text(_data[index].data()["status"])),
      // DataCell(
      //   ElevatedButton(
      //     style: ElevatedButton.styleFrom(
      //       primary: Colors.red,
      //       onPrimary: Colors.white,
      //       elevation: 0, //////// HERE
      //     ),
      //     onPressed: () {
      //       onDelete(_data[index].data()["uid"]);
      //     },
      //     child: Text(
      //       'Delete',
      //     ),
      //   ),
      // ),
    ]);
  }
}