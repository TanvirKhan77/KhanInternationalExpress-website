import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:khanintlexpress/EmployeeScreens/employeeClients&ServicesScreen.dart';
import 'package:khanintlexpress/EmployeeScreens/employeeDashboardScreen.dart';
import 'package:khanintlexpress/EmployeeScreens/employeeFormScreen.dart';
import 'package:khanintlexpress/EmployeeScreens/employeeMakeBill.dart';
import 'package:khanintlexpress/EmployeeScreens/employeeProfileScreen.dart';
import 'package:khanintlexpress/EmployeeScreens/employeeTableScreen.dart';
import 'package:provider/provider.dart';

import '../../AdminScreens/Components/menuController.dart';

class EmployeeSideMenu extends StatefulWidget {
  const EmployeeSideMenu({Key? key}) : super(key: key);

  @override
  State<EmployeeSideMenu> createState() => _EmployeeSideMenuState();
}

class _EmployeeSideMenuState extends State<EmployeeSideMenu> {
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
                        child: EmployeeProfileScreen(),
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
                        child: EmployeeDashboardScreen(),
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
                        child: EmployeeFormScreen(),
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
                        child: EmployeeMakeBillScreen(),
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
                        child: EmployeeClientsServicesScreen(),
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
                        child: EmployeeTableScreen(),
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
