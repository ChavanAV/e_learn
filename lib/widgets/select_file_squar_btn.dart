import 'package:flutter/material.dart';

class SelectFileSquareBtn extends StatelessWidget {
  final String selectFileText;
  final Widget selectFileIcon;
  final void Function() onTapForSelectFile;
  const SelectFileSquareBtn(
      {super.key,
      required this.selectFileText,
      required this.selectFileIcon,
      required this.onTapForSelectFile});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 125,
      width: 100,
      margin: const EdgeInsets.all(10),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: Colors.deepOrangeAccent,
          )),
      child: GestureDetector(
        onTap: onTapForSelectFile,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            selectFileIcon,
            Text(
              textAlign: TextAlign.center,
              selectFileText,
              style: const TextStyle(color: Color(0XFFFF6000)),
            )
          ],
        ),
      ),
    );
  }
}
