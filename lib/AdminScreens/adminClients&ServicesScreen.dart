import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_network/image_network.dart';
import 'package:intl/intl.dart';
import 'package:khanintlexpress/AppBar/customAppBar.dart';
import 'package:provider/provider.dart';

import '../Widgets/loading_dialog.dart';
import 'Components/adminSideMenu.dart';
import 'Components/menuController.dart';

TextEditingController clientsTextEditingController = TextEditingController();
TextEditingController servicesTextEditingController = TextEditingController();

addClients(BuildContext context){
  if(clientsTextEditingController.text.isNotEmpty){
    showDialog(context: context, builder: (c){
      return LoadingDialogWidget(
        message: "Adding Clients",
      );
    });

    DocumentReference reference = FirebaseFirestore.instance.collection("clients").doc();
    reference.set({
      "uid": reference.id,
      "name": clientsTextEditingController.text.trim(),
    });

    Navigator.pop(context);
  }
  else{
    showDialog(context: context, builder: (c){
      return LoadingDialogWidget(
        message: "Field is Empty",
      );
    });
    Navigator.pop(context);
  }
}

addServices(BuildContext context){
  if(servicesTextEditingController.text.isNotEmpty){
    showDialog(context: context, builder: (c){
      return LoadingDialogWidget(
        message: "Adding Services",
      );
    });

    DocumentReference reference = FirebaseFirestore.instance.collection("service").doc();
    reference.set({
      "uid": reference.id,
      "name": servicesTextEditingController.text.trim(),
    });

    Navigator.pop(context);
  }
  else{
    showDialog(context: context, builder: (c){
      return LoadingDialogWidget(
        message: "Field is Empty",
      );
    });
    Navigator.pop(context);
  }
}

class AdminClientsServicesScreen extends StatefulWidget {
  const AdminClientsServicesScreen({Key? key}) : super(key: key);

  @override
  State<AdminClientsServicesScreen> createState() => _AdminClientsServicesScreenState();
}

class _AdminClientsServicesScreenState extends State<AdminClientsServicesScreen> {
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
                return const AdminClientsSerivcesMobile();
              } else if (constraints.maxWidth > 600 && constraints.maxWidth < 900) {
                return const AdminClientsSerivcesMobile();
              } else {
                return const AdminClientsServicesDesktop();
              }
            },
          ),
        ],
      ),
    );
  }
}

class AdminClientsSerivcesMobile extends StatefulWidget {
  const AdminClientsSerivcesMobile({Key? key}) : super(key: key);

  @override
  State<AdminClientsSerivcesMobile> createState() => _AdminClientsSerivcesMobileState();
}

class _AdminClientsSerivcesMobileState extends State<AdminClientsSerivcesMobile> {

  bool sort = true;

  @override
  Widget build(BuildContext context) {

    bool darkTheme = MediaQuery.of(context).platformBrightness == Brightness.dark;

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
                      "Clients & Services",
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

          SizedBox(height: 20,),

          Container(
            margin: const EdgeInsets.symmetric(horizontal: 20),
            padding: const EdgeInsets.all(20),
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
              //color: Colors.white,
              color: darkTheme ? Colors.black45 : Colors.grey.shade100,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('Clients',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: darkTheme ? Colors.amberAccent.shade400 : Colors.black,
                  ),
                ),

                Container(
                  margin: EdgeInsets.fromLTRB(0, 20, 0, 20),
                  width: MediaQuery.of(context).size.width > 300 ? 400 : 300,
                  padding: EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: Colors.transparent,
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(width: 2,color: darkTheme ? Colors.amberAccent.shade400 : Colors.blue),
                  ),
                  child: Column(
                    children: [
                      TextFormField(
                        controller: clientsTextEditingController,
                        keyboardType: TextInputType.multiline,
                        inputFormatters: [
                          LengthLimitingTextInputFormatter(200)
                        ],
                        maxLines: null,
                        decoration: InputDecoration(
                          hintText: 'Add Clients',
                          hintStyle: TextStyle(
                            color: darkTheme ? Colors.grey : Colors.grey,
                          ),
                          filled: true,
                          fillColor: darkTheme ? Colors.black45 : Colors.grey.shade200,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(40),
                            borderSide: const BorderSide(
                              width: 0,
                              style: BorderStyle.none,
                            ),
                          ),
                          //border: InputBorder.none,
                          prefixIcon: Icon(Icons.message, color: darkTheme ? Colors.amberAccent.shade400 : Colors.grey,),
                        ),
                      ),

                      const SizedBox(height: 20,),

                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          primary: darkTheme ? Colors.amberAccent.shade400 : Colors.blue,
                          onPrimary: darkTheme ? Colors.black : Colors.white,
                          elevation: 0,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(32.0)),
                          minimumSize: const Size(100, 40), //////// HERE
                        ),
                        onPressed: () {
                          addClients(context);
                        },
                        child: const Text('Submit'),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          SizedBox(height: 20,),

          Container(
            margin: const EdgeInsets.symmetric(horizontal: 20),
            padding: const EdgeInsets.all(20),
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
              //color: Colors.white,
              color: darkTheme ? Colors.black45 : Colors.grey.shade100,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('Services',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: darkTheme ? Colors.amberAccent.shade400 : Colors.black,
                  ),
                ),

                Container(
                  margin: EdgeInsets.fromLTRB(0, 20, 0, 20),
                  width: MediaQuery.of(context).size.width > 300 ? 400 : 300,
                  padding: EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: Colors.transparent,
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(width: 2,color: darkTheme ? Colors.amberAccent.shade400 : Colors.blue),
                  ),
                  child: Column(
                    children: [
                      TextFormField(
                        controller: servicesTextEditingController,
                        keyboardType: TextInputType.multiline,
                        inputFormatters: [
                          LengthLimitingTextInputFormatter(200)
                        ],
                        maxLines: null,
                        decoration: InputDecoration(
                          hintText: 'Add Services',
                          hintStyle: TextStyle(
                            color: darkTheme ? Colors.grey : Colors.grey,
                          ),
                          filled: true,
                          fillColor: darkTheme ? Colors.black45 : Colors.grey.shade200,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(40),
                            borderSide: const BorderSide(
                              width: 0,
                              style: BorderStyle.none,
                            ),
                          ),
                          //border: InputBorder.none,
                          prefixIcon: Icon(Icons.message, color: darkTheme ? Colors.amberAccent.shade400 : Colors.grey,),
                        ),
                      ),

                      const SizedBox(height: 20,),

                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          primary: darkTheme ? Colors.amberAccent.shade400 : Colors.blue,
                          onPrimary: darkTheme ? Colors.black : Colors.white,
                          elevation: 0,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(32.0)),
                          minimumSize: const Size(100, 40), //////// HERE
                        ),
                        onPressed: () {
                          addServices(context);
                        },
                        child: const Text('Submit'),
                      ),
                    ],
                  ),
                ),

              ],
            ),
          ),

          Container(
            margin: EdgeInsets.fromLTRB(20, 20, 20, 20),
            padding: EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: darkTheme ? Colors.black : Colors.grey.shade200,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Column(
              children: [

                Text(
                  'Clients',
                  style: TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                    color: darkTheme ? Colors.white: Colors.black,
                  ),
                ),

                ConstrainedBox(
                  constraints: BoxConstraints(
                    minHeight: 200,
                    maxHeight: 360,
                    maxWidth: double.infinity,
                  ),
                  child: Theme(
                    data: Theme.of(context).copyWith(
                        cardColor: darkTheme ? Colors.transparent : Colors.grey.shade200,
                        dividerColor: Colors.transparent
                    ),
                    child: StreamBuilder(
                      stream: FirebaseFirestore.instance.collection("clients").snapshots(),
                      builder: (context, AsyncSnapshot snapshot) {
                        return PaginatedDataTable(
                          sortColumnIndex: 0,
                          sortAscending: sort,
                          rowsPerPage: 5,
                          columnSpacing: 20,
                          horizontalMargin: 0,
                          columns: [
                            DataColumn(label: Text('ID',style: TextStyle(fontWeight: FontWeight.bold),),),
                            DataColumn(label: Text('Name',style: TextStyle(fontWeight: FontWeight.bold),),),
                            DataColumn(label: Text('Edit',style: TextStyle(fontWeight: FontWeight.bold),),),
                            DataColumn(label: Text('Delete',style: TextStyle(fontWeight: FontWeight.bold),),),
                          ],
                          source: Clients(snapshot.data.docs),
                        );
                      },
                    ),
                  ),
                ),
              ],
            ),
          ),

          Container(
            margin: EdgeInsets.fromLTRB(20, 0, 20, 20),
            padding: EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: darkTheme ? Colors.black : Colors.grey.shade200,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Column(
              children: [

                Text(
                  'Service',
                  style: TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                    color: darkTheme ? Colors.white: Colors.black,
                  ),
                ),

                ConstrainedBox(
                  constraints: BoxConstraints(
                    minHeight: 200,
                    maxHeight: 360,
                    maxWidth: double.infinity,
                  ),
                  child: Theme(
                    data: Theme.of(context).copyWith(
                        cardColor: darkTheme ? Colors.transparent : Colors.grey.shade200,
                        dividerColor: Colors.transparent),
                    child: StreamBuilder(
                      stream: FirebaseFirestore.instance.collection("service").snapshots(),
                      builder: (context, AsyncSnapshot snapshot) {
                        return PaginatedDataTable(
                          sortColumnIndex: 0,
                          sortAscending: sort,
                          rowsPerPage: 5,
                          columnSpacing: 20,
                          horizontalMargin: 0,
                          columns: [
                            DataColumn(label: Text('ID',style: TextStyle(fontWeight: FontWeight.bold),),),
                            DataColumn(label: Text('Name',style: TextStyle(fontWeight: FontWeight.bold),),),
                            DataColumn(label: Text('Edit',style: TextStyle(fontWeight: FontWeight.bold),),),
                            DataColumn(label: Text('Delete',style: TextStyle(fontWeight: FontWeight.bold),),),
                          ],
                          source: Service(snapshot.data.docs),
                        );
                      },
                    ),
                  ),
                ),
              ],
            ),
          ),

        ],
      )
    );
  }
}

class AdminClientsServicesDesktop extends StatefulWidget {
  const AdminClientsServicesDesktop({Key? key}) : super(key: key);

  @override
  State<AdminClientsServicesDesktop> createState() => _AdminClientsServicesDesktopState();
}

class _AdminClientsServicesDesktopState extends State<AdminClientsServicesDesktop> {

  bool sort = true;

  @override
  Widget build(BuildContext context) {

    bool darkTheme = MediaQuery.of(context).platformBrightness == Brightness.dark;

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
                        "Clients & Services",
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

            SizedBox(height: 20,),

            Row(
              children: [
                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 20),
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    //color: Colors.white,
                    color: darkTheme ? Colors.black45 : Colors.grey.shade100,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('Clients',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: darkTheme ? Colors.amberAccent.shade400 : Colors.black,
                        ),
                      ),

                      Container(
                        margin: EdgeInsets.fromLTRB(0, 20, 0, 20),
                        width: 350,
                        padding: EdgeInsets.all(20),
                        decoration: BoxDecoration(
                          color: Colors.transparent,
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(width: 2,color: darkTheme ? Colors.amberAccent.shade400 : Colors.blue),
                        ),
                        child: Column(
                          children: [
                            TextFormField(
                              controller: clientsTextEditingController,
                              keyboardType: TextInputType.multiline,
                              inputFormatters: [
                                LengthLimitingTextInputFormatter(200)
                              ],
                              maxLines: null,
                              decoration: InputDecoration(
                                hintText: 'Add Clients',
                                hintStyle: TextStyle(
                                  color: darkTheme ? Colors.grey : Colors.grey,
                                ),
                                filled: true,
                                fillColor: darkTheme ? Colors.black45 : Colors.grey.shade200,
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(40),
                                  borderSide: const BorderSide(
                                    width: 0,
                                    style: BorderStyle.none,
                                  ),
                                ),
                                //border: InputBorder.none,
                                prefixIcon: Icon(Icons.message, color: darkTheme ? Colors.amberAccent.shade400 : Colors.grey,),
                              ),
                            ),

                            const SizedBox(height: 20,),

                            ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                primary: darkTheme ? Colors.amberAccent.shade400 : Colors.blue,
                                onPrimary: darkTheme ? Colors.black : Colors.white,
                                elevation: 0,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(32.0)),
                                minimumSize: const Size(100, 40), //////// HERE
                              ),
                              onPressed: () {
                                addClients(context);
                              },
                              child: const Text('Submit'),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),

                Container(
                  //margin: const EdgeInsets.symmetric(horizontal: 20),
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    //color: Colors.white,
                    color: darkTheme ? Colors.black45 : Colors.grey.shade100,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('Services',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: darkTheme ? Colors.amberAccent.shade400 : Colors.black,
                        ),
                      ),

                      Container(
                        margin: EdgeInsets.fromLTRB(0, 20, 0, 20),
                        width: 350,
                        padding: EdgeInsets.all(20),
                        decoration: BoxDecoration(
                          color: Colors.transparent,
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(width: 2,color: darkTheme ? Colors.amberAccent.shade400 : Colors.blue),
                        ),
                        child: Column(
                          children: [
                            TextFormField(
                              controller: servicesTextEditingController,
                              keyboardType: TextInputType.multiline,
                              inputFormatters: [
                                LengthLimitingTextInputFormatter(200)
                              ],
                              maxLines: null,
                              decoration: InputDecoration(
                                hintText: 'Add Services',
                                hintStyle: TextStyle(
                                  color: darkTheme ? Colors.grey : Colors.grey,
                                ),
                                filled: true,
                                fillColor: darkTheme ? Colors.black45 : Colors.grey.shade200,
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(40),
                                  borderSide: const BorderSide(
                                    width: 0,
                                    style: BorderStyle.none,
                                  ),
                                ),
                                //border: InputBorder.none,
                                prefixIcon: Icon(Icons.message, color: darkTheme ? Colors.amberAccent.shade400 : Colors.grey,),
                              ),
                            ),

                            const SizedBox(height: 20,),

                            ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                primary: darkTheme ? Colors.amberAccent.shade400 : Colors.blue,
                                onPrimary: darkTheme ? Colors.black : Colors.white,
                                elevation: 0,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(32.0)),
                                minimumSize: const Size(100, 40), //////// HERE
                              ),
                              onPressed: () {
                                addServices(context);
                              },
                              child: const Text('Submit'),
                            ),
                          ],
                        ),
                      ),

                    ],
                  ),
                ),
              ],
            ),

            Row(
              children: [
                Container(
                  margin: EdgeInsets.fromLTRB(20, 20, 20, 20),
                  padding: EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: darkTheme ? Colors.black : Colors.grey.shade200,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Column(
                    children: [

                      Text(
                        'Clients',
                        style: TextStyle(
                          fontSize: 25,
                          fontWeight: FontWeight.bold,
                          color: darkTheme ? Colors.white: Colors.black,
                        ),
                      ),

                      ConstrainedBox(
                        constraints: BoxConstraints(
                          minHeight: 200,
                          maxHeight: 360,
                          maxWidth: 350,
                        ),
                        child: Theme(
                          data: Theme.of(context).copyWith(
                              cardColor: darkTheme ? Colors.transparent : Colors.grey.shade200,
                              dividerColor: Colors.transparent
                          ),
                          child: StreamBuilder(
                            stream: FirebaseFirestore.instance.collection("clients").snapshots(),
                            builder: (context, AsyncSnapshot snapshot) {
                              return PaginatedDataTable(
                                sortColumnIndex: 0,
                                sortAscending: sort,
                                rowsPerPage: 5,
                                columnSpacing: 20,
                                horizontalMargin: 0,
                                columns: [
                                  DataColumn(label: Text('ID',style: TextStyle(fontWeight: FontWeight.bold),),),
                                  DataColumn(label: Text('Name',style: TextStyle(fontWeight: FontWeight.bold),),),
                                  DataColumn(label: Text('Edit',style: TextStyle(fontWeight: FontWeight.bold),),),
                                  DataColumn(label: Text('Delete',style: TextStyle(fontWeight: FontWeight.bold),),),
                                ],
                                source: Clients(snapshot.data.docs),
                              );
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                Container(
                  margin: EdgeInsets.fromLTRB(0, 20, 20, 20),
                  padding: EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: darkTheme ? Colors.black : Colors.grey.shade200,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Column(
                    children: [

                      Text(
                        'Service',
                        style: TextStyle(
                          fontSize: 25,
                          fontWeight: FontWeight.bold,
                          color: darkTheme ? Colors.white: Colors.black,
                        ),
                      ),

                      ConstrainedBox(
                        constraints: BoxConstraints(
                          minHeight: 200,
                          maxHeight: 360,
                          maxWidth: 350,
                        ),
                        child: Theme(
                          data: Theme.of(context).copyWith(
                              cardColor: darkTheme ? Colors.transparent : Colors.grey.shade200,
                              dividerColor: Colors.transparent),
                          child: StreamBuilder(
                            stream: FirebaseFirestore.instance.collection("service").snapshots(),
                            builder: (context, AsyncSnapshot snapshot) {
                              return PaginatedDataTable(
                                sortColumnIndex: 0,
                                sortAscending: sort,
                                rowsPerPage: 5,
                                columnSpacing: 20,
                                horizontalMargin: 0,
                                columns: [
                                  DataColumn(label: Text('ID',style: TextStyle(fontWeight: FontWeight.bold),),),
                                  DataColumn(label: Text('Name',style: TextStyle(fontWeight: FontWeight.bold),),),
                                  DataColumn(label: Text('Edit',style: TextStyle(fontWeight: FontWeight.bold),),),
                                  DataColumn(label: Text('Delete',style: TextStyle(fontWeight: FontWeight.bold),),),
                                ],
                                source: Service(snapshot.data.docs),
                              );
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),

          ],
        )
    );
  }
}

// The "soruce" of the table
class Clients extends DataTableSource {
  Clients(this._data);
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
      DataCell(Text((index+1).toString())),
      DataCell(Text(_data[index].data()['name'].toString())),
      DataCell(
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            primary: Colors.green,
            onPrimary: Colors.white,
            elevation: 0,
          ),
          onPressed: () {

          },
          child: Text(
            'Edit',
          ),
        ),
      ),
      DataCell(
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            primary: Colors.red,
            onPrimary: Colors.white,
            elevation: 0, //////// HERE
          ),
          onPressed: () {
            // onDeleteShipment(data.airwaybill_no.toString());
            //onDeletePickupRequest(data.uid.toString());
          },
          child: Text(
            'Delete',
          ),
        ),
      ),
    ]);
  }
}

// The "soruce" of the table
class Service extends DataTableSource {
  Service(this._data);
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
      DataCell(Text((index+1).toString())),
      DataCell(Text(_data[index].data()['name'].toString())),
      DataCell(
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            primary: Colors.green,
            onPrimary: Colors.white,
            elevation: 0,
          ),
          onPressed: () {

          },
          child: Text(
            'Edit',
          ),
        ),
      ),
      DataCell(
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            primary: Colors.red,
            onPrimary: Colors.white,
            elevation: 0, //////// HERE
          ),
          onPressed: () {
            // onDeleteShipment(data.airwaybill_no.toString());
            //onDeletePickupRequest(data.uid.toString());
          },
          child: Text(
            'Delete',
          ),
        ),
      ),
    ]);
  }
}