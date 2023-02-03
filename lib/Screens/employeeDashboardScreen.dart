
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../AppBar/customAppbar.dart';
import '../AppBar/navbarCustom.dart';
import '../AppBar/navbarItem.dart';
import '../Global/global.dart';
import '../AdminScreens/adminDashboardScreen.dart';
import 'agentDashboardScreen.dart';
import 'guestProfileScreen.dart';
import 'homeScreen.dart';
import 'loginScreen.dart';

class EmployeeProfileScreen extends StatefulWidget {
  const EmployeeProfileScreen({Key? key}) : super(key: key);

  @override
  State<EmployeeProfileScreen> createState() => _EmployeeProfileScreenState();
}

class _EmployeeProfileScreenState extends State<EmployeeProfileScreen> {
  @override
  Widget build(BuildContext context) {

    bool darkTheme = MediaQuery.of(context).platformBrightness == Brightness.dark;

    return Scaffold(
      appBar: CustomAppBar(),
    );
  }
}
