import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:khanintlexpress/AppBar/customAppbar.dart';
import 'package:khanintlexpress/Global/global.dart';

import '../Widgets/loading_dialog.dart';
import 'homeScreen.dart';

TextEditingController nameTextEditingController = TextEditingController();
TextEditingController phoneTextEditingController = TextEditingController();
TextEditingController emailTextEditingController = TextEditingController();
TextEditingController messageTextEditingController = TextEditingController();
GlobalKey<FormState> formKey = GlobalKey<FormState>();
String downloadUrlImage = "";

XFile? imgXFile;
final ImagePicker imagePicker = ImagePicker();

formValidation(BuildContext context) async {
  if(FirebaseAuth.instance.currentUser == null){
    if(nameTextEditingController.text.isNotEmpty
        && phoneTextEditingController.text.isNotEmpty
        && emailTextEditingController.text.isNotEmpty
        && messageTextEditingController.text.isNotEmpty)
    {
      showDialog(context: context, builder: (c)
      {
        return LoadingDialogWidget(
          message: "Sending your message.. Please Wait",
        );

      });
      print("Sending your message");

      saveInformationToDatabase(context);
    }
    else {
      print("Please complete the form. Do not leave any text field empty.");
    }
  } else {
    if(messageTextEditingController.text.isNotEmpty)
    {
      showDialog(context: context, builder: (c)
      {
        return LoadingDialogWidget(
          message: "Sending your message.. Please Wait",
        );

      });
      //print("Sending your message");

      saveInformationToDatabase(context);
    }
    else {
      showDialog(context: context, builder: (c)
      {
        return LoadingDialogWidget(
          message: "Please complete the form.",
        );

      });
      //print("Please complete the form. Do not leave any text field empty.");
    }
  }
}

saveInformationToDatabase(BuildContext context) async {

  if(FirebaseAuth.instance.currentUser != null){
    FirebaseFirestore.instance
        .collection("contacted")
        .doc(userModelCurrentInfo!.uid)
        .set(
        {
          "uid": userModelCurrentInfo!.uid,
          "date": DateTime.now(),
          "name": userModelCurrentInfo!.name,
          "phone": userModelCurrentInfo!.phone,
          "email": userModelCurrentInfo!.email,
          "message": messageTextEditingController.text.trim(),
          "status": userModelCurrentInfo!.status,
        });
  }else {
    DocumentReference reference = FirebaseFirestore.instance.collection("contacted").doc();
    reference.set({
      "uid": reference.id,
      "date": DateTime.now(),
      "name": nameTextEditingController.text.trim(),
      "phone": phoneTextEditingController.text.trim(),
      "email": emailTextEditingController.text.trim(),
      "message": messageTextEditingController.text.trim(),
      "status": "Guest",
    });
    // FirebaseFirestore.instance
    //     .collection("contacted")
    //     .doc()
    //     .set(
    //     {
    //       "date": DateTime.now(),
    //       "name": nameTextEditingController.text.trim(),
    //       "phone": phoneTextEditingController.text.trim(),
    //       "email": emailTextEditingController.text.trim(),
    //       "message": messageTextEditingController.text.trim(),
    //       "status": "Guest",
    //     });
  }

  showDialog(
      context: context,
      builder: (c)
      {
        return LoadingDialogWidget(
          message: "Your message has been sent.",
        );
      }
  );


  Navigator.push(context, MaterialPageRoute(builder: (c) => HomeScreen()));
}



class ContactUsScreen extends StatefulWidget {
  const ContactUsScreen({Key? key}) : super(key: key);

  @override
  State<ContactUsScreen> createState() => _ContactUsScreenState();
}

class _ContactUsScreenState extends State<ContactUsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: CustomAppBar(),
        body: ListView(
          children: [
            LayoutBuilder(
              builder: (context, constraints) {
                if (constraints.maxWidth < 600) {
                  return const ContactUsMobile();
                } else if (constraints.maxWidth > 600 && constraints.maxWidth < 900) {
                  return const ContactUsMobile();
                } else {
                  return const ContactUsDesktop();
                }
              },
            ),
          ],
        )
    );
  }
}

class ContactUsMobile extends StatelessWidget {
  const ContactUsMobile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    bool darkTheme = MediaQuery.of(context).platformBrightness == Brightness.dark;

    return Center(
      child: Container(
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
            Text('Contact Us',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: darkTheme ? Colors.amberAccent.shade400 : Colors.black,
              ),
            ),

            SizedBox(height: 10,),

            const Text(
              'Please enter your name and other information',
              style: TextStyle(
                color: Colors.grey,
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
                  Visibility(
                    visible: FirebaseAuth.instance.currentUser == null ? true : false,
                    child: Column(
                      children: [
                        TextField(
                          controller: nameTextEditingController,
                          decoration: InputDecoration(
                            hintText: 'Name',
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

                        const SizedBox(height: 20,),

                        TextField(
                          controller: phoneTextEditingController,
                          inputFormatters: [
                            FilteringTextInputFormatter.digitsOnly,
                          ],
                          decoration: InputDecoration(
                            hintText: 'Phone',
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
                            prefixIcon: Icon(Icons.phone, color: darkTheme ? Colors.amberAccent.shade400 : Colors.grey,),
                          ),
                        ),

                        const SizedBox(height: 20,),

                        TextField(
                          controller: emailTextEditingController,
                          decoration: InputDecoration(
                            hintText: 'Email',
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
                            prefixIcon: Icon(Icons.email, color: darkTheme ? Colors.amberAccent.shade400 : Colors.grey,),
                          ),
                        ),

                        const SizedBox(height: 20,),
                      ],
                    ),
                  ),

                  TextFormField(
                    controller: messageTextEditingController,
                    keyboardType: TextInputType.multiline,
                    inputFormatters: [
                      LengthLimitingTextInputFormatter(200)
                    ],
                    maxLines: null,
                    decoration: InputDecoration(
                      hintText: 'Message',
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
                  
                  // TextField(
                  //   controller: messageTextEditingController,
                  //   keyboardType: TextInputType.multiline,
                  //   maxLines: null,
                  //   decoration: InputDecoration(
                  //     hintText: 'Message',
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
                  //     prefixIcon: Icon(Icons.message, color: darkTheme ? Colors.amberAccent.shade400 : Colors.grey,),
                  //   ),
                  // ),

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
    );
  }
}

class ContactUsDesktop extends StatefulWidget {
  const ContactUsDesktop({Key? key}) : super(key: key);

  @override
  State<ContactUsDesktop> createState() => _ContactUsDesktopState();
}

class _ContactUsDesktopState extends State<ContactUsDesktop> {
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
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Contact Us',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: darkTheme ? Colors.amberAccent.shade400 : Colors.black,
              ),
            ),

            SizedBox(height: 10,),

            const Text(
              'Please enter your name and other information',
              style: TextStyle(
                color: Colors.grey,
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
                  Visibility(
                    visible: FirebaseAuth.instance.currentUser == null ? true : false,
                    child: Column(
                      children: [
                        TextField(
                          controller: nameTextEditingController,
                          decoration: InputDecoration(
                            hintText: 'Name',
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

                        const SizedBox(height: 20,),

                        TextField(
                          controller: phoneTextEditingController,
                          inputFormatters: [
                            FilteringTextInputFormatter.digitsOnly,
                          ],
                          decoration: InputDecoration(
                            hintText: 'Phone',
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
                            prefixIcon: Icon(Icons.phone, color: darkTheme ? Colors.amberAccent.shade400 : Colors.grey,),
                          ),
                        ),

                        const SizedBox(height: 20,),

                        TextField(
                          controller: emailTextEditingController,
                          decoration: InputDecoration(
                            hintText: 'Email',
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
                            prefixIcon: Icon(Icons.email, color: darkTheme ? Colors.amberAccent.shade400 : Colors.grey,),
                          ),
                        ),

                        const SizedBox(height: 20,),
                      ],
                    ),
                  ),

                  TextField(
                    controller: messageTextEditingController,
                    keyboardType: TextInputType.multiline,
                    maxLines: null,
                    decoration: InputDecoration(
                      hintText: 'Message',
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
                      shadowColor: Colors.greenAccent,
                      elevation: 3,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(32.0)),
                      minimumSize: const Size(100, 40), //////// HERE
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
    );
  }
}
