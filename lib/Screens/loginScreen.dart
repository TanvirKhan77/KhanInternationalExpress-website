
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:khanintlexpress/Screens/homeScreen.dart';
import 'package:khanintlexpress/Screens/loginScreen.dart';
import 'package:khanintlexpress/Screens/registerScreen.dart';
import 'package:khanintlexpress/Widgets/loading_dialog.dart';

import '../AppBar/customAppbar.dart';
import '../AppBar/navbarCustom.dart';
import '../AppBar/navbarItem.dart';
import '../Global/global.dart';
import '../assistants/assistant_methods.dart';
import '../AdminScreens/adminDashboardScreen.dart';
import 'agentDashboardScreen.dart';
import 'employeeDashboardScreen.dart';
import 'guestProfileScreen.dart';

TextEditingController emailTextEditingController = TextEditingController();
TextEditingController passwordTextEditingController = TextEditingController();
GlobalKey<FormState> formKey = GlobalKey<FormState>();

checkIfUserRecordExists(User currentUser, BuildContext context) async {

  // print("Baal4");

  await FirebaseFirestore.instance
      .collection("users")
      .doc(currentUser.uid)
      .get()
      .then((record) async
  {
    if(record.exists) //record exists
        {
      //status is customer
      if(record.data()!["status"] == "Admin"
      || record.data()!["status"] == "Employee"
      || record.data()!["status"] == "Customer"
      || record.data()!["status"] == "Agent"){
        fAuth.currentUser != null ? AssistantMethods.readCurrentOnlineUserInfo() : null;
        Navigator.push(context, MaterialPageRoute(builder: (c) => HomeScreen()));
      }
      else //status is not customer
          {
        FirebaseAuth.instance.signOut();
        print("Blocked by admin. Contack Admin: khan_tanvir@outlook.com");
      }
    }
  });
}

loginNow(BuildContext context) async {
  showDialog(
      context: context,
      builder: (c)
      {
        return LoadingDialogWidget(
          message: "Checking credentials. Please Wait...",
        );
      }
  );


  User? currentUser;

  await FirebaseAuth.instance.signInWithEmailAndPassword(
    email: emailTextEditingController.text.trim(),
    password: passwordTextEditingController.text.trim(),
  ).then((auth){
    currentUser = auth.user;
  }).catchError((errorMessage){
    showDialog(
      context: context,
      builder: (c)
      {
        return LoadingDialogWidget(
          message: "Error Occured",
        );
      }
    );
    //print("Error Occured");
  });

  if(currentUser != null){
    checkIfUserRecordExists(currentUser!, context);
  }

}

validateForm(BuildContext context) {
  if(emailTextEditingController.text.isNotEmpty && passwordTextEditingController.text.isNotEmpty) {
    loginNow(context);
  }
  else {
    print("Please provide email and password.");
  }
}

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {

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
                return const LoginMobile();
              } else if (constraints.maxWidth > 600 && constraints.maxWidth < 900) {
                return const LoginMobile();
              } else {
                return const LoginDesktop();
              }
            },
          )
        ],
      )
    );
  }
}

class LoginMobile extends StatelessWidget {
  const LoginMobile({Key? key}) : super(key: key);

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
            Text('Login',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: darkTheme ? Colors.amberAccent.shade400 : Colors.black,
              ),
            ),
            
            SizedBox(height: 10,),
            
            const Text(
              'Please enter email and password',
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
                      validateForm(context);
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
                    Navigator.push(context, MaterialPageRoute(builder: (c) => RegisterScreen()));
                  },
                  child: Text(
                    "Doesn't have an account? Register",
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

class LoginDesktop extends StatelessWidget {
  const LoginDesktop({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    bool darkTheme = MediaQuery.of(context).platformBrightness == Brightness.dark;

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
                Text('Login',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: darkTheme ? Colors.amberAccent.shade700 : Colors.black,
                  ),
                ),

                const SizedBox(height: 10,),

                const Text(
                  'Please enter email and password',
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

                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          primary: darkTheme ? Colors.amberAccent.shade400 : Colors.blue,
                          onPrimary: darkTheme ? Colors.black : Colors.white,
                          // shadowColor: Colors.greenAccent,
                          elevation: 3,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(32.0)
                          ),
                          minimumSize: const Size(100, 40), //////// HERE
                        ),
                        onPressed: () {
                          validateForm(context);
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
                        Navigator.push(context, MaterialPageRoute(builder: (c) => RegisterScreen()));
                      },
                      child: Text(
                        "Doesn't have an account? Register",
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
