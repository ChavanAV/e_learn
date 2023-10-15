import 'package:flutter/material.dart';

class FloatingActionBtn extends StatelessWidget {
  final Function() press;
  const FloatingActionBtn({super.key, required this.press});

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      onPressed: press,
      backgroundColor: Theme.of(context)
          .floatingActionButtonTheme
          .backgroundColor, //const Color(0XFF9D9D9D)
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      child: const Icon(
        Icons.send_outlined,
        color: Colors.white,
      ),
    );
  }
}
