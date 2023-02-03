import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:image_network/image_network.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../AppBar/customAppBar.dart';
import '../Global/global.dart';
import '../Global/responsive.dart';
import '../Models/pickupRequest.dart';
import 'Components/adminSideMenu.dart';
import 'Components/menuController.dart';

List<PickupRequest> myPickupRequest = [];

class AdminProfileScreen extends StatefulWidget {
  const AdminProfileScreen({Key? key}) : super(key: key);

  @override
  State<AdminProfileScreen> createState() => _AdminProfileScreenState();
}

class _AdminProfileScreenState extends State<AdminProfileScreen> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: context.read<MenuController>().scaffoldKey,
      appBar: CustomAppBar(),
      drawer: AdminSideMenu(),
      body: ListView(
        children: [
          LayoutBuilder(
            builder: (context, constraints) {
              if (constraints.maxWidth < 600) {
                return const AdminProfileMobile();
              } else if (constraints.maxWidth > 600 && constraints.maxWidth < 900) {
                return const AdminProfileMobile();
              } else {
                return const AdminProfileMobile();
              }
            },
          )
        ],
      ),
    );
  }
}

class AdminProfileMobile extends StatefulWidget {
  const AdminProfileMobile({Key? key}) : super(key: key);

  @override
  State<AdminProfileMobile> createState() => _AdminProfileMobileState();
}

class _AdminProfileMobileState extends State<AdminProfileMobile> {

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

    return Column(
      children: [
        Stack(
          children: [

            //Background
            Container(
              height: 250,
              width: double.infinity,
            ),

            //Cover Photo
            Container(
              height: 200,
              width: double.infinity,
              decoration: BoxDecoration(
                // color: Colors.blue,
              ),
              child: Image.asset("assets/images/cover.jpg"),
            ),

            //Edit Cover Photo Button
            // Positioned(
            //   top: 160,
            //   right: 15,
            //   child: ElevatedButton(
            //     style: ElevatedButton.styleFrom(
            //       primary: Colors.white,
            //       onPrimary: Colors.black,
            //       elevation: 0, //////// HERE
            //     ),
            //     onPressed: () {
            //
            //     },
            //     child: Row(
            //       children: [
            //
            //         Icon(
            //           Icons.camera_alt,
            //         ),
            //
            //         SizedBox(width: 5,),
            //
            //         Text(
            //           'Edit cover photo',
            //         )
            //       ],
            //     ),
            //   ),
            // ),

            //Edit Profile Button
            Positioned(
              bottom: 10,
              right: 20,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  primary: Colors.grey.shade700,
                  onPrimary: Colors.white,
                  elevation: 0, //////// HERE
                ),
                onPressed: () {

                },
                child: Row(
                  children: [

                    Icon(
                      Icons.edit,
                      size: 13,
                    ),

                    SizedBox(width: 5,),

                    Text(
                      'Edit profile',
                      style: TextStyle(
                        fontSize: 12,
                      ),
                    )
                  ],
                ),
              ),
            ),


            Positioned(
              left: 20,
              top: 150,
              child: Row(
                children: [
                  Stack(
                    children: [
                      Container(
                        //padding: EdgeInsets.all(30),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(
                            width: 2,
                            color: Colors.black54,
                          ),
                          // color: Colors.green,
                        ),
                        // child: Icon(
                        //   Icons.person,
                        // ),
                        child: ClipOval(
                          child: ImageNetwork(
                            height: 90,
                            width: 90,
                            image: "https://firebasestorage.googleapis.com/v0/b/khanintlexpress-fcd9c.appspot.com/o/users%2F${userModelCurrentInfo!.uid}%2Fpro-pic.png?alt=media&token=0f442e20-dfb2-47ab-85e1-0642520dedd0",
                          ),
                        ),
                      ),

                      //Profile Photo Edit Button
                      Positioned(
                        bottom: 0,
                        right: 0,
                        child: Container(
                          padding: EdgeInsets.all(5),
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.black54,
                          ),
                          child: Icon(
                            Icons.camera_alt,
                            size: 15,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ],
                  ),

                  SizedBox(width: 10,),

                  Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [

                      SizedBox(height: 45,),

                      Text(
                        userModelCurrentInfo!.name!,
                        style: TextStyle(
                          fontSize: 18,
                        ),
                      ),
                    ],
                  ),

                ],
              ),
            ),

            Positioned(
              top: 10,
              left: 10,
              child: IconButton(
                onPressed: context.read<MenuController>().controlMenu,
                icon: Icon(Icons.menu),
              ),
            )

          ],
        ),

        //For later update
        ListView(
          scrollDirection: Axis.vertical,
          shrinkWrap: true,
          children: [
            Padding(
              padding: EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding: EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: darkTheme ? Colors.black : Colors.grey.shade200,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Column(
                      children: [

                        Text(
                          'Pickup Requested History',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: darkTheme ? Colors.white: Colors.black,
                          ),
                        ),

                        StreamBuilder(
                          stream: FirebaseFirestore.instance.collection('pickupRequest').snapshots(),
                          //initialData: myNum,
                          // stream: onVariableChanged,
                          builder: (context, AsyncSnapshot snapshot){
                            if(!snapshot.hasData){
                              return Text('');
                            }
                            else {
                              myPickupRequest = [
                                for(int i = 0;i < snapshot.data.docs.length;i++)
                                  if(snapshot.data.docs[i].data()['sender_uid'] == userModelCurrentInfo!.uid)
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
                              return Text('');
                            }
                          },
                        ),

                        if(_isLoading) ...[
                          CircularProgressIndicator(),
                        ] else  ...[
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
                                //sortAscending: sort,
                                rowsPerPage: 10,
                                columnSpacing: 20,
                                horizontalMargin: 0,
                                columns: [
                                  DataColumn(
                                    label: const Text(
                                      "ID",
                                      // style: TextStyle(
                                      //     fontWeight: FontWeight.w600, fontSize: 14
                                      // ),
                                    ),
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
                                  // DataColumn(label: Text("Edit",),),
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
                ],
              )
            )
          ],
        ),

      ],
    );
  }
}

class AdminProfileDesktop extends StatefulWidget {
  const AdminProfileDesktop({Key? key}) : super(key: key);

  @override
  State<AdminProfileDesktop> createState() => _AdminProfileDesktopState();
}

class _AdminProfileDesktopState extends State<AdminProfileDesktop> {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
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
      // DataCell(
      //   ElevatedButton(
      //     style: ElevatedButton.styleFrom(
      //       primary: Colors.green,
      //       onPrimary: Colors.white,
      //       elevation: 0, //////// HERE
      //     ),
      //     onPressed: () {
      //
      //     },
      //     child: Text(
      //       'Edit',
      //     ),
      //   ),
      // ),
      // DataCell(
      //   ElevatedButton(
      //     style: ElevatedButton.styleFrom(
      //       primary: Colors.red,
      //       onPrimary: Colors.white,
      //       elevation: 0, //////// HERE
      //     ),
      //     onPressed: () {
      //       // onDeleteShipment(data.airwaybill_no.toString());
      //       //onDeletePickupRequest(data.uid.toString());
      //     },
      //     child: Text(
      //       'Delete',
      //     ),
      //   ),
      // ),
    ],
  );
}