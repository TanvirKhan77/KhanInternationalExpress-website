import 'dart:io';
import 'dart:js';
import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:khanintlexpress/Assistants/assistant_methods.dart';
import 'package:khanintlexpress/Screens/homeScreen.dart';
import 'package:khanintlexpress/Widgets/loading_dialog.dart';

import '../AppBar/customAppbar.dart';
import '../AppBar/navbarCustom.dart';
import '../AppBar/navbarItem.dart';
import '../StorageService/storageService.dart';
import 'loginScreen.dart';
import 'package:path/path.dart' as Path;

TextEditingController nameTextEditingController = TextEditingController();
TextEditingController addressTextEditingController = TextEditingController();
TextEditingController phoneTextEditingController = TextEditingController();
TextEditingController emailTextEditingController = TextEditingController();
TextEditingController passwordTextEditingController = TextEditingController();
TextEditingController confirmPasswordTextEditingController = TextEditingController();
GlobalKey<FormState> formKey = GlobalKey<FormState>();
String downloadUrlImage = "";

File? _pickedImage;
Uint8List webImage = Uint8List(8);


XFile? imgXFile;
final ImagePicker imagePicker = ImagePicker();

var imagePath;
var imageName;

//final PickedFile pickedFile = PickedFile(imagePath);

PickedFile? pickedFile = PickedFile(imagePath);

final Storage storage = Storage();

formValidation(BuildContext context) async {
  if(passwordTextEditingController.text == confirmPasswordTextEditingController.text){
    if(nameTextEditingController.text.isNotEmpty
        && addressTextEditingController.text.isNotEmpty
        && phoneTextEditingController.text.isNotEmpty
        && emailTextEditingController.text.isNotEmpty
        && passwordTextEditingController.text.isNotEmpty
        && confirmPasswordTextEditingController.text.isNotEmpty)
    {
      showDialog(context: context, builder: (c)
      {
        return LoadingDialogWidget(
          message: "Registering your account",
        );

      }
      );
      print("Registering your account");

      saveInformationToDatabase(context);
    }
    else {
      //Not Working
      //Fluttertoast.showToast(msg: "Please complete the form. Do not leave any text field empty.");
      //Not Working
      // LoadingDialogWidget(
      //   message: "Please complete the form. Do not leave any text field empty.",
      // );
      print("Please complete the form. Do not leave any text field empty.");
    }
  }
  else {
    //Fluttertoast.showToast(msg: "Password and Confirm Password do not match.");
    print("Password and Confirm Password do not match.");
  }
}

saveInformationToDatabase(BuildContext context) async {
  //authenticate the user first
  User? currentUser;

  await FirebaseAuth.instance.createUserWithEmailAndPassword(
    email: emailTextEditingController.text.trim(),
    password: passwordTextEditingController.text.trim(),
  ).then((auth){
    currentUser = auth.user;
  }).catchError((errorMessage){
    print("Error Occured");
  });

  if(currentUser != null){
    saveInfoToFirestoreAndLocally(currentUser!, context);
  }
}

saveInfoToFirestoreAndLocally(User currentUser, BuildContext context) async {
  //save to firestore
  FirebaseFirestore.instance
      .collection("users")
      .doc(currentUser.uid)
      .set(
      {
        "photoId": "pro-pic.png",
        "uid": currentUser.uid,
        "name": nameTextEditingController.text.trim(),
        "address": addressTextEditingController.text.trim(),
        "phone": phoneTextEditingController.text.trim(),
        "email": currentUser.email,
        //"photoUrl": downloadUrlImage,
        "status": "Customer",
      });



  if(kIsWeb){
    storage.uploadFileForWeb(currentUser, pickedFile).then((value) => print('Done'));
  }
  else if(!kIsWeb){
    storage.uploadFile(currentUser, imagePath, imageName).then((value) => print('Done'));
  }



  //For saving user data locally
  AssistantMethods.readCurrentOnlineUserInfo();

  //save locally
  // sharedPreferences = await SharedPreferences.getInstance();
  // await sharedPreferences!.setString("uid", currentUser.uid);
  // await sharedPreferences!.setString("name", nameTextEditingController.text.trim());
  // await sharedPreferences!.setString("address", addressTextEditingController.text.trim());
  // await sharedPreferences!.setString("phone", phoneTextEditingController.text.trim());
  // await sharedPreferences!.setString("email", currentUser.email!);

  Navigator.push(context, MaterialPageRoute(builder: (c) => HomeScreen()));
}

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {

  @override
  Widget build(BuildContext context) {

    bool darkTheme = MediaQuery.of(context).platformBrightness == Brightness.dark;

    return Scaffold(
        appBar: CustomAppBar(),
        body: ListView(
          children: [
            LayoutBuilder(
              builder: (context, constraints) {
                if (constraints.maxWidth < 600) {
                  return const RegisterMobile();
                } else if (constraints.maxWidth > 600 && constraints.maxWidth < 900) {
                  return const RegisterMobile();
                } else {
                  return const RegisterDesktop();
                }
              },
            ),
          ],
        )
    );
  }
}

class RegisterMobile extends StatefulWidget {
  const RegisterMobile({Key? key}) : super(key: key);

  @override
  State<RegisterMobile> createState() => _RegisterMobileState();
}

class _RegisterMobileState extends State<RegisterMobile> {
  @override
  Widget build(BuildContext context) {
    bool darkTheme = MediaQuery.of(context).platformBrightness == Brightness.dark;

    // getImageFromGallery() async{
    //   imgXFile = await imagePicker.pickImage(source: ImageSource.gallery);
    //
    //   setState(() {
    //     imgXFile;
    //   });
    // }

    Future<void> _pickImage() async {
      if(!kIsWeb){
        final ImagePicker _picker = ImagePicker();
        XFile? image = await _picker.pickImage(source: ImageSource.gallery);
        if(image != null){
          var seletected = File(image.path);
          setState(() {
            imagePath = image.path;
            imageName = image.name;
            _pickedImage = seletected;
          });
        }else {
          print('No image has been picked');
        }
      }
      else if(kIsWeb){
        final ImagePicker _picker = ImagePicker();
        //XFile? image = await _picker.pickImage(source: ImageSource.gallery);
        pickedFile = await _picker.getImage(source: ImageSource.gallery);
        if(pickedFile != null){
          var f = await pickedFile!.readAsBytes();
          setState(() {
            webImage = f;
            _pickedImage = File('a');
          });
        }else {
          print('No image has been picked');
        }
      }
      else {
        print('Something went wrong');
      }
    }

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
            Text('Register',
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
                  //get-capture image
                  GestureDetector(
                    onTap: ()
                    {
                      //getImageFromGallery();
                      _pickImage();
                    },
                    // child: CircleAvatar(
                    //   radius: MediaQuery.of(context).size.width * 0.15,
                    //   backgroundColor: Colors.white,
                    //   //backgroundImage: imgXFile == null ? null : FileImage(File(imgXFile!.path)),
                    //   // child: imgXFile == null
                    //   //     ? Icon(
                    //   //   Icons.person,
                    //   //   color: Colors.grey,
                    //   //   size: MediaQuery.of(context).size.width * 0.20,
                    //   // ) : null,
                    //   child: _pickedImage == null ? Icon(Icons.add_a_photo,size: 50,)
                    //       : kIsWeb ? Image.memory(webImage, fit: BoxFit.cover,)
                    //       //: kIsWeb ? Image.file(_pickedImage!, fit: BoxFit.fill,)
                    //       : Image.file(_pickedImage!, fit: BoxFit.cover,),
                    // ),
                    child: ClipOval(
                      child: CircleAvatar(
                        radius: MediaQuery.of(context).size.width * 0.15,
                        backgroundColor: Colors.white,
                        child: _pickedImage == null ? Icon(Icons.add_a_photo,size: 50,)
                            : kIsWeb ? Image.memory(webImage, fit: BoxFit.cover,)
                            : Image.file(_pickedImage!, fit: BoxFit.cover,),
                      ),
                    ),
                  ),

                  SizedBox(height: 20,),

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
                    controller: addressTextEditingController,
                    decoration: InputDecoration(
                      hintText: 'Address',
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
                      prefixIcon: Icon(Icons.location_city, color: darkTheme ? Colors.amberAccent.shade400 : Colors.grey,),
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

                  TextField(
                    controller: passwordTextEditingController,
                    obscureText: true,
                    decoration: InputDecoration(
                      hintText: 'Password',
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
                      prefixIcon: Icon(Icons.lock, color: darkTheme ? Colors.amberAccent.shade400 : Colors.grey,),
                    ),
                  ),

                  const SizedBox(height: 20,),

                  TextField(
                    controller: confirmPasswordTextEditingController,
                    obscureText: true,
                    decoration: InputDecoration(
                      hintText: 'Confirm Password',
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
                      prefixIcon: Icon(Icons.lock, color: darkTheme ? Colors.amberAccent.shade400 : Colors.grey,),
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
                      formValidation(context);
                    },
                    child: const Text('Submit'),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 20,),

            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TextButton(
                  onPressed: () {
                    Navigator.push(context, MaterialPageRoute(builder: (c) => LoginScreen()));
                  },
                  child: Text(
                    "ALready have an account? Login Here",
                    style: TextStyle(
                      color: darkTheme ? Colors.amberAccent.shade400 : Colors.blue,
                    ),
                  ),
                ),
              ],
            ),

          ],
        ),
      ),
    );
  }
}


class RegisterDesktop extends StatefulWidget {
  const RegisterDesktop({Key? key}) : super(key: key);

  @override
  State<RegisterDesktop> createState() => _RegisterDesktopState();
}

class _RegisterDesktopState extends State<RegisterDesktop> {
  @override
  Widget build(BuildContext context) {

    bool darkTheme = MediaQuery.of(context).platformBrightness == Brightness.dark;

    Future<void> _pickImage() async {
      if(!kIsWeb){
        final ImagePicker _picker = ImagePicker();
        XFile? image = await _picker.pickImage(source: ImageSource.gallery);
        if(image != null){
          var seletected = File(image.path);
          setState(() {
            imagePath = image.path;
            imageName = image.name;
            _pickedImage = seletected;
          });
        }else {
          print('No image has been picked');
        }
      }
      else if(kIsWeb){
        final ImagePicker _picker = ImagePicker();
        //XFile? image = await _picker.pickImage(source: ImageSource.gallery);
        pickedFile = await _picker.getImage(source: ImageSource.gallery);
        if(pickedFile != null){
          var f = await pickedFile!.readAsBytes();
          setState(() {
            webImage = f;
            _pickedImage = File('a');
          });
        }else {
          print('No image has been picked');
        }
      }
      else {
        print('Something went wrong');
      }
    }

    return Center(
      child: Container(
          width: MediaQuery.of(context).size.width > 900 ? 700 : 500,
          padding: const EdgeInsets.all(40),
          decoration: const BoxDecoration(
            //borderRadius: BorderRadius.circular(20),
          ),
          child: ClipRRect(
            borderRadius: const BorderRadius.all(Radius.circular(20)),
            child: Container(
              //margin: EdgeInsets.symmetric(horizontal: 20, vertical: 100),
              padding: const EdgeInsets.all(20),
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                //color: Colors.white,
                color: darkTheme ? Colors.black45 : Colors.white70,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('Register',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: darkTheme ? Colors.amberAccent.shade700 : Colors.black,
                    ),
                  ),

                  const SizedBox(height: 10,),

                  const Text(
                    'Please enter your name and other information',
                    style: TextStyle(
                      color: Colors.grey,
                    ),
                  ),

                  const SizedBox(height: 20,),

                  Container(
                    width: MediaQuery.of(context).size.width > 900 ? 500 : 350,
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color:Colors.transparent,
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(width: 2,color: darkTheme ? Colors.amberAccent.shade400 : Colors.blue),
                    ),
                    child: Column(
                      children: [
                        //get-capture image
                        GestureDetector(
                          onTap: ()
                          {
                            //getImageFromGallery();
                            _pickImage();
                          },
                          child: CircleAvatar(
                            radius: MediaQuery.of(context).size.width * 0.05,
                            backgroundColor: Colors.white,
                            //backgroundImage: imgXFile == null ? null : FileImage(File(imgXFile!.path)),
                            // child: imgXFile == null
                            //     ? Icon(
                            //   Icons.person,
                            //   color: Colors.grey,
                            //   size: MediaQuery.of(context).size.width * 0.20,
                            // ) : null,
                            child: _pickedImage == null ? Icon(Icons.add_a_photo,size: 50,)
                                : kIsWeb ? Image.memory(webImage, fit: BoxFit.cover,)
                            //: kIsWeb ? Image.file(_pickedImage!, fit: BoxFit.fill,)
                                : Image.file(_pickedImage!, fit: BoxFit.cover,),
                          ),
                        ),

                        SizedBox(height: 20,),

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
                          controller: addressTextEditingController,
                          decoration: InputDecoration(
                            hintText: 'Address',
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
                            prefixIcon: Icon(Icons.location_city, color: darkTheme ? Colors.amberAccent.shade400 : Colors.grey,),
                          ),
                        ),

                        const SizedBox(height: 20,),

                        TextField(
                          controller: phoneTextEditingController,
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

                        TextField(
                          controller: passwordTextEditingController,
                          obscureText: true,
                          decoration: InputDecoration(
                            hintText: 'Password',
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
                            prefixIcon: Icon(Icons.lock, color: darkTheme ? Colors.amberAccent.shade400 : Colors.grey,),
                          ),
                        ),

                        const SizedBox(height: 20,),

                        TextField(
                          controller: confirmPasswordTextEditingController,
                          obscureText: true,
                          decoration: InputDecoration(
                            hintText: 'Confirm Password',
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
                            prefixIcon: Icon(Icons.lock, color: darkTheme ? Colors.amberAccent.shade400 : Colors.grey,),
                          ),
                        ),

                        const SizedBox(height: 20,),

                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            primary: darkTheme ? Colors.amberAccent.shade400 : Colors.blue,
                            onPrimary: darkTheme ? Colors.black : Colors.white,
                            elevation: 0,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(32.0)
                            ),
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

                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      TextButton(
                        onPressed: () {
                          Navigator.push(context, MaterialPageRoute(builder: (c) => LoginScreen()));
                        },
                        child: Text(
                          "Already have an account? Login here",
                          style: TextStyle(
                            color: darkTheme ? Colors.amberAccent.shade400 : Colors.blue,
                          ),
                        ),
                      ),
                    ],
                  ),

                ],
              ),
            ),



          )
      ),
    );
  }
}

