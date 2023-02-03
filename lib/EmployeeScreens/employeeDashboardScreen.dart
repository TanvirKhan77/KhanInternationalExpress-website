import 'package:flutter/material.dart';
import 'package:khanintlexpress/AppBar/customAppBar.dart';
import 'package:khanintlexpress/EmployeeScreens/Components/dashboardScreen.dart';
import 'package:khanintlexpress/EmployeeScreens/Components/employeeSideMenu.dart';
import 'package:khanintlexpress/Global/responsive.dart';
import 'package:provider/provider.dart';

import '../AdminScreens/Components/menuController.dart';

class EmployeeDashboardScreen extends StatefulWidget {
  const EmployeeDashboardScreen({Key? key}) : super(key: key);

  @override
  State<EmployeeDashboardScreen> createState() => _EmployeeDashboardScreenState();
}

class _EmployeeDashboardScreenState extends State<EmployeeDashboardScreen> {
  @override
  Widget build(BuildContext context) {

    bool darkTheme = MediaQuery.of(context).platformBrightness == Brightness.dark;

    return Scaffold(
      key: context.read<MenuController>().scaffoldKey,
      appBar: CustomAppBar(),
      drawer: EmployeeSideMenu(),
      body: SafeArea(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if(Responsive.isDesktop(context))
            Expanded(
              child: EmployeeSideMenu(),
            ),

            Expanded(
              flex: 5,
              child: DashboardScreen(),
            ),
          ],
        ),
      ),
    );
  }
}
