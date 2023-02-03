import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:khanintlexpress/AppBar/customAppBar.dart';
import 'package:khanintlexpress/Global/global.dart';
import 'package:khanintlexpress/Screens/passengerScreen.dart';

import '../Widgets/FromHelper.dart';

DateTime departureDate = DateTime.now();
DateTime returnDate = DateTime.now();

TextEditingController fromTextEditingController = TextEditingController();
TextEditingController toTextEditingController = TextEditingController();
TextEditingController preferableTimeTextEditingController = TextEditingController();

File? _pickedNidImage,_pickedVisaImage;
Uint8List nidWebImage = Uint8List(8);
Uint8List visaWebImage = Uint8List(8);

XFile? nidImgXFile,visaImgXFile;
final ImagePicker nidImagePicker = ImagePicker();
final ImagePicker visaImagePicker = ImagePicker();

var nidImagePath;
var nidImageName;

var visaImagePath;
var visaImageName;

//final PickedFile pickedFile = PickedFile(imagePath);

PickedFile? nidPickedFile = PickedFile(nidImagePath);
PickedFile? visaPickedFile = PickedFile(visaImagePath);

class BookingScreen extends StatefulWidget {
  const BookingScreen({Key? key}) : super(key: key);

  @override
  State<BookingScreen> createState() => _BookingScreenState();
}

class _BookingScreenState extends State<BookingScreen> {
  @override
  Widget build(BuildContext context) {
    if(FirebaseAuth.instance.currentUser == null){
      return Scaffold(
        appBar: CustomAppBar(),
        body: Center(
          child: Text(
            'Please login to book a flight',
          ),
        ),
      );
    }
    else {
      // return Scaffold(
      //   appBar: CustomAppBar(),
      //   body: Center(
      //     child: Text(
      //       'Logged in ${userModelCurrentInfo!.name}',
      //     ),
      //   ),
      // );
      return Scaffold(
          appBar: CustomAppBar(),
          body: LayoutBuilder(
            builder: (context, constraints) {
              if (constraints.maxWidth < 600) {
                return const BookingMobile();
              } else if (constraints.maxWidth > 600 && constraints.maxWidth < 900) {
                return const BookingMobile();
              } else {
                return const BookingDesktop();
              }
            },
          ),
      );
    }

  }
}

class BookingMobile extends StatefulWidget {
  const BookingMobile({Key? key}) : super(key: key);

  @override
  State<BookingMobile> createState() => _BookingMobileState();
}

class _BookingMobileState extends State<BookingMobile> {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}

class BookingDesktop extends StatefulWidget {
  const BookingDesktop({Key? key}) : super(key: key);

  @override
  State<BookingDesktop> createState() => _BookingDesktopState();
}

class _BookingDesktopState extends State<BookingDesktop> {

  List<dynamic> adults = [];
  String? adultsId;
  List<dynamic> childrens = [];
  String? childrensId;
  List<dynamic> infants = [];
  String? infantsId;

  String _value = 'One-Way';

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    adults.add({"id": 1, "passenger": "1"});
    adults.add({"id": 2, "passenger": "2"});
    adults.add({"id": 3, "passenger": "3"});
    adults.add({"id": 4, "passenger": "4"});
    adults.add({"id": 5, "passenger": "5"});
    adults.add({"id": 6, "passenger": "6"});
    adults.add({"id": 7, "passenger": "7"});
    adults.add({"id": 8, "passenger": "8"});
    adults.add({"id": 9, "passenger": "9"});

    childrens.add({"id": 1, "passenger": "1"});
    childrens.add({"id": 2, "passenger": "2"});
    childrens.add({"id": 3, "passenger": "3"});
    childrens.add({"id": 4, "passenger": "4"});
    childrens.add({"id": 5, "passenger": "5"});
    childrens.add({"id": 6, "passenger": "6"});
    childrens.add({"id": 7, "passenger": "7"});
    childrens.add({"id": 8, "passenger": "8"});
    childrens.add({"id": 9, "passenger": "9"});

    infants.add({"id": 1, "passenger": "1"});
    infants.add({"id": 2, "passenger": "2"});
    infants.add({"id": 3, "passenger": "3"});
    infants.add({"id": 4, "passenger": "4"});
    infants.add({"id": 5, "passenger": "5"});
  }

  @override
  Widget build(BuildContext context) {

    bool darkTheme = MediaQuery.of(context).platformBrightness == Brightness.dark;

    Future<void> _pickImage() async {
      if(!kIsWeb){
        final ImagePicker _nidPicker = ImagePicker();
        XFile? image = await _nidPicker.pickImage(source: ImageSource.gallery);
        if(image != null){
          var seletected = File(image.path);
          setState(() {
            nidImagePath = image.path;
            nidImageName = image.name;
            _pickedNidImage = seletected;
          });
        }else {
          print('No image has been picked');
        }
      }
      else if(kIsWeb){
        final ImagePicker _nidPicker = ImagePicker();
        //XFile? image = await _nidPicker.pickImage(source: ImageSource.gallery);
        nidPickedFile = await _nidPicker.getImage(source: ImageSource.gallery);
        if(nidPickedFile != null){
          var f = await nidPickedFile!.readAsBytes();
          setState(() {
            nidWebImage = f;
            _pickedNidImage = File('a');
          });
        }else {
          print('No image has been picked');
        }
      }
      else {
        print('Something went wrong');
      }
    }

    Future<void> _visaImage() async {
      if(!kIsWeb){
        final ImagePicker _visaPicker = ImagePicker();
        XFile? image = await _visaPicker.pickImage(source: ImageSource.gallery);
        if(image != null){
          var seletected = File(image.path);
          setState(() {
            visaImagePath = image.path;
            visaImageName = image.name;
            _pickedVisaImage = seletected;
          });
        }else {
          print('No image has been picked');
        }
      }
      else if(kIsWeb){
        final ImagePicker _visaPicker = ImagePicker();
        //XFile? image = await _picker.pickImage(source: ImageSource.gallery);
        visaPickedFile = await _visaPicker.getImage(source: ImageSource.gallery);
        if(visaPickedFile != null){
          var f = await visaPickedFile!.readAsBytes();
          setState(() {
            visaWebImage = f;
            _pickedVisaImage = File('a');
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
        width: MediaQuery.of(context).size.width > 900 ? 700 : 500,
        decoration: BoxDecoration(
          //color: Colors.white,
          color: darkTheme ? Colors.black45 : Colors.grey.shade100,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Row(
              children: [
                Radio(
                    value: 'One-Way',
                    groupValue: _value,
                    fillColor: MaterialStateColor.resolveWith((states) => darkTheme ? Colors.amber : Colors.blue),
                    onChanged: (value) {
                      setState(() {
                        _value = value!;
                      });
                    }
                ),

                SizedBox(width: 10,),

                Text("One-Way",
                  style: TextStyle(
                    color: darkTheme ? Colors.grey : Colors.black,
                  ),
                ),

                Radio(
                    value: 'Round Way',
                    groupValue: _value,
                    fillColor: MaterialStateColor.resolveWith((states) => darkTheme ? Colors.amber : Colors.blue),
                    onChanged: (value) {
                      setState(() {
                        _value = value!;
                      });
                    }
                ),

                SizedBox(width: 10,),

                Text("Round Way",
                  style: TextStyle(
                    color: darkTheme ? Colors.grey : Colors.black,
                  ),
                ),

                // Radio(
                //     value: 'Multi City',
                //     groupValue: _value,
                //     fillColor: MaterialStateColor.resolveWith((states) => darkTheme ? Colors.amber : Colors.blue),
                //     onChanged: (value) {
                //       setState(() {
                //         _value = value!;
                //       });
                //     }
                // ),
                //
                // SizedBox(width: 10,),
                //
                // Text("Multi City",
                //   style: TextStyle(
                //     color: darkTheme ? Colors.grey : Colors.black,
                //   ),
                // ),
              ],
            ),

            SizedBox(height: 10,),

            Row(
              children: [
                Visibility(
                  visible: _value == '' ? false : _value == 'One-Way' ? true : false,
                  child: Column(
                    children: [
                      Row(
                        children: [
                          SizedBox(
                            width: 300,
                            child: TextField(
                              controller: fromTextEditingController,
                              decoration: InputDecoration(
                                hintText: 'From',
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
                                prefixIcon: Icon(Icons.location_on, color: darkTheme ? Colors.amberAccent.shade400 : Colors.grey,),
                              ),
                            ),
                          ),

                          SizedBox(width: 10,),

                          SizedBox(
                            width: 300,
                            child: TextField(
                              controller: toTextEditingController,
                              decoration: InputDecoration(
                                hintText: 'To',
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
                                prefixIcon: Icon(Icons.location_on, color: darkTheme ? Colors.amberAccent.shade400 : Colors.grey,),
                              ),
                            ),
                          ),
                        ],
                      ),

                      SizedBox(height: 10,),

                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          SizedBox(
                            width: 300,
                            child: GestureDetector(
                              onTap: () async {
                                DateTime? newDate = await showDatePicker(
                                  context: context,
                                  initialDate: departureDate,
                                  firstDate: DateTime(1900),
                                  lastDate: DateTime(2100),
                                );

                                // if 'cancel' => null
                                if(newDate == null) return;

                                //if 'OK' => DateTime
                                setState(() {
                                  departureDate = newDate;
                                  print(departureDate);
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
                                      'Departure Date ${departureDate.day}/${departureDate.month}/${departureDate.year}',
                                      style: TextStyle(
                                        color: Colors.grey,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),

                          SizedBox(width: 10,),

                          SizedBox(
                            width: 300,
                          )

                        ],
                      ),

                      SizedBox(height: 10,),

                      Row(
                        children: [
                          SizedBox(
                            width: 200,
                            child: FormHelper.dropDownWidgetCountry(
                              context,
                              "Adults",
                              this.adultsId,
                              this.adults,
                              (onChangedVal) {
                                this.adultsId = onChangedVal;
                                //print("Selected Country ID: $onChangedVal");
                              },
                                  (onValidateVal) {
                                if(onValidateVal == null) {
                                  return 'Please Select number of passenger';
                                }
                                return null;
                              },
                              optionValue: "id",
                              optionLabel: "passenger",
                            ),
                          ),

                          SizedBox(width: 5,),

                          SizedBox(
                            width: 200,
                            child: FormHelper.dropDownWidgetCountry(
                              context,
                              "Children",
                              this.childrensId,
                              this.childrens,
                                  (onChangedVal) {
                                this.childrensId = onChangedVal;
                                //print("Selected Country ID: $onChangedVal");
                              },
                                  (onValidateVal) {
                                if(onValidateVal == null) {
                                  return 'Please Select number of passenger';
                                }
                                return null;
                              },
                              optionValue: "id",
                              optionLabel: "passenger",
                            ),
                          ),

                          SizedBox(width: 5,),

                          SizedBox(
                            width: 200,
                            child: FormHelper.dropDownWidgetCountry(
                              context,
                              "Infants",
                              this.infantsId,
                              this.infants,
                                  (onChangedVal) {
                                this.infantsId = onChangedVal;
                                //print("Selected Country ID: $onChangedVal");
                              },
                                  (onValidateVal) {
                                if(onValidateVal == null) {
                                  return 'Please Select number of passenger';
                                }
                                return null;
                              },
                              optionValue: "id",
                              optionLabel: "passenger",
                            ),
                          ),

                        ],
                      ),

                      SizedBox(height: 10,),

                      Text('Optional',
                        style: TextStyle(
                          color: darkTheme ? Colors.grey : Colors.black,
                        ),
                      ),

                      SizedBox(height: 10,),

                      Container(
                        // width: MediaQuery.of(context).size.width > 300 ? 400 : 300,
                        padding: EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: Colors.transparent,
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(width: 2,color: darkTheme ? Colors.amberAccent.shade400 : Colors.blue),
                        ),
                        child: Row(
                          children: [
                            GestureDetector(
                              onTap: ()
                              {
                                //getImageFromGallery();
                                _pickImage();
                              },
                              child: Container(
                                height: 200,
                                width: 300,
                                child: _pickedNidImage == null ?
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [

                                      Icon(Icons.add_a_photo,size: 50,),

                                      SizedBox(height: 10,),

                                      Text('Upload BC/NID/Passport Copy',
                                        style: TextStyle(
                                          color: darkTheme ? Colors.amber : Colors.blue,
                                        ),
                                      )
                                    ],
                                  )

                                    : kIsWeb ? Image.memory(nidWebImage, fit: BoxFit.cover,)
                                    : Image.file(_pickedNidImage!, fit: BoxFit.cover,),
                              ),
                            ),

                            SizedBox(width: 2,),

                            GestureDetector(
                              onTap: ()
                              {
                                //getImageFromGallery();
                                _visaImage();
                              },
                              child: Container(
                                height: 200,
                                width: 300,
                                child: _pickedNidImage == null ?
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [

                                    Icon(Icons.add_a_photo,size: 50,),

                                    SizedBox(height: 10,),

                                    Text('Upload VISA Copy \n for international flight',
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        color: darkTheme ? Colors.amber : Colors.blue,
                                      ),
                                    )
                                  ],
                                )

                                    : kIsWeb ? Image.memory(visaWebImage, fit: BoxFit.cover,)
                                    : Image.file(_pickedVisaImage!, fit: BoxFit.cover,),
                              ),
                            ),
                          ],
                        ),
                      ),

                      SizedBox(height: 20,),

                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          primary: darkTheme ? Colors.amberAccent.shade400 : Colors.blue,
                          onPrimary: darkTheme ? Colors.black : Colors.white,
                          elevation: 3,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(32.0)),
                          minimumSize: const Size(100, 40), //////// HERE
                        ),
                        onPressed: () async {
                          Navigator.push(context, MaterialPageRoute(builder: (c) => PassengerScreen()));
                        },
                        child: const Text('Search'),
                      ),

                    ],
                  ),

                ),

                Visibility(
                  visible: _value == '' ? false : _value == 'Round Way' ? true : false,
                  child: Column(
                    children: [
                      Row(
                        children: [
                          SizedBox(
                            width: 300,
                            child: TextField(
                              controller: fromTextEditingController,
                              decoration: InputDecoration(
                                hintText: 'From',
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
                                prefixIcon: Icon(Icons.location_on, color: darkTheme ? Colors.amberAccent.shade400 : Colors.grey,),
                              ),
                            ),
                          ),

                          SizedBox(width: 10,),

                          SizedBox(
                            width: 300,
                            child: TextField(
                              controller: toTextEditingController,
                              decoration: InputDecoration(
                                hintText: 'To',
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
                                prefixIcon: Icon(Icons.location_on, color: darkTheme ? Colors.amberAccent.shade400 : Colors.grey,),
                              ),
                            ),
                          ),
                        ],
                      ),

                      SizedBox(height: 10,),

                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          SizedBox(
                            width: 300,
                            child: GestureDetector(
                              onTap: () async {
                                DateTime? newDate = await showDatePicker(
                                  context: context,
                                  initialDate: departureDate,
                                  firstDate: DateTime(1900),
                                  lastDate: DateTime(2100),
                                );

                                // if 'cancel' => null
                                if(newDate == null) return;

                                //if 'OK' => DateTime
                                setState(() {
                                  departureDate = newDate;
                                  print(departureDate);
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
                                      'Departure Date ${departureDate.day}/${departureDate.month}/${departureDate.year}',
                                      style: TextStyle(
                                        color: Colors.grey,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),

                          SizedBox(width: 10,),

                          SizedBox(
                            width: 300,
                            child: GestureDetector(
                              onTap: () async {
                                DateTime? newDate = await showDatePicker(
                                  context: context,
                                  initialDate: returnDate,
                                  firstDate: DateTime(1900),
                                  lastDate: DateTime(2100),
                                );

                                // if 'cancel' => null
                                if(newDate == null) return;

                                //if 'OK' => DateTime
                                setState(() {
                                  returnDate = newDate;
                                  print(returnDate);
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
                                      'Return Date ${returnDate.day}/${returnDate.month}/${returnDate.year}',
                                      style: TextStyle(
                                        color: Colors.grey,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          )

                        ],
                      ),

                      SizedBox(height: 10,),

                      Row(
                        children: [
                          SizedBox(
                            width: 200,
                            child: FormHelper.dropDownWidgetCountry(
                              context,
                              "Adults",
                              this.adultsId,
                              this.adults,
                                  (onChangedVal) {
                                this.adultsId = onChangedVal;
                                //print("Selected Country ID: $onChangedVal");
                              },
                                  (onValidateVal) {
                                if(onValidateVal == null) {
                                  return 'Please Select number of passenger';
                                }
                                return null;
                              },
                              optionValue: "id",
                              optionLabel: "passenger",
                            ),
                          ),

                          SizedBox(width: 5,),

                          SizedBox(
                            width: 200,
                            child: FormHelper.dropDownWidgetCountry(
                              context,
                              "Children",
                              this.childrensId,
                              this.childrens,
                                  (onChangedVal) {
                                this.childrensId = onChangedVal;
                                //print("Selected Country ID: $onChangedVal");
                              },
                                  (onValidateVal) {
                                if(onValidateVal == null) {
                                  return 'Please Select number of passenger';
                                }
                                return null;
                              },
                              optionValue: "id",
                              optionLabel: "passenger",
                            ),
                          ),

                          SizedBox(width: 5,),

                          SizedBox(
                            width: 200,
                            child: FormHelper.dropDownWidgetCountry(
                              context,
                              "Infants",
                              this.infantsId,
                              this.infants,
                                  (onChangedVal) {
                                this.infantsId = onChangedVal;
                                //print("Selected Country ID: $onChangedVal");
                              },
                                  (onValidateVal) {
                                if(onValidateVal == null) {
                                  return 'Please Select number of passenger';
                                }
                                return null;
                              },
                              optionValue: "id",
                              optionLabel: "passenger",
                            ),
                          ),

                        ],
                      ),

                      SizedBox(height: 10,),

                      Text('Optional',
                        style: TextStyle(
                          color: darkTheme ? Colors.grey : Colors.black,
                        ),
                      ),

                      SizedBox(height: 10,),

                      Container(
                        // width: MediaQuery.of(context).size.width > 300 ? 400 : 300,
                        padding: EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: Colors.transparent,
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(width: 2,color: darkTheme ? Colors.amberAccent.shade400 : Colors.blue),
                        ),
                        child: Row(
                          children: [
                            GestureDetector(
                              onTap: ()
                              {
                                //getImageFromGallery();
                                _pickImage();
                              },
                              child: Container(
                                height: 200,
                                width: 300,
                                child: _pickedNidImage == null ?
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [

                                    Icon(Icons.add_a_photo,size: 50,),

                                    SizedBox(height: 10,),

                                    Text('Upload BC/NID/Passport Copy',
                                      style: TextStyle(
                                        color: darkTheme ? Colors.amber : Colors.blue,
                                      ),
                                    )
                                  ],
                                )

                                    : kIsWeb ? Image.memory(nidWebImage, fit: BoxFit.cover,)
                                    : Image.file(_pickedNidImage!, fit: BoxFit.cover,),
                              ),
                            ),

                            SizedBox(width: 2,),

                            GestureDetector(
                              onTap: ()
                              {
                                //getImageFromGallery();
                                _visaImage();
                              },
                              child: Container(
                                height: 200,
                                width: 300,
                                child: _pickedNidImage == null ?
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [

                                    Icon(Icons.add_a_photo,size: 50,),

                                    SizedBox(height: 10,),

                                    Text('Upload VISA Copy \n for international flight',
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        color: darkTheme ? Colors.amber : Colors.blue,
                                      ),
                                    )
                                  ],
                                )

                                    : kIsWeb ? Image.memory(visaWebImage, fit: BoxFit.cover,)
                                    : Image.file(_pickedVisaImage!, fit: BoxFit.cover,),
                              ),
                            ),
                          ],
                        ),
                      ),

                      SizedBox(height: 20,),

                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          primary: darkTheme ? Colors.amberAccent.shade400 : Colors.blue,
                          onPrimary: darkTheme ? Colors.black : Colors.white,
                          elevation: 3,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(32.0)),
                          minimumSize: const Size(100, 40), //////// HERE
                        ),
                        onPressed: () async {
                          Navigator.push(context, MaterialPageRoute(builder: (c) => PassengerScreen()));
                        },
                        child: const Text('Search'),
                      ),

                    ],
                  ),
                ),

                // Visibility(
                //   visible: _value == '' ? false : _value == 'Multi City' ? true : false,
                //   child: Container(
                //     color: Colors.amber,
                //     height: 200,
                //     width: 900,
                //     child: Text('Multi City'),
                //   ),
                // ),
              ],
            ),



          ],
        ),
      ),
    );

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
    //             Text('Book a flight',
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
    //                     controller: fromTextEditingController,
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
    //                     controller: toTextEditingController,
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
    //                   GestureDetector(
    //                     onTap: () async {
    //                       DateTime? newDate = await showDatePicker(
    //                         context: context,
    //                         initialDate: departureDate,
    //                         firstDate: DateTime(1900),
    //                         lastDate: DateTime(2100),
    //                       );
    //
    //                       // if 'cancel' => null
    //                       if(newDate == null) return;
    //
    //                       //if 'OK' => DateTime
    //                       setState(() {
    //                         departureDate = newDate;
    //                         print(departureDate);
    //                       });
    //                     },
    //                     child: Container(
    //                       padding: EdgeInsets.all(15),
    //                       decoration: BoxDecoration(
    //                         color: darkTheme ? Colors.black45 : Colors.grey.shade200,
    //                         borderRadius: BorderRadius.circular(30),
    //                       ),
    //                       child: Row(
    //                         children: [
    //                           Icon(
    //                             Icons.calendar_today,
    //                             color: darkTheme ? Colors.amber : Colors.grey,
    //                           ),
    //
    //                           SizedBox(width: 10,),
    //
    //                           Text(
    //                             'Departure Date ${departureDate.day}/${departureDate.month}/${departureDate.year}',
    //                             style: TextStyle(
    //                               color: Colors.grey,
    //                             ),
    //                           ),
    //                         ],
    //                       ),
    //                     ),
    //                   ),
    //
    //                   const SizedBox(height: 20,),
    //
    //                   GestureDetector(
    //                     onTap: () async {
    //                       DateTime? newDate = await showDatePicker(
    //                         context: context,
    //                         initialDate: returnDate,
    //                         firstDate: DateTime(1900),
    //                         lastDate: DateTime(2100),
    //                       );
    //
    //                       // if 'cancel' => null
    //                       if(newDate == null) return;
    //
    //                       //if 'OK' => DateTime
    //                       setState(() {
    //                         returnDate = newDate;
    //                         print(returnDate);
    //                       });
    //                     },
    //                     child: Container(
    //                       padding: EdgeInsets.all(15),
    //                       decoration: BoxDecoration(
    //                         color: darkTheme ? Colors.black45 : Colors.grey.shade200,
    //                         borderRadius: BorderRadius.circular(30),
    //                       ),
    //                       child: Row(
    //                         children: [
    //                           Icon(
    //                             Icons.calendar_today,
    //                             color: darkTheme ? Colors.amber : Colors.grey,
    //                           ),
    //
    //                           SizedBox(width: 10,),
    //
    //                           Text(
    //                             'Return Date ${returnDate.day}/${returnDate.month}/${returnDate.year}',
    //                             style: TextStyle(
    //                               color: Colors.grey,
    //                             ),
    //                           ),
    //                         ],
    //                       ),
    //                     ),
    //                   ),
    //
    //                   const SizedBox(height: 20,),
    //
    //                   TextField(
    //                     controller: preferableTimeTextEditingController,
    //                     decoration: InputDecoration(
    //                       hintText: 'Preferable Time',
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
    //                   FormHelper.dropDownWidgetCountry(
    //                     context,
    //                     "Select number of Passenger",
    //                     this.passengerId,
    //                     this.passengers,
    //                     (onChangedVal) {
    //                       this.passengerId = onChangedVal;
    //                       print("Selected Country ID: $onChangedVal");
    //                     },
    //                         (onValidateVal) {
    //                       if(onValidateVal == null) {
    //                         return 'Please Select Country';
    //                       }
    //                       return null;
    //                     },
    //                     optionValue: "id",
    //                     optionLabel: "passenger",
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
    //                       Navigator.push(context, MaterialPageRoute(builder: (c) => PassengerScreen()));
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
