import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:khanintlexpress/ExcelTest/excelTest.dart';
import 'package:provider/provider.dart';

import '../AppBar/customAppBar.dart';
import '../Global/responsive.dart';
import 'Components/adminSideMenu.dart';
import 'Components/menuController.dart';

DateTime date = DateTime.now();
DateTime startDate = DateTime.now();
DateTime endDate = DateTime.now();

Timestamp myStartTimeStamp = Timestamp.fromDate(startDate);
Timestamp myEndTimeStamp = Timestamp.fromDate(endDate);

String clientsDropdownvalue = '';

formValidation(BuildContext context){
  Future.delayed(Duration(milliseconds: 500), () {
    Navigator.push(context, MaterialPageRoute(builder: (c) =>
        MultiProvider(
          providers: [
            ChangeNotifierProvider(
              create: (context) => MenuController(),
            ),
          ],
          child: ExcelTest(clientsDropdownvalue, startDate, endDate),
        ),
    ));
  });
  //Navigator.push(context, MaterialPageRoute(builder: (c) => ExcelTest(clientsDropdownvalue, startDate, endDate)));
}

class AdminMakeBillScreen extends StatefulWidget {
  const AdminMakeBillScreen({Key? key}) : super(key: key);

  @override
  State<AdminMakeBillScreen> createState() => _AdminMakeBillScreenState();
}

class _AdminMakeBillScreenState extends State<AdminMakeBillScreen> {
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
                return const AdminMakeBillMobile();
              } else if (constraints.maxWidth > 600 && constraints.maxWidth < 900) {
                return const AdminMakeBillMobile();
              } else {
                return const AdminMakeBillDesktop();
              }
            },
          )
        ],
      ),
    );
  }
}

class AdminMakeBillMobile extends StatefulWidget {
  const AdminMakeBillMobile({Key? key}) : super(key: key);

  @override
  State<AdminMakeBillMobile> createState() => _AdminMakeBillMobileState();
}

class _AdminMakeBillMobileState extends State<AdminMakeBillMobile> {
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
                      "Make Bill",
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
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
              //color: Colors.white,
              color: darkTheme ? Colors.black45 : Colors.grey.shade100,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('Make Bill',
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
                                prefixIcon: Icon(Icons.map,color: darkTheme ? Colors.amber : Colors.grey,),
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
                            startDate = newDate;
                            myStartTimeStamp = Timestamp.fromDate(newDate);
                            print(myStartTimeStamp);
                            print(startDate);
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
                              Icon(Icons.calendar_today,color: darkTheme ? Colors.amber : Colors.grey,),

                              SizedBox(width: 10,),

                              Text(
                                '${startDate.day}/${startDate.month}/${startDate.year}',
                                style: TextStyle(
                                  color: Colors.grey,
                                ),
                              ),
                            ],
                          ),
                        ),
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
                            endDate = newDate;
                            myEndTimeStamp = Timestamp.fromDate(newDate);
                            print(myEndTimeStamp);
                            print(endDate);
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
                              Icon(Icons.calendar_today,color: darkTheme ? Colors.amber : Colors.grey,),

                              SizedBox(width: 10,),

                              Text(
                                '${endDate.day}/${endDate.month}/${endDate.year}',
                                style: TextStyle(
                                  color: Colors.grey,
                                ),
                              ),
                            ],
                          ),
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
                        child: const Text('Make Bill'),
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

class AdminMakeBillDesktop extends StatefulWidget {
  const AdminMakeBillDesktop({Key? key}) : super(key: key);

  @override
  State<AdminMakeBillDesktop> createState() => _AdminMakeBillDesktopState();
}

class _AdminMakeBillDesktopState extends State<AdminMakeBillDesktop> {
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
                      "Make Bill",
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
                Text('Make Bill',
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
                                prefixIcon: Icon(Icons.map,color: darkTheme ? Colors.amber : Colors.grey,),
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
                            startDate = newDate;
                            myStartTimeStamp = Timestamp.fromDate(newDate);
                            print(myStartTimeStamp);
                            print(startDate);
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
                              Icon(Icons.calendar_today,color: darkTheme ? Colors.amber : Colors.grey,),

                              SizedBox(width: 10,),

                              Text(
                                '${startDate.day}/${startDate.month}/${startDate.year}',
                                style: TextStyle(
                                  color: Colors.grey,
                                ),
                              ),
                            ],
                          ),
                        ),
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
                            endDate = newDate;
                            myEndTimeStamp = Timestamp.fromDate(newDate);
                            print(myEndTimeStamp);
                            print(endDate);
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
                              Icon(Icons.calendar_today,color: darkTheme ? Colors.amber : Colors.grey,),

                              SizedBox(width: 10,),

                              Text(
                                '${endDate.day}/${endDate.month}/${endDate.year}',
                                style: TextStyle(
                                  color: Colors.grey,
                                ),
                              ),
                            ],
                          ),
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
                        child: const Text('Make Bill'),
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
