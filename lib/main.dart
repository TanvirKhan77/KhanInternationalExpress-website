import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:khanintlexpress/AdminScreens/adminDashboardScreen.dart';
import 'package:khanintlexpress/ExcelTest/excelTest.dart';
import 'package:khanintlexpress/ExcelTest/excelTest2.dart';
import 'package:khanintlexpress/Screens/homeScreen.dart';
import 'package:khanintlexpress/Screens/loginScreen.dart';
import 'package:khanintlexpress/Screens/registerScreen.dart';
import 'package:khanintlexpress/ScrollBehaviour/myScrollBehaviour.dart';
import 'package:khanintlexpress/api/sheets/user_sheets_api.dart';
import 'package:khanintlexpress/global/blurry.dart';
import 'package:khanintlexpress/provider/theme_provider.dart';
import 'package:provider/provider.dart';

import 'AdminScreens/Components/menuController.dart';
import 'ExcelTest/excelTest3.dart';
import 'Global/global.dart';
import 'Paginate/paginate.dart';
import 'assistants/assistant_methods.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await UserSheetsApi.init();

  await Firebase.initializeApp(
    // Replace with actual values
    options: FirebaseOptions(
      apiKey: "AIzaSyDrvgfzAT_tT9BmAzqLwoNv_2gV-Lm4cN8",
      appId: "1:906818652186:web:33f50e5c6b40db8890a9a3",
      messagingSenderId: "906818652186",
      projectId: "khanintlexpress-fcd9c",
      storageBucket: "khanintlexpress-fcd9c.appspot.com",
    ),
  );

  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late StreamSubscription<User?> user;
  void initState() {
    super.initState();
    user = FirebaseAuth.instance.authStateChanges().listen((user) {
      if (user == null) {
        print('User is currently signed out!');
      } else {
        print('User is signed in!');
        AssistantMethods.readCurrentOnlineUserInfo();
      }
    });
  }

  @override
  void dispose() {
    //user.cancel();
    super.dispose();
  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Khan International Express',
      themeMode: ThemeMode.system,
      theme: MyThemes.lightTheme,
      darkTheme: MyThemes.darkTheme,
      debugShowCheckedModeBanner: false,
      scrollBehavior: MyCustomScrollBehavior(),
      home: HomeScreen(),
    );
  }
}

