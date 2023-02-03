import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:khanintlexpress/EmployeeScreens/Components/employeeSideMenu.dart';
import 'package:provider/provider.dart';

import '../AdminScreens/Components/menuController.dart';
import '../AppBar/customAppBar.dart';
import '../Global/responsive.dart';
import '../Widgets/loading_dialog.dart';
import 'employeeTableScreen.dart';

// DateTime date = DateTime.now();

TextEditingController airwaybillNoTextEditingController = TextEditingController();
TextEditingController countryTextEditingController = TextEditingController();
TextEditingController weightTextEditingController = TextEditingController();
TextEditingController amountTextEditingController = TextEditingController();
TextEditingController noteTextEditingController = TextEditingController();

String clientsDropdownvalue = '';
String serviceDropdownvalue = '';
String shipmentTypeDropdownvalue = '';
String amountStatusDropdownvalue = '';

// List of items in our dropdown menu
var shipmentItems = [
  'DOX',
  'WPX',
];

var amountStatusItems = [
  'Due',
  'Paid',
];

formValidation(
    BuildContext context,
    String airwaybill_no,
    String clientsDropdownvalue,
    DateTime date,
    String shipmentTypeDropdownvalue,
    String countryTextEditingController,
    String weightTextEditingController,
    String serviceDropdownvalue,
    String amountTextEditingController,
    String amountStatusDropdownvalue,
    String noteTextEditingController
    ) async {

  if(clientsDropdownvalue != null
      && date != null
      && shipmentTypeDropdownvalue != null
      && countryTextEditingController != null
      && weightTextEditingController != null
      && serviceDropdownvalue != null
      && amountTextEditingController != null
      && amountStatusDropdownvalue != null
  ){
    FirebaseFirestore.instance
        .collection('shipment')
        .doc(airwaybill_no)
        .update({
      "clients": clientsDropdownvalue,
      "date": date,
      "shipmentType": shipmentTypeDropdownvalue,
      "country": countryTextEditingController,
      "weight": weightTextEditingController,
      "service": serviceDropdownvalue,
      "amount": amountTextEditingController,
      "amount_status": amountStatusDropdownvalue,
      "note": noteTextEditingController,
    });

    // Navigator.push(context, MaterialPageRoute(builder: (c) => AdminTableScreen()));

    Future.delayed(Duration(milliseconds: 500), () {
      Navigator.push(context, MaterialPageRoute(builder: (c) =>
          MultiProvider(
            providers: [
              ChangeNotifierProvider(
                create: (context) => MenuController(),
              ),
            ],
            child: EmployeeTableScreen(),
          ),
      ));
    });

  }
  else {
    showDialog(context: context, builder: (c)
    {
      return LoadingDialogWidget(
        message: "Some fields are empty",
      );
    }
    );
  }

}

class EmployeeUpdateTableScreen extends StatefulWidget {
  String clients,shipment_type,airwaybill_no,country,weight,service,amount,amount_status,note;
  DateTime date;
  EmployeeUpdateTableScreen({
    Key? key,
    required this.clients,
    required this.date,
    required this.shipment_type,
    required this.airwaybill_no,
    required this.country,
    required this.weight,
    required this.service,
    required this.amount,
    required this.amount_status,
    required this.note,
  }) : super(key: key);

  @override
  State<EmployeeUpdateTableScreen> createState() => _EmployeeUpdateTableScreenState(
    clients,date,shipment_type,airwaybill_no,country,weight,service,amount,amount_status,note,
  );
}

class _EmployeeUpdateTableScreenState extends State<EmployeeUpdateTableScreen> {

  String? clients;
  DateTime? date;
  String? shipment_type;
  String? airwaybill_no;
  String? country;
  String? weight;
  String? service;
  String? amount;
  String? amount_status;
  String? note;

  _EmployeeUpdateTableScreenState(
      this.clients,
      this.date,
      this.shipment_type,
      this.airwaybill_no,
      this.country,
      this.weight,
      this.service,
      this.amount,
      this.amount_status,
      this.note,
  );

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
                return EmployeeUpdateTableMobile(
                    this.clients,
                    this.date,
                    this.shipment_type,
                    this.airwaybill_no,
                    this.country,
                    this.weight,
                    this.service,
                    this.amount,
                    this.amount_status,
                    this.note
                );
              } else if (constraints.maxWidth > 600 && constraints.maxWidth < 900) {
                return EmployeeUpdateTableMobile(
                    this.clients,
                    this.date,
                    this.shipment_type,
                    this.airwaybill_no,
                    this.country,
                    this.weight,
                    this.service,
                    this.amount,
                    this.amount_status,
                    this.note
                );
              } else {
                return AdminUpdateTableDesktop(
                    this.clients,
                    this.date,
                    this.shipment_type,
                    this.airwaybill_no,
                    this.country,
                    this.weight,
                    this.service,
                    this.amount,
                    this.amount_status,
                    this.note
                );
              }
            },
          )
        ],
      ),
    );
  }
}

class EmployeeUpdateTableMobile extends StatefulWidget {
  String? clients,shipment_type,airwaybill_no,country,weight,service,amount,amount_status,note;
  DateTime? date;

  EmployeeUpdateTableMobile(
      this.clients,
      this.date,
      this.shipment_type,
      this.airwaybill_no,
      this.country,
      this.weight,
      this.service,
      this.amount,
      this.amount_status,
      this.note,
      {Key? key}
      ) : super(key: key);

  @override
  State<EmployeeUpdateTableMobile> createState() => _EmployeeUpdateTableMobileState(
    clients,date,shipment_type,airwaybill_no,country,weight,service,amount,amount_status,note,
  );
}

class _EmployeeUpdateTableMobileState extends State<EmployeeUpdateTableMobile> {

  String? clients;
  DateTime? date;
  String? shipment_type;
  String? airwaybill_no;
  String? country;
  String? weight;
  String? service;
  String? amount;
  String? amount_status;
  String? note;

  _EmployeeUpdateTableMobileState(
      this.clients,
      this.date,
      this.shipment_type,
      this.airwaybill_no,
      this.country,
      this.weight,
      this.service,
      this.amount,
      this.amount_status,
      this.note,
      );

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    countryTextEditingController.text = country!;
    weightTextEditingController.text = weight!;
    amountTextEditingController.text = amount!;
    noteTextEditingController.text = note!;

  }

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
                      if(!Responsive.isDesktop(context))
                        IconButton(
                          onPressed: context.read<MenuController>().controlMenu,
                          icon: Icon(Icons.menu),
                        ),

                      // if(!Responsive.isMobile(context))
                      Text(
                        "Update Table Data",
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
              margin: EdgeInsets.fromLTRB(20, 10, 20, 20),
              padding: const EdgeInsets.all(20),
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                //color: Colors.white,
                color: darkTheme ? Colors.black45 : Colors.grey.shade100,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('Update',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: darkTheme ? Colors.amberAccent.shade400 : Colors.black,
                    ),
                  ),

                  SizedBox(height: 10,),

                  Text(
                    'You are updataing data of Airwaybill No: $airwaybill_no',
                    style: TextStyle(
                      color: Colors.red,
                      fontSize: 15,
                    ),
                  ),

                  const SizedBox(height: 20,),

                  Container(
                    width: MediaQuery.of(context).size.width > 300 ? 400 : 300,
                    padding: EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: Colors.transparent,
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(width: 2,color: darkTheme ? Colors.amberAccent.shade400 : Colors.blue),
                    ),
                    child: Column(
                      children: [
                        //Clients
                        StreamBuilder(
                          stream: FirebaseFirestore.instance.collection('clients').snapshots(),
                          builder: (context, AsyncSnapshot snapshot){
                            if(!snapshot.hasData){
                              return Text('Loading');
                            }
                            else{
                              List<DropdownMenuItem> clientsItems = [];
                              for(int i = 0;i<snapshot.data.docs.length; i++){
                                DocumentSnapshot snap = snapshot.data.docs[i];
                                clientsItems.add(
                                    DropdownMenuItem(
                                      child: Text(
                                        snap["name"],
                                      ),
                                      value: snap["name"],
                                    )
                                );
                              }
                              return DropdownButtonFormField(
                                value: clients,
                                decoration: InputDecoration(
                                  hintText: 'Select Clients',
                                  prefixIcon: Icon(Icons.person,color: darkTheme ? Colors.amberAccent.shade400 : Colors.grey,),
                                  filled: true,
                                  fillColor: darkTheme ? Colors.black45 : Colors.grey.shade200,
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(40),
                                    borderSide: const BorderSide(
                                      width: 0,
                                      style: BorderStyle.none,
                                    ),
                                  ),
                                ),
                                items: clientsItems,
                                onChanged: (contactedValue){
                                  setState(() {
                                    clientsDropdownvalue = contactedValue;
                                    print(clientsDropdownvalue);
                                  });
                                },
                              );
                            }
                          },
                        ),

                        SizedBox(height: 20,),

                        GestureDetector(
                          onTap: () async {
                            DateTime? newDate = await showDatePicker(
                              context: context,
                              initialDate: widget.date!,
                              firstDate: DateTime(1900),
                              lastDate: DateTime(2100),
                            );

                            // if 'cancel' => null
                            if(newDate == null) return;

                            //if 'OK' => DateTime
                            setState(() {
                              date = newDate;
                              print(date);
                            });
                          },
                          child: Container(
                            padding: EdgeInsets.all(15),
                            decoration: BoxDecoration(
                              color: darkTheme ? Colors.black45 : Colors.grey.shade200,
                              borderRadius: BorderRadius.circular(30),
                            ),
                            child: Row(
                              children: [
                                Icon(
                                  Icons.calendar_today,
                                  color: darkTheme ? Colors.amber : Colors.grey,
                                ),

                                SizedBox(width: 10,),

                                Text(
                                  '${date?.day}/${date?.month}/${date?.year}',
                                  style: TextStyle(
                                    color: Colors.white,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),

                        //Date
                        // ElevatedButton.icon(
                        //   label: Text('Select Date'),
                        //   icon: Icon(Icons.date_range),
                        //   style: ElevatedButton.styleFrom(
                        //     primary: darkTheme ? Colors.amberAccent.shade400 : Colors.blue,
                        //     onPrimary: darkTheme ? Colors.black : Colors.white,
                        //     elevation: 0,
                        //     shape: RoundedRectangleBorder(
                        //         borderRadius: BorderRadius.circular(32.0)),
                        //     minimumSize: const Size(100, 40),
                        //   ),
                        //   onPressed: () async {
                        //     DateTime? newDate = await showDatePicker(
                        //       context: context,
                        //       initialDate: date,
                        //       firstDate: DateTime(1900),
                        //       lastDate: DateTime(2100),
                        //     );
                        //
                        //     // if 'cancel' => null
                        //     if(newDate == null) return;
                        //
                        //     //if 'OK' => DateTime
                        //     setState(() {
                        //       date = newDate;
                        //       print(date);
                        //     });
                        //   },
                        // ),

                        SizedBox(height: 20,),

                        //ShipmentType
                        DropdownButtonFormField(
                            value: shipment_type,
                            decoration: InputDecoration(
                              hintText: 'Shipment Type',
                              prefixIcon: Icon(Icons.local_shipping_outlined,color: darkTheme ? Colors.amber : Colors.grey,),
                              filled: true,
                              fillColor: darkTheme ? Colors.black45 : Colors.grey.shade200,
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(40),
                                borderSide: const BorderSide(
                                  width: 0,
                                  style: BorderStyle.none,
                                ),
                              ),
                            ),
                            items: shipmentItems.map((String items) {
                              return DropdownMenuItem(
                                value: items,
                                child: Text(items),
                              );
                            }).toList(),
                            onChanged: (String? newValue) {
                              setState(() {
                                shipmentTypeDropdownvalue = newValue!;
                                print('$shipmentTypeDropdownvalue');
                              });
                            }
                        ),

                        // SizedBox(height: 20,),

                        //Airwaybill_no
                        // TextField(
                        //   controller: airwaybillNoTextEditingController,
                        //   decoration: InputDecoration(
                        //     hintText: 'Airwaybill_no',
                        //     hintStyle: TextStyle(
                        //       color: darkTheme ? Colors.grey : Colors.grey,
                        //     ),
                        //     filled: true,
                        //     fillColor: darkTheme ? Colors.black45 : Colors.grey.shade200,
                        //     border: OutlineInputBorder(
                        //       borderRadius: BorderRadius.circular(40),
                        //       borderSide: const BorderSide(
                        //         width: 0,
                        //         style: BorderStyle.none,
                        //       ),
                        //     ),
                        //     //border: InputBorder.none,
                        //     prefixIcon: Icon(Icons.email, color: darkTheme ? Colors.amberAccent.shade400 : Colors.grey,),
                        //   ),
                        // ),

                        const SizedBox(height: 20,),

                        //Country
                        TextFormField(
                          //initialValue: country,
                          controller: countryTextEditingController,
                          decoration: InputDecoration(
                            hintText: 'Country',
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
                            prefixIcon: Icon(Icons.map, color: darkTheme ? Colors.amberAccent.shade400 : Colors.grey,),
                          ),
                        ),

                        const SizedBox(height: 20,),

                        //Weight
                        TextFormField(
                          //initialValue: weight,
                          controller: weightTextEditingController,
                          decoration: InputDecoration(
                            hintText: 'Weight',
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
                            prefixIcon: Icon(Icons.lock_outline, color: darkTheme ? Colors.amberAccent.shade400 : Colors.grey,),
                          ),
                        ),

                        const SizedBox(height: 20,),

                        //Services
                        StreamBuilder(
                          stream: FirebaseFirestore.instance.collection('service').snapshots(),
                          builder: (context, AsyncSnapshot snapshot){
                            if(!snapshot.hasData){
                              return Text('Loading');
                            }
                            else{
                              List<DropdownMenuItem> serviceItems = [];
                              for(int i = 0;i<snapshot.data.docs.length; i++){
                                DocumentSnapshot snap = snapshot.data.docs[i];
                                serviceItems.add(
                                    DropdownMenuItem(
                                      child: Text(
                                        snap["name"],
                                      ),
                                      value: snap["name"],
                                    )
                                );
                              }
                              return DropdownButtonFormField(
                                value: service,
                                decoration: InputDecoration(
                                  hintText: 'Select Service',
                                  prefixIcon: Icon(Icons.design_services,color: darkTheme ? Colors.amber : Colors.grey,),
                                  filled: true,
                                  fillColor: darkTheme ? Colors.black45 : Colors.grey.shade200,
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(40),
                                    borderSide: const BorderSide(
                                      width: 0,
                                      style: BorderStyle.none,
                                    ),
                                  ),
                                ),
                                items: serviceItems,
                                onChanged: (contactedValue){
                                  setState(() {
                                    serviceDropdownvalue = contactedValue;
                                    print(serviceDropdownvalue);
                                  });
                                },
                              );
                            }
                          },
                        ),

                        SizedBox(height: 20,),

                        //Amount
                        TextFormField(
                          // initialValue: amount,
                          controller: amountTextEditingController,
                          decoration: InputDecoration(
                            hintText: 'Amount',
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
                            prefixIcon: Icon(Icons.price_change, color: darkTheme ? Colors.amberAccent.shade400 : Colors.grey,),
                          ),
                        ),

                        const SizedBox(height: 20,),

                        DropdownButtonFormField(
                            value: amount_status,
                            decoration: InputDecoration(
                              hintText: 'Select Amount Status',
                              prefixIcon: Icon(Icons.price_change_sharp,color: darkTheme ? Colors.amber : Colors.grey,),
                              filled: true,
                              fillColor: darkTheme ? Colors.black45 : Colors.grey.shade200,
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(40),
                                borderSide: const BorderSide(
                                  width: 0,
                                  style: BorderStyle.none,
                                ),
                              ),
                            ),
                            items: amountStatusItems.map((String items) {
                              return DropdownMenuItem(
                                value: items,
                                child: Text(items),
                              );
                            }).toList(),
                            onChanged: (String? newValue) {
                              setState(() {
                                amountStatusDropdownvalue = newValue!;
                                print('$amountStatusDropdownvalue');
                              });
                            }
                        ),

                        SizedBox(height: 20,),

                        //Note
                        TextFormField(
                          // initialValue: note,
                          controller: noteTextEditingController,
                          keyboardType: TextInputType.multiline,
                          inputFormatters: [
                            LengthLimitingTextInputFormatter(200)
                          ],
                          maxLines: null,
                          decoration: InputDecoration(
                            hintText: 'Note',
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
                            prefixIcon: Icon(Icons.note, color: darkTheme ? Colors.amberAccent.shade400 : Colors.grey,),
                          ),
                        ),

                        SizedBox(height: 20,),

                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            primary: darkTheme ? Colors.amberAccent.shade400 : Colors.blue,
                            onPrimary: darkTheme ? Colors.black : Colors.white,
                            elevation: 0,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(32.0)),
                            minimumSize: const Size(100, 40),
                          ),
                          onPressed: () {
                            if(clientsDropdownvalue == ''){
                              clientsDropdownvalue = clients!;
                            }
                            if(shipmentTypeDropdownvalue == ''){
                              shipmentTypeDropdownvalue = shipment_type!;
                            }
                            if(serviceDropdownvalue == ''){
                              serviceDropdownvalue = service!;
                            }
                            if(amountStatusDropdownvalue == ''){
                              amountStatusDropdownvalue = amount_status!;
                            }
                            formValidation(
                              context,
                              airwaybill_no!,
                              clientsDropdownvalue,
                              date!,
                              shipmentTypeDropdownvalue,
                              countryTextEditingController.text,
                              weightTextEditingController.text,
                              serviceDropdownvalue,
                              amountTextEditingController.text,
                              amountStatusDropdownvalue,
                              noteTextEditingController.text,
                            );
                          },
                          child: const Text('Update'),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 20,),

                ],
              ),
            ),
          ],
        )
    );
  }
}

class AdminUpdateTableDesktop extends StatefulWidget {
  String? clients,shipment_type,airwaybill_no,country,weight,service,amount,amount_status,note;
  DateTime? date;

  AdminUpdateTableDesktop(
      this.clients,
      this.date,
      this.shipment_type,
      this.airwaybill_no,
      this.country,
      this.weight,
      this.service,
      this.amount,
      this.amount_status,
      this.note,
      {Key? key}
      ) : super(key: key);

  @override
  State<AdminUpdateTableDesktop> createState() => _AdminUpdateTableDesktopState(
    clients,date,shipment_type,airwaybill_no,country,weight,service,amount,amount_status,note,
  );
}

class _AdminUpdateTableDesktopState extends State<AdminUpdateTableDesktop> {

  String? clients;
  DateTime? date;
  String? shipment_type;
  String? airwaybill_no;
  String? country;
  String? weight;
  String? service;
  String? amount;
  String? amount_status;
  String? note;

  _AdminUpdateTableDesktopState(
      this.clients,
      this.date,
      this.shipment_type,
      this.airwaybill_no,
      this.country,
      this.weight,
      this.service,
      this.amount,
      this.amount_status,
      this.note,
      );

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    countryTextEditingController.text = country!;
    weightTextEditingController.text = weight!;
    amountTextEditingController.text = amount!;
    noteTextEditingController.text = note!;

  }

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

                    Text(
                      "Update Table Data",
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
            margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 50),
            padding: const EdgeInsets.all(20),
            width: MediaQuery.of(context).size.width > 900 ? 700 : 500,
            decoration: BoxDecoration(
              //color: Colors.white,
              color: darkTheme ? Colors.black45 : Colors.grey.shade100,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('Update',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: darkTheme ? Colors.amberAccent.shade400 : Colors.black,
                  ),
                ),

                SizedBox(height: 10,),

                Text(
                  'You are updataing data of Airwaybill No: $airwaybill_no',
                  style: TextStyle(
                    color: Colors.red,
                    fontSize: 15,
                  ),
                ),

                const SizedBox(height: 20,),

                Container(
                  width: MediaQuery.of(context).size.width > 300 ? 400 : 300,
                  padding: EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: Colors.transparent,
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(width: 2,color: darkTheme ? Colors.amberAccent.shade400 : Colors.blue),
                  ),
                  child: Column(
                    children: [
                      //Clients
                      StreamBuilder(
                        stream: FirebaseFirestore.instance.collection('clients').snapshots(),
                        builder: (context, AsyncSnapshot snapshot){
                          if(!snapshot.hasData){
                            return Text('Loading');
                          }
                          else{
                            List<DropdownMenuItem> clientsItems = [];
                            for(int i = 0;i<snapshot.data.docs.length; i++){
                              DocumentSnapshot snap = snapshot.data.docs[i];
                              clientsItems.add(
                                  DropdownMenuItem(
                                    child: Text(
                                      snap["name"],
                                    ),
                                    value: snap["name"],
                                  )
                              );
                            }
                            return DropdownButtonFormField(
                              value: clients,
                              decoration: InputDecoration(
                                hintText: 'Select Clients',
                                prefixIcon: Icon(Icons.person,color: darkTheme ? Colors.amberAccent.shade400 : Colors.grey,),
                                filled: true,
                                fillColor: darkTheme ? Colors.black45 : Colors.grey.shade200,
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(40),
                                  borderSide: const BorderSide(
                                    width: 0,
                                    style: BorderStyle.none,
                                  ),
                                ),
                              ),
                              items: clientsItems,
                              onChanged: (contactedValue){
                                setState(() {
                                  clientsDropdownvalue = contactedValue;
                                  print(clientsDropdownvalue);
                                });
                              },
                            );
                          }
                        },
                      ),

                      SizedBox(height: 20,),

                      GestureDetector(
                        onTap: () async {
                          DateTime? newDate = await showDatePicker(
                            context: context,
                            initialDate: widget.date!,
                            firstDate: DateTime(1900),
                            lastDate: DateTime(2100),
                          );

                          // if 'cancel' => null
                          if(newDate == null) return;

                          //if 'OK' => DateTime
                          setState(() {
                            date = newDate;
                            print(date);
                          });
                        },
                        child: Container(
                          padding: EdgeInsets.all(15),
                          decoration: BoxDecoration(
                            color: darkTheme ? Colors.black45 : Colors.grey.shade200,
                            borderRadius: BorderRadius.circular(30),
                          ),
                          child: Row(
                            children: [
                              Icon(
                                Icons.calendar_today,
                                color: darkTheme ? Colors.amber : Colors.grey,
                              ),

                              SizedBox(width: 10,),

                              Text(
                                '${date?.day}/${date?.month}/${date?.year}',
                                style: TextStyle(
                                  color: Colors.white,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),

                      //Date
                      // ElevatedButton.icon(
                      //   label: Text('Select Date'),
                      //   icon: Icon(Icons.date_range),
                      //   style: ElevatedButton.styleFrom(
                      //     primary: darkTheme ? Colors.amberAccent.shade400 : Colors.blue,
                      //     onPrimary: darkTheme ? Colors.black : Colors.white,
                      //     elevation: 0,
                      //     shape: RoundedRectangleBorder(
                      //         borderRadius: BorderRadius.circular(32.0)),
                      //     minimumSize: const Size(100, 40),
                      //   ),
                      //   onPressed: () async {
                      //     DateTime? newDate = await showDatePicker(
                      //       context: context,
                      //       initialDate: date,
                      //       firstDate: DateTime(1900),
                      //       lastDate: DateTime(2100),
                      //     );
                      //
                      //     // if 'cancel' => null
                      //     if(newDate == null) return;
                      //
                      //     //if 'OK' => DateTime
                      //     setState(() {
                      //       date = newDate;
                      //       print(date);
                      //     });
                      //   },
                      // ),

                      SizedBox(height: 20,),

                      //ShipmentType
                      DropdownButtonFormField(
                          value: shipment_type,
                          decoration: InputDecoration(
                            hintText: 'Shipment Type',
                            prefixIcon: Icon(Icons.local_shipping_outlined,color: darkTheme ? Colors.amber : Colors.grey,),
                            filled: true,
                            fillColor: darkTheme ? Colors.black45 : Colors.grey.shade200,
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(40),
                              borderSide: const BorderSide(
                                width: 0,
                                style: BorderStyle.none,
                              ),
                            ),
                          ),
                          items: shipmentItems.map((String items) {
                            return DropdownMenuItem(
                              value: items,
                              child: Text(items),
                            );
                          }).toList(),
                          onChanged: (String? newValue) {
                            setState(() {
                              shipmentTypeDropdownvalue = newValue!;
                              print('$shipmentTypeDropdownvalue');
                            });
                          }
                      ),

                      // SizedBox(height: 20,),

                      //Airwaybill_no
                      // TextField(
                      //   controller: airwaybillNoTextEditingController,
                      //   decoration: InputDecoration(
                      //     hintText: 'Airwaybill_no',
                      //     hintStyle: TextStyle(
                      //       color: darkTheme ? Colors.grey : Colors.grey,
                      //     ),
                      //     filled: true,
                      //     fillColor: darkTheme ? Colors.black45 : Colors.grey.shade200,
                      //     border: OutlineInputBorder(
                      //       borderRadius: BorderRadius.circular(40),
                      //       borderSide: const BorderSide(
                      //         width: 0,
                      //         style: BorderStyle.none,
                      //       ),
                      //     ),
                      //     //border: InputBorder.none,
                      //     prefixIcon: Icon(Icons.email, color: darkTheme ? Colors.amberAccent.shade400 : Colors.grey,),
                      //   ),
                      // ),

                      const SizedBox(height: 20,),

                      //Country
                      TextFormField(
                        //initialValue: country,
                        controller: countryTextEditingController,
                        decoration: InputDecoration(
                          hintText: 'Country',
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
                          prefixIcon: Icon(Icons.map, color: darkTheme ? Colors.amberAccent.shade400 : Colors.grey,),
                        ),
                      ),

                      const SizedBox(height: 20,),

                      //Weight
                      TextFormField(
                        //initialValue: weight,
                        controller: weightTextEditingController,
                        decoration: InputDecoration(
                          hintText: 'Weight',
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
                          prefixIcon: Icon(Icons.lock_outline, color: darkTheme ? Colors.amberAccent.shade400 : Colors.grey,),
                        ),
                      ),

                      const SizedBox(height: 20,),

                      //Services
                      StreamBuilder(
                        stream: FirebaseFirestore.instance.collection('service').snapshots(),
                        builder: (context, AsyncSnapshot snapshot){
                          if(!snapshot.hasData){
                            return Text('Loading');
                          }
                          else{
                            List<DropdownMenuItem> serviceItems = [];
                            for(int i = 0;i<snapshot.data.docs.length; i++){
                              DocumentSnapshot snap = snapshot.data.docs[i];
                              serviceItems.add(
                                  DropdownMenuItem(
                                    child: Text(
                                      snap["name"],
                                    ),
                                    value: snap["name"],
                                  )
                              );
                            }
                            return DropdownButtonFormField(
                              value: service,
                              decoration: InputDecoration(
                                hintText: 'Select Service',
                                prefixIcon: Icon(Icons.design_services,color: darkTheme ? Colors.amber : Colors.grey,),
                                filled: true,
                                fillColor: darkTheme ? Colors.black45 : Colors.grey.shade200,
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(40),
                                  borderSide: const BorderSide(
                                    width: 0,
                                    style: BorderStyle.none,
                                  ),
                                ),
                              ),
                              items: serviceItems,
                              onChanged: (contactedValue){
                                setState(() {
                                  serviceDropdownvalue = contactedValue;
                                  print(serviceDropdownvalue);
                                });
                              },
                            );
                          }
                        },
                      ),

                      SizedBox(height: 20,),

                      //Amount
                      TextFormField(
                        // initialValue: amount,
                        controller: amountTextEditingController,
                        decoration: InputDecoration(
                          hintText: 'Amount',
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
                          prefixIcon: Icon(Icons.price_change, color: darkTheme ? Colors.amberAccent.shade400 : Colors.grey,),
                        ),
                      ),

                      const SizedBox(height: 20,),

                      DropdownButtonFormField(
                          value: amount_status,
                          decoration: InputDecoration(
                            hintText: 'Select Amount Status',
                            prefixIcon: Icon(Icons.price_change_sharp,color: darkTheme ? Colors.amber : Colors.grey,),
                            filled: true,
                            fillColor: darkTheme ? Colors.black45 : Colors.grey.shade200,
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(40),
                              borderSide: const BorderSide(
                                width: 0,
                                style: BorderStyle.none,
                              ),
                            ),
                          ),
                          items: amountStatusItems.map((String items) {
                            return DropdownMenuItem(
                              value: items,
                              child: Text(items),
                            );
                          }).toList(),
                          onChanged: (String? newValue) {
                            setState(() {
                              amountStatusDropdownvalue = newValue!;
                              print('$amountStatusDropdownvalue');
                            });
                          }
                      ),

                      SizedBox(height: 20,),

                      //Note
                      TextFormField(
                        // initialValue: note,
                        controller: noteTextEditingController,
                        keyboardType: TextInputType.multiline,
                        inputFormatters: [
                          LengthLimitingTextInputFormatter(200)
                        ],
                        maxLines: null,
                        decoration: InputDecoration(
                          hintText: 'Note',
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
                          prefixIcon: Icon(Icons.note, color: darkTheme ? Colors.amberAccent.shade400 : Colors.grey,),
                        ),
                      ),

                      SizedBox(height: 20,),

                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          primary: darkTheme ? Colors.amberAccent.shade400 : Colors.blue,
                          onPrimary: darkTheme ? Colors.black : Colors.white,
                          elevation: 0,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(32.0)),
                          minimumSize: const Size(100, 40),
                        ),
                        onPressed: () {
                          if(clientsDropdownvalue == ''){
                            clientsDropdownvalue = clients!;
                          }
                          if(shipmentTypeDropdownvalue == ''){
                            shipmentTypeDropdownvalue = shipment_type!;
                          }
                          if(serviceDropdownvalue == ''){
                            serviceDropdownvalue = service!;
                          }
                          if(amountStatusDropdownvalue == ''){
                            amountStatusDropdownvalue = amount_status!;
                          }
                          formValidation(
                            context,
                            airwaybill_no!,
                            clientsDropdownvalue,
                            date!,
                            shipmentTypeDropdownvalue,
                            countryTextEditingController.text,
                            weightTextEditingController.text,
                            serviceDropdownvalue,
                            amountTextEditingController.text,
                            amountStatusDropdownvalue,
                            noteTextEditingController.text,
                          );
                        },
                        child: const Text('Update'),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 20,),

              ],
            ),
          ),
        ],
      ),
    );
  }
}
