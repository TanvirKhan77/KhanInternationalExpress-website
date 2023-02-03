import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../Global/global.dart';

class SearchField extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    bool darkTheme = MediaQuery.of(context).platformBrightness == Brightness.dark;

    // return TextField(
    //   decoration: InputDecoration(
    //     hintText: "Search",
    //     fillColor: darkTheme ? Colors.black54 : Colors.grey.shade200,
    //     filled: true,
    //     border: OutlineInputBorder(
    //       borderSide: BorderSide.none,
    //       borderRadius: BorderRadius.all(Radius.circular(10)),
    //     ),
    //     suffixIcon: InkWell(
    //       onTap: () {},
    //       child: Container(
    //         padding: EdgeInsets.all(16 * 0.75),
    //         margin: EdgeInsets.symmetric(horizontal: 16/2),
    //         decoration: BoxDecoration(
    //           color: primaryColor,
    //           borderRadius: BorderRadius.circular(10),
    //         ),
    //         // child: SvgPicture.asset('assets/icons/Search.svg'),
    //         child: Icon(Icons.search,color: Colors.white,size: 15,),
    //       ),
    //     ),
    //   ),
    // );
    return Container(
      decoration: BoxDecoration(
        shape: BoxShape.circle,
      ),
      child: Icon(Icons.notifications),
    );
  }
}
