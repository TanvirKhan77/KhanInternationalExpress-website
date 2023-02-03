import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../AppBar/customAppbar.dart';
import '../AppBar/navbarCustom.dart';
import '../AppBar/navbarItem.dart';
import '../Global/global.dart';
import '../AdminScreens/adminDashboardScreen.dart';
import 'employeeDashboardScreen.dart';
import 'guestProfileScreen.dart';
import 'homeScreen.dart';
import 'loginScreen.dart';

class AgentProfileScreen extends StatefulWidget {
  const AgentProfileScreen({Key? key}) : super(key: key);

  @override
  State<AgentProfileScreen> createState() => _AgentProfileScreenState();
}

class _AgentProfileScreenState extends State<AgentProfileScreen> {
  @override
  Widget build(BuildContext context) {

    bool darkTheme = MediaQuery.of(context).platformBrightness == Brightness.dark;

    return Scaffold(
      appBar: CustomAppBar(),
    );
  }
}
