import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:khanintlexpress/AdminScreens/adminProfileScreen.dart';
import 'package:khanintlexpress/EmployeeScreens/employeeProfileScreen.dart';
import 'package:khanintlexpress/Screens/contactUsScreen.dart';
import 'package:provider/provider.dart';

import '../AdminScreens/Components/menuController.dart';
import '../CustomerScreens/customerProfileScreen.dart';
import '../Global/global.dart';
import '../AdminScreens/adminDashboardScreen.dart';
import '../Screens/agentDashboardScreen.dart';
import '../Screens/guestProfileScreen.dart';
import '../Screens/homeScreen.dart';
import '../Screens/loginScreen.dart';
import 'navbarCustom.dart';
import 'navbarItem.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget{

  @override
  Size get preferredSize => const Size.fromHeight(50);

  @override
  Widget build(BuildContext context) {

    bool darkTheme = MediaQuery.of(context).platformBrightness == Brightness.dark;

    return Scaffold(
      body: AdaptiveNavBar(
        backgroundColor: darkTheme ? Colors.black87 : primaryColor,
        screenWidth: MediaQuery.of(context).size.width,
        centerTitle: MediaQuery.of(context).size.width < 600 ? true : false,
        elevation: 0.0,
        leading: GestureDetector(
          onTap: () {
            Navigator.push(context, MaterialPageRoute(builder: (c) => HomeScreen()));
          },
          child: Image.asset('assets/images/logo-small.png',scale: 30,),
        ),
        title: FittedBox(
          child: Row(
            children: const [
              Text("Khan International Express",
                style: TextStyle(
                  fontSize: 18,
                ),
              ),
            ],
          ),
        ),
        navBarItems: [
          NavBarItem(
            text: "Home",
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (c) => HomeScreen()));
            },
          ),
          NavBarItem(
            text: "Profile",
            onTap: () {
              if(FirebaseAuth.instance.currentUser == null){
                Navigator.push(context, MaterialPageRoute(builder: (c) => GuestProfileScreen()));
              }
              else {
                if(userModelCurrentInfo!.status == "Admin"){
                  Future.delayed(Duration(milliseconds: 500), () {
                    Navigator.push(context, MaterialPageRoute(builder: (c) =>
                        MultiProvider(
                          providers: [
                            ChangeNotifierProvider(
                              create: (context) => MenuController(),
                            ),
                          ],
                          child: AdminProfileScreen(),
                        ),
                    ));
                  });
                }
                else if(userModelCurrentInfo!.status == "Employee") {
                  Future.delayed(Duration(milliseconds: 500), () {
                    Navigator.push(context, MaterialPageRoute(builder: (c) =>
                        MultiProvider(
                          providers: [
                            ChangeNotifierProvider(
                              create: (context) => MenuController(),
                            ),
                          ],
                          child: EmployeeProfileScreen(),
                        ),
                    ));
                  });
                  //Navigator.push(context, MaterialPageRoute(builder: (c) => EmployeeProfileScreen()));
                }
                else if(userModelCurrentInfo!.status == "Agent") {
                  Navigator.push(context, MaterialPageRoute(builder: (c) => AgentProfileScreen()));
                }
                else if(userModelCurrentInfo!.status == "Customer") {
                  Future.delayed(Duration(milliseconds: 500), () {
                    Navigator.push(context, MaterialPageRoute(builder: (c) =>
                        MultiProvider(
                          providers: [
                            ChangeNotifierProvider(
                              create: (context) => MenuController(),
                            ),
                          ],
                          child: CustomerProfileScreen(),
                        ),
                    ));
                  });
                  //Navigator.push(context, MaterialPageRoute(builder: (c) => CustomerProfileScreen()));
                }
              }
            },
          ),
          // NavBarItem(
          //   text: "Services",
          //   onTap: () {
          //     Navigator.push(context, MaterialPageRoute(builder: (c) => ServicesScreen()));
          //   },
          // ),
          NavBarItem(
            text: "Contact Us",
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (c) => ContactUsScreen()));
            },
          ),
          NavBarItem(
            text: FirebaseAuth.instance.currentUser == null ? "Login" : "Logout",
            onTap: () {
              if(FirebaseAuth.instance.currentUser == null){
                Navigator.push(context, MaterialPageRoute(builder: (c) => LoginScreen()));
              }
              else {
                FirebaseAuth.instance.signOut();
                Navigator.push(context, MaterialPageRoute(builder: (c) => HomeScreen()));
              }
            },
          ),
        ],
      ),
    );
  }
}
