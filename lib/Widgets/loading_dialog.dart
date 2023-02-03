import 'package:flutter/material.dart';


class LoadingDialogWidget extends StatelessWidget
{
  final String? message;

  LoadingDialogWidget({
    this.message,
  });

  @override
  Widget build(BuildContext context) {

    bool darkTheme = MediaQuery.of(context).platformBrightness == Brightness.dark;

    return AlertDialog(
      key: key,
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [

          //circular progress bar
          Container(
            alignment: Alignment.center,
            padding: const EdgeInsets.only(top: 14),
            child: const CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation(Colors.pinkAccent),
            ),
          ),

          const SizedBox(height: 16,),

          Text(
            message.toString(),
          ),

        ],
      ),
    );
  }
}
