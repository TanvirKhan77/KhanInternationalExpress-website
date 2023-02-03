import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:khanintlexpress/AdminScreens/Components/adminSideMenu.dart';
import 'package:khanintlexpress/AppBar/customAppBar.dart';
import 'package:provider/provider.dart';
import '../Global/responsive.dart';
import '../Widgets/loading_dialog.dart';
import 'Components/menuController.dart';

DateTime date = DateTime.now();

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

formValidation(BuildContext context) async {

  if(clientsDropdownvalue != null
    && date != null
    && shipmentTypeDropdownvalue != null
    && airwaybillNoTextEditingController.text.isNotEmpty
    && countryTextEditingController.text.isNotEmpty
    && weightTextEditingController.text.isNotEmpty
    && serviceDropdownvalue != null
    && amountTextEditingController.text.isNotEmpty
    && amountStatusDropdownvalue != null
  ) {
    FirebaseFirestore.instance
      .collection('shipment')
      .doc(airwaybillNoTextEditingController.text.trim())
      .get()
      .then((documentSnapshot) async
    {
      if(documentSnapshot.exists){
        showDialog(context: context, builder: (c){
          return LoadingDialogWidget(
            message: "Airwaybill No. already exixts",
          );
        });
      }
      else{
        showDialog(context: context, builder: (c){
          return LoadingDialogWidget(
            message: "Adding data to Database",
          );
        });

        FirebaseFirestore.instance
            .collection("shipment")
            .doc(airwaybillNoTextEditingController.text.trim())
            .set({
          "clients": clientsDropdownvalue,
          "date": date,
          "shipmentType": shipmentTypeDropdownvalue,
          "airwaybill_no": airwaybillNoTextEditingController.text.trim(),
          "country": countryTextEditingController.text.trim(),
          "weight": weightTextEditingController.text.trim(),
          "service": serviceDropdownvalue,
          "amount": amountTextEditingController.text.trim(),
          "amount_status": amountStatusDropdownvalue,
          "note": noteTextEditingController.text.trim(),
        });

        airwaybillNoTextEditingController.clear();
        countryTextEditingController.clear();
        weightTextEditingController.clear();
        amountTextEditingController.clear();
        noteTextEditingController.clear();

        await Navigator.push(context, MaterialPageRoute(builder: (c) => AdminFormScreen()));
      }
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

class AdminFormScreen extends StatefulWidget {
  const AdminFormScreen({Key? key}) : super(key: key);

  @override
  State<AdminFormScreen> createState() => _AdminFormScreenState();
}

class _AdminFormScreenState extends State<AdminFormScreen> {
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
                return const AdminFormMobile();
              } else if (constraints.maxWidth > 600 && constraints.maxWidth < 900) {
                return const AdminFormMobile();
              } else {
                return const AdminFormDesktop();
              }
            },
          )
        ],
      ),
    );
  }
}

class AdminFormMobile extends StatefulWidget {
  const AdminFormMobile({Key? key}) : super(key: key);

  @override
  State<AdminFormMobile> createState() => _AdminFormMobileState();
}

class _AdminFormMobileState extends State<AdminFormMobile> {



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
                      "Form",
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
                Text('Form',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: darkTheme ? Colors.amberAccent.shade400 : Colors.black,
                  ),
                ),

                // SizedBox(height: 10,),
                //
                // const Text(
                //   'Please enter email and password',
                //   style: TextStyle(
                //     color: Colors.grey,
                //   ),
                // ),

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
                            initialDate: date,
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
                                '${date.day}/${date.month}/${date.year}',
                                style: TextStyle(
                                  color: Colors.grey,
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

                      SizedBox(height: 20,),

                      //Airwaybill_no
                      TextField(
                        controller: airwaybillNoTextEditingController,
                        decoration: InputDecoration(
                          hintText: 'Airwaybill_no',
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
                          prefixIcon: Icon(Icons.numbers, color: darkTheme ? Colors.amberAccent.shade400 : Colors.grey,),
                        ),
                      ),

                      const SizedBox(height: 20,),

                      //Country
                      TextField(
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
                      TextField(
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
                      TextField(
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
                          formValidation(context);
                        },
                        child: const Text('Submit'),
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

class AdminFormDesktop extends StatefulWidget {
  const AdminFormDesktop({Key? key}) : super(key: key);

  @override
  State<AdminFormDesktop> createState() => _AdminFormDesktopState();
}

class _AdminFormDesktopState extends State<AdminFormDesktop> {
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
                      "Form",
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
                Text('Form',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: darkTheme ? Colors.amberAccent.shade400 : Colors.black,
                  ),
                ),

                // SizedBox(height: 10,),
                //
                // const Text(
                //   'Please enter email and password',
                //   style: TextStyle(
                //     color: Colors.grey,
                //   ),
                // ),

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
                            initialDate: date,
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
                                '${date.day}/${date.month}/${date.year}',
                                style: TextStyle(
                                  color: Colors.grey,
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

                      SizedBox(height: 20,),

                      //Airwaybill_no
                      TextField(
                        controller: airwaybillNoTextEditingController,
                        decoration: InputDecoration(
                          hintText: 'Airwaybill_no',
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
                          prefixIcon: Icon(Icons.numbers, color: darkTheme ? Colors.amberAccent.shade400 : Colors.grey,),
                        ),
                      ),

                      const SizedBox(height: 20,),

                      //Country
                      TextField(
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
                      TextField(
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
                      TextField(
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
                          formValidation(context);
                        },
                        child: const Text('Submit'),
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
