import 'package:flutter/material.dart';
import 'package:khanintlexpress/EmployeeScreens/Components/searchField.dart';
import 'package:provider/provider.dart';

import '../../AdminScreens/Components/menuController.dart';
import '../../Global/responsive.dart';

class Header extends StatefulWidget {
  const Header({Key? key}) : super(key: key);

  @override
  State<Header> createState() => _HeaderState();
}

class _HeaderState extends State<Header> {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            if(!Responsive.isDesktop(context))
              IconButton(
                onPressed: context.read<MenuController>().controlMenu,
                icon: Icon(Icons.menu),
              ),

            // if(!Responsive.isMobile(context))
            Text(
              "Dashboard",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 30,
              ),
            ),
          ],
        ),

        SearchField(),

      ],
    );
  }
}
