
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:khanintlexpress/Global/global.dart';

import '../AppBar/customAppbar.dart';
import '../AppBar/navbarCustom.dart';
import '../AppBar/navbarItem.dart';
import '../AdminScreens/adminDashboardScreen.dart';
import 'agentDashboardScreen.dart';
import 'employeeDashboardScreen.dart';
import 'homeScreen.dart';
import 'loginScreen.dart';

class GuestProfileScreen extends StatefulWidget {
  const GuestProfileScreen({Key? key}) : super(key: key);

  @override
  State<GuestProfileScreen> createState() => _GuestProfileScreenState();
}

class _GuestProfileScreenState extends State<GuestProfileScreen> {
  @override
  Widget build(BuildContext context) {

    bool darkTheme = MediaQuery.of(context).platformBrightness == Brightness.dark;

    return Scaffold(
      appBar: CustomAppBar(),
      body: Center(
        child: Text(
          "Please login to see your Profile",
        ),
      ),
    );
  }
}
