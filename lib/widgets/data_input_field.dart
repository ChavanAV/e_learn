import 'package:flutter/material.dart';

import '../utils/decoration.dart';

class DataInput extends StatelessWidget {
  final String labelText;
  final String? hintText;
  final TextEditingController controller;
  const DataInput(
      {Key? key,
      required this.labelText,
      required this.controller,
      this.hintText})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        focusedBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: orangeColor),
          borderRadius: BorderRadius.all(Radius.circular(10)),
        ),
        border: const OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(10)),
        ),
        labelText: labelText,
        labelStyle: const TextStyle(color: Colors.grey),
        hintText: hintText,
        contentPadding: const EdgeInsets.all(15),
      ),
      validator: (val) {
        if (val!.isEmpty) {
          return labelText;
        } else {
          return null;
        }
      },
    );
  }
}
