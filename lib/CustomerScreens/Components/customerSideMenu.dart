import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:khanintlexpress/CustomerScreens/customerProfileScreen.dart';
import 'package:provider/provider.dart';

import '../../AdminScreens/Components/menuController.dart';

class CustomerSideMenu extends StatefulWidget {
  const CustomerSideMenu({Key? key}) : super(key: key);

  @override
  State<CustomerSideMenu> createState() => _CustomerSideMenuState();
}

class _CustomerSideMenuState extends State<CustomerSideMenu> {
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
                        child: CustomerProfileScreen(),
                      ),
                  ));
                });
              },
            ),
            // DrawerListTile(
            //   title: "Dashboard",
            //   svgSrc: "assets/icons/menu_tran.svg",
            //   press: () {
            //
            //   },
            // ),
            // DrawerListTile(
            //   title: "Users",
            //   svgSrc: "assets/icons/menu_tran.svg",
            //   press: () {},
            // ),
            // DrawerListTile(
            //   title: "Form",
            //   svgSrc: "assets/icons/menu_tran.svg",
            //   press: () {
            //
            //   },
            // ),
            // DrawerListTile(
            //   title: "Make Bill",
            //   svgSrc: "assets/icons/menu_tran.svg",
            //   press: () {
            //
            //   },
            // ),
            // DrawerListTile(
            //   title: "Clients & Services",
            //   svgSrc: "assets/icons/menu_tran.svg",
            //   press: () {
            //
            //   },
            // ),
            // DrawerListTile(
            //   title: "Table",
            //   svgSrc: "assets/icons/menu_tran.svg",
            //   press: () {
            //
            //   },
            // ),
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