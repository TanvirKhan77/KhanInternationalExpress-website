import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:khanintlexpress/AdminScreens/adminClients&ServicesScreen.dart';
import 'package:khanintlexpress/AdminScreens/adminDashboardScreen.dart';
import 'package:khanintlexpress/AdminScreens/adminFormScreen.dart';
import 'package:khanintlexpress/AdminScreens/adminMakeBill.dart';
import 'package:khanintlexpress/AdminScreens/adminProfileScreen.dart';
import 'package:khanintlexpress/AdminScreens/adminTableScreen.dart';
import 'package:provider/provider.dart';

import '../../Screens/homeScreen.dart';
import 'menuController.dart';

class AdminSideMenu extends StatelessWidget {
  const AdminSideMenu({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: SingleChildScrollView(
        child: Column(
          children: [
            DrawerHeader(
              child: Image.asset("assets/images/logo-small.png"),
            ),
            // DrawerListTile(
            //   title: "Home",
            //   svgSrc: "assets/icons/menu_dashbord.svg",
            //   press: () {
            //     Navigator.push(context, MaterialPageRoute(builder: (c) => HomeScreen()));
            //   },
            // ),
            DrawerListTile(
              title: "Profile",
              svgSrc: "assets/icons/menu_tran.svg",
              press: () {
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
              },
            ),
            DrawerListTile(
              title: "Dashboard",
              svgSrc: "assets/icons/menu_tran.svg",
              press: () {
                Future.delayed(Duration(milliseconds: 500), () {
                  Navigator.push(context, MaterialPageRoute(builder: (c) =>
                      MultiProvider(
                        providers: [
                          ChangeNotifierProvider(
                            create: (context) => MenuController(),
                          ),
                        ],
                        child: AdminDashboardScreen(),
                      ),
                  ));
                });
              },
            ),
            DrawerListTile(
              title: "Users",
              svgSrc: "assets/icons/menu_tran.svg",
              press: () {},
            ),
            DrawerListTile(
              title: "Form",
              svgSrc: "assets/icons/menu_tran.svg",
              press: () {
                Future.delayed(Duration(milliseconds: 500), () {
                  Navigator.push(context, MaterialPageRoute(builder: (c) =>
                      MultiProvider(
                        providers: [
                          ChangeNotifierProvider(
                            create: (context) => MenuController(),
                          ),
                        ],
                        child: AdminFormScreen(),
                      ),
                  ));
                });
              },
            ),
            DrawerListTile(
              title: "Make Bill",
              svgSrc: "assets/icons/menu_tran.svg",
              press: () {
                Future.delayed(Duration(milliseconds: 500), () {
                  Navigator.push(context, MaterialPageRoute(builder: (c) =>
                      MultiProvider(
                        providers: [
                          ChangeNotifierProvider(
                            create: (context) => MenuController(),
                          ),
                        ],
                        child: AdminMakeBillScreen(),
                      ),
                  ));
                });
              },
            ),
            DrawerListTile(
              title: "Clients & Services",
              svgSrc: "assets/icons/menu_tran.svg",
              press: () {
                Future.delayed(Duration(milliseconds: 500), () {
                  Navigator.push(context, MaterialPageRoute(builder: (c) =>
                      MultiProvider(
                        providers: [
                          ChangeNotifierProvider(
                            create: (context) => MenuController(),
                          ),
                        ],
                        child: AdminClientsServicesScreen(),
                      ),
                  ));
                });
              },
            ),
            DrawerListTile(
              title: "Table",
              svgSrc: "assets/icons/menu_tran.svg",
              press: () {
                Future.delayed(Duration(milliseconds: 500), () {
                  Navigator.push(context, MaterialPageRoute(builder: (c) =>
                      MultiProvider(
                        providers: [
                          ChangeNotifierProvider(
                            create: (context) => MenuController(),
                          ),
                        ],
                        child: AdminTableScreen(),
                      ),
                  ));
                });
              },
            ),
          ],
        ),
      ),
    );
  }
}

class DrawerListTile extends StatelessWidget {
  const DrawerListTile({
    required this.title,
    required this.svgSrc,
    required this.press,
  });

  final String title, svgSrc;
  final VoidCallback press;

  @override
  Widget build(BuildContext context) {

    bool darkTheme = MediaQuery.of(context).platformBrightness == Brightness.dark;

    return ListTile(
      onTap: press,
      leading: SvgPicture.asset(
        svgSrc,
        color: darkTheme ? Colors.white : Colors.black,
      ),
      title: Text(
        title,
        style: TextStyle(color: darkTheme ? Colors.white54 : Colors.black),
      ),
    );
  }
}
