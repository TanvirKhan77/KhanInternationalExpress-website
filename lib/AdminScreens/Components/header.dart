import 'package:flutter/material.dart';
import 'package:khanintlexpress/AdminScreens/Components/searchField.dart';
import 'package:provider/provider.dart';

import '../../Global/responsive.dart';
import 'menuController.dart';

class Header extends StatelessWidget {
  const Header({Key? key}) : super(key: key);

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
