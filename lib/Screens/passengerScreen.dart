import 'package:flutter/material.dart';

import '../AppBar/customAppBar.dart';

class PassengerScreen extends StatefulWidget {
  const PassengerScreen({Key? key}) : super(key: key);

  @override
  State<PassengerScreen> createState() => _PassengerScreenState();
}

class _PassengerScreenState extends State<PassengerScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(),
      body: LayoutBuilder(
        builder: (context, constraints) {
          if (constraints.maxWidth < 600) {
            return const PassengerMobile();
          } else if (constraints.maxWidth > 600 && constraints.maxWidth < 900) {
            return const PassengerMobile();
          } else {
            return const PassengerDesktop();
          }
        },
      ),
    );
  }
}

class PassengerMobile extends StatefulWidget {
  const PassengerMobile({Key? key}) : super(key: key);

  @override
  State<PassengerMobile> createState() => _PassengerMobileState();
}

class _PassengerMobileState extends State<PassengerMobile> {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}

class PassengerDesktop extends StatefulWidget {
  const PassengerDesktop({Key? key}) : super(key: key);

  @override
  State<PassengerDesktop> createState() => _PassengerDesktopState();
}

class _PassengerDesktopState extends State<PassengerDesktop> {

  @override
  Widget build(BuildContext context) {

    bool darkTheme = MediaQuery.of(context).platformBrightness == Brightness.dark;

    return Center(
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 50),
        padding: const EdgeInsets.all(20),
        width: MediaQuery.of(context).size.width > 900 ? 700 : 500,
        decoration: BoxDecoration(
          //color: Colors.white,
          color: darkTheme ? Colors.black45 : Colors.grey.shade100,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Container(
          width: MediaQuery.of(context).size.width > 300 ? 400 : 300,
          padding: EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: Colors.transparent,
            borderRadius: BorderRadius.circular(20),
            border: Border.all(width: 2,color: darkTheme ? Colors.amberAccent.shade400 : Colors.blue),
          ),
          child: ListView.builder(
            itemCount: 10,
            itemBuilder: (BuildContext context, int index) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [

                  Text('Passenger ${index+1}',
                    style: TextStyle(
                      color: darkTheme ? Colors.amberAccent : Colors.blue,
                    ),
                  ),

                  SizedBox(height: 10,),

                  TextField(
                    decoration: InputDecoration(
                      hintText: 'First Name',
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
                      prefixIcon: Icon(Icons.person, color: darkTheme ? Colors.amberAccent.shade400 : Colors.grey,),
                    ),
                  ),

                  SizedBox(height: 20,),

                  TextField(
                    decoration: InputDecoration(
                      hintText: 'Last Name',
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
                      prefixIcon: Icon(Icons.person, color: darkTheme ? Colors.amberAccent.shade400 : Colors.grey,),
                    ),
                  ),

                  SizedBox(height: 20,),
                ],
              );
            }
          ),
        ),
      )
    );

    // return ListView.builder(
    //     itemCount: 5,
    //     itemBuilder: (BuildContext ctxt, int index) {
    //       return Column(
    //         children: <Widget>[
    //           SizedBox(
    //             height: 15.0,
    //           ),
    //           Image.network(
    //             "https://picsum.photos/50?image=$index",
    //             fit: BoxFit.cover,
    //           ),
    //           SizedBox(
    //             height: 10.0,
    //           ),
    //           Row(
    //             mainAxisAlignment: MainAxisAlignment.center,
    //             children: <Widget>[
    //               Text("$index",
    //                   style: TextStyle(
    //                       fontWeight: FontWeight.bold,
    //                       fontSize: 23,
    //                       fontFamily: 'Raleway',
    //                       color: Colors.black)),
    //             ],
    //           ),
    //         ],
    //       );
    //     });

    // return Center(
    //   child: Container(
    //     margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 50),
    //     padding: const EdgeInsets.all(20),
    //     width: MediaQuery.of(context).size.width > 900 ? 700 : 500,
    //     decoration: BoxDecoration(
    //       //color: Colors.white,
    //       color: darkTheme ? Colors.black45 : Colors.grey.shade100,
    //       borderRadius: BorderRadius.circular(20),
    //     ),
    //     child: ListView(
    //       children: [
    //         Column(
    //           mainAxisAlignment: MainAxisAlignment.center,
    //           children: [
    //             Text('Passenger Details',
    //               style: TextStyle(
    //                 fontSize: 20,
    //                 fontWeight: FontWeight.bold,
    //                 color: darkTheme ? Colors.amberAccent.shade400 : Colors.black,
    //               ),
    //             ),
    //
    //             // SizedBox(height: 10,),
    //             //
    //             // const Text(
    //             //   'Pickup is only available in Dhaka City.'
    //             //       '\nThere will be pickup charge depending on the location and size of the shipment.'
    //             //       '\nBut will be no pickup charge if you drop shipment to our office.',
    //             //   textAlign: TextAlign.center,
    //             //   style: TextStyle(
    //             //     color: Colors.red,
    //             //     fontWeight: FontWeight.bold,
    //             //   ),
    //             // ),
    //
    //             const SizedBox(height: 20,),
    //
    //             Container(
    //               width: MediaQuery.of(context).size.width > 300 ? 400 : 300,
    //               padding: EdgeInsets.all(20),
    //               decoration: BoxDecoration(
    //                 color: Colors.transparent,
    //                 borderRadius: BorderRadius.circular(20),
    //                 border: Border.all(width: 2,color: darkTheme ? Colors.amberAccent.shade400 : Colors.blue),
    //               ),
    //               child: Column(
    //                 children: [
    //                   TextField(
    //                     //controller: fromTextEditingController,
    //                     decoration: InputDecoration(
    //                       hintText: 'From',
    //                       hintStyle: TextStyle(
    //                         color: darkTheme ? Colors.grey : Colors.grey,
    //                       ),
    //                       filled: true,
    //                       fillColor: darkTheme ? Colors.black45 : Colors.grey.shade200,
    //                       border: OutlineInputBorder(
    //                         borderRadius: BorderRadius.circular(40),
    //                         borderSide: const BorderSide(
    //                           width: 0,
    //                           style: BorderStyle.none,
    //                         ),
    //                       ),
    //                       //border: InputBorder.none,
    //                       prefixIcon: Icon(Icons.location_on, color: darkTheme ? Colors.amberAccent.shade400 : Colors.grey,),
    //                     ),
    //                   ),
    //
    //                   const SizedBox(height: 20,),
    //
    //                   TextField(
    //                     //controller: toTextEditingController,
    //                     decoration: InputDecoration(
    //                       hintText: 'To',
    //                       hintStyle: TextStyle(
    //                         color: darkTheme ? Colors.grey : Colors.grey,
    //                       ),
    //                       filled: true,
    //                       fillColor: darkTheme ? Colors.black45 : Colors.grey.shade200,
    //                       border: OutlineInputBorder(
    //                         borderRadius: BorderRadius.circular(40),
    //                         borderSide: const BorderSide(
    //                           width: 0,
    //                           style: BorderStyle.none,
    //                         ),
    //                       ),
    //                       //border: InputBorder.none,
    //                       prefixIcon: Icon(Icons.location_on, color: darkTheme ? Colors.amberAccent.shade400 : Colors.grey,),
    //                     ),
    //                   ),
    //
    //                   const SizedBox(height: 20,),
    //
    //                   ElevatedButton(
    //                     style: ElevatedButton.styleFrom(
    //                       primary: darkTheme ? Colors.amberAccent.shade400 : Colors.blue,
    //                       onPrimary: darkTheme ? Colors.black : Colors.white,
    //                       elevation: 3,
    //                       shape: RoundedRectangleBorder(
    //                           borderRadius: BorderRadius.circular(32.0)),
    //                       minimumSize: const Size(100, 40), //////// HERE
    //                     ),
    //                     onPressed: () async {
    //
    //                     },
    //                     child: const Text('Submit'),
    //                   ),
    //
    //                 ],
    //               ),
    //             ),
    //
    //           ],
    //         ),
    //       ],
    //     ),
    //   ),
    // );
  }
}
